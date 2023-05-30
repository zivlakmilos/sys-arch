FROM archlinux AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN pacman -Syuu --noconfirm && \
    pacman -S --noconfirm ansible git curl sudo

FROM base AS zi
ARG TAGS
RUN groupadd --gid 1000 zi
RUN useradd --uid 1000 --gid 1000 -ms /bin/bash zi
RUN usermod -aG wheel zi
RUN passwd -d zi
RUN echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
USER zi
WORKDIR /home/zi

FROM zi
RUN mkdir /home/zi/sys-arch
WORKDIR /home/zi/sys-arch
COPY --chown=zi:zi . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
