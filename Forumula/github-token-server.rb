class GithubTokenServer < Formula
  desc "LiteLLM-style secure credential server for local automation"
  homepage "https://github.com/thecontinium/homebrew-tap"
  url "https://github.com/thecontinium/github-token-server/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.0"
  # Automated target checks
  sha256 "9fbc9eaa215c2a2ea50d3c1a98e98018a72fa76d67466b03b2bbb961d94c3702"
  license "MIT"

  depends_on "node"

  def install
    # Copy code assets cleanly into Homebrew's persistent cell library
    libexec.install Dir["*"]

    # Trigger npm installation environments internally within the folder hook
    cd libexec do
      system "npm", "install", "--production"
    end

    # Write a dynamic entry point binary wrapper straight inside /opt/homebrew/bin
    (bin/"github-token-server").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/start-token-server.sh" "$@"
    EOS
  end

  # Replaces launchd plist management boilerplate using modern Homebrew hooks
  service do
    run [opt_bin/"github-token-server"]
    keep_alive true
    run_at_load true
  end
end
