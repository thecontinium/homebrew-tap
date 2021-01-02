cask "alacritty-rc" do

  version "0.7.2"
  
  url "https://github.com/alacritty/alacritty/releases/download/v0.7.0-rc1/Alacritty-v0.7.0-rc1.dmg"
  appcast "https://github.com/alacritty/alacritty/releases.atom"
  name "Alacritty"
  desc "Cross-platform, GPU-accelerated terminal emulator"
  homepage "https://github.com/alacritty/alacritty/"

  app "Alacritty.app"
  binary "#{appdir}/Alacritty.app/Contents/MacOS/alacritty"

  zap delete: [
    "~/Library/Saved Application State/io.alacritty.savedState",
  ]
end
