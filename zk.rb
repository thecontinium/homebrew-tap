# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Zk < Formula
  desc "A plain text note-taking assistant"
  homepage ""
  url "https://github.com/mickael-menu/zk/releases/download/v0.6.0/zk-v0.6.0-macos-arm64.zip"
  sha256 "0e709a11af8d8365d78c011a3f8f5e66ff1595763175a7434117421aebe70d9b"
  license "GPL-3.0"

  depends_on "go"
  bin.install "zk"

end
