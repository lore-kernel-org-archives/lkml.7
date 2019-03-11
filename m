Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75919C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ED82084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfCKNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:23:26 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5fUy-1h9PeY3jti-007BkP for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 040/114] drivers: usb: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:52 +0100
Message-Id: <1552310346-7629-41-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:2y+Lt3d2nyYZIAw5gxXF8Rs9apaqOYKUZaOUmzJKpdy56WTkN24
 N1S2x6Z4PBDPrYcl7gCH0c9q1YI9voTF5P87fleZ9wchT/PauSHDfH7xhD1kY3XkaDLVYh7
 IeGZ2iCxa6zAolMbfJHlSHbZYGDtwY0RsFxpPba+HWgeaDtogqHeiCIByAMj3j672vPqOXv
 l8PP45eheknR8NDuAcEOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:woQrAA64DAA=:xsExR5L4rt7z5vAx207xJM
 xEx1Zb20ZW2fN7yAU5e/zTGVJRRJYjG5AK2ZXRLWm+RWe0xVG8CFKTUacQYuFKWj3AJpnPNlq
 mFBDeMHGt2s13uqZEs6dGjM2mIIJooaDcbmC/hSOiuJOp4ZEJoXF4orDPRcxv1+dIpfw0g/3H
 aTMqduTwU1r2x0yDVf5y9cunXx7LAfXeWlG61FPHyCU6wTlx1w+a2phfZIu3WC2d8tAtduTDV
 0/iWxLaNeRc3tpjiMe7RJ+f+RrxzqtZVYsSLpbGguKNs2Gx/CQTqk+AHyztQKdOAW4Re13PIN
 uPFh3Pb9Fip/8AFQJkKRIWnSQmmAUuh/1l43teDA6j21b4fXGt8MYyVpYhzOUqCLKBcj92vOV
 s1nHdA1miGUqnlnSlaR5V8gdrlHPY+qijIzfO+NmdAT4vHqhvQxwXbHsTDmoptGMZ+6jLmxYJ
 wlO5EYz0uStsrYzN8d7OLWDwXf4dLHOGI32KYmLXCPSMYLr5XgExxefpB79zptE2lF3ONZt4x
 jTRONTIi2bOY/jFw51GlAAsi9t9I9o7bKc43s/07xsS7qgn8ALnAPTMkU9C85hacxkaZGfjn+
 lyXn6KqmShbnTRYIlZ3329NqKQmYw0bfCQTHEQmPPcX6lx8ROcRrTp6jRjFQzpcMmy1Mr9Dd2
 xHESHZLoU977iML6Cu+DQ3KoCzeb/PYQtOWb6uOZQiE9oHX+qKh8eNYg+UD3/zEboPqL5X22w
 +BVRY/Yrs6uIFmTpRkoNhxtGd3ASvLBrkbPnew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/usb/Kconfig               |   2 +-
 drivers/usb/atm/Kconfig           |   2 +-
 drivers/usb/dwc3/Kconfig          |  14 +--
 drivers/usb/gadget/Kconfig        | 160 +++++++++++++-------------
 drivers/usb/gadget/legacy/Kconfig |  48 ++++----
 drivers/usb/gadget/udc/Kconfig    | 234 +++++++++++++++++++-------------------
 drivers/usb/host/Kconfig          | 120 +++++++++----------
 drivers/usb/misc/Kconfig          |  32 +++---
 drivers/usb/serial/Kconfig        |  60 +++++-----
 drivers/usb/wusbcore/Kconfig      |  13 +--
 10 files changed, 342 insertions(+), 343 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index e4b2741..14f9933 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -53,7 +53,7 @@ config USB
 	  traditional PC serial port.  The bus supplies power to peripherals
 	  and allows for hot swapping.  Up to 127 USB peripherals can be
 	  connected to a single USB host in a tree structure.
-	  
+
 	  The USB host is the root of the tree, the peripherals are the
 	  leaves and the inner nodes are special USB devices called hubs.
 	  Most PCs now have USB host ports, used to connect peripherals
diff --git a/drivers/usb/atm/Kconfig b/drivers/usb/atm/Kconfig
index 989aaa3..fbb4a2d 100644
--- a/drivers/usb/atm/Kconfig
+++ b/drivers/usb/atm/Kconfig
@@ -23,7 +23,7 @@ config USB_SPEEDTOUCH
 	select FW_LOADER
 	help
 	  Say Y here if you have an SpeedTouch USB or SpeedTouch 330
-	  modem.  In order to use your modem you will need to install the 
+	  modem.  In order to use your modem you will need to install the
 	  two parts of the firmware, extracted by the user space tools; see
 	  <http://www.linux-usb.org/SpeedTouch/> for details.
 
diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 2b14944..a81f336f 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -96,13 +96,13 @@ config USB_DWC3_KEYSTONE
 	  Say 'Y' or 'M' here if you have one such device
 
 config USB_DWC3_OF_SIMPLE
-       tristate "Generic OF Simple Glue Layer"
-       depends on OF && COMMON_CLK
-       default USB_DWC3
-       help
-         Support USB2/3 functionality in simple SoC integrations.
-	 Currently supports Xilinx and Qualcomm DWC USB3 IP.
-	 Say 'Y' or 'M' if you have one such device.
+	tristate "Generic OF Simple Glue Layer"
+	depends on OF && COMMON_CLK
+	default USB_DWC3
+	help
+	  Support USB2/3 functionality in simple SoC integrations.
+	  Currently supports Xilinx and Qualcomm DWC USB3 IP.
+	  Say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_ST
 	tristate "STMicroelectronics Platforms"
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index ec189d7..587e0d1 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -19,30 +19,30 @@ menuconfig USB_GADGET
 	select USB_COMMON
 	select NLS
 	help
