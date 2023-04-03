#!/usr/bin/env bash
tmux set-hook -g session-window-changed "run-shell '~/dotfiles/.bin/yabacritmux/ipc/client.sh change'"
tmux set-hook -g window-layout-changed "run-shell '~/dotfiles/.bin/yabacritmux/ipc/client.sh resize'"
tmux set-hook -g window-pane-changed "run-shell '~/dotfiles/.bin/yabacritmux/ipc/client.sh focus'"
# tmux set-hook -g session-window-changed ""
# tmux set-hook -g window-layout-changed ""
# tmux set-hook -g window-pane-changed ""
