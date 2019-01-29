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

$(eval $(python-package))
