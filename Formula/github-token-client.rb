class GithubTokenClient < Formula
  desc "Stateless execution interceptor script for GitHub CLI tools"
  homepage "https://github.com/thecontinium/homebrew-tap"
  url "https://github.com/thecontinium/github-token-client/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.2"
  sha256 "f6fe2680aa6efe9d31e2b758883c0077922e5907e9c67749c71d912e630ec16f"
  license "MIT"

  depends_on "gh"

  def install
    # Link our shell proxy into the execution binary lookup directories
    bin.install "gh-proxy"
  end

  def caveats
    <<~EOS
      ========================================================================
      🔒 FINAL CLIENT LOCKDOWN REQUIRED
      ========================================================================
      
      1. ROUTE THE 'gh' CLI THROUGH THE PROXY
         Run this command to append the alias to your Zsh configuration and apply it:

         echo 'alias gh="gh-proxy"' >> ~/.zshrc && source ~/.zshrc

      2. ROUTE NATIVE 'git' COMMANDS THROUGH THE PROXY
         Run the following command in your terminal to bind native git operations 
         (like git push/fetch) to pull short-lived tokens from your gateway:

         git config --global credential.helper '!f() { \\
             if [ "$1" = "get" ]; then \\
                 TOKEN=$(curl -s --max-time 3 http://<SERVER_IP>:8080); \\
                 echo "username=x-access-token"; \\
                 echo "password=$TOKEN"; \\
             fi \\
         }; f'

      * Note: Be sure to replace `<SERVER_IP>` with your actual remote Mac server IP address.
      ========================================================================
    EOS
  end
end
