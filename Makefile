HOSTNAME := $(shell scutil --get LocalHostName)

.PHONY: update
update:
	nix flake update

# Build the system configuration without applying it yet.
.PHONY: darwin-build
darwin-build:
	darwin-rebuild build --flake .#$(HOSTNAME)

# Apply the system configuration (requires sudo password).
.PHONY: darwin-switch
darwin-switch:
	sudo darwin-rebuild switch --flake .#$(HOSTNAME)

# Build the Home Manager configuration without applying it yet.
.PHONY: home-build
home-build:
	home-manager build --flake .#rkarsnk@$(HOSTNAME)

# Apply the Home Manager configuration.
.PHONY: home-switch
home-switch:
	home-manager switch -b bak --flake .#rkarsnk@$(HOSTNAME)

