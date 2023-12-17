FROM alpine:latest

RUN set -ex && \
    apk update && \
    apk upgrade && \
    apk --no-cache add \
    shadow \
    su-exec \
    procps \
    zsh \
    bash \
    curl \
    wget \
    unzip \
    git \
    docker \
    docker-compose \
    nodejs \
    npm \
    ripgrep \
    lazygit \
    neovim \
    tmux \
    gcc \
    musl-dev
    # alpine-sdk \
    # build-base

# RUN set -ex && \
#     apk --no-cache add --virtual build-dependencies \
#     make \
#     autotools-dev \
#     automake \
#     bison \
#     build-essential \
#     pkg-config \
#     libevent-dev \
#     libncurses5-dev

RUN wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz && \
    rm -rf go1.21.4.linux-amd64.tar.gz 
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH $HOME/go
ENV PATH $PATH:$GOPATH/bin

RUN wget https://github.com/peco/peco/releases/download/v0.5.11/peco_linux_amd64.tar.gz && \
    tar xzvf peco_linux_amd64.tar.gz && \
    cd peco_linux_amd64 && \
    cp peco /usr/local/bin

RUN go install github.com/x-motemen/ghq@latest

# RUN apk del build-dependencies

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

RUN usermod -aG docker user

# COPY --chown=user:user ../../.config /home/$USERNAME/.config

# RUN chown -R user /home/$USERNAME/

WORKDIR /home/$USERNAME/
USER $USERNAME

RUN git clone --recursive -b editor https://github.com/mocaffy/dotfiles.git

RUN ln -fns /home/$USERNAME/dotfiles/.config /home/$USERNAME
RUN ln -fns /home/$USERNAME/dotfiles/.config/astro-nvim /home/$USERNAME/.config/nvim/lua/user
RUN chmod u+x /home/user/dotfiles/.bin/tmux-layout-setup.sh

LABEL \
        maintainer="mocaffy@gmail.com" \
        url.github="https://github.com/mocaffy/dotfiles"

RUN set -ex && nvim +:q

RUN set -ex && NVIM_APPNAME=nvim-term nvim -u ~/.config/nvim-term/init.lua +:q

RUN $HOME/dotfiles/.config/tmux/plugins/tpm/bin/install_plugins

RUN git clone https://github.com/mocaffy/tmux-tabicon-theme.git ~/.config/tmux/tabicon-theme/

RUN wget https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info && \
    tic -xe alacritty,alacritty-direct alacritty.info && \
    rm alacritty.info

ENV TERM alacritty-direct

RUN curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh >24-bit-color.sh

RUN echo "alias start='/home/user/dotfiles/.bin/tmux-layout-setup.sh'" >> ~/.bashrc

USER root

RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

RUN echo "export STARSHIP_CONFIG=~/.config/starship/starship.toml" >> /home/user/.zshrc
RUN echo "eval '$(starship init zsh)'" >> /home/user/.zshrc

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
