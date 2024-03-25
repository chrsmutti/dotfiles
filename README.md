# dotfiles

My dotfiles with `GNU Stow` support.

## Requirements

-   Install [GNU Stow](https://www.gnu.org/software/stow/)
-   Clone this repository.

```bash
git clone https://github.com/chrsmutti/dotfiles.git ~/Workspace/dotfiles
```

## Usage

`GNU Stow` will create symlinks for files in your home directory. The target directory for stow will be the `$HOME` directory.

Navigate to your dotfiles directory and use stow to symlink a package:

```bash
cd ~/Workspace/dotfiles
 stow -t $HOME .
```
