class Litellm < Formula
  desc "Isolated LiteLLM server powered by uv with Keychain credentials loading"
  homepage "https://github.com/thecontinium/homebrew-tap"
  
  # Stable dummy target to satisfy Homebrew's required framework checkpoints
  url "https://raw.githubusercontent.com/astral-sh/uv/main/LICENSE-MIT"
  sha256 "860e3d7a86b84e6a7012c7a635fc64df475cebc6cce34dfeb73a5982ec58176c"
  version "latest"

  depends_on "uv"
  depends_on "bash" # Enforces the installation of modern Homebrew Bash

  def install
    # 1. Establish isolated internal execution cell pathways
    libexec.install Dir["*"]

    # 2. Build out a localized standalone Python environment block via 'uv'
    system "uv", "venv", "#{libexec}/.venv"
    system "#{libexec}/.venv/bin/uv", "pip", "install", "litellm[proxy]"

    # 3. Create the launcher service script using the explicit Homebrew Bash path
    (libexec/"litellm-service").write <<~EOS
      #!#{Formula["bash"].opt_bin}/bash
      set -euo pipefail

      # Context paths handling multiple users cleanly
      CONFIG="${LITELLM_CONFIG:-$HOME/.config/litellm/config.yaml}"
      
      # Explicitly prioritize the local user-space Homebrew binary paths
      export PATH="#{HOMEBREW_PREFIX}/bin:#{libexec}/.venv/bin:${HOME}/.local/bin:/usr/bin:/bin:$PATH"

      if [ ! -f "$CONFIG" ]; then
          echo "LiteLLM config not found: $CONFIG" >&2
          exit 1
      fi

      # Dynamically pluck unique variable mappings from configuration files
      mapfile -t REQUIRED_VARS < <(
          grep -rhoE 'os\\.environ/[A-Z0-9_]+' "$CONFIG" |
          sed 's#os\\.environ/##' |
          sort -u
      )

      load_secret() {
          local var="$1"
          local value
          
          # Query macOS encrypted Keychain vault matching current active session owner
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

      for var in "${REQUIRED_VARS[@]}"; do
          load_secret "$var"
      done

      echo "🚀 Starting LiteLLM proxy gateway..."
      exec litellm --config "$CONFIG" --host 127.0.0.1 --port 4000
    EOS

    # 4. Correct execution permissions for the newly bundled controller wrapper
    chmod 0755, libexec/"litellm-service"

    # 5. Create a global symlink shortcut pointing directly to the script launcher
    bin.install_symlink libexec/"litellm-service"
  end

  def post_install
    # 6. Build the safe default workspace configuration directories
    config_dir = Etc.getpwuid.dir + "/.config/litellm"
    config_file = config_dir + "/config.yaml"
    
    mkdir_p config_dir

    # Write initial parameters ONLY if the developer hasn't created one already
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

  # Native launchd declarative hook automatically managing background state lifecycle
  service do
    run [opt_bin/"litellm-service"]
    keep_alive true
    run_at_load true
  end

  def caveats
    <<~EOS
      ========================================================================
      🔑 KEYCHAIN INJECTION REQUIRED BEFORE STARTING THE SERVICE
      ========================================================================

      Your LiteLLM config references 'os.environ/GEMINI_API_KEY'. Save your
      secret keys inside the macOS Keychain before running the service:

      security add-generic-password -U -a "$USER" -s GEMINI_API_KEY -w 'your-actual-api-key'

      ========================================================================
      ⚙️ RUNNING THE GATEWAY DAEMON
      ========================================================================

      To run LiteLLM persistently in the background via system launchd services:

        brew services start litellm

      * Endpoint verification target: http://127.0.0.1:4000
      * Configuration profile path: ~/.config/litellm/config.yaml
      ========================================================================
    EOS
  end
end
