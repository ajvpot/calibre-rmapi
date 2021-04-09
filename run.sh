#!/usr/bin/env bash
set -xeuo pipefail

# check auth, if this fails we will bail.
/rmapi -ni ls > /dev/null

# monitor for updates
cd "$1"
while true; do
 inotifywait -e moved_to -e create -e delete -e delete_self -r .
 /rmapi -ni mput "${TARGET_FOLDER:-books}"
done
