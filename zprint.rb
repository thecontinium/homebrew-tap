class Zprint < Formula
  desc "Library to reformat Clojure and Clojurescript source code and s-expressions"
  homepage "https://github.com/kkinnear/zprint"
  zprint_version "0.5.4"
  zprint_name "zprintm-#{zprint_version}"
  url "https://github.com/kkinnear/zprint/releases/download/#{zprint_version}/#{zprint_name}"
  sha256 "281fb1749bbb1eb2102d5c8bb0db013fbbea0d5b3eb2889f6cd4da06d1e588a5"
  version '0.0.11'
  
  def install
    bin.install "#{zprint_name}"
    mv bin/"#{zprint_name}", bin/"zprintm"
  end

end
