#/usr/bin/env bash
docker build -t docker_nvim:latest --build-arg CACHEBUST=$(date +%s) .      

