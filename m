Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98111C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6643920857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfCKN2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:28:17 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M6DSo-1h9xcL18Om-006dmd for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 043/114] drivers: staging: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:55 +0100
Message-Id: <1552310346-7629-44-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:46c7GgHvgbho6g6yK1N86lYIHnO5v/FSvgbwSbdThGOfxgoIxCB
 Z8qnkA6kPeCtmhxBhTxWgOkHFlc4FB5uBAj+n5yM4kvbuw1XsFnY9qRKj9812Ud1hjVuae1
 7s6QdhWvCzOiOvsVTrGRiV0hwUy0Zxz8/yuO6/47dglr3iLHNOxSuxn8lD954gNzI7aoblX
 Xkddsk73uhEU1eH9AcitQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PK9tDskpZeY=:2m9eaIPAPbu8kaqwexhald
 lDUcrV7v7ef6/fJfHHYCXa+5jTloWbKakLBUHjx6yWvJNiqMRubV/8w1rtvg3vtRKSHMD6mbW
 ESE3Zu/N2Eaf2YF/9vfwj7r4MpbK8qp2djvVB+KvcSpjzO/n+bCGEemzii/msf/PMsv1lGMO5
 3xMgdl5QqIG4A0oCmv4dweWqCGfJ8a8SC+G99mO3++nKestBCwjacPsGYooDab1XPx3Pa4ztl
 YV1FElChrXEqO33KnkkpNeHBGFIbZgHD0XTx/R3Z1IRO1MLehnHWLAvinl+6BNnBb94uPar7j
 Xtce1FsFZ6MSdSwQY77lMHYswSHAkbqiC5NQN+WKvasGYqa20yweOlvpTMw337vqoPHtegS6D
 JXqNh9yId5PHUXmQOJ9SLNZ3iXcpYRyZIvyeRj2X9nuQDgLkvUdI1p4HOXl868YUKu5a5MNhL
 80FTgXPhRWl/MO6iQ9J2/1etM21jq3cM3qR88Qs9yFpjaND6Gc6q1ewVxRYhRWYWoAWFSRQwH
 fVa1uIuTHnVmGqcR6lNK8e6DQ4Yjwxm3S+ZBmhwT3tCCI3UwYlCbbGoTmPkW6x6bHqq345gXp
 B4+MhKUoYX+UZT2J6kdNIhyVjqlJ1nKka6K22DdV6wE62VzkMvPPI8lnet73CB5+KqX+Bzam8
 pV5j+Uv5jI3VHdz6RB9UXSPXSsinv/F3YzgdS+aY92UKZt1J6TknEz0lFFwsT/eJcqVdOqCML
 mqhLQu93Mvfaj/OJumnr5+N3NyhLAHNSUSb0iA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/staging/android/ion/Kconfig                |  2 +-
 drivers/staging/emxx_udc/Kconfig                   | 10 ++++-----
 drivers/staging/fbtft/Kconfig                      | 12 +++++-----
 drivers/staging/fwserial/Kconfig                   | 26 +++++++++++-----------
 drivers/staging/greybus/Kconfig                    |  4 ++--
 drivers/staging/media/tegra-vde/Kconfig            |  4 ++--
 drivers/staging/most/Kconfig                       | 10 ++++-----
 drivers/staging/nvec/Kconfig                       | 19 +++++++---------
 drivers/staging/pi433/Kconfig                      | 24 ++++++++++----------
 drivers/staging/speakup/Kconfig                    |  8 +++----
 .../staging/vc04_services/bcm2835-audio/Kconfig    | 13 +++++------
 drivers/staging/vt6655/Kconfig                     |  9 ++++----
 12 files changed, 67 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/android/ion/Kconfig b/drivers/staging/android/ion/Kconfig
index 0fdda6f..bba670c9 100644
--- a/drivers/staging/android/ion/Kconfig
+++ b/drivers/staging/android/ion/Kconfig
@@ -30,7 +30,7 @@ config ION_CHUNK_HEAP
 	bool "Ion chunk heap support"
 	depends on ION
 	help
