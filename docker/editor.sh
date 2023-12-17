LOCAL_UID=$(id -u)
LOCAL_GID=$(id -g)

docker run \
  --rm -it \
  -e LOCAL_UID=$LOCAL_UID \
  -e LOCAL_GID=$LOCAL_GID \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/.gitconfig:/etc/gitconfig \
  -v ~/development/:/root/development/ \
  editor:base \
  "/home/user/dotfiles/.bin/tmux-layout-setup.sh"
