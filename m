Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6918A2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfCKNYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40823 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSKq6-1hVq2T0qN6-00Sgtf for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 073/114] drivers: gpu: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:25 +0100
Message-Id: <1552310346-7629-74-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:i5B7RrA8O8SeLFmcaHWsiEYmEqn7X3p/Mg3o+Po1tAYeNTDC7aU
 9jlPfL4OnP8lIwWwunHQyVI3B7ul7hhF/ShxJtvVvCYEDBVLlim3lT/QJQb2/M6tLFEW9Jw
 kjvNRr1ytqpMkmJOgqttWDrmQg1VJ28FGwuQxvUYCOpZZuVzK0jxICxHLvUqZXYakbfTW+G
 7fVRFtISpEJXwSVEr9vAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vAb6cbRgCmg=:st8PqE8Jn0fuUnBMie6ww0
 GsF2hc+XfiPbXPUdTdFRNXKXgV+oD/n17gxe5ui9nsthTVE0NSWP830VorYYaS5LPit/Mb4a5
 pConLxhrdAPrx34h7ieHHt6cYklB4/sL0dQLoru2S6SGnoHLkYcGPnFcG7LShIfb1718dIzaI
 W1cX2uwgGua7xKLlxP6Vbvlmg20iexCbkLLqDI94KUdZt9hbuVGXKevAEVg+q9/bqYV8a1yyb
 U7pUuEIWDl9SXIkI8XGE5eNz/kygT74Te/CZ2wGXaF5FABjxbpxkaZ5UE++60V4dC2oitM8Rv
 x5mO36wtDs0eaeeNEJYJ1TPejcLwRUO37ztvcPi/cYGhc1I+GgtPgarAmgirbd5RoLaxP2tE1
 bxxXRsMZu/9jHWUBX4HNqxqDzM3BFGdAjWk8tK7WCkgCRZRJ6OTyhodZ1/w3uXXpQdvCe06EC
 WET6DwlB/wdmwyXvsqVJXb9zewSTlNUKknXhYuXCEcliA/dQIFRhXAjm0apZ+IakPMU3ZuC9A
 0l5SMC/T43nO6LStjkp5YJXyZ8W6VA3RMjkE7/1WUfdOuHs+kPs2wfYS2lzNqydmsC5AXTwQK
 3XsTSCXRHJ+V6s7Hddzjcy+kgoVPZ9Vd3K6xSa6QWC65zEYgSHFcEH7elXGS+r+08L5Xd6VxZ
 mAnc/aEoPR26uno+/bEeIR+LaOozYOEnIJKTfr+ozlLw0YBqH3xqXvZDAs/vVPwzUHIjUewRI
 ufdy1lKhBwLs1sHyMWUVVJhiDAsE1XrP+zXITg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpu/drm/Kconfig                  |  8 +++----
 drivers/gpu/drm/amd/acp/Kconfig          | 20 ++++++++---------
 drivers/gpu/drm/amd/lib/Kconfig          | 10 ++++-----
 drivers/gpu/drm/ast/Kconfig              | 11 +++++----
 drivers/gpu/drm/bridge/Kconfig           |  8 +++----
 drivers/gpu/drm/cirrus/Kconfig           | 14 ++++++------
 drivers/gpu/drm/hisilicon/kirin/Kconfig  |  6 ++---
 drivers/gpu/drm/i2c/Kconfig              |  2 +-
 drivers/gpu/drm/i915/Kconfig             | 12 +++++-----
 drivers/gpu/drm/mgag200/Kconfig          | 11 +++++----
 drivers/gpu/drm/nouveau/Kconfig          |  2 +-
 drivers/gpu/drm/omapdrm/displays/Kconfig | 38 ++++++++++++++++----------------
 drivers/gpu/drm/omapdrm/dss/Kconfig      | 12 +++++-----
 drivers/gpu/drm/rockchip/Kconfig         |  8 +++----
 drivers/gpu/drm/sun4i/Kconfig            | 16 +++++++-------
 drivers/gpu/drm/udl/Kconfig              |  2 +-
 drivers/gpu/drm/vc4/Kconfig              |  8 +++----
 drivers/gpu/drm/virtio/Kconfig           |  6 ++---
 drivers/gpu/drm/vmwgfx/Kconfig           |  5 ++---
 drivers/gpu/vga/Kconfig                  |  2 +-
 20 files changed, 99 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index bd943a7..59b52d3 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -189,8 +189,8 @@ config DRM_RADEON
 	tristate "ATI Radeon"
 	depends on DRM && PCI && MMU
 	select FW_LOADER
