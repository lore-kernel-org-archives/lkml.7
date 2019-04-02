Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360952084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201142;
	bh=tNTGCgBFunGHlQsiBGi869tNvAG8lJS3S8A7AXJNG7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=plmC8+TqT3T+vdhZcmL1KSN1sdUSMoDGoMQTmBq7lJzBJOX27mUWjS0FctMW9luJi
	 TCT4FfMifdIkXx1hvslofAe1x3HIXXDVScqk4wbqtY5ucsv/SdHK/X7t2f6NZC5i+v
	 c3mXqlPNgxjYAYDbO3IiXds8uyvceBwbMQe9Df3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfDBKcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBKcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF072084C;
        Tue,  2 Apr 2019 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201138;
        bh=tNTGCgBFunGHlQsiBGi869tNvAG8lJS3S8A7AXJNG7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsBZ+R/5ZUgZLBtvg0RJfW7EesIqByH84LeIiSqgfHH93O978t+6lJzmwfsmd6Itw
         cOFwnFx+bBnur2YNN2XiLH/NMdRx56f4YrDn0pYtK0rpn/q3k1wyWkt3YKBQRzHiD9
         sIUcexHGX+2DJtcuhbFDHD1vMiFPX5SNeLisvK+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/16] staging: add missing SPDX lines to Kconfig files
