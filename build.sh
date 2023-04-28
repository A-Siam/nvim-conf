#/usr/bin/env bash
cp ~/.gitconfig .
docker build -t docker_nvim:latest \
    --build-arg CACHEBUST=$(date +%s)  .      

rm .gitconfig