-        select DRM_KMS_HELPER
-        select DRM_TTM
+	select DRM_KMS_HELPER
+	select DRM_TTM
 	select POWER_SUPPLY
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
@@ -209,9 +209,9 @@ config DRM_AMDGPU
 	tristate "AMD GPU"
 	depends on DRM && PCI && MMU
 	select FW_LOADER
-        select DRM_KMS_HELPER
+	select DRM_KMS_HELPER
 	select DRM_SCHED
-        select DRM_TTM
+	select DRM_TTM
 	select POWER_SUPPLY
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
diff --git a/drivers/gpu/drm/amd/acp/Kconfig b/drivers/gpu/drm/amd/acp/Kconfig
index e503e3d..a85bb60 100644
--- a/drivers/gpu/drm/amd/acp/Kconfig
+++ b/drivers/gpu/drm/amd/acp/Kconfig
@@ -1,15 +1,15 @@
 menu "ACP (Audio CoProcessor) Configuration"
 
 config DRM_AMD_ACP
-       bool "Enable AMD Audio CoProcessor IP support"
-       depends on DRM_AMDGPU
-       select MFD_CORE
-       select PM_GENERIC_DOMAINS if PM
-       help
-	Choose this option to enable ACP IP support for AMD SOCs.
-	This adds the ACP (Audio CoProcessor) IP driver and wires
-	it up into the amdgpu driver.  The ACP block provides the DMA
-	engine for the i2s-based ALSA driver. It is required for audio
-	on APUs which utilize an i2s codec.
+	bool "Enable AMD Audio CoProcessor IP support"
+	depends on DRM_AMDGPU
+	select MFD_CORE
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  Choose this option to enable ACP IP support for AMD SOCs.
+	  This adds the ACP (Audio CoProcessor) IP driver and wires
+	  it up into the amdgpu driver.  The ACP block provides the DMA
+	  engine for the i2s-based ALSA driver. It is required for audio
+	  on APUs which utilize an i2s codec.
 
 endmenu
diff --git a/drivers/gpu/drm/amd/lib/Kconfig b/drivers/gpu/drm/amd/lib/Kconfig
index 776ef34..d2700b1 100644
--- a/drivers/gpu/drm/amd/lib/Kconfig
+++ b/drivers/gpu/drm/amd/lib/Kconfig
@@ -7,22 +7,22 @@ config CHASH
 	tristate
 	default DRM_AMDGPU
 	help
-	 Statically sized closed hash table implementation with low
-	 memory and CPU overhead.
+	  Statically sized closed hash table implementation with low
+	  memory and CPU overhead.
 
 config CHASH_STATS
 	bool "Closed hash table performance statistics"
 	depends on CHASH
 	default n
 	help
-	 Enable collection of performance statistics for closed hash tables.
+	  Enable collection of performance statistics for closed hash tables.
 
 config CHASH_SELFTEST
 	bool "Closed hash table self test"
 	depends on CHASH
 	default n
 	help
-	 Runs a selftest during module load. Several module parameters
-	 are available to modify the behaviour of the test.
+	  Runs a selftest during module load. Several module parameters
+	  are available to modify the behaviour of the test.
 
 endmenu
diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
index 9647e1f..b3d5262 100644
--- a/drivers/gpu/drm/ast/Kconfig
+++ b/drivers/gpu/drm/ast/Kconfig
@@ -5,9 +5,8 @@ config DRM_AST
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	help
-	 Say yes for experimental AST GPU driver. Do not enable
-	 this driver without having a working -modesetting,
-	 and a version of AST that knows to fail if KMS
-	 is bound to the driver. These GPUs are commonly found
-	 in server chipsets.
-
+	  Say yes for experimental AST GPU driver. Do not enable
+	  this driver without having a working -modesetting,
+	  and a version of AST that knows to fail if KMS
+	  is bound to the driver. These GPUs are commonly found
+	  in server chipsets.
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 8840f39..1366464 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -58,10 +58,10 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	---help---
-          This is a driver for the display bridges of
-          GE B850v3 that convert dual channel LVDS
-          to DP++. This is used with the i.MX6 imx-ldb
-          driver. You are likely to say N here.
+	  This is a driver for the display bridges of
+	  GE B850v3 that convert dual channel LVDS
+	  to DP++. This is used with the i.MX6 imx-ldb
+	  driver. You are likely to say N here.
 
 config DRM_NXP_PTN3460
 	tristate "NXP PTN3460 DP/LVDS bridge"
diff --git a/drivers/gpu/drm/cirrus/Kconfig b/drivers/gpu/drm/cirrus/Kconfig
index fc78c90..b394916 100644
--- a/drivers/gpu/drm/cirrus/Kconfig
+++ b/drivers/gpu/drm/cirrus/Kconfig
@@ -4,15 +4,15 @@ config DRM_CIRRUS_QEMU
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	help
-	 This is a KMS driver for emulated cirrus device in qemu.
-	 It is *NOT* intended for real cirrus devices. This requires
-	 the modesetting userspace X.org driver.
+	  This is a KMS driver for emulated cirrus device in qemu.
+	  It is *NOT* intended for real cirrus devices. This requires
+	  the modesetting userspace X.org driver.
 
-	 Cirrus is obsolete, the hardware was designed in the 90ies
-	 and can't keep up with todays needs.  More background:
-	 https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
+	  Cirrus is obsolete, the hardware was designed in the 90ies
+	  and can't keep up with todays needs.  More background:
+	  https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
 
-	 Better alternatives are:
+	  Better alternatives are:
 	   - stdvga (DRM_BOCHS, qemu -vga std, default in qemu 2.2+)
 	   - qxl (DRM_QXL, qemu -vga qxl, works best with spice)
 	   - virtio (DRM_VIRTIO_GPU), qemu -vga virtio)
diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
index 499f644..3d5d343 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
+++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
@@ -14,6 +14,6 @@ config HISI_KIRIN_DW_DSI
 	depends on DRM_HISI_KIRIN
 	select DRM_MIPI_DSI
 	help
-	 This selects support for HiSilicon Kirin SoC specific extensions for
-	 the Synopsys DesignWare DSI driver. If you want to enable MIPI DSI on
-	 hi6220 based SoC, you should selet this option.
+	  This selects support for HiSilicon Kirin SoC specific extensions for
+	  the Synopsys DesignWare DSI driver. If you want to enable MIPI DSI on
+	  hi6220 based SoC, you should selet this option.
diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
index 65d3acb..ec11a00 100644
--- a/drivers/gpu/drm/i2c/Kconfig
+++ b/drivers/gpu/drm/i2c/Kconfig
@@ -1,5 +1,5 @@
 menu "I2C encoder or helper chips"
-     depends on DRM && DRM_KMS_HELPER && I2C
+	depends on DRM && DRM_KMS_HELPER && I2C
 
 config DRM_I2C_CH7006
 	tristate "Chrontel ch7006 TV encoder"
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 148be8e..ffdb05a 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -67,7 +67,7 @@ config DRM_I915_CAPTURE_ERROR
 	  This option enables capturing the GPU state when a hang is detected.
 	  This information is vital for triaging hangs and assists in debugging.
 	  Please report any hang to