-	   USB is a master/slave protocol, organized with one master
-	   host (such as a PC) controlling up to 127 peripheral devices.
-	   The USB hardware is asymmetric, which makes it easier to set up:
-	   you can't connect a "to-the-host" connector to a peripheral.
-
-	   Linux can run in the host, or in the peripheral.  In both cases
-	   you need a low level bus controller driver, and some software
-	   talking to it.  Peripheral controllers are often discrete silicon,
-	   or are integrated with the CPU in a microcontroller.  The more
-	   familiar host side controllers have names like "EHCI", "OHCI",
-	   or "UHCI", and are usually integrated into southbridges on PC
-	   motherboards.
-
-	   Enable this configuration option if you want to run Linux inside
-	   a USB peripheral device.  Configure one hardware driver for your
-	   peripheral/device side bus controller, and a "gadget driver" for
-	   your peripheral protocol.  (If you use modular gadget drivers,
-	   you may configure more than one.)
-
-	   If in doubt, say "N" and don't enable these drivers; most people
-	   don't have this kind of hardware (except maybe inside Linux PDAs).
-
-	   For more information, see <http://www.linux-usb.org/gadget> and
-	   the kernel documentation for this API.
+	  USB is a master/slave protocol, organized with one master
+	  host (such as a PC) controlling up to 127 peripheral devices.
+	  The USB hardware is asymmetric, which makes it easier to set up:
+	  you can't connect a "to-the-host" connector to a peripheral.
+
+	  Linux can run in the host, or in the peripheral.  In both cases
+	  you need a low level bus controller driver, and some software
+	  talking to it.  Peripheral controllers are often discrete silicon,
+	  or are integrated with the CPU in a microcontroller.  The more
+	  familiar host side controllers have names like "EHCI", "OHCI",
+	  or "UHCI", and are usually integrated into southbridges on PC
+	  motherboards.
+
+	  Enable this configuration option if you want to run Linux inside
+	  a USB peripheral device.  Configure one hardware driver for your
+	  peripheral/device side bus controller, and a "gadget driver" for
+	  your peripheral protocol.  (If you use modular gadget drivers,
+	  you may configure more than one.)
+
+	  If in doubt, say "N" and don't enable these drivers; most people
+	  don't have this kind of hardware (except maybe inside Linux PDAs).
+
+	  For more information, see <http://www.linux-usb.org/gadget> and
+	  the kernel documentation for this API.
 
 if USB_GADGET
 
@@ -50,90 +50,90 @@ config USB_GADGET_DEBUG
 	bool "Debugging messages (DEVELOPMENT)"
 	depends on DEBUG_KERNEL
 	help
-	   Many controller and gadget drivers will print some debugging
-	   messages if you use this option to ask for those messages.
+	  Many controller and gadget drivers will print some debugging
+	  messages if you use this option to ask for those messages.
 
-	   Avoid enabling these messages, even if you're actively
-	   debugging such a driver.  Many drivers will emit so many
-	   messages that the driver timings are affected, which will
-	   either create new failure modes or remove the one you're
-	   trying to track down.  Never enable these messages for a
-	   production build.
+	  Avoid enabling these messages, even if you're actively
+	  debugging such a driver.  Many drivers will emit so many
+	  messages that the driver timings are affected, which will
+	  either create new failure modes or remove the one you're
+	  trying to track down.  Never enable these messages for a
+	  production build.
 
 config USB_GADGET_VERBOSE
 	bool "Verbose debugging Messages (DEVELOPMENT)"
 	depends on USB_GADGET_DEBUG
 	help
-	   Many controller and gadget drivers will print verbose debugging
-	   messages if you use this option to ask for those messages.
+	  Many controller and gadget drivers will print verbose debugging
+	  messages if you use this option to ask for those messages.
 
-	   Avoid enabling these messages, even if you're actively
-	   debugging such a driver.  Many drivers will emit so many
-	   messages that the driver timings are affected, which will
-	   either create new failure modes or remove the one you're
-	   trying to track down.  Never enable these messages for a
-	   production build.
+	  Avoid enabling these messages, even if you're actively
+	  debugging such a driver.  Many drivers will emit so many
+	  messages that the driver timings are affected, which will
+	  either create new failure modes or remove the one you're
+	  trying to track down.  Never enable these messages for a
+	  production build.
 
 config USB_GADGET_DEBUG_FILES
 	bool "Debugging information files (DEVELOPMENT)"
 	depends on PROC_FS
 	help
-	   Some of the drivers in the "gadget" framework can expose
-	   debugging information in files such as /proc/driver/udc
-	   (for a peripheral controller).  The information in these
-	   files may help when you're troubleshooting or bringing up a
-	   driver on a new board.   Enable these files by choosing "Y"
-	   here.  If in doubt, or to conserve kernel memory, say "N".
+	  Some of the drivers in the "gadget" framework can expose
+	  debugging information in files such as /proc/driver/udc
+	  (for a peripheral controller).  The information in these
+	  files may help when you're troubleshooting or bringing up a
+	  driver on a new board.   Enable these files by choosing "Y"
+	  here.  If in doubt, or to conserve kernel memory, say "N".
 
 config USB_GADGET_DEBUG_FS
 	bool "Debugging information files in debugfs (DEVELOPMENT)"
 	depends on DEBUG_FS
 	help
