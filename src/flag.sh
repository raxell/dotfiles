#!/bin/bash

# Set of functions to manage persistent flags. Those flags can be
# used to share state across multiple script executions.
# A possible usage is for implementing idempotent functions or
# functions that must be executed a single time (e.g. those to
# setup/initialize an environment).
#
# Flags are setted/unsetted by simply adding/removing them to a
# file, no more no less.

FLAGS_FILE="$HOME/.dotfiles-flags"

# Sets the given flag.
#
# Usage:
#   flag_set "flag_id"
#
function flag_set {
    echo $1 >> $FLAGS_FILE
}

# Unsets the given flag.
#
# Usage:
#   flag_unset "flag_id"
#
function flag_unset {
    local TMP_FILE="/tmp/$(uuidgen)"
    grep -v $1 $FLAGS_FILE > $TMP_FILE; mv $TMP_FILE $FLAGS_FILE
}

# Checks if the given flag has been set.
# Echoes "true" if it is set, "false" otherwise.
#
# Usage:
#   flag_is_set "flag_id"
#
function flag_is_set {
    if [ $(grep -s $1 $FLAGS_FILE) ]; then
        echo true
    else
        echo false
    fi
}

