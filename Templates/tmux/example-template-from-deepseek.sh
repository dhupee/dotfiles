#!/bin/bash

# Simple 2-window tmux template

SESSION_NAME="dev"
MAIN_WINDOW="editor"
SECOND_WINDOW="terminal"

# Check if session exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session $SESSION_NAME exists. Attaching..."
    tmux attach -t "$SESSION_NAME"
    exit 0
fi

# Create session with first window
echo "Creating session: $SESSION_NAME"
tmux new-session -d -s "$SESSION_NAME" -n "$MAIN_WINDOW"

# First window: split into two vertical panes
tmux split-window -h -t "$SESSION_NAME":"$MAIN_WINDOW" -p 30

# Second window: create and split into three panes
tmux new-window -t "$SESSION_NAME":2 -n "$SECOND_WINDOW"
tmux split-window -v -t "$SESSION_NAME":"$SECOND_WINDOW" -p 30
tmux split-window -h -t "$SESSION_NAME":"$SECOND_WINDOW".1 -p 50

# Go back to first window
tmux select-window -t "$SESSION_NAME":"$MAIN_WINDOW"

# Attach
tmux attach -t "$SESSION_NAME"