-	   Some of the drivers in the "gadget" framework can expose
-	   debugging information in files under /sys/kernel/debug/.
-	   The information in these files may help when you're
-	   troubleshooting or bringing up a driver on a new board.
-	   Enable these files by choosing "Y" here.  If in doubt, or
-	   to conserve kernel memory, say "N".
+	  Some of the drivers in the "gadget" framework can expose
+	  debugging information in files under /sys/kernel/debug/.
+	  The information in these files may help when you're
+	  troubleshooting or bringing up a driver on a new board.
+	  Enable these files by choosing "Y" here.  If in doubt, or
+	  to conserve kernel memory, say "N".
 
 config USB_GADGET_VBUS_DRAW
 	int "Maximum VBUS Power usage (2-500 mA)"
 	range 2 500
 	default 2
 	help
-	   Some devices need to draw power from USB when they are
-	   configured, perhaps to operate circuitry or to recharge
-	   batteries.  This is in addition to any local power supply,
-	   such as an AC adapter or batteries.
+	  Some devices need to draw power from USB when they are
+	  configured, perhaps to operate circuitry or to recharge
+	  batteries.  This is in addition to any local power supply,
+	  such as an AC adapter or batteries.
 
-	   Enter the maximum power your device draws through USB, in
-	   milliAmperes.  The permitted range of values is 2 - 500 mA;
-	   0 mA would be legal, but can make some hosts misbehave.
+	  Enter the maximum power your device draws through USB, in
+	  milliAmperes.  The permitted range of values is 2 - 500 mA;
+	  0 mA would be legal, but can make some hosts misbehave.
 
-	   This value will be used except for system-specific gadget
-	   drivers that have more specific information.
+	  This value will be used except for system-specific gadget
+	  drivers that have more specific information.
 
 config USB_GADGET_STORAGE_NUM_BUFFERS
 	int "Number of storage pipeline buffers"
 	range 2 256
 	default 2
 	help
-	   Usually 2 buffers are enough to establish a good buffering
-	   pipeline. The number may be increased in order to compensate
-	   for a bursty VFS behaviour. For instance there may be CPU wake up
-	   latencies that makes the VFS to appear bursty in a system with
-	   an CPU on-demand governor. Especially if DMA is doing IO to
-	   offload the CPU. In this case the CPU will go into power
-	   save often and spin up occasionally to move data within VFS.
-	   If selecting USB_GADGET_DEBUG_FILES this value may be set by
-	   a module parameter as well.
-	   If unsure, say 2.
+	  Usually 2 buffers are enough to establish a good buffering
+	  pipeline. The number may be increased in order to compensate
+	  for a bursty VFS behaviour. For instance there may be CPU wake up
+	  latencies that makes the VFS to appear bursty in a system with
+	  an CPU on-demand governor. Especially if DMA is doing IO to
+	  offload the CPU. In this case the CPU will go into power
+	  save often and spin up occasionally to move data within VFS.
+	  If selecting USB_GADGET_DEBUG_FILES this value may be set by
+	  a module parameter as well.
+	  If unsure, say 2.
 
 config U_SERIAL_CONSOLE
 	bool "Serial gadget console support"
 	depends on USB_U_SERIAL
 	help
-	   It supports the serial gadget can be used as a console.
+	  It supports the serial gadget can be used as a console.
 
 source "drivers/usb/gadget/udc/Kconfig"
 
@@ -299,14 +299,14 @@ config USB_CONFIGFS_RNDIS
 	select USB_U_ETHER
 	select USB_F_RNDIS
 	help
-	   Microsoft Windows XP bundles the "Remote NDIS" (RNDIS) protocol,
-	   and Microsoft provides redistributable binary RNDIS drivers for
-	   older versions of Windows.
-
-	   To make MS-Windows work with this, use Documentation/usb/linux.inf
-	   as the "driver info file".  For versions of MS-Windows older than
-	   XP, you'll need to download drivers from Microsoft's website; a URL
-	   is given in comments found in that info file.
+	  Microsoft Windows XP bundles the "Remote NDIS" (RNDIS) protocol,
+	  and Microsoft provides redistributable binary RNDIS drivers for
+	  older versions of Windows.
+
+	  To make MS-Windows work with this, use Documentation/usb/linux.inf
+	  as the "driver info file".  For versions of MS-Windows older than
+	  XP, you'll need to download drivers from Microsoft's website; a URL
+	  is given in comments found in that info file.
 
 config USB_CONFIGFS_EEM
 	bool "Ethernet Emulation Model (EEM)"
diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legacy/Kconfig
index d7c9e4f..b282781 100644
--- a/drivers/usb/gadget/legacy/Kconfig
+++ b/drivers/usb/gadget/legacy/Kconfig
@@ -135,36 +135,36 @@ config USB_ETH_RNDIS
 	select USB_F_RNDIS
 	default y
 	help
-	   Microsoft Windows XP bundles the "Remote NDIS" (RNDIS) protocol,
-	   and Microsoft provides redistributable binary RNDIS drivers for
-	   older versions of Windows.
+	  Microsoft Windows XP bundles the "Remote NDIS" (RNDIS) protocol,
+	  and Microsoft provides redistributable binary RNDIS drivers for
+	  older versions of Windows.
 
