# dotfiles ![travis](https://travis-ci.com/chrsmutti/dotfiles.svg?branch=master)

My dotfiles written as Ansible roles. Sets up a full local development environment with a single command.
**Only Arch Linux supported**

Based on [sloria's dotfiles](https://github.com/sloria/dotfiles).

## install

- Install [ansible](https://wiki.archlinux.org/index.php/Ansible).
- Clone and run ansible.

```bash
git clone https://github.com/chrsmutti/dotfiles.git ~/Workspace/dotfiles
```

- Update the following variables in `group_vars/local` (at a minimum)
  - `full_name`: Your name, which will be attached to commit messages, e.g. "Christian Mutti"
  - `git_email`: Your git email address.
- Edit `site.yml` as you see fit. Remove any roles you don't use. Edit roles that you do use.
- If you did not chose to clone the `dotfiles` repo to `~/Workspace`, you should change the `clone_folder` var.
- For some roles you need `yay` installed.

```
cd ~/Workspace/dotfiles
ansible-playbook -i inventory.local site.yml
```

## modules

Modules inside `library` dir.

- [ansible-yay](https://github.com/mnussbaum/ansible-yay)
