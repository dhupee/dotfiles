#!/bin/bash

repository_url="https://github.com/gaganpreet/plasma-applet-eventcalendar.git"
install_directory=".eventcalendar"

if [ "$1" = "--update" ]; then
    cd "$install_directory"
    sh ./install --restart
elif [ "$1" = "--uninstall" ]; then
    cd "$install_directory"
    sh ./uninstall
else
    git clone "$repository_url" "$install_directory"
    cd "$install_directory"
    sh ./install
fi
