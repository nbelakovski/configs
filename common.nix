{ config, pkgs, ... }:

let
  unstablePkgs = import <nixpkgs-unstable> {};
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home.packages = [
    pkgs.fd
    pkgs.eza
    pkgs.cmake
    pkgs.ninja
    pkgs.tree
    pkgs.wget
    pkgs.nmap
    pkgs.unrar
    pkgs.watch
    pkgs.bash-completion
    pkgs.bashInteractive
    pkgs.bash-preexec  # I think this one is necessary for atuin?
    pkgs.nix-bash-completions
    # vim-full appears to work fine on Darwin, but it appears that
    # vim-darwin is compiled with some sort of special support for Darwin so
    # let's use that.
    (if pkgs.stdenv.isDarwin then pkgs.vim-darwin else pkgs.vim-full)
  ];

  programs.atuin = {
    enable = true;
    package = unstablePkgs.atuin;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Nickolai Belakovski";
    aliases = {
      br = "branch";
      ci = "commit";
      co = "checkout";
      st = "status";
      wt = "worktree";
      sw = "switch";
    };
    extraConfig = {
      push = { default = "current"; };
      protocol = { file = { allow = "always"; }; };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;  # start windows at 1 and not 0, so <leader>1 goes to first window
    mouse = true;
    terminal = "xterm-256color";  # vim colorschemes are a little weird with 'screen'
    escapeTime = 0;  # prevents delay between insert and command mode in vim
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
            set -g @dracula-plugins "git battery ram-usage spotify-tui weather time network-ping"

            set -g @dracula-battery-label "🔋"
            set -g @dracula-show-empty-plugins false
            set -g @dracula-ram-usage-label "🐏"
            set -g @dracula-show-left-icon session
            set -g @dracula-refresh-rate 1
            set -g @dracula-border-contrast true
            set -g @dracula-git-show-diff-symbol " "
            set -g @dracula-git-no-untracked-files true
            set -g @dracula-spotify-tui-format "|%s |%t"
            set -g @dracula-ping-server "lepotato.local"
            set -g @dracula-ping-rate 5
          '';
      }
    ];
    extraConfig = ''
        unbind r
        bind r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf reloaded."

        # Set to scroll one line per scroll
        # Source: https://stackoverflow.com/questions/36002866/configure-tmux-scroll-speed
        bind-key -T copy-mode-vi WheelUpPane send-keys -X scroll-up
        bind-key -T copy-mode-vi WheelDownPane send-keys -X scroll-down

        # Set new panes and windows to open in the current path
        bind  c  new-window      -c "#{pane_current_path}"
        bind  %  split-window -h -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"

        # Increase default display time for messages
        set -g display-time 1500
      '';
  };
  home.file = {
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink ./.vimrc;
    ".shell_settings.sh".source = config.lib.file.mkOutOfStoreSymlink ./.shell_settings.sh;
  };
}
