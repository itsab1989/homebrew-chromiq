cask "chromiq" do
  arch arm: "arm64", intel: "x86_64"

  version "4.3.7"
  sha256 arm:   "2a8b89714245fe66a667fdbef59e41abfa343683297e718c1691e0e9f0145d86",
         intel: "e1a1d7a458e4197d7c9ab02a997a698f098f575795b3549edebd1c82778dd2a2"

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
