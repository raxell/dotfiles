#!/bin/bash

SESSION_NAME='pp-dev'

tmux has-session -t $SESSION_NAME 2> /dev/null

if [ $? != 0 ]; then
    # Create a new session for prontopro-dev
    tmux new-session -s $SESSION_NAME -d

    # Setup a window for starting and managing the dev environment
    tmux rename-window -t $SESSION_NAME 'Dev Environment'

    # Create 3 panes:
    #  * a general purpose one for sending commands
    #  * another for seeing the status of frontend compilation
    #  * a last one for watching for changes in frontend code
    tmux split-window -h -t $SESSION_NAME
    tmux split-window -v -t $SESSION_NAME
    tmux send-keys -t $SESSION_NAME:0.0 ' z dev-environment' C-m
    tmux send-keys -t $SESSION_NAME:0.1 ' z dev-environment' C-m
    tmux send-keys -t $SESSION_NAME:0.2 ' z dev-environment' C-m

    tmux send-keys -t $SESSION_NAME:0.0 ' docker-machine start prontopro-dev && eval $(docker-machine env prontopro-dev) && ppro up && ppro composer install && ppro fixtures -r && tmux wait-for -S ppro' C-m

    tmux send-keys -t $SESSION_NAME:0.2 ' tmux wait-for ppro; eval $(docker-machine env prontopro-dev) && ppro watch' C-m
    tmux send-keys -t $SESSION_NAME:0.1 ' tmux wait-for ppro; eval $(docker-machine env prontopro-dev) && docker restart pp_frontend && docker logs -f pp_frontend' C-m

    tmux select-pane -t 0
fi


# Attach to the session
tmux attach-session -t $SESSION_NAME

