#!/bin/bash

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
usermod -u $USER_ID -o -m -d /home/user user
groupmod -g $GROUP_ID user

export HOME=/home/user
echo "alias angular='docker compose -f /home/mocaffy/docker-compose.yml exec angular zsh -c ng v'" >> /home/user/.zshrc
exec su-exec user "$@"