-	   If you say "y" here, the Ethernet gadget driver will try to provide
-	   a second device configuration, supporting RNDIS to talk to such
-	   Microsoft USB hosts.
+	  If you say "y" here, the Ethernet gadget driver will try to provide
+	  a second device configuration, supporting RNDIS to talk to such
+	  Microsoft USB hosts.
 
-	   To make MS-Windows work with this, use Documentation/usb/linux.inf
-	   as the "driver info file".  For versions of MS-Windows older than
-	   XP, you'll need to download drivers from Microsoft's website; a URL
-	   is given in comments found in that info file.
+	  To make MS-Windows work with this, use Documentation/usb/linux.inf
+	  as the "driver info file".  For versions of MS-Windows older than
+	  XP, you'll need to download drivers from Microsoft's website; a URL
+	  is given in comments found in that info file.
 
 config USB_ETH_EEM
-       bool "Ethernet Emulation Model (EEM) support"
-       depends on USB_ETH
+	bool "Ethernet Emulation Model (EEM) support"
+	depends on USB_ETH
 	select USB_LIBCOMPOSITE
 	select USB_F_EEM
-       default n
-       help
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
+	default n
+	help
+	  CDC EEM is a newer USB standard that is somewhat simpler than CDC ECM
+	  and therefore can be supported by more hardware.  Technically ECM and
+	  EEM are designed for different applications.  The ECM model extends
+	  the network interface to the target (e.g. a USB cable modem), and the
+	  EEM model is for mobile devices to communicate with hosts using
+	  ethernet over USB.  For Linux gadgets, however, the interface with
+	  the host is the same (a usbX device), so the differences are minimal.
+
+	  If you say "y" here, the Ethernet gadget driver will use the EEM
+	  protocol rather than ECM.  If unsure, say "n".
 
 config USB_G_NCM
 	tristate "Network Control Model (NCM) support"
diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index ef0259a..b316dda 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -35,24 +35,24 @@ config USB_AT91
 	depends on ARCH_AT91
 	depends on OF || COMPILE_TEST
 	help
-	   Many Atmel AT91 processors (such as the AT91RM2000) have a
-	   full speed USB Device Port with support for five configurable
-	   endpoints (plus endpoint zero).
+	  Many Atmel AT91 processors (such as the AT91RM2000) have a
+	  full speed USB Device Port with support for five configurable
+	  endpoints (plus endpoint zero).
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "at91_udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "at91_udc" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_LPC32XX
 	tristate "LPC32XX USB Peripheral Controller"
 	depends on ARCH_LPC32XX && I2C
 	select USB_ISP1301
 	help
-	   This option selects the USB device controller in the LPC32xx SoC.
+	  This option selects the USB device controller in the LPC32xx SoC.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "lpc32xx_udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "lpc32xx_udc" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_ATMEL_USBA
 	tristate "Atmel USBA"
@@ -80,49 +80,49 @@ config USB_BCM63XX_UDC
 	tristate "Broadcom BCM63xx Peripheral Controller"
 	depends on BCM63XX
 	help
-	   Many Broadcom BCM63xx chipsets (such as the BCM6328) have a
-	   high speed USB Device Port with support for four fixed endpoints
-	   (plus endpoint zero).
+	  Many Broadcom BCM63xx chipsets (such as the BCM6328) have a
+	  high speed USB Device Port with support for four fixed endpoints
+	  (plus endpoint zero).
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "bcm63xx_udc".
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "bcm63xx_udc".
 
 config USB_FSL_USB2
 	tristate "Freescale Highspeed USB DR Peripheral Controller"
 	depends on FSL_SOC || ARCH_MXC
 	help
-	   Some of Freescale PowerPC and i.MX processors have a High Speed
-	   Dual-Role(DR) USB controller, which supports device mode.
+	  Some of Freescale PowerPC and i.MX processors have a High Speed
+	  Dual-Role(DR) USB controller, which supports device mode.
 
-	   The number of programmable endpoints is different through
-	   SOC revisions.
+	  The number of programmable endpoints is different through
+	  SOC revisions.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "fsl_usb2_udc" and force
-	   all gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "fsl_usb2_udc" and force
+	  all gadget drivers to also be dynamically linked.
 
 config USB_FUSB300
 	tristate "Faraday FUSB300 USB Peripheral Controller"
 	depends on !PHYS_ADDR_T_64BIT && HAS_DMA
 	help
-	   Faraday usb device controller FUSB300 driver
+	  Faraday usb device controller FUSB300 driver
 
 config USB_FOTG210_UDC
 	depends on HAS_DMA
 	tristate "Faraday FOTG210 USB Peripheral Controller"
 	help
-	   Faraday USB2.0 OTG controller which can be configured as
-	   high speed or full speed USB device. This driver supppors
-	   Bulk Transfer so far.
+	  Faraday USB2.0 OTG controller which can be configured as
+	  high speed or full speed USB device. This driver supppors
+	  Bulk Transfer so far.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "fotg210_udc".
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "fotg210_udc".
 
 config USB_GR_UDC
-       tristate "Aeroflex Gaisler GRUSBDC USB Peripheral Controller Driver"
-       depends on HAS_DMA
-       help
-          Select this to support Aeroflex Gaisler GRUSBDC cores from the GRLIB
+	tristate "Aeroflex Gaisler GRUSBDC USB Peripheral Controller Driver"
+	depends on HAS_DMA
+	help
+	  Select this to support Aeroflex Gaisler GRUSBDC cores from the GRLIB
 	  VHDL IP core library.
 
 config USB_OMAP
