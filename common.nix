{ pkgs, ... }:

{
  home.packages = [
    pkgs.eza
    pkgs.cmake
    pkgs.ninja
    # TODO: Need to research making tmuxconf in here, in addition to vim conf, and having home manager manage the shell
    pkgs.tmux
    pkgs.tree
    pkgs.wget
    pkgs.nmap
    pkgs.unrar
  ];
}
