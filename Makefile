install:
	mkdir -p $(HOME)/.vim/plugged/molokai/colors
	cp molokai.vim $(HOME)/.vim/plugged/molokai/colors/
	mkdir -p $(HOME)/.oh-my-zsh/themes
	cp robbyrussell.zsh-theme $(HOME)/.oh-my-zsh/themes/
	cp .tmux.conf $(HOME)/
	echo "Installing tmux plugin manager"
	# Either it exists or we install it
	[ -e $(HOME)/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	echo "Done"

