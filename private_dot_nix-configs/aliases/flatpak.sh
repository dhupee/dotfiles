# Flatpak
if [[ -d "$HOME/.var/app/org.openscad.OpenSCAD" ]]; then
    alias openscad="flatpak run org.openscad.OpenSCAD"
fi

# Bottles CLI
if [[ -d "$HOME/.var/app/com.usebottles.bottles" ]]; then
    alias bottles-cli="flatpak run --command=bottles-cli com.usebottles.bottles"
fi
