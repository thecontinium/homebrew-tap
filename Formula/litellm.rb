class Litellm < Formula
  desc "Isolated LiteLLM server powered by uv with Keychain credentials loading"
  homepage "https://github.com/YOUR_GITHUB_USERNAME/homebrew-tap"
  
  # Stable dummy target to satisfy Homebrew framework requirements
  url "https://raw.githubusercontent.com/astral-sh/uv/main/LICENSE-MIT"
  sha256 "860e3d7a86b84e6a7012c7a635fc64df475cebc6cce34dfeb73a5982ec58176c"
  version "latest"

  def install
    # Establish isolated execution cell pathways
    libexec.install Dir["*"]

    # Build out a localized standalone Python environment block 
    # This expects 'uv' to be present on your user's machine path
    system "uv", "venv", "#{libexec}/.venv"
    system "#{libexec}/.venv/bin/uv", "pip", "install", "litellm[proxy]"

    # Create the launcher service script using a portable shell environment
    (libexec/"litellm-service").write <<~EOS
      #!/usr/bin/env bash
      set -euo pipefail

      CONFIG="${LITELLM_CONFIG:-$HOME/.config/litellm/config.yaml}"
      
      # Explicitly prioritize the local user-space Homebrew binary paths + environment virtualenv
      export PATH="#{HOMEBREW_PREFIX}/bin:#{libexec}/.venv/bin:${HOME}/.local/bin:/usr/bin:/bin:$PATH"

      if [ ! -f "$CONFIG" ]; then
          echo "LiteLLM config not found: $CONFIG" >&2
          exit 1
      fi

      # Portable secret-extraction logic (works across older and newer bash engines)
      REQUIRED_VARS=$(grep -rhoE 'os\\.environ/[A-Z0-9_]+' "$CONFIG" | sed 's#os\\.environ/##' | sort -u)

      load_secret() {
          local var="$1"
          local value
          
          value="$(
              security find-generic-password \\
                  -a "$USER" \\
                  -s "$var" \\
                  -w 2>/dev/null || true
          )"

          if [ -z "$value" ]; then
              echo "❌ Missing Keychain entry: $var" >&2
              return 1
          fi

          echo "✅ Loaded and exporting credentials for $var"
          export "$var=$value"
      }

      for var in $REQUIRED_VARS; do
          load_secret "$var"
      done

      echo "🚀 Starting LiteLLM proxy gateway..."
      exec litellm --config "$CONFIG" --host 127.0.0.1 --port 4000
    EOS

    chmod 0755, libexec/"litellm-service"
    bin.install_symlink libexec/"litellm-service"
  end

  def post_install
    config_dir = Etc.getpwuid.dir + "/.config/litellm"
    config_file = config_dir + "/config.yaml"
    mkdir_p config_dir

    unless File.exist?(config_file)
      File.write(config_file, <<~YAML
        model_list:
          - model_name: fast
            litellm_params:
              model: gemini/gemini-2.5-flash
              api_key: os.environ/GEMINI_API_KEY
      YAML
      )
    end
  end

  service do
    run [opt_bin/"litellm-service"]
    keep_alive true
    run_at_load true
  end
end
