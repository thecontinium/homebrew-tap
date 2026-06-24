class GithubTokenServer < Formula
  desc "LiteLLM-style secure credential server for local automation"
  homepage "https://github.com/thecontinium/homebrew-tap"
  url "https://github.com/thecontinium/github-token-server/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.2"
  # Automated target checks
  sha256 "a11c88a652b07f64de8b9cce5947f9cfcb8e6a38e39ac9dc1b70732c6ce5b698"
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

  def caveats
    <<~EOS
      ========================================================================
      🔑 SECURE KEYCHAIN CONFIGURATION REQUIRED
      ========================================================================
      
      Before starting the background service, you must securely inject your
      GitHub App secrets into the native macOS Keychain. Run these 3 commands:

      1. Store your App ID:
         security add-generic-password -a "github-app" -s "pi-app-id" -w "YOUR_APP_ID"

      2. Store your App Installation ID:
         security add-generic-password -a "github-app" -s "pi-app-installation-id" -w "YOUR_INSTALLATION_ID"

      3. Stream your raw PEM private key block into the secure vault:
         security add-generic-password -a "github-app" -s "pi-app-private-key-raw" -w - < /path/to/your-key.pem

      * IMPORTANT: Once securely saved to the Keychain, remember to delete the 
        physical .pem file from disk (`rm /path/to/your-key.pem`).

      ========================================================================
      🚀 STARTING THE BACKGROUND SERVICE
      ========================================================================
      
      Once your keys are securely added to the Keychain, spin up the background
      service wrapper natively via Homebrew services:

         brew services start github-token-server

      ========================================================================
    EOS
  end
end
