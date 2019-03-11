Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8256FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C5420657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfCKNWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:33 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfCKNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:43 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUGmL-1hTMGa3lNj-00RJzE for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 063/114] drivers: media: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:15 +0100
Message-Id: <1552310346-7629-64-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:znjyGX9vU2EpncFLECwgE4FhhUfbM3/g9WuVm2GAzGqtW/Sbx1+
 VDYDI51zTrjYh8a6JPakntZ6ob4Nq/7+QgAiCocs/sn8l66dWVaau1PW9fhyjGGlrJ38peI
 boPl60PANGTgx+cq5fXcPibfMljUSvOD7dnKj6UQnVvddHm65sNRNUHqmed/zmQbt+JNhrI
 yZ7fVWerRRAi8uK8GRdQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cpmItPNk/mA=:rUoduttgMz2Egq3LTJ+Nqw
 FPltd3WBc6vsOe52yr6ThxPHnyw4qGqQax/+Wr+eM9EvY4qm3u7WlAAgQlfrQI6OCKbj0MNcg
 lr9wxkOzNbqCfixTh2UloiCRZc83uMMyNDB9ZZNHDEQG7vGxCa6FLGQM6+CyuBwEoQ8uwgHUw
 rqXnuw5ibJ0BVRpHpHmTOcTEbmEPHikzZIYtNIkOI5Ymzc6gfDDt4GBf475Z3wFgJJxpbGePQ
 8irNwsmP5TsFVj1e2xTk2ydIlhifVbf3n7XdGfk0YK2cE5tV/STRh9+Z69MVOt+pwtpT/uAQk
 IIPRyxY+RzYVc6qmVoeoo/G99HSoW/ciRPoH9moPvJfTlohnJzRqM+sBfWq5g5BGhO10IDJEw
 NGfG1Cb8/t88NAItO0812WsuPWYt0RjjPNVLVrXgJVRM4K6rJ3AXUpXKQtf7cNugk71uGJBAE
 pd5l1rtMVltQIsO1y2QNDmriw4hMKExNI3N81igDZeshGSo9rfeKr9fpiqd0e1vwxY0DgJ+zh
 HUOsMvNhvA7KFHw6VKE01sOkeCGRiuJV4+4FeL3Vmn2A2LP3V14ok8IA3Gy+DJIS7Qq8mYS1M
 wg8o3jhEu1pK1R8lVnus24RYJvgmA7seeB9ncevnoBM7KFp7c0nu9cWFMeVLUW27Q9DcedA2S
 WSWPDF9CcV/W0ezVaB7Uh1L30el6S2EVvTvOEIf3nmaVMA+Q54d6rkw5Zb2M1TBjXumuJCx9T
 87qlaZh2+fh7H5Ck4XRnoMKz/0g/W0JNij3ntQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/media/i2c/Kconfig                      |   6 +-
 drivers/media/platform/Kconfig                 | 150 +++++------
 drivers/media/platform/am437x/Kconfig          |   8 +-
 drivers/media/platform/atmel/Kconfig           |   4 +-
 drivers/media/platform/davinci/Kconfig         |  50 ++--
 drivers/media/platform/exynos4-is/Kconfig      |   2 +-
 drivers/media/platform/sunxi/sun6i-csi/Kconfig |   2 +-
 drivers/media/platform/xilinx/Kconfig          |   4 +-
 drivers/media/radio/si470x/Kconfig             |   4 +-
 drivers/media/rc/Kconfig                       | 343 ++++++++++++-------------
 drivers/media/rc/img-ir/Kconfig                |  52 ++--
 11 files changed, 308 insertions(+), 317 deletions(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 6d32f8d..b29a77c 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -1113,10 +1113,10 @@ config VIDEO_M52790
 	tristate "Mitsubishi M52790 A/V switch"
 	depends on VIDEO_V4L2 && I2C
 	---help---
-	 Support for the Mitsubishi M52790 A/V switch.
+	  Support for the Mitsubishi M52790 A/V switch.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called m52790.
+	  To compile this driver as a module, choose M here: the
+	  module will be called m52790.
 
 config VIDEO_I2C
 	tristate "I2C transport video support"
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 4acbed1..1d88945 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -19,9 +19,9 @@ config VIDEO_VIA_CAMERA
 	select VIDEOBUF_DMA_SG
 	select VIDEO_OV7670
 	help
-	   Driver support for the integrated camera controller in VIA
-	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
-	   with ov7670 sensors.
+	  Driver support for the integrated camera controller in VIA
+	  Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
+	  with ov7670 sensors.
 
 #
 # Platform multimedia device configuration
@@ -185,8 +185,8 @@ config VIDEO_CODA
 	select V4L2_MEM2MEM_DEV
 	select GENERIC_ALLOCATOR
 	---help---
-	   Coda is a range of video codec IPs that supports
-	   H.264, MPEG-4, and other video formats.
+	  Coda is a range of video codec IPs that supports
+	  H.264, MPEG-4, and other video formats.
 
 config VIDEO_IMX_VDOA
 	def_tristate VIDEO_CODA if SOC_IMX6Q || COMPILE_TEST
@@ -219,13 +219,13 @@ config VIDEO_MEDIATEK_VPU
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	---help---
-	    This driver provides downloading VPU firmware and
-	    communicating with VPU. This driver for hw video
-	    codec embedded in Mediatek's MT8173 SOCs. It is able
-	    to handle video decoding/encoding in a range of formats.
+	  This driver provides downloading VPU firmware and
+	  communicating with VPU. This driver for hw video
+	  codec embedded in Mediatek's MT8173 SOCs. It is able
+	  to handle video decoding/encoding in a range of formats.
 
-	    To compile this driver as a module, choose M here: the
-	    module will be called mtk-vpu.
+	  To compile this driver as a module, choose M here: the
+	  module will be called mtk-vpu.
 
 config VIDEO_MEDIATEK_MDP
 	tristate "Mediatek MDP driver"
@@ -237,11 +237,11 @@ config VIDEO_MEDIATEK_MDP
 	select VIDEO_MEDIATEK_VPU
 	default n
 	---help---
-	    It is a v4l2 driver and present in Mediatek MT8173 SoCs.
-	    The driver supports for scaling and color space conversion.
+	  It is a v4l2 driver and present in Mediatek MT8173 SoCs.
+	  The driver supports for scaling and color space conversion.
 
-	    To compile this driver as a module, choose M here: the
-	    module will be called mtk-mdp.
+	  To compile this driver as a module, choose M here: the
+	  module will be called mtk-mdp.
 
 config VIDEO_MEDIATEK_VCODEC
 	tristate "Mediatek Video Codec driver"
@@ -253,12 +253,12 @@ config VIDEO_MEDIATEK_VCODEC
 	select VIDEO_MEDIATEK_VPU
 	default n
 	---help---
-	    Mediatek video codec driver provides HW capability to
-	    encode and decode in a range of video formats
-	    This driver rely on VPU driver to communicate with VPU.
+	  Mediatek video codec driver provides HW capability to
+	  encode and decode in a range of video formats
+	  This driver rely on VPU driver to communicate with VPU.
 
-	    To compile this driver as a module, choose M here: the
-	    module will be called mtk-vcodec
+	  To compile this driver as a module, choose M here: the
+	  module will be called mtk-vcodec
 
 config VIDEO_MEM2MEM_DEINTERLACE
 	tristate "Deinterlace support"
@@ -267,7 +267,7 @@ config VIDEO_MEM2MEM_DEINTERLACE
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	help
-	    Generic deinterlacing V4L2 driver.
+	  Generic deinterlacing V4L2 driver.
 
 config VIDEO_SAMSUNG_S5P_G2D
 	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
@@ -297,7 +297,7 @@ config VIDEO_SAMSUNG_S5P_MFC
 	select VIDEOBUF2_DMA_CONTIG
 	default n
 	help
-	    MFC 5.1 and 6.x driver for V4L2
+	  MFC 5.1 and 6.x driver for V4L2
 
 config VIDEO_MX2_EMMAPRP
 	tristate "MX2 eMMa-PrP support"
@@ -306,9 +306,9 @@ config VIDEO_MX2_EMMAPRP
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	help
-	    MX2X chips have a PrP that can be used to process buffers from
-	    memory to memory. Operations include resizing and format
-	    conversion.
+	  MX2X chips have a PrP that can be used to process buffers from
+	  memory to memory. Operations include resizing and format
+	  conversion.
 
 config VIDEO_SAMSUNG_EXYNOS_GSC
 	tristate "Samsung Exynos G-Scaler driver"
@@ -358,16 +358,16 @@ config VIDEO_STI_DELTA
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_STI || COMPILE_TEST
 	help
-		This V4L2 driver enables DELTA multi-format video decoder
-		of STMicroelectronics STiH4xx SoC series allowing hardware
-		decoding of various compressed video bitstream format in
-		raw uncompressed format.
+	  This V4L2 driver enables DELTA multi-format video decoder
+	  of STMicroelectronics STiH4xx SoC series allowing hardware
+	  decoding of various compressed video bitstream format in
+	  raw uncompressed format.
 
-		Use this option to see the decoders available for such
-		hardware.
+	  Use this option to see the decoders available for such
+	  hardware.
 
-		Please notice that the driver will only be built if
-		at least one of the DELTA decoder below is selected.
+	  Please notice that the driver will only be built if
+	  at least one of the DELTA decoder below is selected.
 
 if VIDEO_STI_DELTA
 
@@ -375,10 +375,10 @@ config VIDEO_STI_DELTA_MJPEG
 	bool "STMicroelectronics DELTA MJPEG support"
 	default y
 	help
-		Enables DELTA MJPEG hardware support.
+	  Enables DELTA MJPEG hardware support.
 
-		To compile this driver as a module, choose M here:
-		the module will be called st-delta.
+	  To compile this driver as a module, choose M here:
+	  the module will be called st-delta.
 
 config VIDEO_STI_DELTA_DRIVER
 	tristate
@@ -397,8 +397,8 @@ config VIDEO_SH_VEU
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	help
-	    Support for the Video Engine Unit (VEU) on SuperH and
-	    SH-Mobile SoCs.
+	  Support for the Video Engine Unit (VEU) on SuperH and
+	  SH-Mobile SoCs.
 
 config VIDEO_RENESAS_FDP1
 	tristate "Renesas Fine Display Processor"
@@ -590,49 +590,49 @@ config CEC_GPIO
 	  between compatible devices.
 
 config VIDEO_SAMSUNG_S5P_CEC
-       tristate "Samsung S5P CEC driver"
-       depends on ARCH_EXYNOS || COMPILE_TEST
-       select CEC_CORE
-       select CEC_NOTIFIER
-       ---help---
-	 This is a driver for Samsung S5P HDMI CEC interface. It uses the
-	 generic CEC framework interface.
-	 CEC bus is present in the HDMI connector and enables communication
-	 between compatible devices.
+	tristate "Samsung S5P CEC driver"
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	select CEC_CORE
+	select CEC_NOTIFIER
+	---help---
+	  This is a driver for Samsung S5P HDMI CEC interface. It uses the
+	  generic CEC framework interface.
+	  CEC bus is present in the HDMI connector and enables communication
+	  between compatible devices.
 
 config VIDEO_STI_HDMI_CEC
-       tristate "STMicroelectronics STiH4xx HDMI CEC driver"
-       depends on ARCH_STI || COMPILE_TEST
-       select CEC_CORE
-       select CEC_NOTIFIER
-       ---help---
-	 This is a driver for STIH4xx HDMI CEC interface. It uses the
-	 generic CEC framework interface.
-	 CEC bus is present in the HDMI connector and enables communication
-	 between compatible devices.
+	tristate "STMicroelectronics STiH4xx HDMI CEC driver"
+	depends on ARCH_STI || COMPILE_TEST
+	select CEC_CORE
+	select CEC_NOTIFIER
+	---help---
+	  This is a driver for STIH4xx HDMI CEC interface. It uses the
+	  generic CEC framework interface.
+	  CEC bus is present in the HDMI connector and enables communication
+	  between compatible devices.
 
 config VIDEO_STM32_HDMI_CEC
-       tristate "STMicroelectronics STM32 HDMI CEC driver"
-       depends on ARCH_STM32 || COMPILE_TEST
-       select REGMAP
-       select REGMAP_MMIO
-       select CEC_CORE
-       ---help---
-	 This is a driver for STM32 interface. It uses the
-	 generic CEC framework interface.
-	 CEC bus is present in the HDMI connector and enables communication
-	 between compatible devices.
+	tristate "STMicroelectronics STM32 HDMI CEC driver"
+	depends on ARCH_STM32 || COMPILE_TEST
+	select REGMAP
+	select REGMAP_MMIO
+	select CEC_CORE
+	---help---
+	  This is a driver for STM32 interface. It uses the
+	  generic CEC framework interface.
+	  CEC bus is present in the HDMI connector and enables communication
+	  between compatible devices.
 
 config VIDEO_TEGRA_HDMI_CEC
-       tristate "Tegra HDMI CEC driver"
-       depends on ARCH_TEGRA || COMPILE_TEST
-       select CEC_CORE
-       select CEC_NOTIFIER
-       ---help---
-	 This is a driver for the Tegra HDMI CEC interface. It uses the
-	 generic CEC framework interface.
-	 The CEC bus is present in the HDMI connector and enables communication
-	 between compatible devices.
+	tristate "Tegra HDMI CEC driver"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	select CEC_CORE
+	select CEC_NOTIFIER
+	---help---
+	  This is a driver for the Tegra HDMI CEC interface. It uses the
+	  generic CEC framework interface.
+	  The CEC bus is present in the HDMI connector and enables communication
+	  between compatible devices.
 
 config VIDEO_SECO_CEC
 	tristate "SECO Boards HDMI CEC driver"
diff --git a/drivers/media/platform/am437x/Kconfig b/drivers/media/platform/am437x/Kconfig
index f4ce117..e9f7e8f 100644
--- a/drivers/media/platform/am437x/Kconfig
+++ b/drivers/media/platform/am437x/Kconfig
@@ -5,8 +5,8 @@ config VIDEO_AM437X_VPFE
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_FWNODE
 	help
-	   Support for AM437x Video Processing Front End based Video
-	   Capture Driver.
+	  Support for AM437x Video Processing Front End based Video
+	  Capture Driver.
 
-	   To compile this driver as a module, choose M here. The module
-	   will be called am437x-vpfe.
+	  To compile this driver as a module, choose M here. The module
+	  will be called am437x-vpfe.
diff --git a/drivers/media/platform/atmel/Kconfig b/drivers/media/platform/atmel/Kconfig
index a211ef2..a57e310 100644
--- a/drivers/media/platform/atmel/Kconfig
+++ b/drivers/media/platform/atmel/Kconfig
@@ -6,8 +6,8 @@ config VIDEO_ATMEL_ISC
 	select REGMAP_MMIO
 	select V4L2_FWNODE
 	help
-	   This module makes the ATMEL Image Sensor Controller available
-	   as a v4l2 device.
+	  This module makes the ATMEL Image Sensor Controller available
+	  as a v4l2 device.
 
 config VIDEO_ATMEL_ISI
 	tristate "ATMEL Image Sensor Interface (ISI) support"
diff --git a/drivers/media/platform/davinci/Kconfig b/drivers/media/platform/davinci/Kconfig
index 06b5e58..2ac21ca 100644
--- a/drivers/media/platform/davinci/Kconfig
+++ b/drivers/media/platform/davinci/Kconfig
@@ -36,14 +36,14 @@ config VIDEO_DM6446_CCDC
 	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
-	   Enables DaVinci CCD hw module. DaVinci CCDC hw interfaces
-	   with decoder modules such as TVP5146 over BT656 or
-	   sensor module such as MT9T001 over a raw interface. This
-	   module configures the interface and CCDC/ISIF to do
-	   video frame capture from slave decoders.
+	  Enables DaVinci CCD hw module. DaVinci CCDC hw interfaces
+	  with decoder modules such as TVP5146 over BT656 or
+	  sensor module such as MT9T001 over a raw interface. This
+	  module configures the interface and CCDC/ISIF to do
+	  video frame capture from slave decoders.
 
-	   To compile this driver as a module, choose M here. There will
-	   be three modules called vpfe_capture.ko, vpss.ko and dm644x_ccdc.ko
+	  To compile this driver as a module, choose M here. There will
+	  be three modules called vpfe_capture.ko, vpss.ko and dm644x_ccdc.ko
 
 config VIDEO_DM355_CCDC
 	tristate "TI DM355 CCDC video capture driver"
@@ -52,14 +52,14 @@ config VIDEO_DM355_CCDC
 	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
-	   Enables DM355 CCD hw module. DM355 CCDC hw interfaces
-	   with decoder modules such as TVP5146 over BT656 or
-	   sensor module such as MT9T001 over a raw interface. This
-	   module configures the interface and CCDC/ISIF to do
-	   video frame capture from a slave decoders
+	  Enables DM355 CCD hw module. DM355 CCDC hw interfaces
+	  with decoder modules such as TVP5146 over BT656 or
+	  sensor module such as MT9T001 over a raw interface. This
+	  module configures the interface and CCDC/ISIF to do
+	  video frame capture from a slave decoders
 
-	   To compile this driver as a module, choose M here. There will
-	   be three modules called vpfe_capture.ko, vpss.ko and dm355_ccdc.ko
+	  To compile this driver as a module, choose M here. There will
+	  be three modules called vpfe_capture.ko, vpss.ko and dm355_ccdc.ko
 
 config VIDEO_DM365_ISIF
 	tristate "TI DM365 ISIF video capture driver"
@@ -68,12 +68,12 @@ config VIDEO_DM365_ISIF
 	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
-	   Enables ISIF hw module. This is the hardware module for
-	   configuring ISIF in VPFE to capture Raw Bayer RGB data from
-	   a image sensor or YUV data from a YUV source.
+	  Enables ISIF hw module. This is the hardware module for
+	  configuring ISIF in VPFE to capture Raw Bayer RGB data from
+	  a image sensor or YUV data from a YUV source.
 
-	   To compile this driver as a module, choose M here. There will
-	   be three modules called vpfe_capture.ko, vpss.ko and isif.ko
+	  To compile this driver as a module, choose M here. There will
+	  be three modules called vpfe_capture.ko, vpss.ko and isif.ko
 
 config VIDEO_DAVINCI_VPBE_DISPLAY
 	tristate "TI DaVinci VPBE V4L2-Display driver"
@@ -82,10 +82,10 @@ config VIDEO_DAVINCI_VPBE_DISPLAY
 	depends on I2C
 	select VIDEOBUF2_DMA_CONTIG
 	help
-	    Enables Davinci VPBE module used for display devices.
-	    This module is used for display on TI DM644x/DM365/DM355
-	    based display devices.
+	  Enables Davinci VPBE module used for display devices.
+	  This module is used for display on TI DM644x/DM365/DM355
+	  based display devices.
 
-	    To compile this driver as a module, choose M here. There will
-	    be five modules created called vpss.ko, vpbe.ko, vpbe_osd.ko,
-	    vpbe_venc.ko and vpbe_display.ko
+	  To compile this driver as a module, choose M here. There will
+	  be five modules created called vpss.ko, vpbe.ko, vpbe_osd.ko,
+	  vpbe_venc.ko and vpbe_display.ko
diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
index c8e5ad8..cf77a75 100644
--- a/drivers/media/platform/exynos4-is/Kconfig
+++ b/drivers/media/platform/exynos4-is/Kconfig
@@ -12,7 +12,7 @@ config VIDEO_SAMSUNG_EXYNOS4_IS
 if VIDEO_SAMSUNG_EXYNOS4_IS
 
 config VIDEO_EXYNOS4_IS_COMMON
-       tristate
+	tristate
 
 config VIDEO_S5P_FIMC
 	tristate "S5P/EXYNOS4 FIMC/CAMIF camera interface driver"
diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
index 018e3ec..a96298f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
@@ -6,4 +6,4 @@ config VIDEO_SUN6I_CSI
 	select REGMAP_MMIO
 	select V4L2_FWNODE
 	help
-	   Support for the Allwinner Camera Sensor Interface Controller on V3s.
+	  Support for the Allwinner Camera Sensor Interface Controller on V3s.
diff --git a/drivers/media/platform/xilinx/Kconfig b/drivers/media/platform/xilinx/Kconfig
index 74ec8aa..7143644 100644
--- a/drivers/media/platform/xilinx/Kconfig
+++ b/drivers/media/platform/xilinx/Kconfig
@@ -15,12 +15,12 @@ config VIDEO_XILINX_TPG
 	depends on VIDEO_XILINX
 	select VIDEO_XILINX_VTC
 	---help---
-	   Driver for the Xilinx Video Test Pattern Generator
+	  Driver for the Xilinx Video Test Pattern Generator
 
 config VIDEO_XILINX_VTC
 	tristate "Xilinx Video Timing Controller"
 	depends on VIDEO_XILINX
 	---help---
-	   Driver for the Xilinx Video Timing Controller
+	  Driver for the Xilinx Video Timing Controller
 
 endif #VIDEO_XILINX
diff --git a/drivers/media/radio/si470x/Kconfig b/drivers/media/radio/si470x/Kconfig
index 6dbb158..a221e80 100644
--- a/drivers/media/radio/si470x/Kconfig
+++ b/drivers/media/radio/si470x/Kconfig
@@ -1,6 +1,6 @@
 config RADIO_SI470X
-        tristate "Silicon Labs Si470x FM Radio Receiver support"
-        depends on VIDEO_V4L2
+	tristate "Silicon Labs Si470x FM Radio Receiver support"
+	depends on VIDEO_V4L2
 	---help---
 	  This is a driver for devices with the Silicon Labs SI470x
 	  chip (either via USB or I2C buses).
diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
index 96ce3e5..a6a0b69 100644
--- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -20,10 +20,10 @@ config LIRC
 	bool "LIRC user interface"
 	depends on RC_CORE
 	---help---
-	   Enable this option to enable the Linux Infrared Remote
-	   Control user interface (e.g. /dev/lirc*). This interface
-	   passes raw IR to and from userspace, which is needed for
-	   IR transmitting (aka "blasting") and for the lirc daemon.
+	  Enable this option to enable the Linux Infrared Remote
+	  Control user interface (e.g. /dev/lirc*). This interface
+	  passes raw IR to and from userspace, which is needed for
+	  IR transmitting (aka "blasting") and for the lirc daemon.
 
 config BPF_LIRC_MODE2
 	bool "Support for eBPF programs attached to lirc devices"
@@ -31,12 +31,12 @@ config BPF_LIRC_MODE2
 	depends on RC_CORE=y
 	depends on LIRC
 	help
-	   Allow attaching eBPF programs to a lirc device using the bpf(2)
-	   syscall command BPF_PROG_ATTACH. This is supported for raw IR
-	   receivers.
+	  Allow attaching eBPF programs to a lirc device using the bpf(2)
+	  syscall command BPF_PROG_ATTACH. This is supported for raw IR
+	  receivers.
 
-	   These eBPF programs can be used to decode IR into scancodes, for
-	   IR protocols not supported by the kernel decoders.
+	  These eBPF programs can be used to decode IR into scancodes, for
+	  IR protocols not supported by the kernel decoders.
 
 menuconfig RC_DECODERS
 	bool "Remote controller decoders"
@@ -47,91 +47,82 @@ config IR_NEC_DECODER
 	tristate "Enable IR raw decoder for the NEC protocol"
 	depends on RC_CORE
 	select BITREVERSE
-
 	---help---
-	   Enable this option if you have IR with NEC protocol, and
-	   if the IR is decoded in software
+	  Enable this option if you have IR with NEC protocol, and
+	  if the IR is decoded in software
 
 config IR_RC5_DECODER
 	tristate "Enable IR raw decoder for the RC-5 protocol"
 	depends on RC_CORE
 	select BITREVERSE
-
 	---help---
-	   Enable this option if you have IR with RC-5 protocol, and
-	   if the IR is decoded in software
+	  Enable this option if you have IR with RC-5 protocol, and
+	  if the IR is decoded in software
 
 config IR_RC6_DECODER
 	tristate "Enable IR raw decoder for the RC6 protocol"
 	depends on RC_CORE
 	select BITREVERSE
-
 	---help---
-	   Enable this option if you have an infrared remote control which
-	   uses the RC6 protocol, and you need software decoding support.
+	  Enable this option if you have an infrared remote control which
+	  uses the RC6 protocol, and you need software decoding support.
 
 config IR_JVC_DECODER
 	tristate "Enable IR raw decoder for the JVC protocol"
 	depends on RC_CORE
 	select BITREVERSE
-
 	---help---
-	   Enable this option if you have an infrared remote control which
-	   uses the JVC protocol, and you need software decoding support.
+	  Enable this option if you have an infrared remote control which
+	  uses the JVC protocol, and you need software decoding support.
 
 config IR_SONY_DECODER
 	tristate "Enable IR raw decoder for the Sony protocol"
 	depends on RC_CORE
 	select BITREVERSE
-
 	---help---
-	   Enable this option if you have an infrared remote control which
-	   uses the Sony protocol, and you need software decoding support.
+	  Enable this option if you have an infrared remote control which
+	  uses the Sony protocol, and you need software decoding support.
 
 config IR_SANYO_DECODER
 	tristate "Enable IR raw decoder for the Sanyo protocol"
 	depends on RC_CORE
-
 	---help---
-	   Enable this option if you have an infrared remote control which
-	   uses the Sanyo protocol (Sanyo, Aiwa, Chinon remotes),
-	   and you need software decoding support.
+	  Enable this option if you have an infrared remote control which
+	  uses the Sanyo protocol (Sanyo, Aiwa, Chinon remotes),
+	  and you need software decoding support.
 
 config IR_SHARP_DECODER
 	tristate "Enable IR raw decoder for the Sharp protocol"
 	depends on RC_CORE
-
 	---help---
-	   Enable this option if you have an infrared remote control which
-	   uses the Sharp protocol (Sharp, Denon), and you need software
-	   decoding support.
+	  Enable this option if you have an infrared remote control which
+	  uses the Sharp protocol (Sharp, Denon), and you need software
+	  decoding support.
 
 config IR_MCE_KBD_DECODER
 	tristate "Enable IR raw decoder for the MCE keyboard/mouse protocol"
 	depends on RC_CORE
 	select BITREVERSE
-
 	---help---
-	   Enable this option if you have a Microsoft Remote Keyboard for
-	   Windows Media Center Edition, which you would like to use with
-	   a raw IR receiver in your system.
+	  Enable this option if you have a Microsoft Remote Keyboard for
+	  Windows Media Center Edition, which you would like to use with
+	  a raw IR receiver in your system.
 
 config IR_XMP_DECODER
 	tristate "Enable IR raw decoder for the XMP protocol"
 	depends on RC_CORE
 	select BITREVERSE
-
 	---help---
-	   Enable this option if you have IR with XMP protocol, and
-	   if the IR is decoded in software
+	  Enable this option if you have IR with XMP protocol, and
+	  if the IR is decoded in software
 
 config IR_IMON_DECODER
 	tristate "Enable IR raw decoder for the iMON protocol"
 	depends on RC_CORE
 	---help---
-	   Enable this option if you have iMON PAD or Antec Veris infrared
-	   remote control and you would like to use it with a raw IR
-	   receiver, or if you wish to use an encoder to transmit this IR.
+	  Enable this option if you have iMON PAD or Antec Veris infrared
+	  remote control and you would like to use it with a raw IR
+	  receiver, or if you wish to use an encoder to transmit this IR.
 
 config IR_RCMM_DECODER
 	tristate "Enable IR raw decoder for the RC-MM protocol"
@@ -160,43 +151,43 @@ config RC_ATI_REMOTE
 	depends on RC_CORE
 	select USB
 	help
-	   Say Y here if you want to use an X10 based USB remote control.
-	   These are RF remotes with USB receivers.
+	  Say Y here if you want to use an X10 based USB remote control.
+	  These are RF remotes with USB receivers.
 
-	   Such devices include the ATI remote that comes with many of ATI's
-	   All-In-Wonder video cards, the X10 "Lola" remote, NVIDIA RF remote,
-	   Medion RF remote, and SnapStream FireFly remote.
+	  Such devices include the ATI remote that comes with many of ATI's
+	  All-In-Wonder video cards, the X10 "Lola" remote, NVIDIA RF remote,
+	  Medion RF remote, and SnapStream FireFly remote.
 
-	   This driver provides mouse pointer, left and right mouse buttons,
-	   and maps all the other remote buttons to keypress events.
+	  This driver provides mouse pointer, left and right mouse buttons,
+	  and maps all the other remote buttons to keypress events.
 
-	   To compile this driver as a module, choose M here: the module will be
-	   called ati_remote.
+	  To compile this driver as a module, choose M here: the module will be
+	  called ati_remote.
 
 config IR_ENE
 	tristate "ENE eHome Receiver/Transceiver (pnp id: ENE0100/ENE02xxx)"
 	depends on PNP || COMPILE_TEST
 	depends on RC_CORE
 	---help---
-	   Say Y here to enable support for integrated infrared receiver
-	   /transceiver made by ENE.
+	  Say Y here to enable support for integrated infrared receiver
+	  /transceiver made by ENE.
 
-	   You can see if you have it by looking at lspnp output.
-	   Output should include ENE0100 ENE0200 or something similar.
+	  You can see if you have it by looking at lspnp output.
+	  Output should include ENE0100 ENE0200 or something similar.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called ene_ir.
+	  To compile this driver as a module, choose M here: the
+	  module will be called ene_ir.
 
 config IR_HIX5HD2
 	tristate "Hisilicon hix5hd2 IR remote control"
 	depends on RC_CORE
 	depends on OF || COMPILE_TEST
 	help
-	   Say Y here if you want to use hisilicon hix5hd2 remote control.
-	   To compile this driver as a module, choose M here: the module will be
-	   called ir-hix5hd2.
+	  Say Y here if you want to use hisilicon hix5hd2 remote control.
+	  To compile this driver as a module, choose M here: the module will be
+	  called ir-hix5hd2.
 
-	   If you're not sure, select N here
+	  If you're not sure, select N here
 
 config IR_IMON
 	tristate "SoundGraph iMON Receiver and Display"
@@ -204,11 +195,11 @@ config IR_IMON
 	depends on RC_CORE
 	select USB
 	---help---
-	   Say Y here if you want to use a SoundGraph iMON (aka Antec Veris)
-	   IR Receiver and/or LCD/VFD/VGA display.
+	  Say Y here if you want to use a SoundGraph iMON (aka Antec Veris)
+	  IR Receiver and/or LCD/VFD/VGA display.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called imon.
+	  To compile this driver as a module, choose M here: the
+	  module will be called imon.
 
 config IR_IMON_RAW
 	tristate "SoundGraph iMON Receiver (early raw IR models)"
@@ -216,11 +207,11 @@ config IR_IMON_RAW
 	depends on RC_CORE
 	select USB
 	---help---
-	   Say Y here if you want to use a SoundGraph iMON IR Receiver,
-	   early raw models.
+	  Say Y here if you want to use a SoundGraph iMON IR Receiver,
+	  early raw models.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called imon_raw.
+	  To compile this driver as a module, choose M here: the
+	  module will be called imon_raw.
 
 config IR_MCEUSB
 	tristate "Windows Media Center Ed. eHome Infrared Transceiver"
@@ -228,71 +219,71 @@ config IR_MCEUSB
 	depends on RC_CORE
 	select USB
 	---help---
-	   Say Y here if you want to use a Windows Media Center Edition
-	   eHome Infrared Transceiver.
+	  Say Y here if you want to use a Windows Media Center Edition
+	  eHome Infrared Transceiver.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called mceusb.
+	  To compile this driver as a module, choose M here: the
+	  module will be called mceusb.
 
 config IR_ITE_CIR
 	tristate "ITE Tech Inc. IT8712/IT8512 Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
 	depends on RC_CORE
 	---help---
-	   Say Y here to enable support for integrated infrared receivers
-	   /transceivers made by ITE Tech Inc. These are found in
-	   several ASUS devices, like the ASUS Digimatrix or the ASUS
-	   EEEBox 1501U.
+	  Say Y here to enable support for integrated infrared receivers
+	  /transceivers made by ITE Tech Inc. These are found in
+	  several ASUS devices, like the ASUS Digimatrix or the ASUS
+	  EEEBox 1501U.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called ite-cir.
+	  To compile this driver as a module, choose M here: the
+	  module will be called ite-cir.
 
 config IR_FINTEK
 	tristate "Fintek Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
 	depends on RC_CORE
 	---help---
-	   Say Y here to enable support for integrated infrared receiver
-	   /transceiver made by Fintek. This chip is found on assorted
-	   Jetway motherboards (and of course, possibly others).
+	  Say Y here to enable support for integrated infrared receiver
+	  /transceiver made by Fintek. This chip is found on assorted
+	  Jetway motherboards (and of course, possibly others).
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called fintek-cir.
+	  To compile this driver as a module, choose M here: the
+	  module will be called fintek-cir.
 
 config IR_MESON
 	tristate "Amlogic Meson IR remote receiver"
 	depends on RC_CORE
 	depends on ARCH_MESON || COMPILE_TEST
 	---help---
-	   Say Y if you want to use the IR remote receiver available
-	   on Amlogic Meson SoCs.
+	  Say Y if you want to use the IR remote receiver available
+	  on Amlogic Meson SoCs.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called meson-ir.
+	  To compile this driver as a module, choose M here: the
+	  module will be called meson-ir.
 
 config IR_MTK
 	tristate "Mediatek IR remote receiver"
 	depends on RC_CORE
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	---help---
-	   Say Y if you want to use the IR remote receiver available
-	   on Mediatek SoCs.
+	  Say Y if you want to use the IR remote receiver available
+	  on Mediatek SoCs.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called mtk-cir.
+	  To compile this driver as a module, choose M here: the
+	  module will be called mtk-cir.
 
 config IR_NUVOTON
 	tristate "Nuvoton w836x7hg Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
 	depends on RC_CORE
 	---help---
-	   Say Y here to enable support for integrated infrared receiver
-	   /transceiver made by Nuvoton (formerly Winbond). This chip is
-	   found in the ASRock ION 330HT, as well as assorted Intel
-	   DP55-series motherboards (and of course, possibly others).
+	  Say Y here to enable support for integrated infrared receiver
+	  /transceiver made by Nuvoton (formerly Winbond). This chip is
+	  found in the ASRock ION 330HT, as well as assorted Intel
+	  DP55-series motherboards (and of course, possibly others).
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called nuvoton-cir.
+	  To compile this driver as a module, choose M here: the
+	  module will be called nuvoton-cir.
 
 config IR_REDRAT3
 	tristate "RedRat3 IR Transceiver"
@@ -302,10 +293,10 @@ config IR_REDRAT3
 	select LEDS_CLASS
 	select USB
 	---help---
-	   Say Y here if you want to use a RedRat3 Infrared Transceiver.
+	  Say Y here if you want to use a RedRat3 Infrared Transceiver.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called redrat3.
+	  To compile this driver as a module, choose M here: the
+	  module will be called redrat3.
 
 config IR_SPI
 	tristate "SPI connected IR LED"
@@ -323,11 +314,11 @@ config IR_STREAMZAP
 	depends on RC_CORE
 	select USB
 	---help---
-	   Say Y here if you want to use a Streamzap PC Remote
-	   Infrared Receiver.
+	  Say Y here if you want to use a Streamzap PC Remote
+	  Infrared Receiver.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called streamzap.
+	  To compile this driver as a module, choose M here: the
+	  module will be called streamzap.
 
 config IR_WINBOND_CIR
 	tristate "Winbond IR remote control"
@@ -337,13 +328,13 @@ config IR_WINBOND_CIR
 	select LEDS_CLASS
 	select BITREVERSE
 	---help---
-	   Say Y here if you want to use the IR remote functionality found
-	   in some Winbond SuperI/O chips. Currently only the WPCD376I
-	   chip is supported (included in some Intel Media series
-	   motherboards).
+	  Say Y here if you want to use the IR remote functionality found
+	  in some Winbond SuperI/O chips. Currently only the WPCD376I
+	  chip is supported (included in some Intel Media series
+	  motherboards).
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called winbond_cir.
+	  To compile this driver as a module, choose M here: the module will
+	  be called winbond_cir.
 
 config IR_IGORPLUGUSB
 	tristate "IgorPlug-USB IR Receiver"
@@ -351,14 +342,14 @@ config IR_IGORPLUGUSB
 	depends on RC_CORE
 	select USB
 	---help---
-	   Say Y here if you want to use the IgorPlug-USB IR Receiver by
-	   Igor Cesko. This device is included on the Fit-PC2.
+	  Say Y here if you want to use the IgorPlug-USB IR Receiver by
+	  Igor Cesko. This device is included on the Fit-PC2.
 
-	   Note that this device can only record bursts of 36 IR pulses and
-	   spaces, which is not enough for the NEC, Sanyo and RC-6 protocol.
+	  Note that this device can only record bursts of 36 IR pulses and
+	  spaces, which is not enough for the NEC, Sanyo and RC-6 protocol.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called igorplugusb.
+	  To compile this driver as a module, choose M here: the module will
+	  be called igorplugusb.
 
 config IR_IGUANA
 	tristate "IguanaWorks USB IR Transceiver"
@@ -366,15 +357,15 @@ config IR_IGUANA
 	depends on RC_CORE
 	select USB
 	---help---
-	   Say Y here if you want to use the IguanaWorks USB IR Transceiver.
-	   Both infrared receive and send are supported. If you want to
-	   change the ID or the pin config, use the user space driver from
-	   IguanaWorks.
+	  Say Y here if you want to use the IguanaWorks USB IR Transceiver.
+	  Both infrared receive and send are supported. If you want to
+	  change the ID or the pin config, use the user space driver from
+	  IguanaWorks.
 
-	   Only firmware 0x0205 and later is supported.
+	  Only firmware 0x0205 and later is supported.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called iguanair.
+	  To compile this driver as a module, choose M here: the module will
+	  be called iguanair.
 
 config IR_TTUSBIR
 	tristate "TechnoTrend USB IR Receiver"
@@ -384,21 +375,21 @@ config IR_TTUSBIR
 	select NEW_LEDS
 	select LEDS_CLASS
 	---help---
-	   Say Y here if you want to use the TechnoTrend USB IR Receiver. The
-	   driver can control the led.
+	  Say Y here if you want to use the TechnoTrend USB IR Receiver. The
+	  driver can control the led.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called ttusbir.
+	  To compile this driver as a module, choose M here: the module will
+	  be called ttusbir.
 
 config IR_RX51
 	tristate "Nokia N900 IR transmitter diode"
 	depends on (OMAP_DM_TIMER && PWM_OMAP_DMTIMER && ARCH_OMAP2PLUS || COMPILE_TEST) && RC_CORE
 	---help---
-	   Say Y or M here if you want to enable support for the IR
-	   transmitter diode built in the Nokia N900 (RX51) device.
+	  Say Y or M here if you want to enable support for the IR
+	  transmitter diode built in the Nokia N900 (RX51) device.
 
-	   The driver uses omap DM timers for generating the carrier
-	   wave and pulses.
+	  The driver uses omap DM timers for generating the carrier
+	  wave and pulses.
 
 source "drivers/media/rc/img-ir/Kconfig"
 
@@ -406,24 +397,24 @@ config RC_LOOPBACK
 	tristate "Remote Control Loopback Driver"
 	depends on RC_CORE
 	---help---
-	   Say Y here if you want support for the remote control loopback
-	   driver which allows TX data to be sent back as RX data.
-	   This is mostly useful for debugging purposes.
+	  Say Y here if you want support for the remote control loopback
+	  driver which allows TX data to be sent back as RX data.
+	  This is mostly useful for debugging purposes.
 
-	   If you're not sure, select N here.
+	  If you're not sure, select N here.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called rc_loopback.
+	  To compile this driver as a module, choose M here: the module will
+	  be called rc_loopback.
 
 config IR_GPIO_CIR
 	tristate "GPIO IR remote control"
 	depends on RC_CORE
 	depends on (OF && GPIOLIB) || COMPILE_TEST
 	---help---
-	   Say Y if you want to use GPIO based IR Receiver.
+	  Say Y if you want to use GPIO based IR Receiver.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called gpio-ir-recv.
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio-ir-recv.
 
 config IR_GPIO_TX
 	tristate "GPIO IR Bit Banging Transmitter"
@@ -431,11 +422,11 @@ config IR_GPIO_TX
 	depends on LIRC
 	depends on (OF && GPIOLIB) || COMPILE_TEST
 	---help---
-	   Say Y if you want to a GPIO based IR transmitter. This is a
-	   bit banging driver.
+	  Say Y if you want to a GPIO based IR transmitter. This is a
+	  bit banging driver.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called gpio-ir-tx.
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio-ir-tx.
 
 config IR_PWM_TX
 	tristate "PWM IR transmitter"
@@ -444,67 +435,67 @@ config IR_PWM_TX
 	depends on PWM
 	depends on OF || COMPILE_TEST
 	---help---
-	   Say Y if you want to use a PWM based IR transmitter. This is
-	   more power efficient than the bit banging gpio driver.
+	  Say Y if you want to use a PWM based IR transmitter. This is
+	  more power efficient than the bit banging gpio driver.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called pwm-ir-tx.
+	  To compile this driver as a module, choose M here: the module will
+	  be called pwm-ir-tx.
 
 config RC_ST
 	tristate "ST remote control receiver"
 	depends on RC_CORE
 	depends on ARCH_STI || COMPILE_TEST
 	---help---
-	   Say Y here if you want support for ST remote control driver
-	   which allows both IR and UHF RX.
-	   The driver passes raw pulse and space information to the LIRC decoder.
+	  Say Y here if you want support for ST remote control driver
+	  which allows both IR and UHF RX.
+	  The driver passes raw pulse and space information to the LIRC decoder.
 
-	   If you're not sure, select N here.
+	  If you're not sure, select N here.
 
 config IR_SUNXI
 	tristate "SUNXI IR remote control"
 	depends on RC_CORE
 	depends on ARCH_SUNXI || COMPILE_TEST
 	---help---
-	   Say Y if you want to use sunXi internal IR Controller
+	  Say Y if you want to use sunXi internal IR Controller
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called sunxi-ir.
+	  To compile this driver as a module, choose M here: the module will
+	  be called sunxi-ir.
 
 config IR_SERIAL
 	tristate "Homebrew Serial Port Receiver"
 	depends on RC_CORE
 	---help---
-	   Say Y if you want to use Homebrew Serial Port Receivers and
-	   Transceivers.
+	  Say Y if you want to use Homebrew Serial Port Receivers and
+	  Transceivers.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called serial-ir.
+	  To compile this driver as a module, choose M here: the module will
+	  be called serial-ir.
 
 config IR_SERIAL_TRANSMITTER
 	bool "Serial Port Transmitter"
 	depends on IR_SERIAL
 	---help---
-	   Serial Port Transmitter support
+	  Serial Port Transmitter support
 
 config IR_SIR
 	tristate "Built-in SIR IrDA port"
 	depends on RC_CORE
 	---help---
-	   Say Y if you want to use a IrDA SIR port Transceivers.
+	  Say Y if you want to use a IrDA SIR port Transceivers.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called sir-ir.
+	  To compile this driver as a module, choose M here: the module will
+	  be called sir-ir.
 
 config IR_TANGO
 	tristate "Sigma Designs SMP86xx IR decoder"
 	depends on RC_CORE
 	depends on ARCH_TANGO || COMPILE_TEST
 	---help---
-	   Adds support for the HW IR decoder embedded on Sigma Designs
-	   Tango-based systems (SMP86xx, SMP87xx).
-	   The HW decoder supports NEC, RC-5, RC-6 IR protocols.
-	   When compiled as a module, look for tango-ir.
+	  Adds support for the HW IR decoder embedded on Sigma Designs
+	  Tango-based systems (SMP86xx, SMP87xx).
+	  The HW decoder supports NEC, RC-5, RC-6 IR protocols.
+	  When compiled as a module, look for tango-ir.
 
 config RC_XBOX_DVD
 	tristate "Xbox DVD Movie Playback Kit"
@@ -512,22 +503,22 @@ config RC_XBOX_DVD
 	depends on USB_ARCH_HAS_HCD
 	select USB
 	help
-	   Say Y here if you want to use the Xbox DVD Movie Playback Kit.
-	   These are IR remotes with USB receivers for the Original Xbox (2001).
+	  Say Y here if you want to use the Xbox DVD Movie Playback Kit.
+	  These are IR remotes with USB receivers for the Original Xbox (2001).
 
-	   To compile this driver as a module, choose M here: the module will be
-	   called xbox_remote.
+	  To compile this driver as a module, choose M here: the module will be
+	  called xbox_remote.
 
 config IR_ZX
 	tristate "ZTE ZX IR remote control"
 	depends on RC_CORE
 	depends on ARCH_ZX || COMPILE_TEST
 	---help---
-	   Say Y if you want to use the IR remote control available
-	   on ZTE ZX family SoCs.
+	  Say Y if you want to use the IR remote control available
+	  on ZTE ZX family SoCs.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called zx-irdec.
+	  To compile this driver as a module, choose M here: the
+	  module will be called zx-irdec.
 
 endif #RC_DEVICES
 
diff --git a/drivers/media/rc/img-ir/Kconfig b/drivers/media/rc/img-ir/Kconfig
index d2c6617..102b089 100644
--- a/drivers/media/rc/img-ir/Kconfig
+++ b/drivers/media/rc/img-ir/Kconfig
@@ -4,74 +4,74 @@ config IR_IMG
 	depends on MIPS || COMPILE_TEST
 	select IR_IMG_HW if !IR_IMG_RAW
 	help
-	   Say Y or M here if you want to use the ImgTec infrared decoder
-	   functionality found in SoCs such as TZ1090.
+	  Say Y or M here if you want to use the ImgTec infrared decoder
+	  functionality found in SoCs such as TZ1090.
 
 config IR_IMG_RAW
 	bool "Raw decoder"
 	depends on IR_IMG
 	help
-	   Say Y here to enable the raw mode driver which passes raw IR signal
-	   changes to the IR raw decoders for software decoding. This is much
-	   less reliable (due to lack of timestamps) and consumes more
-	   processing power than using hardware decode, but can be useful for
-	   testing, debug, and to make more protocols available.
+	  Say Y here to enable the raw mode driver which passes raw IR signal
+	  changes to the IR raw decoders for software decoding. This is much
+	  less reliable (due to lack of timestamps) and consumes more
+	  processing power than using hardware decode, but can be useful for
+	  testing, debug, and to make more protocols available.
 
 config IR_IMG_HW
 	bool "Hardware decoder"
 	depends on IR_IMG
 	help
-	   Say Y here to enable the hardware decode driver which decodes the IR
-	   signals in hardware. This is more reliable, consumes less processing
-	   power since only a single interrupt is received for each scancode,
-	   and allows an IR scancode to be used as a wake event.
+	  Say Y here to enable the hardware decode driver which decodes the IR
+	  signals in hardware. This is more reliable, consumes less processing
+	  power since only a single interrupt is received for each scancode,
+	  and allows an IR scancode to be used as a wake event.
 
 config IR_IMG_NEC
 	bool "NEC protocol support"
 	depends on IR_IMG_HW
 	help
-	   Say Y here to enable support for the NEC, extended NEC, and 32-bit
-	   NEC protocols in the ImgTec infrared decoder block.
+	  Say Y here to enable support for the NEC, extended NEC, and 32-bit
+	  NEC protocols in the ImgTec infrared decoder block.
 
 config IR_IMG_JVC
 	bool "JVC protocol support"
 	depends on IR_IMG_HW
 	help
-	   Say Y here to enable support for the JVC protocol in the ImgTec
-	   infrared decoder block.
+	  Say Y here to enable support for the JVC protocol in the ImgTec
+	  infrared decoder block.
 
 config IR_IMG_SONY
 	bool "Sony protocol support"
 	depends on IR_IMG_HW
 	help
-	   Say Y here to enable support for the Sony protocol in the ImgTec
-	   infrared decoder block.
+	  Say Y here to enable support for the Sony protocol in the ImgTec
+	  infrared decoder block.
 
 config IR_IMG_SHARP
 	bool "Sharp protocol support"
 	depends on IR_IMG_HW
 	help
-	   Say Y here to enable support for the Sharp protocol in the ImgTec
-	   infrared decoder block.
+	  Say Y here to enable support for the Sharp protocol in the ImgTec
+	  infrared decoder block.
 
 config IR_IMG_SANYO
 	bool "Sanyo protocol support"
 	depends on IR_IMG_HW
 	help
-	   Say Y here to enable support for the Sanyo protocol (used by Sanyo,
-	   Aiwa, Chinon remotes) in the ImgTec infrared decoder block.
+	  Say Y here to enable support for the Sanyo protocol (used by Sanyo,
+	  Aiwa, Chinon remotes) in the ImgTec infrared decoder block.
 
 config IR_IMG_RC5
 	bool "Philips RC5 protocol support"
 	depends on IR_IMG_HW
 	help
-	   Say Y here to enable support for the RC5 protocol in the ImgTec
-	   infrared decoder block.
+	  Say Y here to enable support for the RC5 protocol in the ImgTec
+	  infrared decoder block.
 
 config IR_IMG_RC6
 	bool "Philips RC6 protocol support"
 	depends on IR_IMG_HW
 	help
-	   Say Y here to enable support for the RC6 protocol in the ImgTec
-	   infrared decoder block.
-	   Note: This version only supports mode 0.
+	  Say Y here to enable support for the RC6 protocol in the ImgTec
+	  infrared decoder block.
+	  Note: This version only supports mode 0.
-- 
1.9.1

