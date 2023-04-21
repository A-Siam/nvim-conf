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

RUN npm install -g ts-node

ENV MAIN_SHELL fish

COPY safe_git_workspace.sh /opt/safe_git_workspace.sh

RUN chmod +x /opt/safe_git_workspace.sh

RUN echo "/opt/safe_git_workspace.sh" >> /root/.config/fish/config.fish

# lazygit
COPY lazygit_bootstrap.sh /opt/lazygit_bootstrap.sh
RUN bash /opt/lazygit_bootstrap.sh

RUN npm i -g yarn
RUN yarn global add yaml-language-server

COPY java_dap_build.sh /opt/java_dap_build.sh
RUN bash /opt/java_dap_build.sh

WORKDIR /root/go_lsp
RUN curl -LO https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz
RUN fish -c "fish_add_path /usr/local/go/bin"
RUN /usr/local/go/bin/go install golang.org/x/tools/gopls@latest

RUN /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest

RUN fish -c "fish_add_path /root/go/bin"

WORKDIR /workspace
# dotfiles
ARG CACHEBUST=1 
RUN git clone https://github.com/A-Siam/nvim-conf /root/.config/nvim

CMD ["nvim", "-v"]

