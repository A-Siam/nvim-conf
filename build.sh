#/usr/bin/env bash
if [[ ! -f ~/.gitconfig ]]; then
    echo "please configure git first"
    exit 1
fi
cp ~/.gitconfig .
docker build -t docker_nvim:latest \
    --build-arg CACHEBUST=$(date +%s)  .      

rm .gitconfig