-          Choose this option to enable chunk heaps with Ion. This heap is
+	  Choose this option to enable chunk heaps with Ion. This heap is
 	  similar in function the carveout heap but memory is broken down
 	  into smaller chunk sizes, typically corresponding to a TLB size.
 	  Unless you know your system has these regions, you should say N here.
diff --git a/drivers/staging/emxx_udc/Kconfig b/drivers/staging/emxx_udc/Kconfig
index e50e722..15d99a6e 100644
--- a/drivers/staging/emxx_udc/Kconfig
+++ b/drivers/staging/emxx_udc/Kconfig
@@ -2,9 +2,9 @@ config USB_EMXX
 	tristate "EMXX USB Function Device Controller"
 	depends on USB_GADGET && (ARCH_RENESAS || (ARM && COMPILE_TEST))
 	help
-	   The Emma Mobile series of SoCs from Renesas Electronics and
-	   former NEC Electronics include USB Function hardware.
+	  The Emma Mobile series of SoCs from Renesas Electronics and
+	  former NEC Electronics include USB Function hardware.
 
-	   Say "y" to link the driver statically, or "m" to build a
-	   dynamically linked module called "emxx_udc" and force all
-	   gadget drivers to also be dynamically linked.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "emxx_udc" and force all
+	  gadget drivers to also be dynamically linked.
diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index 84b2e7e..3e504c6 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -94,8 +94,8 @@ config FB_TFT_PCD8544
 	  Generic Framebuffer support for PCD8544
 
 config FB_TFT_RA8875
-        tristate "FB driver for the RA8875 LCD Controller"
-        depends on FB_TFT
+	tristate "FB driver for the RA8875 LCD Controller"
+	depends on FB_TFT
 	help
 	  Generic Framebuffer support for RA8875
 
@@ -124,10 +124,10 @@ config FB_TFT_SSD1289
 	  Framebuffer support for SSD1289
 
 config FB_TFT_SSD1305
-        tristate "FB driver for the SSD1305 OLED Controller"
-        depends on FB_TFT
-        help
-          Framebuffer support for SSD1305
+	tristate "FB driver for the SSD1305 OLED Controller"
+	depends on FB_TFT
+	help
+	  Framebuffer support for SSD1305
 
 config FB_TFT_SSD1306
 	tristate "FB driver for the SSD1306 OLED Controller"
diff --git a/drivers/staging/fwserial/Kconfig b/drivers/staging/fwserial/Kconfig
index 9c7c926..64cb277 100644
--- a/drivers/staging/fwserial/Kconfig
+++ b/drivers/staging/fwserial/Kconfig
@@ -1,8 +1,8 @@
 config FIREWIRE_SERIAL
-       tristate "TTY over Firewire"
-       depends on FIREWIRE && TTY
-       help
-          This enables TTY over IEEE 1394, providing high-speed serial
+	tristate "TTY over Firewire"
+	depends on FIREWIRE && TTY
+	help
+	  This enables TTY over IEEE 1394, providing high-speed serial
 	  connectivity to cabled peers. This driver implements a
 	  ad-hoc transport protocol and is currently limited to
 	  Linux-to-Linux communication.
@@ -13,18 +13,18 @@ config FIREWIRE_SERIAL
 if FIREWIRE_SERIAL
 
 config FWTTY_MAX_TOTAL_PORTS
-       int "Maximum number of serial ports supported"
-       default "64"
-       help
-          Set this to the maximum number of serial ports you want the
+	int "Maximum number of serial ports supported"
+	default "64"
+	help
+	  Set this to the maximum number of serial ports you want the
 	  firewire-serial driver to support.
 
 config FWTTY_MAX_CARD_PORTS
-       int "Maximum number of serial ports supported per adapter"
-       range 0 FWTTY_MAX_TOTAL_PORTS
-       default "32"
-       help
-          Set this to the maximum number of serial ports each firewire
+	int "Maximum number of serial ports supported per adapter"
+	range 0 FWTTY_MAX_TOTAL_PORTS
+	default "32"
+	help
+	  Set this to the maximum number of serial ports each firewire
 	  adapter supports. The actual number of serial ports registered
 	  is set with the module parameter "ttys".
 
diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index b571e4e..ed1ce74 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -216,7 +216,7 @@ config GREYBUS_USB
 	  To compile this code as a module, chose M here: the module
 	  will be called gb-usb.ko
 
-endif	# GREYBUS_BRIDGED_PHY
+endif # GREYBUS_BRIDGED_PHY
 
 config GREYBUS_ARCHE
 	tristate "Greybus Arche Platform driver"
@@ -227,4 +227,4 @@ config GREYBUS_ARCHE
 	  To compile this code as a module, chose M here: the module
 	  will be called gb-arche.ko
 
-endif	# GREYBUS
+endif # GREYBUS
diff --git a/drivers/staging/media/tegra-vde/Kconfig b/drivers/staging/media/tegra-vde/Kconfig
index 5c49146..0c7d79f 100644
--- a/drivers/staging/media/tegra-vde/Kconfig
+++ b/drivers/staging/media/tegra-vde/Kconfig
@@ -4,5 +4,5 @@ config TEGRA_VDE
 	select DMA_SHARED_BUFFER
 	select SRAM
 	help
-	    Say Y here to enable support for the NVIDIA Tegra video decoder
-	    driver.
+	  Say Y here to enable support for the NVIDIA Tegra video decoder
+	  driver.
diff --git a/drivers/staging/most/Kconfig b/drivers/staging/most/Kconfig
index 20047ab..044fa4b 100644
--- a/drivers/staging/most/Kconfig
+++ b/drivers/staging/most/Kconfig
@@ -1,8 +1,8 @@
 menuconfig MOST
-        tristate "MOST support"
+	tristate "MOST support"
 	depends on HAS_DMA
-        default n
-        ---help---
+	default n
+	---help---
 	  Say Y here if you want to enable MOST support.
 	  This driver needs at least one additional component to enable the
 	  desired access from userspace (e.g. character devices) and one that
@@ -11,9 +11,7 @@ menuconfig MOST
 	  To compile this driver as a module, choose M here: the
 	  module will be called most_core.
 
-          If in doubt, say N here.
-
-
+	  If in doubt, say N here.
 
 if MOST
 
diff --git a/drivers/staging/nvec/Kconfig b/drivers/staging/nvec/Kconfig
index e3a89fb..68636d3 100644
--- a/drivers/staging/nvec/Kconfig
+++ b/drivers/staging/nvec/Kconfig
@@ -3,11 +3,11 @@ config MFD_NVEC
 	depends on I2C && GPIOLIB && ARCH_TEGRA
 	select MFD_CORE
 	help
-	    Say Y here to enable support for a nVidia compliant embedded
-	    controller.
+	  Say Y here to enable support for a nVidia compliant embedded
+	  controller.
 
-	    To compile this driver as a module, say M here: the module will be
-            called mfd-nvec
+	  To compile this driver as a module, say M here: the module will be
+	  called mfd-nvec
 
 config KEYBOARD_NVEC
 	tristate "Keyboard on nVidia compliant EC"
@@ -17,7 +17,7 @@ config KEYBOARD_NVEC
 	  a nVidia compliant embedded controller.
 
 	  To compile this driver as a module, say M here: the module will be
-          called keyboard-nvec
+	  called keyboard-nvec
 
 config SERIO_NVEC_PS2
 	tristate "PS2 on nVidia EC"
@@ -27,8 +27,7 @@ config SERIO_NVEC_PS2
 	  to a nVidia compliant embedded controller.
 
 	  To compile this driver as a module, say M here: the module will be
-          called serio-nvec-ps2
-
+	  called serio-nvec-ps2
 
 config NVEC_POWER
 	tristate "NVEC charger and battery"
@@ -38,8 +37,7 @@ config NVEC_POWER
 	  nVidia compliant embedded controllers.
 
 	  To compile this driver as a module, say M here: the module will be
-          called nvec-power
-
+	  called nvec-power
 
 config NVEC_PAZ00
 	tristate "Support for OEM specific functions on Compal PAZ00 based devices"
@@ -49,5 +47,4 @@ config NVEC_PAZ00
 	  devices, e.g. Toshbia AC100 and Dynabooks AZ netbooks.
 
 	  To compile this driver as a module, say M here: the module will be
