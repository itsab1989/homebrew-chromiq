# Homebrew tap for ChromIQ

[ChromIQ](https://github.com/itsab1989/ChromIQ) is a free GUI for ICC printer profiling with ArgyllCMS.

## Install

```sh
brew install --cask itsab1989/chromiq/chromiq        # latest stable release
brew install --cask itsab1989/chromiq/chromiq@beta   # latest beta (replaces the stable cask)
```

ArgyllCMS is installed with it (`argyll-cms`).

## Update and remove

```sh
brew upgrade --cask chromiq          # or chromiq@beta
brew uninstall --cask chromiq        # your projects in ~/ChromIQ are kept
brew uninstall --zap --cask chromiq  # also removes settings, logs and caches (never ~/ChromIQ)
```

## Notes

* `chromiq` only ever installs stable releases. `chromiq@beta` follows the newest release, beta or stable. The two cannot be installed at the same time.
* ChromIQ is ad-hoc signed, not notarised by Apple. So that it opens on first launch, both casks remove the macOS download quarantine from the installed app.
* The casks are updated automatically by ChromIQ's release workflow, with the checksums of the release's DMGs.