@@ -130,31 +130,31 @@ config USB_OMAP
 	depends on ARCH_OMAP1
 	depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)
 	help
-	   Many Texas Instruments OMAP processors have flexible full
-	   speed USB device controllers, with support for up to 30
-	   endpoints (plus endpoint zero).  This driver supports the
-	   controller in the OMAP 1611, and should work with controllers
-	   in other OMAP processors too, given minor tweaks.
+	  Many Texas Instruments OMAP processors have flexible full
+	  speed USB device controllers, with support for up to 30
+	  endpoints (plus endpoint zero).  This driver supports the
+	  controller in the OMAP 1611, and should work with controllers
+	  in other OMAP processors too, given minor tweaks.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "omap_udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "omap_udc" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_PXA25X
 	tristate "PXA 25x or IXP 4xx"
 	depends on (ARCH_PXA && PXA25x) || ARCH_IXP4XX
 	depends on HAS_IOMEM
 	help
-	   Intel's PXA 25x series XScale ARM-5TE processors include
-	   an integrated full speed USB 1.1 device controller.  The
-	   controller in the IXP 4xx series is register-compatible.
+	  Intel's PXA 25x series XScale ARM-5TE processors include
+	  an integrated full speed USB 1.1 device controller.  The
+	  controller in the IXP 4xx series is register-compatible.
 
-	   It has fifteen fixed-function endpoints, as well as endpoint
-	   zero (for control transfers).
+	  It has fifteen fixed-function endpoints, as well as endpoint
+	  zero (for control transfers).
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "pxa25x_udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "pxa25x_udc" and force all
+	  gadget drivers to also be dynamically linked.
 
 # if there's only one gadget driver, using only two bulk endpoints,
 # don't waste memory for the other endpoints
@@ -170,25 +170,25 @@ config USB_R8A66597
 	tristate "Renesas R8A66597 USB Peripheral Controller"
 	depends on HAS_DMA
 	help
-	   R8A66597 is a discrete USB host and peripheral controller chip that
-	   supports both full and high speed USB 2.0 data transfers.
-	   It has nine configurable endpoints, and endpoint zero.
+	  R8A66597 is a discrete USB host and peripheral controller chip that
+	  supports both full and high speed USB 2.0 data transfers.
+	  It has nine configurable endpoints, and endpoint zero.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "r8a66597_udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "r8a66597_udc" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_RENESAS_USBHS_UDC
 	tristate 'Renesas USBHS controller'
 	depends on USB_RENESAS_USBHS
 	help
-	   Renesas USBHS is a discrete USB host and peripheral controller chip
-	   that supports both full and high speed USB 2.0 data transfers.
-	   It has nine or more configurable endpoints, and endpoint zero.
+	  Renesas USBHS is a discrete USB host and peripheral controller chip
+	  that supports both full and high speed USB 2.0 data transfers.
+	  It has nine or more configurable endpoints, and endpoint zero.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "renesas_usbhs" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "renesas_usbhs" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_RENESAS_USB3
 	tristate 'Renesas USB3.0 Peripheral controller'
@@ -196,26 +196,26 @@ config USB_RENESAS_USB3
 	depends on EXTCON
 	select USB_ROLE_SWITCH
 	help
-	   Renesas USB3.0 Peripheral controller is a USB peripheral controller
-	   that supports super, high, and full speed USB 3.0 data transfers.
+	  Renesas USB3.0 Peripheral controller is a USB peripheral controller
+	  that supports super, high, and full speed USB 3.0 data transfers.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "renesas_usb3" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "renesas_usb3" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_PXA27X
 	tristate "PXA 27x"
 	depends on HAS_IOMEM
 	help
-	   Intel's PXA 27x series XScale ARM v5TE processors include
-	   an integrated full speed USB 1.1 device controller.
+	  Intel's PXA 27x series XScale ARM v5TE processors include
+	  an integrated full speed USB 1.1 device controller.
 
-	   It has up to 23 endpoints, as well as endpoint zero (for
-	   control transfers).
+	  It has up to 23 endpoints, as well as endpoint zero (for
+	  control transfers).
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "pxa27x_udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "pxa27x_udc" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_S3C2410
 	tristate "S3C2410 USB Device Controller"
@@ -294,13 +294,13 @@ config USB_M66592
 	tristate "Renesas M66592 USB Peripheral Controller"
 	depends on HAS_IOMEM
 	help
-	   M66592 is a discrete USB peripheral controller chip that
-	   supports both full and high speed USB 2.0 data transfers.
-	   It has seven configurable endpoints, and endpoint zero.
+	  M66592 is a discrete USB peripheral controller chip that
+	  supports both full and high speed USB 2.0 data transfers.
+	  It has seven configurable endpoints, and endpoint zero.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "m66592_udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "m66592_udc" and force all
+	  gadget drivers to also be dynamically linked.
 
 source "drivers/usb/gadget/udc/bdc/Kconfig"
 
@@ -313,31 +313,31 @@ config USB_AMD5536UDC
 	depends on USB_PCI
 	select USB_SNP_CORE
 	help
-	   The AMD5536 UDC is part of the AMD Geode CS5536, an x86 southbridge.
-	   It is a USB Highspeed DMA capable USB device controller. Beside ep0
-	   it provides 4 IN and 4 OUT endpoints (bulk or interrupt type).
-	   The UDC port supports OTG operation, and may be used as a host port
-	   if it's not being used to implement peripheral or OTG roles.
+	  The AMD5536 UDC is part of the AMD Geode CS5536, an x86 southbridge.
+	  It is a USB Highspeed DMA capable USB device controller. Beside ep0
+	  it provides 4 IN and 4 OUT endpoints (bulk or interrupt type).
+	  The UDC port supports OTG operation, and may be used as a host port
+	  if it's not being used to implement peripheral or OTG roles.
 
