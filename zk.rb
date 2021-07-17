# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Zk < Formula
  desc "A plain text note-taking assistant"
  homepage ""
  url "https://github.com/mickael-menu/zk/releases/download/v0.6.0/zk-v0.6.0-macos-x86_64.zip"
  sha256 "7f312567a62cf722f038e313e61f0092593468311120327407cd207206bad670"
  license "GPL-3.0"
  version '0.0.05'

  depends_on "go"

  def install
    bin.install "zk"
  end
end
