######################################
#
# cardinal-bin
#
######################################

CARDINAL_BIN_VERSION = 34f49211e2ba16ebc782f46999160a02b2706198
CARDINAL_BIN_SITE_METHOD = local
CARDINAL_BIN_SITE = $($(PKG)_PKGDIR)/
CARDINAL_BIN_BUNDLES = Cardinal.lv2 CardinalFX.lv2

define CARDINAL_BIN_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bundles/* $(TARGET_DIR)/usr/lib/lv2/
	cp $(@D)/binaries/$(MOD_BIN_COMPAT)/Cardinal.so $(TARGET_DIR)/usr/lib/lv2/Cardinal.lv2/
	cp $(@D)/binaries/$(MOD_BIN_COMPAT)/CardinalFX.so $(TARGET_DIR)/usr/lib/lv2/CardinalFX.lv2/
endef

$(eval $(generic-package))
