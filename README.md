# dotfiles

My dotfiles with `homer` support.

## Requirements

- Install [homer](https://github.com/chrsmutti/homer#installation)
- Clone this repository.

```bash
git clone https://github.com/chrsmutti/dotfiles.git ~/Workspace/dotfiles
```

## Usage

`homer` will link all files inside the `home` directory into it's repesctive
folders in `$HOME`.

```sh
cd ~/Workspace/dotfiles
homer

./scripts/init-vim.sh # some minor stuff for nvim to function properly.
```