-            https://bugs.freedesktop.org/enter_bug.cgi?product=DRI
+	    https://bugs.freedesktop.org/enter_bug.cgi?product=DRI
 	  for triaging.
 
 	  If in doubt, say "Y".
@@ -96,11 +96,11 @@ config DRM_I915_USERPTR
 	  If in doubt, say "Y".
 
 config DRM_I915_GVT
-        bool "Enable Intel GVT-g graphics virtualization host support"
-        depends on DRM_I915
-        depends on 64BIT
-        default n
-        help
+	bool "Enable Intel GVT-g graphics virtualization host support"
+	depends on DRM_I915
+	depends on 64BIT
+	default n
+	help
 	  Choose this option if you want to enable Intel GVT-g graphics
 	  virtualization technology host support with integrated graphics.
 	  With GVT-g, it's possible to have one integrated graphics
diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/Kconfig
index db58578..051f691 100644
--- a/drivers/gpu/drm/mgag200/Kconfig
+++ b/drivers/gpu/drm/mgag200/Kconfig
@@ -4,9 +4,8 @@ config DRM_MGAG200
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	help
-	 This is a KMS driver for the MGA G200 server chips, it
-         does not support the original MGA G200 or any of the desktop
-         chips. It requires 0.3.0 of the modesetting userspace driver,
-         and a version of mga driver that will fail on KMS enabled
-         devices.
-
+	  This is a KMS driver for the MGA G200 server chips, it
+	  does not support the original MGA G200 or any of the desktop
+	  chips. It requires 0.3.0 of the modesetting userspace driver,
+	  and a version of mga driver that will fail on KMS enabled
+	  devices.
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 00cd9ab..980492d 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -1,7 +1,7 @@
 config DRM_NOUVEAU
 	tristate "Nouveau (NVIDIA) cards"
 	depends on DRM && PCI && MMU
-        select FW_LOADER
+	select FW_LOADER
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
diff --git a/drivers/gpu/drm/omapdrm/displays/Kconfig b/drivers/gpu/drm/omapdrm/displays/Kconfig
index a349cb6..f2f62e0 100644
--- a/drivers/gpu/drm/omapdrm/displays/Kconfig
+++ b/drivers/gpu/drm/omapdrm/displays/Kconfig
@@ -7,29 +7,29 @@ config DRM_OMAP_ENCODER_OPA362
 	  through a GPIO.
 
 config DRM_OMAP_ENCODER_TFP410
-        tristate "TFP410 DPI to DVI Encoder"
+	tristate "TFP410 DPI to DVI Encoder"
 	help
 	  Driver for TFP410 DPI to DVI encoder.
 
 config DRM_OMAP_ENCODER_TPD12S015
-        tristate "TPD12S015 HDMI ESD protection and level shifter"
+	tristate "TPD12S015 HDMI ESD protection and level shifter"
 	help
 	  Driver for TPD12S015, which offers HDMI ESD protection and level
 	  shifting.
 
 config DRM_OMAP_CONNECTOR_DVI
-        tristate "DVI Connector"
+	tristate "DVI Connector"
 	depends on I2C
 	help
 	  Driver for a generic DVI connector.
 
 config DRM_OMAP_CONNECTOR_HDMI
-        tristate "HDMI Connector"
+	tristate "HDMI Connector"
 	help
 	  Driver for a generic HDMI connector.
 
 config DRM_OMAP_CONNECTOR_ANALOG_TV
-        tristate "Analog TV Connector"
+	tristate "Analog TV Connector"
 	help
 	  Driver for a generic analog TV connector.
 
@@ -58,29 +58,29 @@ config DRM_OMAP_PANEL_LGPHILIPS_LB035Q02
 	  LCD Panel used on the Gumstix Overo Palo35
 
 config DRM_OMAP_PANEL_SHARP_LS037V7DW01
