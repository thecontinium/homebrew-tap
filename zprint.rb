class Zprint < Formula
  desc "Library to reformat Clojure and Clojurescript source code and s-expressions"
  homepage "https://github.com/kkinnear/zprint"
  url "https://github.com/kkinnear/zprint/releases/download/0.5.4/zprint-filter-0.5.4"
  sha256 "625857e8711b72ab71e875bb48b00650c0e31f223860d15b089074e3497925f8"
  version '0.0.7'
  
  def install
    bin.install 'zprint-filter-0.5.4'
    # mv bin/"zprint-filter-0.5.4", bin/"zprint-filter"
  end

end
