#!/usr/bin/bash

dir_array=(
    "$HOME/.nix-configs/"
    "$HOME/.scripts/"
    "$HOME/.distrobox-manifests/"
    "$HOME/Templates/"
    "$HOME/Wallpapers/"
)

# file_array=(
# )

encrypted_dir_array=(
    "$HOME/.ssh/"
    "$HOME/.secrets/"
    "$HOME/.torrents/"
)

# encrypted_file_array=(
# )

#----------------------SAVING FILES AND DIRS----------------------

for d in "${dir_array[@]}"; do
    if [ -d $d ]; then
        # echo "$d exists"
        echo "adding $d"
    else
        echo "$d is not exists"
        read -p "Would you like to make one? (y/n)?" choice
        case "$choice" in
        y | Y) echo "yes, creating directory $d" && mkdir $d ;;
        n | N) echo "skipping" ;;
        *) echo "choice is invalid" ;;
        esac

    fi
    # also change attribute with chezmoi
    # chezmoi add $d
    chezmoi re-add $d
    chezmoi chattr --recursive -- -private $d
done

# for f in "${file_array[@]}"; do
#     if [ -f $f ]; then
#         echo "adding $f"
#     else
#         echo "$f is not exists"
#         echo ""
#     fi
#
#     chezmoi add $f
# done

#-----------------ENCRYPTING AND ADDING DIRS AND FILES---------------------

for d in "${encrypted_dir_array[@]}"; do
    if [ -d $d ]; then
        # echo "$d exists"
        echo "adding and encrypting $d"
    else
        echo "$d is not exists"
        read -p "Would you like to make one? (y/n)?" choice
        case "$choice" in
        y | Y) echo "yes, creating directory $d && mkdir $d" ;;
        n | N) echo "skipping" ;;
        *) echo "choice is invalid" ;;
        esac

    fi
    # chezmoi add --encrypt $d
    chezmoi re-add $d
done

# for f in "${encrypted_file_array[@]}"; do
#     if [ -f $f ]; then
#         echo "adding and encrypting $f"
#     else
#         echo "$f is not exists"
#         echo ""
#     fi
#
#     chezmoi add --encrypt $f
# done

echo " "
echo "Dotsave is done, go to Chezmoi directory to push to git manually"
