class Zprint < Formula
  desc "Library to reformat Clojure and Clojurescript source code and s-expressions"
  homepage "https://github.com/kkinnear/zprint"
  sha256 "281fb1749bbb1eb2102d5c8bb0db013fbbea0d5b3eb2889f6cd4da06d1e588a5"
  @@alias_version = "0.5.4" # just change this alias version
  @@alias_name = "zprintm-#{@@alias_version}"
  url "https://github.com/kkinnear/zprint/releases/download/#{@@alias_version}/#{@@alias_name}"
  version '0.0.22'
  
  def install
    bin.install "#{@@alias_name}"
    mv bin/"#{@@alias_name}", bin/"zprintm"
  end

end
