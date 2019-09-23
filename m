Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EEFC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F5920882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569253806;
	bh=FFzbPPyzstoUTQIh5AyphTjoKpbu5dT+XJPhAdHJBEY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0w790mmaNVYaGZhNOWum4oYHycrqQhjzVJgYPkQ74Mny7/Bc/G9/vBbwhy/ckL889
	 RN8BSIpQ9impPLkFhSCIxE/kX5GFnArsyGXpHJ3aygQXvtsmG4Bb6b0GDgKRsFlVyI
	 f/MHHbh4jGT9OaLKEUSQFMHYd1IOZWXIbC5h720w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbfIWPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbfIWPuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:50:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38AB4205F4;
        Mon, 23 Sep 2019 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569253804;
        bh=FFzbPPyzstoUTQIh5AyphTjoKpbu5dT+XJPhAdHJBEY=;
        h=From:To:Cc:Subject:Date:From;
        b=WBIhvdLMxJGUloK7m32dwhWXk2Pzythdg85Y3TSxn4AHNwXEWcHxcw+rY7vVpAs+Q
         4dhoLEiE6ZtMnGhsyFxIqOBxx6+90XwCjhNUtY1//+iHfp7u1ky5Fhe0MJZ5gEjI9k
         6r7Wug9n5vYaVA7XEoPXnv+IcQKMLQJqAU7x4fjc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH trivial] usb: Fix Kconfig indentation
Date:   Mon, 23 Sep 2019 17:49:56 +0200
Message-Id: <20190923154956.6868-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
    $ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/dwc3/Kconfig           |  4 +-
 drivers/usb/gadget/legacy/Kconfig  | 20 ++++-----
 drivers/usb/gadget/udc/Kconfig     |  2 +-
 drivers/usb/host/Kconfig           | 68 +++++++++++++++---------------
 drivers/usb/misc/Kconfig           |  8 ++--
 drivers/usb/misc/sisusbvga/Kconfig |  2 +-
 drivers/usb/serial/Kconfig         | 44 +++++++++----------
 7 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 89abc6078703..cc431376fcd0 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -103,7 +103,7 @@ config USB_DWC3_MESON_G12A
        default USB_DWC3
        select USB_ROLE_SWITCH
        help
-         Support USB2/3 functionality in Amlogic G12A platforms.
+	 Support USB2/3 functionality in Amlogic G12A platforms.
 	 Say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_OF_SIMPLE
@@ -111,7 +111,7 @@ config USB_DWC3_OF_SIMPLE
        depends on OF && COMMON_CLK
        default USB_DWC3
        help
-         Support USB2/3 functionality in simple SoC integrations.
+	 Support USB2/3 functionality in simple SoC integrations.
 	 Currently supports Xilinx and Qualcomm DWC USB3 IP.
 	 Say 'Y' or 'M' if you have one such device.
 
diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legacy/Kconfig
index 69ff7f8c86f5..38eaa9417b38 100644
--- a/drivers/usb/gadget/legacy/Kconfig
+++ b/drivers/usb/gadget/legacy/Kconfig
@@ -154,16 +154,16 @@ config USB_ETH_EEM
 	select USB_LIBCOMPOSITE
 	select USB_F_EEM
        help
-         CDC EEM is a newer USB standard that is somewhat simpler than CDC ECM
-         and therefore can be supported by more hardware.  Technically ECM and
-         EEM are designed for different applications.  The ECM model extends
-         the network interface to the target (e.g. a USB cable modem), and the
-         EEM model is for mobile devices to communicate with hosts using
-         ethernet over USB.  For Linux gadgets, however, the interface with
-         the host is the same (a usbX device), so the differences are minimal.
-
-         If you say "y" here, the Ethernet gadget driver will use the EEM
-         protocol rather than ECM.  If unsure, say "n".
+	 CDC EEM is a newer USB standard that is somewhat simpler than CDC ECM
+	 and therefore can be supported by more hardware.  Technically ECM and
+	 EEM are designed for different applications.  The ECM model extends
+	 the network interface to the target (e.g. a USB cable modem), and the
+	 EEM model is for mobile devices to communicate with hosts using
+	 ethernet over USB.  For Linux gadgets, however, the interface with
+	 the host is the same (a usbX device), so the differences are minimal.
+
+	 If you say "y" here, the Ethernet gadget driver will use the EEM
+	 protocol rather than ECM.  If unsure, say "n".
 
 config USB_G_NCM
 	tristate "Network Control Model (NCM) support"
diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index d7e611645533..485c92ef888a 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -123,7 +123,7 @@ config USB_GR_UDC
        tristate "Aeroflex Gaisler GRUSBDC USB Peripheral Controller Driver"
        depends on HAS_DMA
        help
-          Select this to support Aeroflex Gaisler GRUSBDC cores from the GRLIB
+	  Select this to support Aeroflex Gaisler GRUSBDC cores from the GRLIB
 	  VHDL IP core library.
 
 config USB_OMAP
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 79b2e79dddd0..d6164ede63d3 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -220,12 +220,12 @@ config USB_EHCI_HCD_ORION
 	  Marvell PXA/MMP USB controller" for those.
 
 config USB_EHCI_HCD_SPEAR
