#
# This policy configuration will be used by all products that
# inherit from QASSA
#

ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
ifeq ($(TARGET_HAS_FUSEBLK_SEPOLICY_ON_VENDOR),true)
BOARD_SEPOLICY_M4DEFS += board_excludes_fuseblk_sepolicy=true
endif
endif

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    device/qassa/sepolicy/common/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    device/qassa/sepolicy/common/private

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    device/qassa/sepolicy/common/dynamic \
    device/qassa/sepolicy/common/system
else
BOARD_SEPOLICY_DIRS += \
    device/qassa/sepolicy/common/dynamic \
    device/qassa/sepolicy/common/vendor
endif

# Selectively include legacy rules defined by the products
-include device/qassa/sepolicy/legacy-common/sepolicy.mk

# Include atv rules on atv product
ifeq ($(PRODUCT_IS_ATV), true)
include device/lineage/sepolicy/atv/sepolicy.mk
endif
