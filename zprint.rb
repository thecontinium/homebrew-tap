class Zprint < Formula
  desc "Library to reformat Clojure and Clojurescript source code and s-expressions"
  homepage "https://github.com/kkinnear/zprint"
  url "https://github.com/kkinnear/zprint/releases/download/0.5.4/zprintm-0.5.4"
  sha256 "625857e8711b72ab71e875bb48b00650c0e31f223860d15b089074e3497925f8"
  version '0.0.8'
  
  def install
    bin.install 'zprintm-0.5.4'
    mv bin/"zprintm-0.5.4", bin/"zprintm"
  end

end
