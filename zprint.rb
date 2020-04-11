class Zprint < Formula
  desc "Library to reformat Clojure and Clojurescript source code and s-expressions"
  homepage "https://github.com/kkinnear/zprint"
  url "https://github.com/kkinnear/zprint/releases/download/0.5.4/zprint-filter-0.5.4"
  version '0.0.6'
  
  def install
    bin.install 'zprint-filter-0.5.4'
    # mv bin/"zprint-filter-0.5.4", bin/"zprint-filter"
  end

end
