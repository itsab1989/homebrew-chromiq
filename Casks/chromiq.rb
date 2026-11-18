cask "chromiq" do
  arch arm: "arm64", intel: "x86_64"

  version "4.3.46"
  sha256 arm:   "5c8b923a948d5dc930201be53cdde5c81b83b6cf3cf20f5837c805106c60138f",
         intel: "c1843389ca5f1b488baaf79adfd73e16965045ecdfebb428f9e2312396be0fce"

  url "https://github.com/itsab1989/ChromIQ/releases/download/v#{version}/ChromIQ-macOS-#{arch}_v#{version}_homebrew.dmg"
  name "ChromIQ"
  desc "GUI for ICC printer profiling with ArgyllCMS"
  homepage "https://github.com/itsab1989/ChromIQ"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "chromiq@beta"
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
