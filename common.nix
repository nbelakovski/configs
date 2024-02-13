{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.fd
    pkgs.eza
    pkgs.cmake
    pkgs.ninja
    pkgs.tree
    pkgs.wget
    pkgs.nmap
    pkgs.unrar
    # vim-full appears to work fine on Darwin, but it appears that
    # vim-darwin is compiled with some sort of special support for Darwin so
    # let's use that.
    (if pkgs.stdenv.isDarwin then pkgs.vim-darwin else pkgs.vim-full)
  ];

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    baseIndex = 1;
    prefix = "C-s";
    mouse = true;
    terminal = "xterm-256color";  # vim colorschemes are a little weird with 'screen'
    escapeTime = 0;  # prevents delay between insert and command mode in vim
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
            set -g @dracula-plugins "git battery ram-usage spotify-tui weather time network-ping"

            set -g @dracula-fixed-location "Culver City, CA"
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
  };
}
