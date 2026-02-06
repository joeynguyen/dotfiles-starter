# dotfiles-starter

A zsh-focused dotfiles starter template for MacOS, but lots of configurations are compatible with Linux.

Linux support may be added in the future but no guarantees. Create a Pull Request if you want to help make it happen sooner.

## Getting started

First, fork this repo so you can start maintaining your own dotfiles repo, and name your fork `dotfiles`, not `dotfiles-starter`.

### Installing CLI applications

1. [Install Brew](https://brew.sh/)
1. Follow the instructions provided at the completion of the Brew installation process for adding a line to your `~/.zshrc`. Also run the `eval "... shellenv)"` line in your current Terminal to start using `brew` right away.
1. From the root of this repo, run `brew bundle`
   - this will install all apps listed in the _Brewfile_ file

### Set up recommended Zsh and CLI app configurations

1. Back up your current _~/.zshrc_ file
   - `mv ~/.zshrc ~/.zshrc-backup`
1. Create a _~/.my-env-secrets_ file and copy over any secrets from your old _.zshrc_ that you don't want committed to git
   - Manually copy the _my-env-secrets-example_ file from this directory to your `$HOME` directory
     - `cp ./my-env-secrets-example ~/.my-env-secrets`
1. In the _dot-zshrc_ file,
   - update the `DOTFILES_GIT_DIR` variable to match the location of this folder on your computer
   - copy any important settings from your _~/.zshrc-backup_ file to _dot-zshrc_ in this folder
1. Check for potential `stow` conflicts:
   - From the root of this repo, run `stow --simulate --verbose .`
1. From the root of this repo, run `stow .`
1. Exit your current shell session and reopen a new one. Zinit will install itself and you'll get all of the updated settings applied to your new shell.

## CLI tools

### fzf

`<Ctrl-T>` - opens a typeahead that can filter through directories and filenames under the current directory and pastes the selection into the current command prompt - can be useful for `git add [PATH_TO_FILE]` operations after doing a `git status` to see which files have changed

### zoxide

Replace `cd` with `zoxide`

`cdi`/`cdq` for interactive query

### wd

warp directory - bookmark directories

## aliases

Recommendation: prefix your long/less-often-used aliases with a comma, e.g. `,git_browser_url`.

- easier to find when autocompleting using Tab
- commas aren't special characters unlike other symbols ($, #, ?, etc.)

## Ghostty

<kbd>Command+Shift+P</kbd> - activate Command Palette

```sh
ghostty --help
ghostty +list-themes
ghostty +list-keybinds
ghostty +list-actions
```

## Other productivity tips

### Copy text from images

### Text expansion setup

### Clipboard history setup

### Chrome Extensions

1. Vimium

### Other tips
