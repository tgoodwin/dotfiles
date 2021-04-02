VIM_DIR ?= ${HOME}/.vim

plug.vim := $(VIM_DIR)/autoload/plug.vim
git-prompt.sh := ${HOME}/.git-prompt.sh
git-completion.bash := ${HOME}/.git-completion.bash

.PHONY: all
all: dotfiles $(plug.vim)

.PHONY: dotfiles
dotfiles:
	for file in $(shell git ls-files --exclude-standard $(CURDIR) | \
				  xargs -I {} find {} -name '.*' -not -name '.gitignore'); do \
		f=$$(basename $$file); \
		ln -sfn $(CURDIR)/$$file $(HOME)/$$f; \
	done;

$(plug.vim):
	curl -fLo $@ --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

