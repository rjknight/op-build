################################################################################
#
# HCODE
#
################################################################################

HCODE_VERSION ?= e32b9276313e
HCODE_SITE = /esw/san5/rjknight/opensource-hw-image
HCODE_SITE_METHOD = local

HCODE_LICENSE = Apache-2.0
HCODE_DEPENDENCIES = host-ppe42-gcc

HCODE_INSTALL_IMAGES = YES
HCODE_INSTALL_TARGET = NO

#CODE_VERSION=`cat $(HCODE_VERSION_FILE)` -- get this from existing jenkins job?

HW_IMAGE_BIN_PATH=output/images/hw_image
HW_IMAGE_BIN=p9n.hw_image.bin
HCODE_IMAGE_BIN = p9n.ref_image.bin

CROSS_COMPILER_PATH=$(PPE42_GCC_BIN)
PPE_TOOL_PATH ?= $(CROSS_COMPILER_PATH)
PPE_PREFIX    ?= $(PPE_TOOL_PATH)/bin/powerpc-eabi-

HCODE_ENV_VARS= CONFIG_FILE=$(BR2_EXTERNAL_OP_BUILD_PATH)/configs/hcode/$(BR2_HCODE_CONFIG_FILE) \
	LD_LIBRARY_PATH=$(HOST_DIR)/usr/lib OPENPOWER_BUILD=1\
	CROSS_COMPILER_PATH=$(PPE42_GCC_BIN) PPE_TOOL_PATH=$(CROSS_COMPILER_PATH) \
	PPE_PREFIX=$(CROSS_COMPILER_PATH)/bin/powerpc-eabi-

define HCODE_INSTALL_IMAGES_CMDS
	mkdir -p $(STAGING_DIR)/hcode
	cp $(@D)/$(HW_IMAGE_BIN_PATH)/$(HW_IMAGE_BIN) $(STAGING_DIR)/hcode/$(HCODE_IMAGE_BIN)
endef

define HCODE_BUILD_CMDS
		$(HCODE_ENV_VARS) bash -c 'cd $(@D) && source ./env.bash && $(MAKE) '
endef

$(eval $(generic-package))
