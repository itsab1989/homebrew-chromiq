cask "chromiq@beta" do
  arch arm: "arm64", intel: "x86_64"

  version "4.3.24"
  sha256 arm:   "7211acc0271163d5662d47bb9811ff3499b7f177c0bc1c4ab49d2e9e39da5848",
         intel: "99ee5d4ea8b35fa7ea3bbe86620f703d9a708c7847d8cf0ae7577ae81b0daf8a"

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
