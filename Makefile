install:
	mkdir -p $(HOME)/.vim/plugged/molokai/colors
	cp molokai.vim $(HOME)/.vim/plugged/molokai/colors/
	mkdir -p $(HOME)/.oh-my-zsh/themes
	cp robbyrussell.zsh-theme $(HOME)/.oh-my-zsh/themes/
	cp .tmux.conf $(HOME)/
	echo "Installing tmux plugin manager"
	git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