-          called nvec-paz00
-
+	  called nvec-paz00
diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
index c734012..bdf50b1 100644
--- a/drivers/staging/pi433/Kconfig
+++ b/drivers/staging/pi433/Kconfig
@@ -1,16 +1,16 @@
 config PI433
-        tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
-        depends on SPI
-        help
-          This option allows you to enable support for the radio module Pi433.
+	tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
+	depends on SPI
+	help
+	  This option allows you to enable support for the radio module Pi433.
 
-          Pi433 is a shield that fits onto the GPIO header of a Raspberry Pi
-          or compatible. It extends the Raspberry Pi with the option, to
-          send and receive data in the 433MHz ISM band - for example to
-          communicate between two systems without using ethernet or bluetooth
-          or for control or read sockets, actors, sensors, widely available
-          for low price.
+	  Pi433 is a shield that fits onto the GPIO header of a Raspberry Pi
+	  or compatible. It extends the Raspberry Pi with the option, to
+	  send and receive data in the 433MHz ISM band - for example to
+	  communicate between two systems without using ethernet or bluetooth
+	  or for control or read sockets, actors, sensors, widely available
+	  for low price.
 
-          For details or the option to buy, please visit https://pi433.de/en.html
+	  For details or the option to buy, please visit https://pi433.de/en.html
 
-          If in doubt, say N here, but saying yes most probably won't hurt
+	  If in doubt, say N here, but saying yes most probably won't hurt
diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
index d8ec780..c21f086 100644
--- a/drivers/staging/speakup/Kconfig
+++ b/drivers/staging/speakup/Kconfig
@@ -31,7 +31,6 @@ config SPEAKUP
 		used in conjunction with Speakup.  Think of them as
 		video cards for blind people.
 
-
 		The Dectalk pc driver can only be built as a module, and
 		requires software to be pre-loaded on to the card before
 		the module can be loaded.  See the decpc choice below
@@ -70,7 +69,7 @@ config SPEAKUP_SYNTH_AUDPTR
 	tristate "Audapter synthesizer support"
 	help
 		This is the Speakup driver for the Audapter synthesizer.
-		 You can say y to build it into the kernel, or m to
+		You can say y to build it into the kernel, or m to
 		build it as a module.  See the configuration help on the
 		Speakup choice above for more info.
 
@@ -172,7 +171,7 @@ config SPEAKUP_SYNTH_SPKOUT
 	help
 
 		This is the Speakup driver for the Speakout synthesizer.
-		 You can say y to build it into the kernel, or m to
+		You can say y to build it into the kernel, or m to
 		build it as a module.  See the configuration help on the
 		Speakup choice above for more info.
 
@@ -195,5 +194,6 @@ config SPEAKUP_SYNTH_DUMMY
 		the kernel, or m to build it as a module.  See the
 		configuration help on the Speakup choice above for more info.
 
-endif	# SPEAKUP
+endif # SPEAKUP
+
 endmenu
diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index 62c1c8b..eee68a6 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -1,8 +1,7 @@
 config SND_BCM2835
-        tristate "BCM2835 Audio"
-        depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
-        select SND_PCM
-        select BCM2835_VCHIQ
-        help
-          Say Y or M if you want to support BCM2835 built in audio
-
+	tristate "BCM2835 Audio"
+	depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
+	select SND_PCM
+	select BCM2835_VCHIQ
+	help
+	  Say Y or M if you want to support BCM2835 built in audio
diff --git a/drivers/staging/vt6655/Kconfig b/drivers/staging/vt6655/Kconfig
index 77cfc70..e45fdaf 100644
--- a/drivers/staging/vt6655/Kconfig
+++ b/drivers/staging/vt6655/Kconfig
@@ -1,6 +1,5 @@
 config VT6655
-   tristate "VIA Technologies VT6655 support"
-   depends on PCI && MAC80211 && m
-   ---help---
-   This is a vendor-written driver for VIA VT6655.
-
+	tristate "VIA Technologies VT6655 support"
+	depends on PCI && MAC80211 && m
+	---help---
+	  This is a vendor-written driver for VIA VT6655.
-- 
1.9.1

