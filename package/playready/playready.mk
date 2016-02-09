################################################################################
#
# playready
#
################################################################################

PLAYREADY_VERSION = 4bc0680e4a7a4f08a8d94d85c01ffbb9f56411ce
PLAYREADY_SITE = git@github.com:Metrological/playready.git
PLAYREADY_SITE_METHOD = git
PLAYREADY_LICENSE = PROPRIETARY
PLAYREADY_DEPENDENCIES = 
PLAYREADY_INSTALL_STAGING = YES
PLAYREADY_INSTALL_TARGET = YES
PLAYREADY_SUBDIR = src

PLAYREADY_CONF_OPTS = \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_C_FLAGS="-std=c99 -D_GNU_SOURCE"

define PLAYREADY_INSTALL_STAGING_PC
	$(INSTALL) -D package/playready/playready.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/playready.pc
endef

define PLAYREADY_INSTALL_TARGET_BGROUPCERT
	if [ -f package/playready/bgroupcert.dat ]; then \
		$(INSTALL) -D -m 0644 package/playready/bgroupcert.dat $(TARGET_DIR)/etc/playready/; \
	fi
endef

define PLAYREADY_INSTALL_TARGET_ZGPRIV
	if [ -f package/playready/zgpriv.dat ]; then \
		$(INSTALL) -D -m 0644 package/playready/zgpriv.dat $(TARGET_DIR)/etc/playready/; \
	fi
endef

PLAYREADY_POST_INSTALL_STAGING_HOOKS += PLAYREADY_INSTALL_STAGING_PC
PLAYREADY_POST_INSTALL_TARGET_HOOKS += PLAYREADY_INSTALL_TARGET_BGROUPCERT
PLAYREADY_POST_INSTALL_TARGET_HOOKS += PLAYREADY_INSTALL_TARGET_ZGPRIV

$(eval $(cmake-package))
