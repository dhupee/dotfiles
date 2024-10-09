{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        initExtra = ''
            source ~/.p10k.zsh

            # Sourcing aliases
            if [ -d ~/.aliases/ ]; then
                # Loop through all .sh files in the aliases directory and source them
                for file in ~/.aliases/*.sh; do
                    if [ -f "$file" ]; then
                        source "$file"
                    fi
                done
            else
                echo "Aliases directory not found"
            fi


            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

            '';
        # initExtra = "source ~/.p10k.zsh";
        oh-my-zsh = {
            enable = true;
            # theme = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
            theme = "robbyrussell";
            plugins = [
                "thefuck"
                "copypath"
                "docker"
                "podman"
                "qrcode"
                "nvm"
                "node"
                "npm"
                "pyenv"
                "python"
                "golang"
                "zoxide"
            ];
        };
    };
}
