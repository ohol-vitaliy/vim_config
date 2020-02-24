.PHONY: all install app dotfiles clean help

all: clean install ## clean previous setup and install this

install: app dotfiles ## install apps and configs

app: ## install emacs-nox and doom-emacs
	sudo apt install vim-nox -y

dotfiles: ## install config files
	@echo "HOME:  $$HOME";
	@echo "PWD    $$PWD";
	# === DOTFILES-DIRS ===
	@for dir in $(shell find $$PWD -type d \
			| egrep -v "(useful|.git)" \
			| sed s:"$$PWD/":: | sed 1d); do \
		mkdir -p $$HOME/$$dir; \
	done;
	# === DOTFILES-FILES ===
	@for file in $(shell find $$PWD -type f \
			| egrep -v "(.git|Makefile|README.md|LICENSE)" \
			| sed s:"$$PWD/"::); do \
		ln -sf $$PWD/$$file $$HOME/$$file; \
	done;
	@echo "Dont forget to run :PlugInstall inside vim"


clean: ## clean this config
	@if [ -d $$HOME/.vim ]; then \
		rm -rf $$HOME/.vim; \
	fi
	@if [ -f $$HOME/.vimrc ]; then \
		rm $$HOME/.vimrc; \
	fi
	@if [ -f $$HOME/.viminfo ]; then \
		rm $$HOME/.viminfo; \
	fi
	sudo apt purge vim-nox

help: ## this help window
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)\
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
