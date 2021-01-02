cask "alacritty-rc" do
  version "0.7.0"

  url "https://github.com/alacritty/alacritty/releases/download/v#{version}-rc1/Alacritty-v#{version}-rc1.dmg"
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