-        tristate "Support for ST SPEAr on-chip EHCI USB controller"
-        depends on USB_EHCI_HCD && PLAT_SPEAR
-        default y
-        ---help---
-          Enables support for the on-chip EHCI controller on
-          ST SPEAr chips.
+	tristate "Support for ST SPEAr on-chip EHCI USB controller"
+	depends on USB_EHCI_HCD && PLAT_SPEAR
+	default y
+	---help---
+	  Enables support for the on-chip EHCI controller on
+	  ST SPEAr chips.
 
 config USB_EHCI_HCD_STI
 	tristate "Support for ST STiHxxx on-chip EHCI USB controller"
@@ -237,12 +237,12 @@ config USB_EHCI_HCD_STI
 	  STMicroelectronics consumer electronics SoC's.
 
 config USB_EHCI_HCD_AT91
-        tristate  "Support for Atmel on-chip EHCI USB controller"
-        depends on USB_EHCI_HCD && ARCH_AT91
-        default y
-        ---help---
-          Enables support for the on-chip EHCI controller on
-          Atmel chips.
+	tristate  "Support for Atmel on-chip EHCI USB controller"
+	depends on USB_EHCI_HCD && ARCH_AT91
+	default y
+	---help---
+	  Enables support for the on-chip EHCI controller on
+	  Atmel chips.
 
 config USB_EHCI_TEGRA
        tristate "NVIDIA Tegra HCD support"
@@ -250,8 +250,8 @@ config USB_EHCI_TEGRA
        select USB_EHCI_ROOT_HUB_TT
        select USB_TEGRA_PHY
        help
-         This driver enables support for the internal USB Host Controllers
-         found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
+	 This driver enables support for the internal USB Host Controllers
+	 found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
 
 config USB_EHCI_HCD_PPC_OF
 	bool "EHCI support for PPC USB controller on OF platform bus"
@@ -409,12 +409,12 @@ config USB_OHCI_HCD_OMAP1
 	  Enables support for the OHCI controller on OMAP1/2 chips.
 
 config USB_OHCI_HCD_SPEAR
-        tristate "Support for ST SPEAr on-chip OHCI USB controller"
-        depends on USB_OHCI_HCD && PLAT_SPEAR
-        default y
-        ---help---
-          Enables support for the on-chip OHCI controller on
-          ST SPEAr chips.
+	tristate "Support for ST SPEAr on-chip OHCI USB controller"
+	depends on USB_OHCI_HCD && PLAT_SPEAR
+	default y
+	---help---
+	  Enables support for the on-chip OHCI controller on
+	  ST SPEAr chips.
 
 config USB_OHCI_HCD_STI
 	tristate "Support for ST STiHxxx on-chip OHCI USB controller"
@@ -426,12 +426,12 @@ config USB_OHCI_HCD_STI
 	  STMicroelectronics consumer electronics SoC's.
 
 config USB_OHCI_HCD_S3C2410
-        tristate "OHCI support for Samsung S3C24xx/S3C64xx SoC series"
-        depends on USB_OHCI_HCD && (ARCH_S3C24XX || ARCH_S3C64XX)
-        default y
-        ---help---
-          Enables support for the on-chip OHCI controller on
-          S3C24xx/S3C64xx chips.
+	tristate "OHCI support for Samsung S3C24xx/S3C64xx SoC series"
+	depends on USB_OHCI_HCD && (ARCH_S3C24XX || ARCH_S3C64XX)
+	default y
+	---help---
+	  Enables support for the on-chip OHCI controller on
+	  S3C24xx/S3C64xx chips.
 
 config USB_OHCI_HCD_LPC32XX
 	tristate "Support for LPC on-chip OHCI USB controller"
@@ -440,8 +440,8 @@ config USB_OHCI_HCD_LPC32XX
 	depends on USB_ISP1301
 	default y
 	---help---
-          Enables support for the on-chip OHCI controller on
-          NXP chips.
+	  Enables support for the on-chip OHCI controller on
+	  NXP chips.
 
 config USB_OHCI_HCD_PXA27X
 	tristate "Support for PXA27X/PXA3XX on-chip OHCI USB controller"
@@ -456,8 +456,8 @@ config USB_OHCI_HCD_AT91
 	depends on USB_OHCI_HCD && ARCH_AT91 && OF
 	default y
 	---help---
-          Enables support for the on-chip OHCI controller on
-          Atmel chips.
+	  Enables support for the on-chip OHCI controller on
+	  Atmel chips.
 
 config USB_OHCI_HCD_OMAP3
 	tristate "OHCI support for OMAP3 and later chips"
@@ -716,11 +716,11 @@ config USB_IMX21_HCD
        tristate "i.MX21 HCD support"
        depends on ARM && ARCH_MXC
        help
