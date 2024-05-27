molokai fixes issue with parenthesis matching

robbyrussell is my customization to the default oh-my-zsh theme

To install:
- [Install nix](https://nixos.org/download/)
- [Install nix home manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone)
- Create an appropriate home.nix file by copying one of the existing ones and appropriately modifying the username, user folder, and git email
- `rm ~/.config/home-manager/home.nix`
- symlink ~/.config/home-manager/home.nix to the relevant nix file in here, i.e. `ln -s $(pwd)/macbook.nix ~/.config/home-manager/home.nix
- The following script should essentially work and also it should be mostly idempotent (except for adding multiple entries to /etc/shells)
```
# Add the unstable channel for a few packages for which we need a more updated version
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable && nix-channel --update
home-manager switch
# For macOS we need to add the bash shell path to the list of approved shells
echo "$HOME/.nix-profile/bin/bash" | sudo tee -a /etc/shells
# And then we change our login shell to the nix-installed bash shell
chsh -s ~/.nix-profile/bin/bash
# Install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install vim plugins from command line
vim +'PlugInstall --sync' +qa
# Copy this directory's .profile into home. I wouldn't want to make profile read only since sometimes other programs modify it
cp .profile ~/
```

For macOS iterm these are the instructions to make option+left or option+right to move a word
iterm->settings->profiles->keys->key mappings -> remove the things associated with option+left/right
iterm->settings->keys->key bindings -> add two key bindings to send escape sequences. left should send b, right sends f

