#!/usr/bin/sh

# default file directory
FILEDIR=$HOME/.codium-extensions.txt

# alternative file directory if user provides it
ALT_FILEDIR=$1
if [ "$ALT_FILEDIR" != "" ]; then
    FILEDIR=$ALT_FILEDIR
fi

# install the extensions line by line
while IFS= read -r extension; do
    codium --install-extension $extension
done < "$FILEDIR"

# make sure the extensions are updated
# lmao it's updated anyway
# codium --update-extensions