-        tristate "Sharp LS037V7DW01 LCD Panel"
-        depends on BACKLIGHT_CLASS_DEVICE
-        help
-          LCD Panel used in TI's SDP3430 and EVM boards
+	tristate "Sharp LS037V7DW01 LCD Panel"
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  LCD Panel used in TI's SDP3430 and EVM boards
 
 config DRM_OMAP_PANEL_TPO_TD028TTEC1
-        tristate "TPO TD028TTEC1 LCD Panel"
-        depends on SPI
-        help
-          LCD panel used in Openmoko.
+	tristate "TPO TD028TTEC1 LCD Panel"
+	depends on SPI
+	help
+	  LCD panel used in Openmoko.
 
 config DRM_OMAP_PANEL_TPO_TD043MTEA1
-        tristate "TPO TD043MTEA1 LCD Panel"
-        depends on SPI
-        help
-          LCD Panel used in OMAP3 Pandora
+	tristate "TPO TD043MTEA1 LCD Panel"
+	depends on SPI
+	help
+	  LCD Panel used in OMAP3 Pandora
 
 config DRM_OMAP_PANEL_NEC_NL8048HL11
 	tristate "NEC NL8048HL11 Panel"
 	depends on SPI
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
-		This NEC NL8048HL11 panel is TFT LCD used in the
-		Zoom2/3/3630 sdp boards.
+	  This NEC NL8048HL11 panel is TFT LCD used in the
+	  Zoom2/3/3630 sdp boards.
 
 endmenu
diff --git a/drivers/gpu/drm/omapdrm/dss/Kconfig b/drivers/gpu/drm/omapdrm/dss/Kconfig
index f24ebf7..e1ac914 100644
--- a/drivers/gpu/drm/omapdrm/dss/Kconfig
+++ b/drivers/gpu/drm/omapdrm/dss/Kconfig
@@ -5,12 +5,12 @@ config OMAP_DSS_BASE
 	tristate
 
 menuconfig OMAP2_DSS
-        tristate "OMAP2+ Display Subsystem support"
+	tristate "OMAP2+ Display Subsystem support"
 	select OMAP_DSS_BASE
 	select VIDEOMODE_HELPERS
 	select OMAP2_DSS_INIT
 	select HDMI
-        help
+	help
 	  OMAP2+ Display Subsystem support.
 
 if OMAP2_DSS
@@ -51,7 +51,7 @@ config OMAP2_DSS_DPI
 
 config OMAP2_DSS_VENC
 	bool "VENC support"
-        default y
+	default y
 	help
 	  OMAP Video Encoder support for S-Video and composite TV-out.
 
@@ -60,7 +60,7 @@ config OMAP2_DSS_HDMI_COMMON
 
 config OMAP4_DSS_HDMI
 	bool "HDMI support for OMAP4"
-        default y
+	default y
 	select OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI support for OMAP4 based SoCs.
@@ -84,7 +84,7 @@ config OMAP5_DSS_HDMI
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-        default n
+	default n
 	help
 	  SDI (Serial Display Interface) support.
 
@@ -93,7 +93,7 @@ config OMAP2_DSS_SDI
 
 config OMAP2_DSS_DSI
 	bool "DSI support"
-        default n
+	default n
 	help
 	  MIPI DSI (Display Serial Interface) support.
 
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 1e75196..fc7032d 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -27,17 +27,17 @@ config ROCKCHIP_ANALOGIX_DP
 	  on RK3288 or RK3399 based SoC, you should select this option.
 
 config ROCKCHIP_CDN_DP
-        bool "Rockchip cdn DP"
+	bool "Rockchip cdn DP"
 	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
-        help
+	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the cdn DP driver. If you want to enable Dp on
 	  RK3399 based SoC, you should select this
 	  option.
 
 config ROCKCHIP_DW_HDMI
