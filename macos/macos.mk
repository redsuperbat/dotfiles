.PHONY: macos

macos:
	sh $(PWD)/macos/defaults.sh
	ln -his $(PWD)/com.local.KeyRemapping.plist $(HOME)/Library/LaunchAgents/com.local.KeyRemapping.plist

