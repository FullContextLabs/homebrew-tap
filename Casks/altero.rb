cask "altero" do
  version "0.1.3"
  sha256 "0b86508a4396f187017acb4ba5cead2429879e008117407853059ce2b0406d03"

  url "https://github.com/FullContextLabs/Altero/releases/download/v#{version}/Altero-#{version}.dmg"
  name "Altero"
  desc "Claude Code account switcher with menu bar app, widget and CLI"
  homepage "https://github.com/FullContextLabs/Altero"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Altero.app"
  binary "#{appdir}/Altero.app/Contents/Helpers/AlteroEngine.app/Contents/MacOS/altero"

  # Stop the menu bar and backend before the app bundle is replaced or removed:
  # the engine imports Python modules lazily from inside the app.
  uninstall launchctl: [
              "com.fullcontextlabs.altero.auto",
              "com.fullcontextlabs.altero.menubar",
            ],
            quit:      "com.fullcontextlabs.altero"

  # ~/.altero (accounts, credentials, settings, menubar_settings.json) and the
  # "altero" PATH block in ~/.zprofile are deliberately NOT removed.
  zap trash: [
    "~/Library/Containers/com.fullcontextlabs.altero.widget",
    "~/Library/LaunchAgents/com.fullcontextlabs.altero.auto.plist",
    "~/Library/LaunchAgents/com.fullcontextlabs.altero.menubar.plist",
    "~/Library/Logs/com.fullcontextlabs.altero.auto.err",
    "~/Library/Logs/com.fullcontextlabs.altero.auto.log",
    "~/Library/Logs/com.fullcontextlabs.altero.menubar.err",
    "~/Library/Logs/com.fullcontextlabs.altero.menubar.log",
  ]
end
