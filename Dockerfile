FROM ubuntu:jammy

RUN apt update

RUN apt install -y software-properties-common

RUN add-apt-repository ppa:neovim-ppa/unstable

RUN apt install -y build-essential openssl curl wget cmake \
    pkg-config libtool automake unzip git python3-pip neovim

RUN mkdir /workspace

RUN mkdir -p /root/.config/nvim

RUN ln -s /usr/bin/nvim /usr/bin/vim

# install LSPs
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash

RUN apt install nodejs

RUN node -v
RUN npm -v

# install pyright
RUN npm i -g pyright

RUN apt install ripgrep

# install jdtls
RUN apt install -y openjdk-17-jdk

WORKDIR /root/jdtls
RUN curl -LO https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz
RUN tar -xzvf jdt-language-server-1.9.0-202203031534.tar.gz
RUN rm jdt-language-server-1.9.0-202203031534.tar.gz


RUN add-apt-repository ppa:fish-shell/release-3
RUN apt update
RUN apt install -y fish

RUN mkdir -p ~/.config/fish
RUN echo "set fish_greeting" >> ~/.config/fish/config.fish

WORKDIR /root/lua_lsp
RUN curl -LO https://github.com/LuaLS/lua-language-server/releases/download/3.6.18/lua-language-server-3.6.18-linux-x64.tar.gz
RUN tar -xzvf lua-language-server-3.6.18-linux-x64.tar.gz
RUN rm lua-language-server-3.6.18-linux-x64.tar.gz
RUN fish -c "fish_add_path /root/lua_lsp/bin"

WORKDIR /root/lombok
RUN curl -LO https://projectlombok.org/downloads/lombok.jar

# install dap
RUN pip install debugpy

RUN apt install xclip

WORKDIR /workspace

# install tsserver
RUN npm install -g typescript typescript-language-server

# install node dap
WORKDIR /root/node_dap
RUN curl -LO https://github.com/microsoft/vscode-js-debug/archive/refs/tags/v1.77.2.tar.gz
RUN tar -xzvf v1.77.2.tar.gz
RUN rm v1.77.2.tar.gz

WORKDIR /workspace

COPY .gitconfig /root/.gitconfig

ENV EDITOR nvim

# dotfiles
ARG CACHEBUST=1 
RUN git clone https://github.com/A-Siam/nvim-conf /root/.config/nvim


CMD ["nvim", "-v"]

