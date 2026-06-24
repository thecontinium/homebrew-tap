class GithubTokenClient < Formula
  desc "Stateless execution interceptor script for GitHub CLI tools"
  homepage "https://github.com/YOUR_GITHUB_USERNAME/homebrew-tap"
  url "https://github.com/YOUR_GITHUB_USERNAME/github-token-client/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.0"
  sha256 "4df27bead25edaec306d3b70355b7619fca31339bc39e97e1c3933ceae696cc8"
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