-	   This UDC is based on Synopsys USB device controller IP and selects
-	   CONFIG_USB_SNP_CORE option to build the core driver.
+	  This UDC is based on Synopsys USB device controller IP and selects
+	  CONFIG_USB_SNP_CORE option to build the core driver.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "amd5536udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "amd5536udc" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_FSL_QE
 	tristate "Freescale QE/CPM USB Device Controller"
 	depends on FSL_SOC && (QUICC_ENGINE || CPM)
 	help
-	   Some of Freescale PowerPC processors have a Full Speed
-	   QE/CPM2 USB controller, which support device mode with 4
-	   programmable endpoints. This driver supports the
-	   controller in the MPC8360 and MPC8272, and should work with
-	   controllers having QE or CPM2, given minor tweaks.
+	  Some of Freescale PowerPC processors have a Full Speed
+	  QE/CPM2 USB controller, which support device mode with 4
+	  programmable endpoints. This driver supports the
+	  controller in the MPC8360 and MPC8272, and should work with
+	  controllers having QE or CPM2, given minor tweaks.
 
-	   Set CONFIG_USB_GADGET to "m" to build this driver as a
-	   dynamically linked module called "fsl_qe_udc".
+	  Set CONFIG_USB_GADGET to "m" to build this driver as a
+	  dynamically linked module called "fsl_qe_udc".
 
 config USB_NET2272
 	depends on HAS_IOMEM
@@ -366,40 +366,40 @@ config USB_NET2280
 	tristate "NetChip NET228x / PLX USB3x8x"
 	depends on USB_PCI
 	help
-	   NetChip 2280 / 2282 is a PCI based USB peripheral controller which
-	   supports both full and high speed USB 2.0 data transfers.
+	  NetChip 2280 / 2282 is a PCI based USB peripheral controller which
+	  supports both full and high speed USB 2.0 data transfers.
 
-	   It has six configurable endpoints, as well as endpoint zero
-	   (for control transfers) and several endpoints with dedicated
-	   functions.
+	  It has six configurable endpoints, as well as endpoint zero
+	  (for control transfers) and several endpoints with dedicated
+	  functions.
 
-	   PLX 2380 is a PCIe version of the PLX 2380.
+	  PLX 2380 is a PCIe version of the PLX 2380.
 
-	   PLX 3380 / 3382 is a PCIe based USB peripheral controller which
-	   supports full, high speed USB 2.0 and super speed USB 3.0
-	   data transfers.
+	  PLX 3380 / 3382 is a PCIe based USB peripheral controller which
+	  supports full, high speed USB 2.0 and super speed USB 3.0
+	  data transfers.
 
-	   It has eight configurable endpoints, as well as endpoint zero
-	   (for control transfers) and several endpoints with dedicated
-	   functions.
+	  It has eight configurable endpoints, as well as endpoint zero
+	  (for control transfers) and several endpoints with dedicated
+	  functions.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "net2280" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "net2280" and force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_GOKU
 	tristate "Toshiba TC86C001 'Goku-S'"
 	depends on USB_PCI
 	help
-	   The Toshiba TC86C001 is a PCI device which includes controllers
-	   for full speed USB devices, IDE, I2C, SIO, plus a USB host (OHCI).
+	  The Toshiba TC86C001 is a PCI device which includes controllers
+	  for full speed USB devices, IDE, I2C, SIO, plus a USB host (OHCI).
 
-	   The device controller has three configurable (bulk or interrupt)
-	   endpoints, plus endpoint zero (for control transfers).
+	  The device controller has three configurable (bulk or interrupt)
+	  endpoints, plus endpoint zero (for control transfers).
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "goku_udc" and to force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "goku_udc" and to force all
+	  gadget drivers to also be dynamically linked.
 
 config USB_EG20T
 	tristate "Intel QUARK X1000/EG20T PCH/LAPIS Semiconductor IOH(ML7213/ML7831) UDC"
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d809671..cddd68e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -38,9 +38,9 @@ config USB_XHCI_DBGCAP
 	  before enabling this option. If unsure, say 'N'.
 
 config USB_XHCI_PCI
-       tristate
-       depends on USB_PCI
-       default y
+	tristate
+	depends on USB_PCI
+	default y
 
 config USB_XHCI_PLATFORM
 	tristate "Generic xHCI driver for a platform device"
@@ -165,8 +165,8 @@ config USB_EHCI_HCD_PMC_MSP
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	---help---
-		Enables support for the onchip USB controller on the PMC_MSP7100 Family SoC's.
-		If unsure, say N.
+	  Enables support for the onchip USB controller on the PMC_MSP7100 Family SoC's.
+	  If unsure, say N.
 
 config XPS_USB_HCD_XILINX
 	bool "Use Xilinx usb host EHCI controller core"
@@ -174,10 +174,10 @@ config XPS_USB_HCD_XILINX
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	---help---
-		Xilinx xps USB host controller core is EHCI compliant and has
-		transaction translator built-in. It can be configured to either
-		support both high speed and full speed devices, or high speed
-		devices only.
+	  Xilinx xps USB host controller core is EHCI compliant and has
+	  transaction translator built-in. It can be configured to either
+	  support both high speed and full speed devices, or high speed
+	  devices only.
 
 config USB_EHCI_FSL
 	tristate "Support for Freescale on-chip EHCI USB controller"
