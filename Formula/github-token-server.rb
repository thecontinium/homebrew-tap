class GithubTokenServer < Formula
  desc "LiteLLM-style secure credential server for local automation"
  homepage "https://github.com/thecontinium/homebrew-tap"
  url "https://github.com/thecontinium/github-token-server/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.1"
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
end
