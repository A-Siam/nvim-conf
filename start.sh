#/usr/bin/env bash
cache_dir="$HOME/nvim_cache"
projects_dir="$HOME/projects"
java_workspace="$HOME/jdtws"

mkdir -p "$cache_dir"
mkdir -p "$projects_dir"

xhost +local:root
docker run -v "$cache_dir":/root/.local/share/nvim \
           -v "$java_workspace":/root/java-workspaces \
           -v "$projects_dir":/workspace \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v "$HOME/.ssh":"/root/.ssh" \
           -e DISPLAY=$DISPLAY \
           --net="host" \
           --user "$(id -u):$(id -g)" \
           --rm -it --detach-keys="ctrl-z,e" docker_nvim fish
xhost -local:root
