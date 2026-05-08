# dotfiles-starter

A zsh-focused dotfiles starter template for MacOS, but lots of configurations are compatible with Linux.

Linux support is a work-in-progress. Create a Pull Request if you want to contribute!

## Getting started

First, fork this repo so you can start maintaining your own dotfiles repo, and name your fork `dotfiles`, not `dotfiles-starter`. [Github instructions for working with forks](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork)
Follow the instructions for [Configuring a remote repository for a fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/configuring-a-remote-repository-for-a-fork) if you want to sync changes from the source repo to your fork from the command line.

### Configuring MacOS

If you're on MacOS and setting up your computer for the first time or migrating computers, try running the [MacOS System Settings script](scripts/macos/macos-system-settings.sh) to speed up your computer setup. Some of the settings it can help you configure:

1. Trackpad: Tap to click
1. Trackpad: Natural scrolling
1. Dock: Automatically hide and show the Dock
1. Dock: Minimize windows using Scale/Genie effect
1. Mission Control: Automatically rearrange Spaces
1. Mission Control: Group windows by application
1. Mission Control: Drag windows to top of screen
1. Hot Corners

Pull Requests are welcome if you want to contribute additional settings!

### Installing CLI applications

1. [Install Brew](https://brew.sh/)
   - Homebrew requires XCode Command Line Tools to be installed first
1. Follow the instructions provided at the completion of the Brew installation process for adding a line to your `~/.zshrc`. Also run the `eval "... shellenv)"` line in your current Terminal to start using `brew` right away.
1. In this repo, edit _Brewfile_(./Brewfile)
1. From the root of this repo, run `brew bundle`
   - this will install all apps listed in the _Brewfile_ file

### Set up recommended Zsh and CLI app configurations

1. Back up your current _~/.zshrc_ file
   - `mv ~/.zshrc ~/.zshrc-backup`
1. Create a _~/.my-env-secrets_ file and copy over any secrets from your old _.zshrc_ that you don't want committed to git
   - Manually copy the _my-env-secrets-example_ file from this directory to your `$HOME` directory
     - `cp ./my-env-secrets-example ~/.my-env-secrets`
   - There's probably a better way to manage environment secrets than this. Open to suggestions.
1. In the _dot-zshrc_ file,
   - update the `DOTFILES_GIT_DIR` variable to match the location of this folder on your computer
   - copy any important settings from your _~/.zshrc-backup_ file to _dot-zshrc_ in this folder
1. (OPTIONAL) If you have a _~/.aws/config_ file, you may want to version control it in case it gets messed up:
   - copy the contents into this repo's _dot-aws/config_ file
     - `cat ~/.aws/config >> ./dot-aws/config`
   - backup the old file
   - `mv ~/.aws/config ~/.aws/config-backup`
1. Check for potential `stow` conflicts:
   - From the root of this repo, run `stow --simulate --verbose .`
1. From the root of this repo, run `stow .`
1. Exit your current shell session and reopen a new one. Zinit will install itself and you'll get all of the updated settings applied to your new shell.

## CLI tools

### wd

warp directory - bookmark directories - `wd help`

## Aliases and Functions

Recommendation: prefix your long/less-often-used aliases with a comma, e.g. `,git_browser_url`.

- easier to find when autocompleting using Tab
- commas aren't special characters unlike other symbols ($, #, ?, etc.)

There are many suggested recommended (non comma-prefixed) aliases in this repo that are commented out. They're commented out so that they don't override other tools you may already have installed and use regularly, but feel free to uncomment them if you think they're useful. For example, see `gs`, `ga`, `gd`, `gcam`, `gcam`, in the [git aliases file](./aliases-and-functions/git).

**IMPORTANT**: Be aware that this dotfiles setup, by default, overrides the following built-in CLI commands to help improve your workflow. If you don't want them, you'll have manually remove the overrides.

- `cd` - replaced with `zoxide`. To undo, comment out or delete the env variable `ZOXIDE_CMD_OVERRIDE` in _dot-zshrc_.
- `ls` - replaced with `eza`. To undo, comment out or delete the _aliases-and-functions/ls_ file.
- `kubectl` - replaced with `kubecolor`. To undo, comment out or delete the _aliases-and-functions/kubectl_ file.

### custom ones in this repo to try

Call `,alias_query` to see a list of aliases/functions you currently have access to and their definitions. Navigate using the up/down arrow keys and invoke them by pressing <kbd>Enter</kbd>.

- `-`, `..`, `...`, `....` (navigating to previous/parent directories without `cd`)
- `,alias_query`
- `,alias_source_query`
- `,cd_query` / `,cd_rankings` / `,zoxide_query` / `,zoxide_rankings`
- `,copy_branch` / `,copy_path` / `,copy_dirname`
- `,git_branch_query_fzf` / `,git_branch_query_remote_fzf`
- `,git_browser_url` / `,git_browser_url_copy`
- `,git_show_last_commit`
- `,git_undo_unpushed_commit` --> `,git_redo_unpushed_commit`
- `,replace_text_recursively`
- `,show_files` / `,hide_files`
- `,speedtest`
- `,tree`

## Keyboard Shortcuts and Bindings

Refer to [docs/keyboard-shortcuts.md](docs/keyboard-shortcuts.md) for a list of useful builtin keybindings.

**IMPORTANT**: Be aware that this dotfiles setup, by default, adds/overrides the following built-in shell keybindings to help improve your workflow. If you don't want them, you'll have manually remove the overrides in [_keybindings_](./keybindings).

- <kbd>Ctrl+t</kbd> - refer to the `fzf` section below
- <kbd>Ctrl+x then p</kbd> - refer to the Ghostty AppleScript API section below

### fzf

`fzf` which is installed in [Brewfile](Brewfile) comes with a useful shortcut.

`<Ctrl-t>` - opens a typeahead that can filter through directories and filenames under the current directory and pastes the selection into the current command prompt. Can be useful for `git add [PATH_TO_FILE]` operations after doing a `git status` to see which files have changed

## Ghostty

Check out the Ghostty terminal which has been preconfigured in this repo in the [Ghostty config file](./dot-config/ghostty/config). Read more about it and install it from the official website: https://ghostty.org

Optional: for the best experience, download the JetBrains Mono font from https://www.jetbrains.com/lp/mono. Install it by opening the font file and choose Install. Then uncomment the line below in the _dot-config/ghostty/config_:

`font-family = JetBrains Mono`

### useful keyboard shortcuts

| Shortcut                                        | Action                            |
| ----------------------------------------------- | --------------------------------- |
| <kbd>Command+Shift+P</kbd>                      | Activate Command Palette          |
| <kbd>Command+Shift+,</kbd>                      | Reload Ghostty with latest config |
| <kbd>Command+t</kbd>                            | New tab                           |
| <kbd>Command+w</kbd>                            | Close tab                         |
| <kbd>Ctrl+tab</kbd> / <kbd>Ctrl+Shift+tab</kbd> | Next / previous tab               |
| <kbd>Command+d</kbd>                            | New split to the right            |
| <kbd>Command+Shift+d</kbd>                      | New split to the bottom           |
| <kbd>Command+[</kbd> / <kbd>Command+]</kbd>     | Previous / next pane              |

### useful CLI commands

```sh
ghostty --help # see all available commands
ghostty +list-themes
ghostty +list-keybinds
ghostty +list-fonts
```

### AppleScript API

Ghostty has an API that works with AppleScript which allows you to write scripts to automate Ghostty in many interesting ways.

An [example](scripts/ghostty/tvsim.applescript) for the TVSim project has been added that demonstrates how a person on that team might want to automate their workflow of navigating to all of the git repositories related to that project at the beginning of their day. It requires that the exact paths to those git repositories exist on your computer.

For those who want to test out the script without those particular project directories, a more generic [MacOS example](scripts/ghostty/macos.applescript) has also been created that navigates to standard MacOS directories.

In your shell, call the function `,ghosttyProjectStartup` (or type <kbd>Ctrl+x then p</kbd>) to choose from the list of _.applescript_ files in [scripts/ghostty/](scripts/ghostty/) and invoke them.

## Frequently Asked Questions (FAQs)

1. What is this strange behavior happening with my `cd` commmand? It takes me to directories not in my current working directory.

- `cd` has been replaced by `zoxide`. See the #aliases section above to learn more or if you wish to revert back to the built-in `cd` command.

2. How is my prompt being customized and how can I change it?

- The prompt is managed by [Oh My Posh](https://ohmyposh.dev). You can configure it by editing _dot-config/ohmyposh/ohmyposh.toml_ or deleting that file if you want to revert to the default prompt setup.
