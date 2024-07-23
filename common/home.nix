{ lib, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cryolitia";
  home.homeDirectory = "/home/cryolitia";

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
    initExtra = ''
      source ~/.p10k.zsh
      export SSH_AUTH_SOCK="/run/user/1000/gnupg/S.gpg-agent.ssh"
    '';
    history = {
      extended = true;
      save = 999999;
      size = 999999;
    };
  };

  programs.git = {
    enable = true;
    userName = "Cryolitia PukNgae";
    userEmail = "Cryolitia@gmail.com";
    extraConfig = {
      core = {
        autocrlf = "input";
      };
    };
  };

  # https://github.com/nix-community/home-manager/issues/4816
  #  programs.gh = {
  #    enable = true;
  #    gitCredentialHelper.enable = true;
  #  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cryolitia/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
    EDITOR = "nvim";
    SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
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
