FROM ubuntu:22.04

RUN apt update && \
    apt-get update && \
    apt install -y curl git zsh

SHELL [ "/bin/bash", "-c" ]

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
RUN . $HOME/.nvm/nvm.sh && \
    nvm install --lts && \
    nvm use --lts && \
    node -v && npm -v && \
    npm i -g yarn && \
    npm install -g @angular/cli

RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

RUN echo "source ~/.nvm/nvm.sh" >> $HOME/.zshrc
RUN echo "ng v" >> $HOME/.zshrc
RUN echo "eval '$(starship init zsh)'" >> $HOME/.zshrc

RUN mkdir ~/.config/
COPY starship.toml /root/.config/starship.toml

EXPOSE 4200

CMD ["zsh"]
