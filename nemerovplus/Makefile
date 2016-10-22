ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = NemerovPlus
NemerovPlus_FILES = NemerovPlus.mm
NemerovPlus_INSTALL_PATH = /Library/PreferenceBundles
NemerovPlus_FRAMEWORKS = Foundation UIKit CoreGraphics MobileCoreServices
NemerovPlus_PRIVATE_FRAMEWORKS = Preferences
NemerovPlus_LDFLAGS += -Wl,-segalign,4000
NemerovPlus_CFLAGS = -Wno-error

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NemerovPlus.plist$(ECHO_END)
