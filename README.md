molokai fixes issue with parenthesis matching

robbyrussell is my customization to the default oh-my-zsh theme

To install:
- Install nix home manager
- symlink ~/.config/home-manager/home.nix to the relevant nix file in here
- home-manager switch
- On Mac: edit /etc/shells to add the nix bash shell at ~/.nix-profile/bin/bash as one of the allowable ones and then run chsh -s ~/.nix-profile/bin.bash
