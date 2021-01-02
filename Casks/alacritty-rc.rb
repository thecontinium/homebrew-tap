cask "alacritty-rc" do
  version "0.7.0"
  rc "-rc1"
  url "https://github.com/alacritty/alacritty/releases/download/v#{version}#{rc}/Alacritty-v#{version}#{rc}.dmg"
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
