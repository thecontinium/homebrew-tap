class GithubTokenClient < Formula
  desc "Stateless execution interceptor script for GitHub CLI tools"
  homepage "https://github.com/thecontinium/homebrew-tap"
  url "https://github.com/thecontinium/github-token-client/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.1"
  sha256 "f6fe2680aa6efe9d31e2b758883c0077922e5907e9c67749c71d912e630ec16f"
  license "MIT"

  depends_on "gh"

  def install
    # Link our shell proxy into the execution binary lookup directories
    bin.install "gh-proxy"
  end

  def caveats
    <<~EOS
      To finish client sandboxing, route your global 'gh' namespace through the proxy hook.
      Append this statement to your local shell execution files (~/.zshrc or ~/.bashrc):

      alias gh="gh-proxy"
    EOS
  end
end
