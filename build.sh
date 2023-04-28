#/usr/bin/env bash
cp ~/.gitconfig .
docker build -t docker_nvim:latest \
    --no-cache \
    --build-arg CACHEBUST=$(date +%s)  .      

rm .gitconfig
