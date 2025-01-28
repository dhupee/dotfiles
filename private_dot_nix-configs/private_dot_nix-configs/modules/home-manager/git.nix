{pkgs, ...}: {
  # the issue starts to get annoying
  # so use traditional .gitconfig instead
  programs.git = {
    enable = true;
    userEmail = "narutohaj00@gmail.com";
    userName = "Daffa Haj Tsaqif";
    lfs = {
      enable = true;
    };
    # extraConfig = {
    #     user.name = "Daffa Haj Tsaqif";
    #     user.email = "narutohaj00@gmail.com";
    # };
  };
}
