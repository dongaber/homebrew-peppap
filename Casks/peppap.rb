cask "peppap" do
  version "0.6.0"
  sha256 "b5b4d8bc22d2d72c06893328cf01a85d411e51b4d9e003689ae39405f14066ca"

  url "https://github.com/dongaber/peppap/releases/download/v#{version}/Peppap-#{version}.zip"
  name "Peppap"
  desc "Dev status in the MacBook notch: Claude Code sessions and merge requests"
  homepage "https://github.com/dongaber/peppap"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Peppap.app"

  # The app is not notarized; drop the quarantine flag so it opens without a Gatekeeper prompt.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Peppap.app"]
  end

  uninstall quit: "com.peppap.notch"

  zap trash: [
    "~/Library/Application Support/Peppap",
    "~/Library/Preferences/com.peppap.notch.plist",
  ]

  caveats <<~EOS
    Before uninstalling, disconnect the Claude Code hooks from the Peppap menu (✦),
    otherwise Claude Code will keep calling the removed hook script.
  EOS
end
