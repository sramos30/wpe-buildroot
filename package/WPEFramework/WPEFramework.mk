WPEFRAMEWORK_VERSION = 84d6f6eb06a812a0a51d0c85a1196305e000b570
WPEFRAMEWORK_SITE_METHOD = git
WPEFRAMEWORK_SITE = git@github.com:Metrological/cppsdk.git
WPEFRAMEWORK_INSTALL_STAGING = YES
WPEFRAMEWORK_DEPENDENCIES = zlib

WPEFRAMEWORK_CONF_OPTS += -DBUILDREF_WPEFRAMEWORK=$(shell $(GIT) rev-parse HEAD)
WPEFRAMEWORK_CONF_OPTS += -DINSTALL_HEADERS_TO_TARGET=ON -DWPEFRAMEWORK_TEST_APPS=ON -DWPEFRAMEWORK_TEST_LOADER=ON

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
# TODO: This recently stopped working, for now pass debug flags explicitly.
#WPEFRAMEWORK_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
WPEFRAMEWORK_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_LOCATIONSYNC),y)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_LOCATIONSYNC=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_TIMESYNC),y)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_TIMESYNC=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),y)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
WPEFRAMEWORK_CONF_OPTS += -DWPEFRAMEWORK_VIRTUALINPUT=ON
endif

define WPEFRAMEWORK_POST_TARGET_INITD
    mkdir -p $(TARGET_DIR)/etc/init.d
    $(INSTALL) -D -m 0755 package/WPEFramework/S80WPEFramework $(TARGET_DIR)/etc/init.d
    mkdir -p $(TARGET_DIR)/etc/WPEFramework
    rm -rf $(TARGET_DIR)/usr/share/WPEFramework/cmake
endef

WPEFRAMEWORK_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_POST_TARGET_INITD

$(eval $(cmake-package))

include package/WPEFramework/*/*.mk
