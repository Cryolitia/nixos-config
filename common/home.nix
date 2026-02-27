{
  lib,
  inputs,
  pkgs,
  ...
}:

{

  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  programs.nix-index.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cryolitia";
  home.homeDirectory =
    if pkgs.stdenv.hostPlatform.isDarwin then "/Users/cryolitia" else "/home/cryolitia";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  programs.zsh = {
    enable = true;
    initContent = ''
      source ~/.p10k.zsh
    '';
    history = {
      extended = true;
      save = 999999;
      size = 999999;
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "Cryolitia PukNgae";
        email = "Cryolitia@gmail.com";
      };
      core = {
        autocrlf = "input";
      };
      # smtp4dev
      sendemail = {
        smtpServer = "localhost";
        smtpServerPort = 25;
      };
      pull = {
        ff = "only";
      };
    };
  };

  # https://github.com/nix-community/home-manager/issues/4816
  #  programs.gh = {
  #    enable = true;
  #    gitCredentialHelper.enable = true;
  #  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".p10k.zsh".source = ../dotfiles/.p10k.zsh;
    ".config/hyfetch.json".source = ../dotfiles/hyfetch.json;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
    };
  };

  programs.gpg = {
    enable = true;
    # https://github.com/nix-community/home-manager/issues/5383, shame on you!
    settings = lib.mkForce {
      ask-cert-level = true;
      keyserver-options = [
        "no-self-sigs-only"
        "no-import-clean"
      ];
      armor = true;
    };
    # dirmngrSettings = {
    #   keyserver = "hkps://keyserver.ubuntu.com";
    #   # https://github.com/rvm/rvm/issues/4215#issuecomment-435228758
    #   disable-ipv6 = true;
    # };
  };

  home.file.".gnupg/dirmngr.conf".text =
    lib.generators.toKeyValue
      {
        mkKeyValue =
          key: value: (if lib.isString value then "${key} ${value}" else lib.optionalString value key);
        listsAsDuplicateKeys = true;
      }
      {
        keyserver = "hkps://keyserver.ubuntu.com";
        # https://github.com/rvm/rvm/issues/4215#issuecomment-435228758
        disable-ipv6 = true;
      };
}
