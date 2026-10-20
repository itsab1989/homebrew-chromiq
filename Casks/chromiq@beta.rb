cask "chromiq@beta" do
  arch arm: "arm64", intel: "x86_64"

  version "4.3.8-beta.1"
  sha256 arm:   "638b61726eff81a1e7217a551cfbc76de9551507755f476e5c08ff949b94c9c2",
         intel: "3ae1a51831b01fc19cd3d52c02989bb9144acc7cb7be2f51445d76c0cfbcca9b"

  url "https://github.com/itsab1989/ChromIQ/releases/download/v#{version}/ChromIQ-macOS-#{arch}_v#{version}_homebrew.dmg"
  name "ChromIQ (beta)"
  desc "GUI for ICC printer profiling with ArgyllCMS"
  homepage "https://github.com/itsab1989/ChromIQ"

  # The newest release, beta or stable. The releases feed lists pre-releases
  # too, and unlike the GitHub API it is not rate-limited for anonymous use.
  livecheck do
    url "https://github.com/itsab1989/ChromIQ/releases.atom"
    regex(%r{/releases/tag/v?(\d+(?:\.\d+)+(?:-[a-z]+(?:\.\d+)?)?)["<]}i)
    strategy :page_match
  end

  conflicts_with cask: "chromiq"
  depends_on formula: "argyll-cms"
  depends_on macos: :ventura

  app "ChromIQ.app"

  # ChromIQ is ad-hoc signed, not notarised by Apple. Without this step
  # macOS would refuse to open it on first launch ("Apple could not verify
  # ..."), so the cask removes the download quarantine from the installed app.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/ChromIQ.app"],
        writable_paths: ["ChromIQ.app"],
        writable_base:  :appdir
  end

  # Never ~/ChromIQ: those are the user's own projects.
  zap trash: [
    "~/Library/Caches/ChromIQ",
    "~/Library/Logs/ChromIQ",
    "~/Library/Preferences/com.chromiq.ChromIQ.plist",
    "~/Library/Saved Application State/com.chromiq.app.savedState",
  ]
end
