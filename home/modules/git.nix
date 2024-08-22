{config, pkgs, ...}:
{

  programs.git = {
    enable = true;
    userName = config.sops.secrets.gitUser.path;
    userEmail = config.sops.secrets.gitEmail.path;
    extraConfig = {
      credential.helper = "${pkgs.git}/libexec/git-core/git-credential-store --file ${config.sops.secrets.gitCred.path}";
    };

  };
}