Date:   Tue,  2 Apr 2019 12:31:48 +0200
Message-Id: <20190402103203.14959-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few remaining drivers/staging/*/Kconfig files that do not
have SPDX identifiers in them.  Add the correct GPL-2.0 identifier to
them to make scanning tools happy.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/Kconfig                              | 1 +
 drivers/staging/android/Kconfig                      | 1 +
 drivers/staging/android/ion/Kconfig                  | 1 +
 drivers/staging/axis-fifo/Kconfig                    | 1 +
 drivers/staging/board/Kconfig                        | 1 +
 drivers/staging/clocking-wizard/Kconfig              | 1 +
 drivers/staging/comedi/Kconfig                       | 1 +
 drivers/staging/emxx_udc/Kconfig                     | 1 +
 drivers/staging/fbtft/Kconfig                        | 1 +
 drivers/staging/fsl-dpaa2/Kconfig                    | 1 +
 drivers/staging/fwserial/Kconfig                     | 1 +
 drivers/staging/gasket/Kconfig                       | 1 +
 drivers/staging/gdm724x/Kconfig                      | 1 +
 drivers/staging/goldfish/Kconfig                     | 1 +
 drivers/staging/greybus/Kconfig                      | 1 +
 drivers/staging/gs_fpgaboot/Kconfig                  | 1 +
 drivers/staging/iio/Kconfig                          | 1 +
 drivers/staging/iio/accel/Kconfig                    | 1 +
 drivers/staging/iio/adc/Kconfig                      | 1 +
 drivers/staging/iio/addac/Kconfig                    | 1 +
 drivers/staging/iio/cdc/Kconfig                      | 1 +
 drivers/staging/iio/frequency/Kconfig                | 1 +
 drivers/staging/iio/impedance-analyzer/Kconfig       | 1 +
 drivers/staging/iio/meter/Kconfig                    | 1 +
 drivers/staging/iio/resolver/Kconfig                 | 1 +
 drivers/staging/ks7010/Kconfig                       | 1 +
 drivers/staging/media/Kconfig                        | 1 +
 drivers/staging/media/bcm2048/Kconfig                | 1 +
 drivers/staging/media/davinci_vpfe/Kconfig           | 1 +
 drivers/staging/media/imx/Kconfig                    | 1 +
 drivers/staging/media/ipu3/Kconfig                   | 1 +
 drivers/staging/media/mt9t031/Kconfig                | 1 +
 drivers/staging/media/rockchip/vpu/Kconfig           | 1 +
 drivers/staging/media/soc_camera/Kconfig             | 1 +
 drivers/staging/media/sunxi/Kconfig                  | 1 +
 drivers/staging/media/sunxi/cedrus/Kconfig           | 1 +
 drivers/staging/media/tegra-vde/Kconfig              | 1 +
 drivers/staging/media/zoran/Kconfig                  | 1 +
 drivers/staging/most/Kconfig                         | 1 +
 drivers/staging/most/cdev/Kconfig                    | 1 +
 drivers/staging/most/dim2/Kconfig                    | 1 +
 drivers/staging/most/i2c/Kconfig                     | 1 +
 drivers/staging/most/net/Kconfig                     | 1 +
 drivers/staging/most/sound/Kconfig                   | 1 +
 drivers/staging/most/usb/Kconfig                     | 1 +
 drivers/staging/most/video/Kconfig                   | 1 +
 drivers/staging/mt7621-dma/Kconfig                   | 1 +
 drivers/staging/mt7621-dts/Kconfig                   | 1 +
 drivers/staging/mt7621-mmc/Kconfig                   | 1 +
 drivers/staging/mt7621-pci-phy/Kconfig               | 1 +
 drivers/staging/mt7621-pci/Kconfig                   | 1 +
 drivers/staging/mt7621-pinctrl/Kconfig               | 1 +
 drivers/staging/mt7621-spi/Kconfig                   | 1 +
 drivers/staging/netlogic/Kconfig                     | 1 +
 drivers/staging/nvec/Kconfig                         | 1 +
 drivers/staging/octeon-usb/Kconfig                   | 1 +
 drivers/staging/octeon/Kconfig                       | 1 +
 drivers/staging/olpc_dcon/Kconfig                    | 1 +
 drivers/staging/pi433/Kconfig                        | 1 +
 drivers/staging/ralink-gdma/Kconfig                  | 1 +
 drivers/staging/rtl8188eu/Kconfig                    | 1 +
 drivers/staging/rtl8192e/Kconfig                     | 1 +
 drivers/staging/rtl8192e/rtl8192e/Kconfig            | 1 +
 drivers/staging/rtl8192u/Kconfig                     | 1 +
 drivers/staging/rtl8712/Kconfig                      | 1 +
 drivers/staging/rtl8723bs/Kconfig                    | 1 +
 drivers/staging/rtlwifi/Kconfig                      | 1 +
 drivers/staging/rts5208/Kconfig                      | 1 +
 drivers/staging/sm750fb/Kconfig                      | 1 +
 drivers/staging/speakup/Kconfig                      | 1 +
 drivers/staging/unisys/Kconfig                       | 1 +
 drivers/staging/unisys/visorhba/Kconfig              | 1 +
 drivers/staging/unisys/visorinput/Kconfig            | 1 +
 drivers/staging/unisys/visornic/Kconfig              | 1 +
 drivers/staging/vboxvideo/Kconfig                    | 1 +
 drivers/staging/vc04_services/Kconfig                | 1 +
 drivers/staging/vc04_services/bcm2835-audio/Kconfig  | 1 +
 drivers/staging/vc04_services/bcm2835-camera/Kconfig | 1 +
 drivers/staging/vme/devices/Kconfig                  | 1 +
 drivers/staging/vt6655/Kconfig                       | 1 +
 drivers/staging/vt6656/Kconfig                       | 1 +
 drivers/staging/wilc1000/Kconfig                     | 1 +
 drivers/staging/wlan-ng/Kconfig                      | 1 +
 83 files changed, 83 insertions(+)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 62951e836cbc..37121f495cd7 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menuconfig STAGING
 	bool "Staging drivers"
 	default n
diff --git a/drivers/staging/android/Kconfig b/drivers/staging/android/Kconfig
index 17c5587805f5..e02026999161 100644
--- a/drivers/staging/android/Kconfig
+++ b/drivers/staging/android/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menu "Android"
 
 if ANDROID
diff --git a/drivers/staging/android/ion/Kconfig b/drivers/staging/android/ion/Kconfig
index 0fdda6f62953..178df581a8fc 100644
--- a/drivers/staging/android/ion/Kconfig
+++ b/drivers/staging/android/ion/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menuconfig ION
 	bool "Ion Memory Manager"
 	depends on HAS_DMA && MMU
diff --git a/drivers/staging/axis-fifo/Kconfig b/drivers/staging/axis-fifo/Kconfig
index d9725888af6f..09709cd8173d 100644
--- a/drivers/staging/axis-fifo/Kconfig
+++ b/drivers/staging/axis-fifo/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # "Xilinx AXI-Stream FIFO IP core driver"
 #
diff --git a/drivers/staging/board/Kconfig b/drivers/staging/board/Kconfig
index 3f287c48e082..d0c6e42eadda 100644
--- a/drivers/staging/board/Kconfig
+++ b/drivers/staging/board/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config STAGING_BOARD
 	bool "Staging Board Support"
 	depends on OF_ADDRESS && OF_IRQ && CLKDEV_LOOKUP
diff --git a/drivers/staging/clocking-wizard/Kconfig b/drivers/staging/clocking-wizard/Kconfig
index aa57a5865556..04be22dca9b6 100644
--- a/drivers/staging/clocking-wizard/Kconfig
+++ b/drivers/staging/clocking-wizard/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Xilinx Clocking Wizard Driver
 #
diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kconfig
index 9ab1ee7d36bf..73eda687bdc1 100644
--- a/drivers/staging/comedi/Kconfig
+++ b/drivers/staging/comedi/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config COMEDI
 	tristate "Data acquisition support (comedi)"
 	---help---
diff --git a/drivers/staging/emxx_udc/Kconfig b/drivers/staging/emxx_udc/Kconfig
index e50e72218364..ad1478c53e9e 100644
--- a/drivers/staging/emxx_udc/Kconfig
+++ b/drivers/staging/emxx_udc/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config USB_EMXX
 	tristate "EMXX USB Function Device Controller"
 	depends on USB_GADGET && (ARCH_RENESAS || (ARM && COMPILE_TEST))
diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index 84b2e7ebc024..8ec524a95ec8 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menuconfig FB_TFT
 	tristate "Support for small TFT LCD display modules"
 	depends on FB && SPI
diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index 991e154c0eca..368837cdf281 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Freescale DataPath Acceleration Architecture Gen2 (DPAA2) drivers
 #
diff --git a/drivers/staging/fwserial/Kconfig b/drivers/staging/fwserial/Kconfig
index 9c7c9267d52c..9543f8454af9 100644
--- a/drivers/staging/fwserial/Kconfig
+++ b/drivers/staging/fwserial/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config FIREWIRE_SERIAL
        tristate "TTY over Firewire"
        depends on FIREWIRE && TTY
diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
index e82b85541f7e..d9bef8ca41ef 100644
--- a/drivers/staging/gasket/Kconfig
+++ b/drivers/staging/gasket/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menu "Gasket devices"
 
 config STAGING_GASKET_FRAMEWORK
diff --git a/drivers/staging/gdm724x/Kconfig b/drivers/staging/gdm724x/Kconfig
index 0a1f090bbf38..1f403ecd9608 100644
--- a/drivers/staging/gdm724x/Kconfig
+++ b/drivers/staging/gdm724x/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # GCT GDM724x LTE driver configuration
 #
diff --git a/drivers/staging/goldfish/Kconfig b/drivers/staging/goldfish/Kconfig
index 9165385df9de..728f4700b98d 100644
--- a/drivers/staging/goldfish/Kconfig
+++ b/drivers/staging/goldfish/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config GOLDFISH_AUDIO
 	tristate "Goldfish AVD Audio Device"
 	depends on GOLDFISH
diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index b571e4e8060b..4894c3514955 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menuconfig GREYBUS
 	tristate "Greybus support"
 	depends on SYSFS
diff --git a/drivers/staging/gs_fpgaboot/Kconfig b/drivers/staging/gs_fpgaboot/Kconfig
index 550645291fab..232788def2c0 100644
--- a/drivers/staging/gs_fpgaboot/Kconfig
+++ b/drivers/staging/gs_fpgaboot/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # "xilinx FPGA firmware download, fpgaboot"
 #
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index e86ac9e47867..a8e970db179d 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Industrial I/O subsystem configuration
 #
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index befbbfe911c2..3318997a7009 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Accelerometer drivers
 #
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 7a93d3a5c113..94ad59fefb0e 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # ADC drivers
 #
diff --git a/drivers/staging/iio/addac/Kconfig b/drivers/staging/iio/addac/Kconfig
index ba18b8432d9c..b7c3c4a7dfe4 100644
--- a/drivers/staging/iio/addac/Kconfig
+++ b/drivers/staging/iio/addac/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # ADDAC drivers
 #
diff --git a/drivers/staging/iio/cdc/Kconfig b/drivers/staging/iio/cdc/Kconfig
index b97478e7cbd0..e0a5ce66a984 100644
--- a/drivers/staging/iio/cdc/Kconfig
+++ b/drivers/staging/iio/cdc/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # CDC drivers
 #
diff --git a/drivers/staging/iio/frequency/Kconfig b/drivers/staging/iio/frequency/Kconfig
index fc726d3c64a6..72d899cbef8e 100644
--- a/drivers/staging/iio/frequency/Kconfig
+++ b/drivers/staging/iio/frequency/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Direct Digital Synthesis drivers
 #
diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index dd97b6bb3fd0..a5b3ee8b02cb 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Impedance Converter, Network Analyzer drivers
 #
diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
index e01eb8abcdce..aa6a3e7f6cdb 100644
--- a/drivers/staging/iio/meter/Kconfig
+++ b/drivers/staging/iio/meter/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # IIO meter drivers configuration
 #
diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 4a727c17bb8f..6d1e2622e0b0 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Resolver/Synchro drivers
 #
diff --git a/drivers/staging/ks7010/Kconfig b/drivers/staging/ks7010/Kconfig
index 0b9217674d5b..0987fdc2f70d 100644
--- a/drivers/staging/ks7010/Kconfig
+++ b/drivers/staging/ks7010/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config KS7010
 	tristate "KeyStream KS7010 SDIO support"
 	depends on MMC && WIRELESS
diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index 1da5c20d65c0..44280b6c021a 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menuconfig STAGING_MEDIA
 	bool "Media staging drivers"
 	default n
diff --git a/drivers/staging/media/bcm2048/Kconfig b/drivers/staging/media/bcm2048/Kconfig
index a9fc6e186494..c93a0a848c90 100644
--- a/drivers/staging/media/bcm2048/Kconfig
+++ b/drivers/staging/media/bcm2048/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Multimedia Video device configuration
 #
diff --git a/drivers/staging/media/davinci_vpfe/Kconfig b/drivers/staging/media/davinci_vpfe/Kconfig
index aea449a8dbf8..eb61141b29e8 100644
--- a/drivers/staging/media/davinci_vpfe/Kconfig
+++ b/drivers/staging/media/davinci_vpfe/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VIDEO_DM365_VPFE
 	tristate "DM365 VPFE Media Controller Capture Driver"
 	depends on VIDEO_V4L2
diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
index 36b276ea2ecc..6c8b69491ef0 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VIDEO_IMX_MEDIA
 	tristate "i.MX5/6 V4L2 media core driver"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/staging/media/ipu3/Kconfig b/drivers/staging/media/ipu3/Kconfig
index 75cd889f18f7..f80f3e35f431 100644
--- a/drivers/staging/media/ipu3/Kconfig
+++ b/drivers/staging/media/ipu3/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VIDEO_IPU3_IMGU
 	tristate "Intel ipu3-imgu driver"
 	depends on PCI && VIDEO_V4L2
diff --git a/drivers/staging/media/mt9t031/Kconfig b/drivers/staging/media/mt9t031/Kconfig
index 9a58aaf72edd..232f0cdca68b 100644
--- a/drivers/staging/media/mt9t031/Kconfig
+++ b/drivers/staging/media/mt9t031/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config SOC_CAMERA_MT9T031
 	tristate "mt9t031 support (DEPRECATED)"
 	depends on SOC_CAMERA && I2C
diff --git a/drivers/staging/media/rockchip/vpu/Kconfig b/drivers/staging/media/rockchip/vpu/Kconfig
index 9a6fc1378242..208f0379b31f 100644
--- a/drivers/staging/media/rockchip/vpu/Kconfig
+++ b/drivers/staging/media/rockchip/vpu/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VIDEO_ROCKCHIP_VPU
 	tristate "Rockchip VPU driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/staging/media/soc_camera/Kconfig b/drivers/staging/media/soc_camera/Kconfig
index bacd30f0348d..4a54db121574 100644
--- a/drivers/staging/media/soc_camera/Kconfig
+++ b/drivers/staging/media/soc_camera/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config SOC_CAMERA
 	tristate "SoC camera support"
 	depends on VIDEO_V4L2 && HAS_DMA && I2C && BROKEN
diff --git a/drivers/staging/media/sunxi/Kconfig b/drivers/staging/media/sunxi/Kconfig
index c78d92240ceb..4549a135741f 100644
--- a/drivers/staging/media/sunxi/Kconfig
+++ b/drivers/staging/media/sunxi/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VIDEO_SUNXI
 	bool "Allwinner sunXi family Video Devices"
 	depends on ARCH_SUNXI || COMPILE_TEST
diff --git a/drivers/staging/media/sunxi/cedrus/Kconfig b/drivers/staging/media/sunxi/cedrus/Kconfig
index 3252efa422f9..17733e9a088f 100644
--- a/drivers/staging/media/sunxi/cedrus/Kconfig
+++ b/drivers/staging/media/sunxi/cedrus/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VIDEO_SUNXI_CEDRUS
 	tristate "Allwinner Cedrus VPU driver"
 	depends on VIDEO_DEV && VIDEO_V4L2 && MEDIA_CONTROLLER
diff --git a/drivers/staging/media/tegra-vde/Kconfig b/drivers/staging/media/tegra-vde/Kconfig
index 5c4914674468..ff8e846cd15d 100644
--- a/drivers/staging/media/tegra-vde/Kconfig
+++ b/drivers/staging/media/tegra-vde/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config TEGRA_VDE
 	tristate "NVIDIA Tegra Video Decoder Engine driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/staging/media/zoran/Kconfig b/drivers/staging/media/zoran/Kconfig
index 34a18135ede0..84502b0fe48a 100644
--- a/drivers/staging/media/zoran/Kconfig
+++ b/drivers/staging/media/zoran/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VIDEO_ZORAN
 	tristate "Zoran ZR36057/36067 Video For Linux (Deprecated)"
 	depends on PCI && I2C_ALGOBIT && VIDEO_V4L2 && VIRT_TO_BUS
diff --git a/drivers/staging/most/Kconfig b/drivers/staging/most/Kconfig
index 20047abbe560..535455c39fba 100644
--- a/drivers/staging/most/Kconfig
+++ b/drivers/staging/most/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menuconfig MOST
         tristate "MOST support"
 	depends on HAS_DMA
diff --git a/drivers/staging/most/cdev/Kconfig b/drivers/staging/most/cdev/Kconfig
index 2b04e26bcbea..330c95fe6550 100644
--- a/drivers/staging/most/cdev/Kconfig
+++ b/drivers/staging/most/cdev/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # MOST Cdev configuration
 #
diff --git a/drivers/staging/most/dim2/Kconfig b/drivers/staging/most/dim2/Kconfig
index 5aeef22c3cba..22f6900187b5 100644
--- a/drivers/staging/most/dim2/Kconfig
+++ b/drivers/staging/most/dim2/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # MediaLB configuration
 #
diff --git a/drivers/staging/most/i2c/Kconfig b/drivers/staging/most/i2c/Kconfig
index f723f99711bd..19a094b5bee0 100644
--- a/drivers/staging/most/i2c/Kconfig
+++ b/drivers/staging/most/i2c/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # MOST I2C configuration
 #
diff --git a/drivers/staging/most/net/Kconfig b/drivers/staging/most/net/Kconfig
index 28040931f7e7..ed8ac7e076d1 100644
--- a/drivers/staging/most/net/Kconfig
+++ b/drivers/staging/most/net/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # MOST Networking configuration
 #
diff --git a/drivers/staging/most/sound/Kconfig b/drivers/staging/most/sound/Kconfig
index 5614a999b54e..ad9f7821af7d 100644
--- a/drivers/staging/most/sound/Kconfig
+++ b/drivers/staging/most/sound/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # MOST ALSA configuration
 #
diff --git a/drivers/staging/most/usb/Kconfig b/drivers/staging/most/usb/Kconfig
index 539b38fb3d88..a86f1f63def4 100644
--- a/drivers/staging/most/usb/Kconfig
+++ b/drivers/staging/most/usb/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # MOST USB configuration
 #
diff --git a/drivers/staging/most/video/Kconfig b/drivers/staging/most/video/Kconfig
index a458d0c74a0f..e0964ca5e7b3 100644
--- a/drivers/staging/most/video/Kconfig
+++ b/drivers/staging/most/video/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # MOST V4L2 configuration
 #
diff --git a/drivers/staging/mt7621-dma/Kconfig b/drivers/staging/mt7621-dma/Kconfig
index b6e48a682c44..54a110288f92 100644
--- a/drivers/staging/mt7621-dma/Kconfig
+++ b/drivers/staging/mt7621-dma/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config MTK_HSDMA
 	tristate "MTK HSDMA support"
 	depends on RALINK && SOC_MT7621
diff --git a/drivers/staging/mt7621-dts/Kconfig b/drivers/staging/mt7621-dts/Kconfig
index 94a9e16c0b92..3ea08ab9d0d3 100644
--- a/drivers/staging/mt7621-dts/Kconfig
+++ b/drivers/staging/mt7621-dts/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config DTB_GNUBEE1
 	bool "GnuBee1 NAS"
 	depends on SOC_MT7621 && DTB_RT_NONE
diff --git a/drivers/staging/mt7621-mmc/Kconfig b/drivers/staging/mt7621-mmc/Kconfig
index 01f231dd8511..6ede50e9ddc0 100644
--- a/drivers/staging/mt7621-mmc/Kconfig
+++ b/drivers/staging/mt7621-mmc/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config MTK_MMC
 	tristate "MTK SD/MMC"
 	depends on RALINK && MMC
diff --git a/drivers/staging/mt7621-pci-phy/Kconfig b/drivers/staging/mt7621-pci-phy/Kconfig
index b9f6ab784ee8..263e0a91c424 100644
--- a/drivers/staging/mt7621-pci-phy/Kconfig
+++ b/drivers/staging/mt7621-pci-phy/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config PCI_MT7621_PHY
 	tristate "MediaTek MT7621 PCI PHY Driver"
 	depends on RALINK && OF
diff --git a/drivers/staging/mt7621-pci/Kconfig b/drivers/staging/mt7621-pci/Kconfig
index c8fa17cfa807..af928b75a940 100644
--- a/drivers/staging/mt7621-pci/Kconfig
+++ b/drivers/staging/mt7621-pci/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config PCI_MT7621
 	tristate "MediaTek MT7621 PCI Controller"
 	depends on RALINK
diff --git a/drivers/staging/mt7621-pinctrl/Kconfig b/drivers/staging/mt7621-pinctrl/Kconfig
index fc3612711307..f42974026480 100644
--- a/drivers/staging/mt7621-pinctrl/Kconfig
+++ b/drivers/staging/mt7621-pinctrl/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config PINCTRL_RT2880
 	bool "RT2800 pinctrl driver for RALINK/Mediatek SOCs"
 	depends on RALINK
diff --git a/drivers/staging/mt7621-spi/Kconfig b/drivers/staging/mt7621-spi/Kconfig
index 0b90f4cfa426..24f00dcc9696 100644
--- a/drivers/staging/mt7621-spi/Kconfig
+++ b/drivers/staging/mt7621-spi/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config SPI_MT7621
 	tristate "MediaTek MT7621 SPI Controller"
 	depends on RALINK
diff --git a/drivers/staging/netlogic/Kconfig b/drivers/staging/netlogic/Kconfig
index c25a00dd2d5f..b2a4d4586697 100644
--- a/drivers/staging/netlogic/Kconfig
+++ b/drivers/staging/netlogic/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config NETLOGIC_XLR_NET
 	tristate "Netlogic XLR/XLS network device"
 	depends on CPU_XLR
diff --git a/drivers/staging/nvec/Kconfig b/drivers/staging/nvec/Kconfig
index e3a89fb1a4a2..5c12cacf75e1 100644
--- a/drivers/staging/nvec/Kconfig
+++ b/drivers/staging/nvec/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config MFD_NVEC
 	tristate "NV Tegra Embedded Controller SMBus Interface"
 	depends on I2C && GPIOLIB && ARCH_TEGRA
diff --git a/drivers/staging/octeon-usb/Kconfig b/drivers/staging/octeon-usb/Kconfig
index 0b8f1d9c7056..6a5d842ee0f2 100644
--- a/drivers/staging/octeon-usb/Kconfig
+++ b/drivers/staging/octeon-usb/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config OCTEON_USB
 	tristate "Cavium Networks Octeon USB support"
 	depends on CAVIUM_OCTEON_SOC && USB
diff --git a/drivers/staging/octeon/Kconfig b/drivers/staging/octeon/Kconfig
index 6e1d5f8d3ec1..1e3012b9991c 100644
--- a/drivers/staging/octeon/Kconfig
+++ b/drivers/staging/octeon/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config OCTEON_ETHERNET
 	tristate "Cavium Networks Octeon Ethernet support"
 	depends on CAVIUM_OCTEON_SOC && NETDEVICES
diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index 192cc8d0853f..255e266c40e1 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
 	depends on OLPC && FB
diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
index c7340129dd4c..8acde0814206 100644
--- a/drivers/staging/pi433/Kconfig
+++ b/drivers/staging/pi433/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config PI433
         tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
         depends on SPI
diff --git a/drivers/staging/ralink-gdma/Kconfig b/drivers/staging/ralink-gdma/Kconfig
index a12b2c672d48..54e8029e6b1a 100644
--- a/drivers/staging/ralink-gdma/Kconfig
+++ b/drivers/staging/ralink-gdma/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config DMA_RALINK
 	tristate "RALINK DMA support"
 	depends on RALINK && !SOC_RT288X
diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
index ff7832798a77..4f7ef287a0f2 100644
--- a/drivers/staging/rtl8188eu/Kconfig
+++ b/drivers/staging/rtl8188eu/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config R8188EU
 	tristate "Realtek RTL8188EU Wireless LAN NIC driver"
 	depends on WLAN && USB && CFG80211
diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
index aa571c12678f..8b3da2b00cb3 100644
--- a/drivers/staging/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config RTLLIB
 	tristate "Support for rtllib wireless devices"
 	depends on WLAN && m
diff --git a/drivers/staging/rtl8192e/rtl8192e/Kconfig b/drivers/staging/rtl8192e/rtl8192e/Kconfig
index 7ac42a590e21..eae8167f79dd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/rtl8192e/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config RTL8192E
 	tristate "RealTek RTL8192E Wireless LAN NIC driver"
 	depends on PCI && WLAN && RTLLIB
diff --git a/drivers/staging/rtl8192u/Kconfig b/drivers/staging/rtl8192u/Kconfig
index 97df6507a485..22c2165e8b1c 100644
--- a/drivers/staging/rtl8192u/Kconfig
+++ b/drivers/staging/rtl8192u/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config RTL8192U
 	tristate "RealTek RTL8192U Wireless LAN NIC driver"
 	depends on PCI && WLAN && USB
diff --git a/drivers/staging/rtl8712/Kconfig b/drivers/staging/rtl8712/Kconfig
index 622ad14f232c..b6dcda77db1f 100644
--- a/drivers/staging/rtl8712/Kconfig
+++ b/drivers/staging/rtl8712/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config R8712U
 	tristate "RealTek RTL8712U (RTL8192SU) Wireless LAN NIC driver"
 	depends on WLAN && USB
diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
index deae0427ba6c..744091d46f4c 100644
--- a/drivers/staging/rtl8723bs/Kconfig
+++ b/drivers/staging/rtl8723bs/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config RTL8723BS
 	tristate "Realtek RTL8723BS SDIO Wireless LAN NIC driver"
 	depends on WLAN && MMC && CFG80211
diff --git a/drivers/staging/rtlwifi/Kconfig b/drivers/staging/rtlwifi/Kconfig
index 28286a87a601..f874373bab63 100644
--- a/drivers/staging/rtlwifi/Kconfig
+++ b/drivers/staging/rtlwifi/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config R8822BE
 	tristate "Realtek RTL8822BE Wireless Network Adapter"
 	depends on PCI && MAC80211 && m
diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
index 05c990f654a4..b864023d3ccb 100644
--- a/drivers/staging/rts5208/Kconfig
+++ b/drivers/staging/rts5208/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config RTS5208
 	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
 	depends on PCI && SCSI
diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kconfig
index ccebc25c2ec1..fb5a086bf9b1 100644
--- a/drivers/staging/sm750fb/Kconfig
+++ b/drivers/staging/sm750fb/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config FB_SM750
 	tristate "Silicon Motion SM750 framebuffer support"
 	depends on FB && PCI
diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
index d8ec780f7741..0803c2013cf4 100644
--- a/drivers/staging/speakup/Kconfig
+++ b/drivers/staging/speakup/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menu "Speakup console speech"
 
 config SPEAKUP
diff --git a/drivers/staging/unisys/Kconfig b/drivers/staging/unisys/Kconfig
index c27dab3b610f..dc5e1bddc085 100644
--- a/drivers/staging/unisys/Kconfig
+++ b/drivers/staging/unisys/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Unisys SPAR driver configuration
 #
diff --git a/drivers/staging/unisys/visorhba/Kconfig b/drivers/staging/unisys/visorhba/Kconfig
index fb592f7cb7c3..ed59ac11c322 100644
--- a/drivers/staging/unisys/visorhba/Kconfig
+++ b/drivers/staging/unisys/visorhba/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Unisys visorhba configuration
 #
diff --git a/drivers/staging/unisys/visorinput/Kconfig b/drivers/staging/unisys/visorinput/Kconfig
index 1b8efc2fd8c8..5f036393aee9 100644
--- a/drivers/staging/unisys/visorinput/Kconfig
+++ b/drivers/staging/unisys/visorinput/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Unisys visorinput configuration
 #
diff --git a/drivers/staging/unisys/visornic/Kconfig b/drivers/staging/unisys/visornic/Kconfig
index 865f8963409e..3f8f5570821b 100644
--- a/drivers/staging/unisys/visornic/Kconfig
+++ b/drivers/staging/unisys/visornic/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Unisys visornic configuration
 #
diff --git a/drivers/staging/vboxvideo/Kconfig b/drivers/staging/vboxvideo/Kconfig
index 1f4182e2e980..d6ab955c0768 100644
--- a/drivers/staging/vboxvideo/Kconfig
+++ b/drivers/staging/vboxvideo/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config DRM_VBOXVIDEO
 	tristate "Virtual Box Graphics Card"
 	depends on DRM && X86 && PCI
diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index 98064ce2c2b4..6baf9dd57f1f 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 menuconfig BCM_VIDEOCORE
 	tristate "Broadcom VideoCore support"
 	depends on OF
diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index 62c1c8ba4ad4..f66319512faf 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config SND_BCM2835
         tristate "BCM2835 Audio"
         depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
diff --git a/drivers/staging/vc04_services/bcm2835-camera/Kconfig b/drivers/staging/vc04_services/bcm2835-camera/Kconfig
index b8b01aa4e426..c81baf2c111e 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-camera/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VIDEO_BCM2835
 	tristate "BCM2835 Camera"
 	depends on MEDIA_SUPPORT
diff --git a/drivers/staging/vme/devices/Kconfig b/drivers/staging/vme/devices/Kconfig
index c548dd8c91e1..5651bb16b28b 100644
--- a/drivers/staging/vme/devices/Kconfig
+++ b/drivers/staging/vme/devices/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 comment "VME Device Drivers"
 
 config VME_USER
diff --git a/drivers/staging/vt6655/Kconfig b/drivers/staging/vt6655/Kconfig
index 77cfc708c516..e4b224fedf5b 100644
--- a/drivers/staging/vt6655/Kconfig
+++ b/drivers/staging/vt6655/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VT6655
    tristate "VIA Technologies VT6655 support"
    depends on PCI && MAC80211 && m
diff --git a/drivers/staging/vt6656/Kconfig b/drivers/staging/vt6656/Kconfig
index b602ef175d55..51e295265ba6 100644
--- a/drivers/staging/vt6656/Kconfig
+++ b/drivers/staging/vt6656/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config VT6656
 	tristate "VIA Technologies VT6656 support"
 	depends on MAC80211 && USB && WLAN && m
diff --git a/drivers/staging/wilc1000/Kconfig b/drivers/staging/wilc1000/Kconfig
index f9d3ad41c862..81d052a46e57 100644
--- a/drivers/staging/wilc1000/Kconfig
+++ b/drivers/staging/wilc1000/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config WILC1000
 	tristate
 	help
diff --git a/drivers/staging/wlan-ng/Kconfig b/drivers/staging/wlan-ng/Kconfig
index 97238018b315..b796bfd429c4 100644
--- a/drivers/staging/wlan-ng/Kconfig
+++ b/drivers/staging/wlan-ng/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config PRISM2_USB
 	tristate "Prism2.5/3 USB driver"
 	depends on WLAN && USB && CFG80211
-- 
2.21.0

