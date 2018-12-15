#!/bin/bash

CURRENT_FILE_DIR=$(dirname $0)

. "$CURRENT_FILE_DIR/test-utils.sh"
. "$CURRENT_FILE_DIR/../src/flag.sh"

# use a temporary file for testing to not override exiting flags
FLAGS_FILE="$HOME/.dotfiles-flags-test"

FLAG_ID=$(uuidgen)

assert $(not $(flag_is_set $FLAG_ID)) "New flags should be unsetted by default"

flag_set $FLAG_ID
assert $(flag_is_set $FLAG_ID) "flag_set should correctly set the flag"

flag_unset $FLAG_ID
assert $(not $(flag_is_set $FLAG_ID)) "flag_unset should correctly unset the flag"

# remove temporary test flag file
rm $FLAGS_FILE

