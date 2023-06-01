FROM ubuntu:jammy

RUN apt update

RUN apt install -y software-properties-common

RUN add-apt-repository ppa:neovim-ppa/unstable

RUN apt install -y build-essential openssl curl wget cmake \
    pkg-config libtool automake unzip git python3-pip neovim sudo fish

ENV EDITOR nvim


ENV MAIN_SHELL fish


RUN ln -s /usr/bin/nvim /usr/bin/vim

ARG USERNAME=a

RUN useradd -m ${USERNAME}
RUN usermod -aG sudo ${USERNAME}
RUN echo -e "${USERNAME}\n${USERNAME}" | passwd -S ${USERNAME}

USER ${USERNAME}

RUN mkdir /home/${USERNAME}/workspace

RUN mkdir -p /home/${USERNAME}/.config/nvim

# install LSPs
USER root
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash

RUN apt install nodejs

RUN node -v
RUN npm -v

USER ${USERNAME}
RUN npm set prefix /home/${USERNAME}/.npm

RUN mkdir -p /home/${USERNAME}/.npm/bin

RUN ["/usr/bin/fish", "-c", "fish_add_path ~/.npm/bin"]

# install pyright
RUN npm i -g pyright
 
USER root
RUN apt install ripgrep

# install jdtls
RUN apt install -y openjdk-17-jdk

USER ${USERNAME}

RUN mkdir -p /home/${USERNAME}/jdtls
 
WORKDIR /home/${USERNAME}/jdtls
RUN curl -LO https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz
RUN tar -xzvf jdt-language-server-1.9.0-202203031534.tar.gz
RUN rm jdt-language-server-1.9.0-202203031534.tar.gz
  
USER root
 
RUN add-apt-repository ppa:fish-shell/release-3
RUN apt update
RUN apt install -y fish
 
USER ${USERNAME}
RUN mkdir -p /home/${USERNAME}/.config/fish
RUN echo "set fish_greeting" >> /home/${USERNAME}/.config/fish/config.fish
 
RUN mkdir /home/${USERNAME}/lua_lsp
WORKDIR /home/${USERNAME}/lua_lsp
RUN curl -LO https://github.com/LuaLS/lua-language-server/releases/download/3.6.18/lua-language-server-3.6.18-linux-x64.tar.gz
RUN tar -xzvf lua-language-server-3.6.18-linux-x64.tar.gz
RUN rm lua-language-server-3.6.18-linux-x64.tar.gz
RUN fish -c "fish_add_path ~/lua_lsp/bin"

RUN mkdir -p /home/${USERNAME}/lombok
WORKDIR /home/${USERNAME}/lombok
RUN curl -LO https://projectlombok.org/downloads/lombok.jar
 
# install dap
RUN pip install debugpy

USER root 
RUN apt install xclip
 
USER ${USERNAME}
RUN mkdir -p /home/${USERNAME}/workspace
WORKDIR /home/${USERNAME}/workspace
 
# install tsserver
RUN npm install -g typescript typescript-language-server

# install node dap
RUN mkdir -p /home/${USERNAME}/node_dap
WORKDIR /home/${USERNAME}/node_dap
RUN curl -LO https://github.com/microsoft/vscode-js-debug/archive/refs/tags/v1.77.2.tar.gz
RUN tar -xzvf v1.77.2.tar.gz
RUN rm v1.77.2.tar.gz
 
WORKDIR /home/${USERNAME}/workspace
 
 
RUN npm install -g ts-node
RUN mkdir /home/${USERNAME}/.scripts
COPY safe_git_workspace.sh /home/${USERNAME}/.scripts/safe_git_workspace.sh
 
USER root
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.scripts/safe_git_workspace.sh

USER ${USERNAME}
RUN chmod +x /home/${USERNAME}/.scripts/safe_git_workspace.sh
 
RUN echo "/home/${USERNAME}/.scripts/safe_git_workspace.sh" >> /home/${USERNAME}/.config/fish/config.fish
 
# lazygit
COPY lazygit_bootstrap.sh /home/${USERNAME}/.scripts/lazygit_bootstrap.sh

USER root
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.scripts/lazygit_bootstrap.sh
RUN chmod +x /home/${USERNAME}/.scripts/lazygit_bootstrap.sh
RUN bash /home/${USERNAME}/.scripts/lazygit_bootstrap.sh

USER ${USERNAME}
 
RUN npm i -g yarn
RUN /home/${USERNAME}/.npm/bin/yarn global add yaml-language-server@1.11.0
 
COPY java_dap_build.sh /home/${USERNAME}/.scripts/java_dap_build.sh

RUN mkdir -p /home/${USERNAME}/go_lsp
WORKDIR /home/${USERNAME}/go_lsp
RUN curl -LO https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
USER root
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz

USER ${USERNAME}
RUN fish -c "fish_add_path /usr/local/go/bin"
RUN /usr/local/go/bin/go install golang.org/x/tools/gopls@latest
 
RUN /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest
 
RUN fish -c "fish_add_path ~/go/bin"

RUN echo 'SETUVAR fish_key_bindings:fish_vi_key_bindings' >> /home/${USERNAME}/.config/fish/fish_variables

RUN /home/${USERNAME}/.npm/bin/yarn global add prettier
USER root 
RUN apt install -y tmux
 
USER ${USERNAME}
RUN /home/${USERNAME}/.npm/bin/yarn global add @prisma/language-server
 
# download pmd for java static analyser
RUN mkdir -p /home/${USERNAME}/pmd
WORKDIR /home/${USERNAME}/pmd
RUN curl -LO https://github.com/pmd/pmd/releases/download/pmd_releases%2F7.0.0-rc1/pmd-bin-7.0.0-rc1.zip
RUN unzip pmd-bin-7.0.0-rc1.zip
USER root
COPY pmd /usr/bin/pmd
RUN chmod +x /usr/bin/pmd

USER ${USERNAME}
# download google java format for formatting
RUN mkdir -p /home/${USERNAME}/gjf
WORKDIR /home/${USERNAME}/gjf
RUN curl -LO https://github.com/google/google-java-format/releases/download/v1.16.0/google-java-format-1.16.0-all-deps.jar

USER root
COPY google-java-format /usr/bin/google-java-format
RUN chmod +x /usr/bin/google-java-format

USER ${USERNAME} 
# install graphql lsp
RUN npm install -g graphql-language-service-cli
# 
# install html server
RUN npm i -g vscode-langservers-extracted
# 
# install tailwind css lsp
RUN npm install -g @tailwindcss/language-server
# 
# 

WORKDIR /home/${USERNAME}/workspace

USER root
RUN chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}

USER ${USERNAME}
# dotfiles
ARG CACHEBUST=1 
RUN git clone https://github.com/A-Siam/nvim-conf /home/${USERNAME}/.config/nvim

COPY .gitconfig /home/${USERNAME}/.gitconfig

CMD ["nvim", "-v"]
