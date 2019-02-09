NODECTRL_VERSION = dev
NODECTRL_SITE = https://github.com/fifteenhex/nodectrl.git
NODECTRL_SITE_METHOD = git
NODECTRL_DEPENDENCIES = host-pkgconf #glib-networking json-glib
NODECTRL_GIT_SUBMODULES = YES

define THINGYJP_OTA_INSTALL_INIT_SYSV
endef

define NODECTRL_INSTALL_INIT_SYSV
	sed -e s#TMPL_MQTT_HOST#$(BR2_PACKAGE_NODECTRL_MQTT_HOST)# \
		-e s#TMPL_NODE_NAME#$(BR2_PACKAGE_NODECTRL_NODENAME)# \
		$(NODECTRL_PKGDIR)/S58nodectrl.template > \
		$(TARGET_DIR)/etc/init.d/S58nodectrl
	chmod 755 $(TARGET_DIR)/etc/init.d/S58nodectrl
endef

$(eval $(meson-package))
