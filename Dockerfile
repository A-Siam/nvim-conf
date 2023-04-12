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

WORKDIR /workspace

# dotfiles
ARG CACHEBUST=1 
RUN git clone https://github.com/A-Siam/nvim-conf /root/.config/nvim


CMD ["nvim", "-v"]

