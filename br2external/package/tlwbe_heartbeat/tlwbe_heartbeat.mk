################################################################################
#
# tlwbe_heartbeat
#
################################################################################

TLWBE_HEARTBEAT_VERSION = dev
TLWBE_HEARTBEAT_SITE = https://github.com/fifteenhex/tlwbe_heartbeat.git
TLWBE_HEARTBEAT_SITE_METHOD = git
TLWBE_HEARTBEAT_LICENSE = GPL3
TLWBE_HEARTBEAT_LICENSE_FILES = LICENSE
TLWBE_HEARTBEAT_DEPENDENCIES = python-daemonize
TLWBE_HEARTBEAT_SETUP_TYPE = setuptools

define TLWBE_HEARTBEAT_INSTALL_INIT_SYSV
	sed -e s#TMPL_MQTT_HOST#$(BR2_PACKAGE_TLWBE_HEARTBEAT_MQTT_HOST)# \
	    -e s#TMPL_SERIAL_PORT#$(BR2_PACKAGE_TLWBE_HEARTBEAT_SERIAL_PORT)# \
	    -e s#TMPL_GATEWAY_ID#$(BR2_PACKAGE_TLWBE_HEARTBEAT_GATEWAY_ID)# \
	    -e s#TMPL_APP_EUI#$(BR2_PACKAGE_TLWBE_HEARTBEAT_APP_EUI)# \
	    -e s#TMPL_DEV_EUI#$(BR2_PACKAGE_TLWBE_HEARTBEAT_DEV_EUI)# \
	    -e s#TMPL_DEV_KEY#$(BR2_PACKAGE_TLWBE_HEARTBEAT_DEV_KEY)# \
	    $(TLWBE_HEARTBEAT_PKGDIR)/S58tlwbe_heartbeat.template > \
            $(TARGET_DIR)/etc/init.d/S58tlwbe_heartbeat
	chmod 755 $(TARGET_DIR)/etc/init.d/S58tlwbe_heartbeat
endef

$(eval $(python-package))
