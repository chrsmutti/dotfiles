FROM chrsmutti/archlinux-yay

USER root
RUN useradd -m dotfiles
RUN pacman -Syuq --needed --noconfirm
RUN pacman -Sq --needed --noconfirm ansible fontconfig unzip zip

RUN mkdir -p /opt/Workspace/
RUN chown -R dotfiles.dotfiles /opt/Workspace
RUN printf 'dotfiles ALL=(ALL) NOPASSWD: ALL\n' | tee -a /etc/sudoers

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
