#!/usr/bin/env bash
tmp_file="/tmp/safe_git_wokspaces_only_run_once"
if [[ ! -f $tmp_file ]]; then
    echo "started adding directries to safe wrokspaces"
    for dir in $(ls /workspace); do
        git config --global --add safe.directory "/workspace/$dir"
    done
    touch $tmp_file
fi
