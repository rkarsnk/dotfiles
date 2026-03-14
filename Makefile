.PHONY: darwin-build
darwin-build:
	darwin-rebuild build --flake ~/.dotfiles/


.PHONY: darwin-switch
darwin-switch:
	sudo darwin-rebuild switch --flake ~/.dotfiles/

.PHONY: home-build
home-build:
	home-manager build --flake .#rkarsnk

.PHONY: home-switch
home-switch:
	home-manager switch --flake .#rkarsnk