-        bool "Rockchip specific extensions for Synopsys DW HDMI"
-        help
+	bool "Rockchip specific extensions for Synopsys DW HDMI"
+	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the Synopsys DesignWare HDMI driver. If you want to
 	  enable HDMI on RK3288 or RK3399 based SoC, you should select
diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 1dbbc3a..d554d8b 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -16,18 +16,18 @@ config DRM_SUN4I
 if DRM_SUN4I
 
 config DRM_SUN4I_HDMI
-       tristate "Allwinner A10 HDMI Controller Support"
-       default DRM_SUN4I
-       help
+	tristate "Allwinner A10 HDMI Controller Support"
+	default DRM_SUN4I
+	help
 	  Choose this option if you have an Allwinner SoC with an HDMI
 	  controller.
 
 config DRM_SUN4I_HDMI_CEC
-       bool "Allwinner A10 HDMI CEC Support"
-       depends on DRM_SUN4I_HDMI
-       select CEC_CORE
-       select CEC_PIN
-       help
+	bool "Allwinner A10 HDMI CEC Support"
+	depends on DRM_SUN4I_HDMI
+	select CEC_CORE
+	select CEC_PIN
+	help
 	  Choose this option if you have an Allwinner SoC with an HDMI
 	  controller and want to use CEC.
 
diff --git a/drivers/gpu/drm/udl/Kconfig b/drivers/gpu/drm/udl/Kconfig
index 1616ec4..a259f9a 100644
--- a/drivers/gpu/drm/udl/Kconfig
+++ b/drivers/gpu/drm/udl/Kconfig
@@ -7,4 +7,4 @@ config DRM_UDL
 	select DRM_KMS_HELPER
 	help
 	  This is a KMS driver for the USB displaylink video adapters.
-          Say M/Y to add support for these devices via drm/kms interfaces.
+	  Say M/Y to add support for these devices via drm/kms interfaces.
diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
index fdae18a..670faaf 100644
--- a/drivers/gpu/drm/vc4/Kconfig
+++ b/drivers/gpu/drm/vc4/Kconfig
@@ -21,9 +21,9 @@ config DRM_VC4
 	  our display setup.
 
 config DRM_VC4_HDMI_CEC
-       bool "Broadcom VC4 HDMI CEC Support"
-       depends on DRM_VC4
-       select CEC_CORE
-       help
+	bool "Broadcom VC4 HDMI CEC Support"
+	depends on DRM_VC4
+	select CEC_CORE
+	help
 	  Choose this option if you have a Broadcom VC4 GPU
 	  and want to use CEC.
diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
index 0c384d9..774dc57 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -4,7 +4,7 @@ config DRM_VIRTIO_GPU
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	help
-	   This is the virtual GPU driver for virtio.  It can be used with
-	   QEMU based VMMs (like KVM or Xen).
+	  This is the virtual GPU driver for virtio.  It can be used with
+	  QEMU based VMMs (like KVM or Xen).
 
-	   If unsure say M.
+	  If unsure say M.
diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index 6b28a32..e740679 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -22,6 +22,5 @@ config DRM_VMWGFX_FBCON
 	depends on DRM_VMWGFX && FB
 	bool "Enable framebuffer console under vmwgfx by default"
 	help
-	   Choose this option if you are shipping a new vmwgfx
-	   userspace driver that supports using the kernel driver.
-
+	  Choose this option if you are shipping a new vmwgfx
+	  userspace driver that supports using the kernel driver.
diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index d5f1d8e..b409857 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -26,6 +26,6 @@ config VGA_SWITCHEROO
 	help
 	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
 	  to switch between them. This adds support for dynamic switching when
-          X isn't running and delayed switching until the next logoff. This
+	  X isn't running and delayed switching until the next logoff. This
 	  feature is called hybrid graphics, ATI PowerXpress, and Nvidia
 	  HybridPower.
-- 
1.9.1

