HOSTNAME := $(shell scutil --get LocalHostName)

.PHONY: darwin-build
darwin-build:
	sudo darwin-rebuild build --flake .#$(HOSTNAME)


.PHONY: darwin-switch
darwin-switch:
	sudo darwin-rebuild switch --flake .#$(HOSTNAME)

.PHONY: home-build
home-build:
	home-manager build --flake .#rkarsnk

.PHONY: home-switch
home-switch:
	home-manager switch -b bak --flake .#rkarsnk

