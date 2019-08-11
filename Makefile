.ONESHELL:
.SHELL := /bin/bash
PWD=$(shell pwd)
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput sgr0)

define INFO
    echo "$(BOLD)$(GREEN)- INFO: $(1)$(RESET)" 
endef

define ERR
    echo "$(BOLD)$(RED)- INFO:  $(1)$(RESET)" 
endef

help:
	@grep -E '^[0-9#a-z A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: 	## Install emacs on mac
	@$(call INFO, "Install emacs on mac"); \
	brew tap d12frosted/emacs-plus; \
	brew install emacs-plus; \
	ln -s /usr/local/Cellar/emacs-plus/*/Emacs.app/ /Applications/

rm-config:   ## Remove existing emacs/spacemacs configs
	@$(call INFO, "Remove existing emacs/spacemacs configs"); \
	rm -rf ~/.emacs.d; \
	rm -rf ~/.spacemacs.d

font:  ## Download Source Code Pro font
# Ref:  https://github.com/adobe-fonts/source-code-pro/releases
# 		https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it
	@$(call INFO, "Download Source Code Pro font"); \
	wget -P /tmp https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz; \
	cd /tmp; tar xzvf /tmp/1.050R-it.tar.gz; open /tmp/


spacemacs: rm-config   	## Clone spacemacs config from zilongshanren and his private config
	@$(call INFO, "Clone spacemacs config from zilongshanren and his private config"); \
	git clone https://github.com/zilongshanren/spacemacs ~/.emacs.d -b develop; \
	git clone https://github.com/weinix/spacemacs-private ~/.spacemacs.d -b wei-mac ; \
	emacs --insecure
