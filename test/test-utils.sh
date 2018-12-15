#!/bin/bash

# Thsi function Will print:
#   "✔ message" on success
#   "✘ message" on failure
#
# Usage:
#   asssert bool_value "message"
#   asssert $(func x y z) "message"
#
# Where bool_value must be one of "true" or "false".
# You can also pass the result of evaluating a function, such as
# "$(func x y z)". In that case func must be a boolean function
# that echoes "true" on success and "false" on failure.
#
function assert {
    local RES=""

    if [ $1 = true ]; then
        RES+="✔ "
    elif [ $1 = false ]; then
        RES="✘ "
    fi

    RES+=$2

    echo $RES
}

# Turns "true" in "false" and "false" in "true".
#
function not {
    if [ $1 = true ]; then
        echo false
    elif [ $1 = false ]; then
        echo true
    fi
}