-         This driver enables support for the on-chip USB host in the
-         i.MX21 processor.
+	 This driver enables support for the on-chip USB host in the
+	 i.MX21 processor.
 
-         To compile this driver as a module, choose M here: the
-         module will be called "imx21-hcd".
+	 To compile this driver as a module, choose M here: the
+	 module will be called "imx21-hcd".
 
 config USB_HCD_BCMA
 	tristate "BCMA usb host driver"
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index bdae62b2ffe0..664d27bb6086 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -191,8 +191,8 @@ config USB_TEST
 	  including sample test device firmware and "how to use it".
 
 config USB_EHSET_TEST_FIXTURE
-        tristate "USB EHSET Test Fixture driver"
-        help
+	tristate "USB EHSET Test Fixture driver"
+	help
 	  Say Y here if you want to support the special test fixture device
 	  used for the USB-IF Embedded Host High-Speed Electrical Test procedure.
 
@@ -247,13 +247,13 @@ config USB_HSIC_USB3503
        depends on I2C
        select REGMAP_I2C
        help
-         This option enables support for SMSC USB3503 HSIC to USB 2.0 Driver.
+	 This option enables support for SMSC USB3503 HSIC to USB 2.0 Driver.
 
 config USB_HSIC_USB4604
        tristate "USB4604 HSIC to USB20 Driver"
        depends on I2C
        help
-         This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
+	 This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
 
 config USB_LINK_LAYER_TEST
 	tristate "USB Link Layer Test driver"
diff --git a/drivers/usb/misc/sisusbvga/Kconfig b/drivers/usb/misc/sisusbvga/Kconfig
index 9b632ab24f03..c16121276a21 100644
--- a/drivers/usb/misc/sisusbvga/Kconfig
+++ b/drivers/usb/misc/sisusbvga/Kconfig
@@ -4,7 +4,7 @@ config USB_SISUSBVGA
 	tristate "USB 2.0 SVGA dongle support (Net2280/SiS315)"
 	depends on (USB_MUSB_HDRC || USB_EHCI_HCD)
 	select FONT_SUPPORT if USB_SISUSBVGA_CON
-        ---help---
+	---help---
 	  Say Y here if you intend to attach a USB2VGA dongle based on a
 	  Net2280 and a SiS315 chip.
 
diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 67279c6bce33..0a8c16a8cda2 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -271,17 +271,17 @@ config USB_SERIAL_F8153X
 config USB_SERIAL_GARMIN
        tristate "USB Garmin GPS driver"
        help
-         Say Y here if you want to connect to your Garmin GPS.
-         Should work with most Garmin GPS devices which have a native USB port.
+	 Say Y here if you want to connect to your Garmin GPS.
+	 Should work with most Garmin GPS devices which have a native USB port.
 
-         See <http://sourceforge.net/projects/garmin-gps> for the latest
-         version of the driver.
+	 See <http://sourceforge.net/projects/garmin-gps> for the latest
+	 version of the driver.
 
-         To compile this driver as a module, choose M here: the
-         module will be called garmin_gps.
+	 To compile this driver as a module, choose M here: the
+	 module will be called garmin_gps.
 
 config USB_SERIAL_IPW
-        tristate "USB IPWireless (3G UMTS TDD) Driver"
+	tristate "USB IPWireless (3G UMTS TDD) Driver"
 	select USB_SERIAL_WWAN
 	help
 	  Say Y here if you want to use a IPWireless USB modem such as
@@ -341,20 +341,20 @@ config USB_SERIAL_KLSI
 	  module will be called kl5kusb105.
 
 config USB_SERIAL_KOBIL_SCT
-        tristate "USB KOBIL chipcard reader"
-        ---help---
-          Say Y here if you want to use one of the following KOBIL USB chipcard
-          readers:
-
-            - USB TWIN
-            - KAAN Standard Plus
-            - KAAN SIM
-            - SecOVID Reader Plus
-            - B1 Professional
-            - KAAN Professional
-
-          Note that you need a current CT-API.
-          To compile this driver as a module, choose M here: the
+	tristate "USB KOBIL chipcard reader"
+	---help---
+	  Say Y here if you want to use one of the following KOBIL USB chipcard
+	  readers:
+
+	    - USB TWIN
+	    - KAAN Standard Plus
+	    - KAAN SIM
+	    - SecOVID Reader Plus
+	    - B1 Professional
+	    - KAAN Professional
+
+	  Note that you need a current CT-API.
+	  To compile this driver as a module, choose M here: the
 	  module will be called kobil_sct.
 
 config USB_SERIAL_MCT_U232
@@ -458,7 +458,7 @@ config USB_SERIAL_OTI6858
 	tristate "USB Ours Technology Inc. OTi-6858 USB To RS232 Bridge Controller"
 	help
 	  Say Y here if you want to use the OTi-6858 single port USB to serial
-          converter device.
+	  converter device.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called oti6858.
-- 
2.17.1

