echo "Loading .shell_settings..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


add_to_path() {
  if [[ ":$PATH" != *":$1:"* ]]; then
    export PATH=$1:$PATH
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


add_to_path ~/bin

[ "$(command -v eza)" != "" ] && alias ls="eza"


# Tell history to ignore duplicates
case $SHELL in
  *"zsh")
    setopt hist_ignore_all_dups
    PS1="%n@%m %1~ %# "
    ;;
  *"bash")
    export HISTCONTROL=ignoredups 
    PS1="\w \$ "
    bind "set completion-ignore-case on"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    # Put other completions in ~/.local/share/bash-completion/completions
    # They should be named cmd.bash
    [[ -f ~/.nix-profile/share/bash-completion/bash_completion ]] && . ~/.nix-profile/share/bash-completion/bash_completion
    source ~/.nix-profile/share/bash/bash-preexec.sh
    # source "$(blesh-share)"/ble.sh --attach=none # does not work currently
    # [[ ${BLE_VERSION-} ]] && ble-attach

    eval "$(atuin init --disable-up-arrow bash)"
    ;;
  *)
    echo "Could not determine type of $SHELL"
    ;;
esac

# I forget what this one is for. Devcontainers?
add_to_path /Users/nickolai/Library/Application\ Support/Code/User/globalStorage/ms-vscode-remote.remote-containers/cli-bin

add_to_path ~/Library/Python/3.11/bin/

export EDITOR=vim

echo "Loading .shell_settings...done"
