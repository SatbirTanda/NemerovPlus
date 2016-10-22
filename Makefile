ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = NemerovPlus
NemerovPlus_FILES = Tweak.xm Triforce.m HualosUIWindow.m StarOfDavid.m Cross.m Ottoman.m Star.m YinYang.m Sunburst.m
NemerovPlus_FRAMEWORKS = UIKit CoreGraphics
NemerovPlus_LDFLAGS += -Wl,-segalign,4000
NemerovPlus_CFLAGS = -fobjc-arc


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += nemerovplus
include $(THEOS_MAKE_PATH)/aggregate.mk
