# dotfiles-starter

A zsh-focused dotfiles starter template for MacOS, but lots of configurations are compatible with Linux.

Linux support may be added in the future but no guarantees. Create a Pull Request if you want to help make it happen sooner.

## Getting started

First, fork this repo so you can start maintaining your own dotfiles repo.

### Installing CLI applications

1. [Install Brew](https://brew.sh/)
1. From the root of this repo, run `brew bundle`
   - this will install all apps listed in the _Brewfile_ file

### Set up recommended Zsh and CLI app configurations

1. Back up your _~/.zshrc_ file
   - `mv ~/.zshrc ~/.zshrc-backup`
1. Create a _~/.my-env-secrets_ file and copy over any secrets from your old _.zshrc_ that you don't want committed to git
   - Manually copy the _my-env-secrets-example_ file from this directory to your `$HOME` directory
   - `cp ./my-env-secrets-example ~/.my-env-secrets`
1. In the _dot-zshrc_ file,
   - update the `GIT_DOTFILES` variable to match the location of this folder on your computer
   - copy any important settings from your _~/.zshrc_ backup file to _dot-zshrc_ in this folder
1. From the root of this repo, run `stow .`

## CLI tools

### fzf

`<Ctrl-T>` - opens a typeahead that can filter through directories and filenames under the current directory and pastes the selection into the current command prompt. Can be useful for a command like `git add [PATH_TO_FILE_OR_FOLDER]`

## aliases

## Other productivity tips

### Copy text from images

### Text expansion setup

### Clipboard history setup

### Other tips

#### Chrome Extensions

1. Vimium

#### Screenshot text copy