@@ -221,12 +221,12 @@ config USB_EHCI_HCD_ORION
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
@@ -238,21 +238,21 @@ config USB_EHCI_HCD_STI
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
-       tristate "NVIDIA Tegra HCD support"
-       depends on ARCH_TEGRA
-       select USB_EHCI_ROOT_HUB_TT
-       select USB_TEGRA_PHY
-       help
-         This driver enables support for the internal USB Host Controllers
-         found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
+	tristate "NVIDIA Tegra HCD support"
+	depends on ARCH_TEGRA
+	select USB_EHCI_ROOT_HUB_TT
+	select USB_TEGRA_PHY
+	help
+	  This driver enables support for the internal USB Host Controllers
+	  found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
 
 config USB_EHCI_HCD_PPC_OF
 	bool "EHCI support for PPC USB controller on OF platform bus"
@@ -270,10 +270,10 @@ config USB_EHCI_SH
 	  If you use the PCI EHCI controller, this option is not necessary.
 
 config USB_EHCI_EXYNOS
-       tristate "EHCI support for Samsung S5P/EXYNOS SoC Series"
-       depends on ARCH_S5PV210 || ARCH_EXYNOS
-       help
-	Enable support for the Samsung Exynos SOC's on-chip EHCI controller.
+	tristate "EHCI support for Samsung S5P/EXYNOS SoC Series"
+	depends on ARCH_S5PV210 || ARCH_EXYNOS
+	help
+	  Enable support for the Samsung Exynos SOC's on-chip EHCI controller.
 
 config USB_EHCI_MV
 	tristate "EHCI support for Marvell PXA/MMP USB controller"
@@ -418,12 +418,12 @@ config USB_OHCI_HCD_OMAP1
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
@@ -435,12 +435,12 @@ config USB_OHCI_HCD_STI
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
@@ -448,8 +448,8 @@ config USB_OHCI_HCD_LPC32XX
 	depends on USB_ISP1301
 	default y
 	---help---
-          Enables support for the on-chip OHCI controller on
-          NXP chips.
+	  Enables support for the on-chip OHCI controller on
+	  NXP chips.
 
 config USB_OHCI_HCD_PXA27X
 	tristate "Support for PXA27X/PXA3XX on-chip OHCI USB controller"
@@ -464,8 +464,8 @@ config USB_OHCI_HCD_AT91
 	depends on USB_OHCI_HCD && ARCH_AT91 && OF
 	default y
 	---help---
-          Enables support for the on-chip OHCI controller on
-          Atmel chips.
+	  Enables support for the on-chip OHCI controller on
+	  Atmel chips.
 
 config USB_OHCI_HCD_OMAP3
 	tristate "OHCI support for OMAP3 and later chips"
@@ -554,7 +554,7 @@ config USB_OHCI_EXYNOS
 	tristate "OHCI support for Samsung S5P/EXYNOS SoC Series"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS
 	help
-	 Enable support for the Samsung Exynos SOC's on-chip OHCI controller.
+	  Enable support for the Samsung Exynos SOC's on-chip OHCI controller.
 
 config USB_CNS3XXX_OHCI
 	bool "Cavium CNS3XXX OHCI Module (DEPRECATED)"
@@ -619,8 +619,8 @@ config USB_UHCI_PLATFORM
 	default y if (ARCH_VT8500 || ARCH_ASPEED)
 
 config USB_UHCI_ASPEED
-       bool
-       default y if ARCH_ASPEED
+	bool
+	default y if ARCH_ASPEED
 
 config USB_FHCI_HCD
 	tristate "Freescale QE USB Host Controller support"
@@ -672,7 +672,7 @@ config USB_SL811_HCD
 	help
 	  The SL811HS is a single-port USB controller that supports either
 	  host side or peripheral side roles.  Enable this option if your
-	  board has this chip, and you want to use it as a host controller. 
+	  board has this chip, and you want to use it as a host controller.
 	  If unsure, say N.
 
 	  To compile this driver as a module, choose M here: the
@@ -749,14 +749,14 @@ config USB_HWA_HCD
 	  will be called "hwa-hc".
 
 config USB_IMX21_HCD
-       tristate "i.MX21 HCD support"
-       depends on ARM && ARCH_MXC
-       help
-         This driver enables support for the on-chip USB host in the
-         i.MX21 processor.
-
-         To compile this driver as a module, choose M here: the
-         module will be called "imx21-hcd".
+	tristate "i.MX21 HCD support"
+	depends on ARM && ARCH_MXC
+	help
+	  This driver enables support for the on-chip USB host in the
+	  i.MX21 processor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called "imx21-hcd".
 
 config USB_HCD_BCMA
 	tristate "BCMA usb host driver"
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index be04c11..9978866 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -99,7 +99,7 @@ config USB_CYTHERM
 	  Say Y here if you want to connect a Cypress USB thermometer
 	  device to your computer's USB port. This device is also known
 	  as the Cypress USB Starter kit or demo board. The Elektor
-	  magazine published a modified version of this device in issue 
+	  magazine published a modified version of this device in issue
 	  #291.
 
 	  To compile this driver as a module, choose M here: the
@@ -173,10 +173,10 @@ config USB_IOWARRIOR
 	help
 	  Say Y here if you want to support the IO Warrior devices from Code
 	  Mercenaries.  This includes support for the following devices:
