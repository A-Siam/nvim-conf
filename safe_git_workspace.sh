#!/usr/bin/env bash

for dir in $(ls /workspace); do
    git config --global --add safe.directory "/workspace/$dir"
done

