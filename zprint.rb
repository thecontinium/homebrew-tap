class Zprint < Formula
  desc "Library to reformat Clojure and Clojurescript source code and s-expressions"
  homepage "https://github.com/kkinnear/zprint"
  @alias_version = "0.5.4"
  @alias_name = "zprintm-#{alias_version}"
  url "https://github.com/kkinnear/zprint/releases/download/0.5.4/zprintm-0.5.4"
  sha256 "281fb1749bbb1eb2102d5c8bb0db013fbbea0d5b3eb2889f6cd4da06d1e588a5"
  version '0.0.15'
  
  def install
    bin.install "#{alias_name}"
    mv bin/"#{alias_name}", bin/"zprintm"
  end

end
