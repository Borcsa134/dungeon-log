.PHONY: install

ADDON_DIR = /Applications/World of Warcraft/_classic_beta_/Interface/AddOns/DungeonLog

install:
	@echo "Installing DungeonLog addon..."
	@mkdir -p "$(ADDON_DIR)"
	@cp -r *.toc *.lua modules "$(ADDON_DIR)/"
	@echo "DungeonLog installed successfully to $(ADDON_DIR)"
