class Zprint < Formula
  desc "Library to reformat Clojure and Clojurescript source code and s-expressions"
  homepage "https://github.com/kkinnear/zprint"
  url "https://github.com/kkinnear/zprint/releases/download/0.5.4/zprintm-0.5.4"
  sha256 "281fb1749bbb1eb2102d5c8bb0db013fbbea0d5b3eb2889f6cd4da06d1e588a5"
  version '0.0.9'
  
  def install
    bin.install 'zprintm-0.5.4'
    mv bin/"zprintm-0.5.4", bin/"zprintm"
  end

end
