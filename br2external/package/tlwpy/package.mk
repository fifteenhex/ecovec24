TLWPY_VERSION = dev
TLWPY_SITE = https://github.com/fifteenhex/tlwpy.git
TLWPY_SITE_METHOD = git
TLWPY_DEPENDENCIES = python-paho-mqtt host-python-cython libopenssl
TLWPY_GIT_SUBMODULES = YES
TLWPY_SETUP_TYPE = setuptools

$(eval $(python-package))
