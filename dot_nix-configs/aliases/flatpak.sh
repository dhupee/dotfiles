# Flatpak
OPENSCAD_PATH="$HOME/.var/app/org.openscad.OpenSCAD"
if [[ -d $OPENSCAD_PATH ]]; then
    alias openscad="flatpak run org.openscad.OpenSCAD"
fi

# Bottles CLI
BOTTLES_PATH="$HOME/.var/app/com.usebottles.bottles"
if [[ -d $BOTTLES_PATH ]]; then
    alias bottles-cli="flatpak run --command=bottles-cli com.usebottles.bottles"
fi