-	  	IO Warrior 40
-		IO Warrior 24
-		IO Warrior 56
-		IO Warrior 24 Power Vampire
+	        IO Warrior 40
+	        IO Warrior 24
+	        IO Warrior 56
+	        IO Warrior 24 Power Vampire
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called iowarrior.
@@ -192,8 +192,8 @@ config USB_TEST
 	  including sample test device firmware and "how to use it".
 
 config USB_EHSET_TEST_FIXTURE
-        tristate "USB EHSET Test Fixture driver"
-        help
+	tristate "USB EHSET Test Fixture driver"
+	help
 	  Say Y here if you want to support the special test fixture device
 	  used for the USB-IF Embedded Host High-Speed Electrical Test procedure.
 
@@ -244,17 +244,17 @@ config USB_HUB_USB251XB
 	  Say Y or M here if you need to configure such a device via SMBus.
 
 config USB_HSIC_USB3503
-       tristate "USB3503 HSIC to USB20 Driver"
-       depends on I2C
-       select REGMAP_I2C
-       help
-         This option enables support for SMSC USB3503 HSIC to USB 2.0 Driver.
+	tristate "USB3503 HSIC to USB20 Driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This option enables support for SMSC USB3503 HSIC to USB 2.0 Driver.
 
 config USB_HSIC_USB4604
-       tristate "USB4604 HSIC to USB20 Driver"
-       depends on I2C
-       help
-         This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
+	tristate "USB4604 HSIC to USB20 Driver"
+	depends on I2C
+	help
+	  This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
 
 config USB_LINK_LAYER_TEST
 	tristate "USB Link Layer Test driver"
diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 7d03191..b8d316b 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -78,10 +78,10 @@ config USB_SERIAL_SIMPLE
 config USB_SERIAL_AIRCABLE
 	tristate "USB AIRcable Bluetooth Dongle Driver"
 	help
-	    Say Y here if you want to use USB AIRcable Bluetooth Dongle.
+	  Say Y here if you want to use USB AIRcable Bluetooth Dongle.
 
-	    To compile this driver as a module, choose M here: the module
-	    will be called aircable.
+	  To compile this driver as a module, choose M here: the module
+	  will be called aircable.
 
 config USB_SERIAL_ARK3116
 	tristate "USB ARK Micro 3116 USB Serial Driver"
@@ -269,19 +269,19 @@ config USB_SERIAL_F8153X
 
 
 config USB_SERIAL_GARMIN
-       tristate "USB Garmin GPS driver"
-       help
-         Say Y here if you want to connect to your Garmin GPS.
-         Should work with most Garmin GPS devices which have a native USB port.
+	tristate "USB Garmin GPS driver"
+	help
+	  Say Y here if you want to connect to your Garmin GPS.
+	  Should work with most Garmin GPS devices which have a native USB port.
 
-         See <http://sourceforge.net/projects/garmin-gps> for the latest
-         version of the driver.
+	  See <http://sourceforge.net/projects/garmin-gps> for the latest
+	  version of the driver.
 
-         To compile this driver as a module, choose M here: the
-         module will be called garmin_gps.
+	  To compile this driver as a module, choose M here: the
+	  module will be called garmin_gps.
 
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
@@ -392,9 +392,9 @@ config USB_SERIAL_MOS7715_PARPORT
 	depends on PARPORT=y || PARPORT=USB_SERIAL_MOS7720
 	select PARPORT_NOT_PC
 	---help---
-	Say Y if you have a Moschip 7715 device and would like to use
-	the parallel port it provides.  The port will register with
-	the parport subsystem as a low-level driver.
+	  Say Y if you have a Moschip 7715 device and would like to use
+	  the parallel port it provides.  The port will register with
+	  the parport subsystem as a low-level driver.
 
 config USB_SERIAL_MOS7840
 	tristate "USB Moschip 7840/7820 USB Serial Driver"
@@ -458,7 +458,7 @@ config USB_SERIAL_OTI6858
 	tristate "USB Ours Technology Inc. OTi-6858 USB To RS232 Bridge Controller"
 	help
 	  Say Y here if you want to use the OTi-6858 single port USB to serial
-          converter device.
+	  converter device.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called oti6858.
diff --git a/drivers/usb/wusbcore/Kconfig b/drivers/usb/wusbcore/Kconfig
index 12e8918..6de5660 100644
--- a/drivers/usb/wusbcore/Kconfig
+++ b/drivers/usb/wusbcore/Kconfig
@@ -5,15 +5,15 @@
 config USB_WUSB
 	tristate "Enable Wireless USB extensions"
 	depends on UWB
-        select CRYPTO
-        select CRYPTO_BLKCIPHER
-        select CRYPTO_CBC
-        select CRYPTO_MANAGER
-        select CRYPTO_AES
+	select CRYPTO
+	select CRYPTO_BLKCIPHER
+	select CRYPTO_CBC
+	select CRYPTO_MANAGER
+	select CRYPTO_AES
 	help
 	  Enable the host-side support for Wireless USB.
 
-          To compile this support select Y (built in). It is safe to
+	  To compile this support select Y (built in). It is safe to
 	  select even if you don't have the hardware.
 
 config USB_WUSB_CBAF
@@ -37,4 +37,3 @@ config USB_WUSB_CBAF_DEBUG
 	  Say Y here if you want the CBA to produce a bunch of debug messages
 	  to the system log. Select this if you are having a problem with
 	  CBA support and want to see more of what is going on.
-
-- 
1.9.1

