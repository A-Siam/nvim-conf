#!/usr/bin/env bash
echo "started adding directries to safe wrokspaces"
for dir in $(ls ~/workspace); do
    git config --global --add safe.directory "/workspace/$dir"
done
