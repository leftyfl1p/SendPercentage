include $(THEOS)/makefiles/common.mk

#THEOS_DEVICE_IP = 10.0.1.183

TWEAK_NAME = SendPercentage
SendPercentage_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS"
