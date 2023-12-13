FROM ubuntu:22.04

RUN apt update && \
    apt-get update && \
    apt install -y curl git ripgrep tar unzip wget zsh make autotools-dev automake bison build-essential pkg-config libevent-dev libncurses5-dev

RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm get-docker.sh

RUN apt install -y locales && \
    locale-gen ja_JP.UTF-8

SHELL [ "/bin/bash", "-c" ]

RUN wget https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz && \
    tar -zxvf nvim-linux64.tar.gz && \
    mv nvim-linux64/bin/nvim usr/bin/nvim && \
    mv nvim-linux64/lib/nvim usr/lib/nvim && \
    mv nvim-linux64/share/nvim/ usr/share/nvim && \
    rm -rf nvim-linux64 && \
    rm nvim-linux64.tar.gz

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit /usr/local/bin

RUN git clone https://github.com/tmux/tmux /usr/local/src/tmux/ && \
    cd /usr/local/src/tmux/ && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    rm -rf /usr/local/src/tmux/

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

RUN apt-get update && apt-get -y install gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

RUN git clone --recursive https://github.com/mocaffy/dotfiles.git /home/$USERNAME/dotfiles/

WORKDIR /home/$USERNAME/
USER $USERNAME

RUN ln -fns /home/$USERNAME/dotfiles/.config /home/$USERNAME
RUN ln -fns /home/$USERNAME/dotfiles/.config/astro-nvim /home/$USERNAME/.config/nvim/lua/user
RUN chmod u+x /home/user/dotfiles/.bin/tmux-layout-setup.sh

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
RUN . $HOME/.nvm/nvm.sh && \
    nvm install --lts && \
    nvm use --lts && \
    node -v && npm -v && \
    npm i -g yarn

RUN echo "source ~/.nvm/nvm.sh" >> $HOME/.zshrc

RUN nvim +:q
RUN NVIM_APPNAME=nvim-term nvim -u ~/.config/nvim-term/init.lua +:q

RUN $HOME/dotfiles/.config/tmux/plugins/tpm/bin/install_plugins

RUN git clone https://github.com/mocaffy/tmux-tabicon-theme.git ~/.config/tmux/tabicon-theme/

RUN wget https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info && \
    tic -xe alacritty,alacritty-direct alacritty.info && \
    rm alacritty.info

RUN curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh >24-bit-color.sh

ENV TERM alacritty-direct

RUN echo "alias start='/home/user/dotfiles/.bin/tmux-layout-setup.sh'" >> ~/.bashrc

USER root

RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

RUN echo "export STARSHIP_CONFIG=~/.config/starship/starship.toml" >> /home/user/.zshrc
RUN echo "eval '$(starship init zsh)'" >> /home/user/.zshrc
RUN usermod -aG docker user

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# CMD ["bash"]

# CMD ["/root/dotfiles/.bin/tmux-layout-setup.sh"]
