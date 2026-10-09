# Homebrew tap for ChromIQ

[ChromIQ](https://github.com/itsab1989/ChromIQ) is a free GUI for ICC printer profiling with ArgyllCMS.

## Before you start

You need [Homebrew](https://brew.sh). If you don't have it yet, copy the one-line command from [brew.sh](https://brew.sh) into Terminal and follow what it says. ChromIQ needs macOS 13 Ventura or newer, on Apple Silicon or Intel.

## Install

```sh
brew install --cask itsab1989/chromiq/chromiq        # the stable version
brew install --cask itsab1989/chromiq/chromiq@beta   # or: the newest beta
```

What you get:

* **ArgyllCMS comes with it**, as the `argyll-cms` package. ChromIQ finds it on first launch.
* **ChromIQ opens straight away.** ChromIQ is ad-hoc signed and not notarised by Apple, so macOS would normally block it the first time. The cask removes the download quarantine from the installed app, so there is no warning and no right-click and Open step.
* The right build for your Mac (Apple Silicon or Intel) is picked for you.

`chromiq` only ever installs stable releases. `chromiq@beta` always follows the newest release, beta or stable, so beta users get each stable release too. Only one of the two can be installed at a time.

## Update, switch, uninstall

Use `chromiq@beta` in place of `chromiq` if that is the one you installed.

```sh
brew upgrade --cask chromiq                        # update

brew uninstall --cask chromiq                      # switch from stable to beta
brew install --cask itsab1989/chromiq/chromiq@beta

brew uninstall --cask chromiq@beta                 # switch from beta back to stable
brew install --cask itsab1989/chromiq/chromiq

brew uninstall --cask chromiq                      # uninstall
brew uninstall --zap --cask chromiq                # uninstall and remove settings, logs and caches
```

* **Your projects in `~/ChromIQ` are always kept**: by updates, by switching, by uninstalling and by `--zap`. Switching and a plain uninstall keep your settings too.
* **ArgyllCMS stays installed** when you uninstall ChromIQ. Remove it with `brew uninstall argyll-cms` if you no longer need it.
* **When ChromIQ tells you a new version is out**, update with `brew upgrade --cask chromiq` rather than downloading the DMG, so Homebrew stays in charge of the app.

## ChromIQ is already in your Applications folder?

If you installed ChromIQ from the DMG before, Homebrew stops with *"It seems there is already an App at '/Applications/ChromIQ.app'"*. Move the old ChromIQ to the Trash and run the install command again. Your projects and settings are not stored inside the app, so nothing is lost. (Adding `--force` to the install command replaces the old app in one step instead.)

## How the casks are kept current

ChromIQ's release workflow updates the casks after every release, with the checksums of that release's DMGs: a stable release moves `chromiq` (and `chromiq@beta`), a beta moves `chromiq@beta` only, and no cask is ever moved back to an older version. Every push here runs `brew style` and `brew audit --strict --online`.
