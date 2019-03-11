Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD970C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AFA2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfCKNTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N63NW-1h1CBw3GO0-016PR5 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 039/114] drivers: video: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:51 +0100
Message-Id: <1552310346-7629-40-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:KZCiLGIdDMZH5vSWJ4pyGKTiowYi8rNmpVNFrPvyeuvOtVyzXTw
 wdKhmknNUPLrN7+wtTHTdAljKvAWPoorV0S78MqFHefVUdpPl1fyOhyVWOIFaGby7jIkUTi
 MLszk1tqKGIXevwVOilawCh3bjdZOY9feDD4MwpZ9P0akax9M3Mp0swUKENi0yolyvMbHcs
 HQM2rwfhMpPmpJ/B3qkjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uoVS7aJRd6E=:8lAAutmw9AD0XOF1eQjsme
 FQ6/663DWBKZIXke7yMFUWQtmDLD3RBjA1j3aA3bnBrYlX1ZNhTCcId6rNRmB2P1aC1Fwg0Xk
 lI7aiHxFLRBFBeiCuL3vdkl8miKVbUgeWAD17Gc3szlC+KWWLPKv0m8jYVCbghO15Ao0LWR6W
 9CVckF+WeUcNnsnchp2aOUmG8GgTIIghKe3V7T6XcrFJCve53aqDyqEFiFlQDBOgGawtqk+ED
 VlAvDJO60jyiqj7LNC2CjNohfESizBlrzaq5t58DL3ZSRxXiyIOt/OhNmMtWoGosCEZWLX4LP
 Ucv/HCv5lUBkgTsSWNx4IiQtgU0+RBhrPym8Dgbe6fTu8kSjUfzsEymRcDx7yZ2fwjFG5Qo/p
 obilnnGUwrlf+z/8OS9m1llSvlGjyEpBAup89jKnlcAN0H7hHIsmbLe6CkyK2E3Ny6AWU+LE5
 Y6JkqjJJJ38PDvnQmHopwlgoY9DOHfZlkgXN1O/IO3sgPj+SVfTPNLFP8BDwS0IxyLKUQ5d9l
 Bi7TVQGYz9E353JOif9jl/6HqQGMN6/aU3Jl3TTK0AlJ40Cz7PqL0A0un+uaP5hb8cAVbiz4N
 mDpxmEcTmpw84qtPwI05Ny3ZCwjwyiheCojd7YbhjJ2Bpzzw/OvQzqza4mkguefutyRt+Fq27
 PnPdv8eG/WoKo4r3CYK0yS43jT+JV0v2ZN8ouXMnzkjtgIzsOYey4kzjsZjPiX4C2/ZCKvW/Q
 VOrfYBk//EP1VJencDg8ScVXFaJ+ECjxppcRqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/video/Kconfig           |   5 +-
 drivers/video/backlight/Kconfig |  28 ++++-----
 drivers/video/console/Kconfig   | 135 ++++++++++++++++++++--------------------
 3 files changed, 83 insertions(+), 85 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 83d3d27..baefce6 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -25,8 +25,8 @@ endmenu
 source "drivers/video/backlight/Kconfig"
 
 config VGASTATE
-       tristate
-       default n
+	tristate
+	default n
 
 config VIDEOMODE_HELPERS
 	bool
@@ -45,5 +45,4 @@ if FB || SGI_NEWPORT_CONSOLE
 
 endif
 
-
 endmenu
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 71ee978..06302e5 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -14,7 +14,7 @@ if BACKLIGHT_LCD_SUPPORT
 # LCD
 #
 config LCD_CLASS_DEVICE
-        tristate "Lowlevel LCD controls"
+	tristate "Lowlevel LCD controls"
 	default m
 	help
 	  This framework adds support for low-level control of LCD.
@@ -134,12 +134,12 @@ config LCD_HX8357
 	  If you have a HX-8357 LCD panel, say Y to enable its LCD control
 	  driver.
 
-  config LCD_OTM3225A
-  	tristate "ORISE Technology OTM3225A support"
-  	depends on SPI
-  	help
-  	  If you have a panel based on the OTM3225A controller
-  	  chip then say y to include a driver for it.
+config LCD_OTM3225A
+	tristate "ORISE Technology OTM3225A support"
+	depends on SPI
+	help
+	  If you have a panel based on the OTM3225A controller
+	  chip then say y to include a driver for it.
 
 endif # LCD_CLASS_DEVICE
 
@@ -147,11 +147,11 @@ endif # LCD_CLASS_DEVICE
 # Backlight
 #
 config BACKLIGHT_CLASS_DEVICE
-        tristate "Lowlevel Backlight controls"
+	tristate "Lowlevel Backlight controls"
 	default m
 	help
 	  This framework adds support for low-level control of the LCD
-          backlight. This includes support for brightness and power.
+	  backlight. This includes support for brightness and power.
 
 	  To have support for your specific LCD panel you will have to
 	  select the proper drivers which depend on this option.
@@ -277,11 +277,11 @@ config BACKLIGHT_MAX8925
 	  WLED output, say Y here to enable this driver.
 
 config BACKLIGHT_APPLE
-       tristate "Apple Backlight Driver"
-       depends on X86 && ACPI
-       help
-         If you have an Intel-based Apple say Y to enable a driver for its
-	 backlight.
+	tristate "Apple Backlight Driver"
+	depends on X86 && ACPI
+	help
+	  If you have an Intel-based Apple say Y to enable a driver for its
+	  backlight.
 
 config BACKLIGHT_TOSA
 	tristate "Sharp SL-6000 Backlight Driver"
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 787792c..762d76f 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -22,26 +22,26 @@ config VGA_CONSOLE
 	  Say Y.
 
 config VGACON_SOFT_SCROLLBACK
-       bool "Enable Scrollback Buffer in System RAM"
-       depends on VGA_CONSOLE
-       default n
-       help
-         The scrollback buffer of the standard VGA console is located in
-	 the VGA RAM.  The size of this RAM is fixed and is quite small.
-	 If you require a larger scrollback buffer, this can be placed in
-	 System RAM which is dynamically allocated during initialization.
-	 Placing the scrollback buffer in System RAM will slightly slow
-	 down the console.
-
-	 If you want this feature, say 'Y' here and enter the amount of
-	 RAM to allocate for this buffer.  If unsure, say 'N'.
+	bool "Enable Scrollback Buffer in System RAM"
+	depends on VGA_CONSOLE
+	default n
+	help
+	  The scrollback buffer of the standard VGA console is located in
+	  the VGA RAM.  The size of this RAM is fixed and is quite small.
+	  If you require a larger scrollback buffer, this can be placed in
+	  System RAM which is dynamically allocated during initialization.
+	  Placing the scrollback buffer in System RAM will slightly slow
+	  down the console.
+
+	  If you want this feature, say 'Y' here and enter the amount of
+	  RAM to allocate for this buffer.  If unsure, say 'N'.
 
 config VGACON_SOFT_SCROLLBACK_SIZE
-       int "Scrollback Buffer Size (in KB)"
-       depends on VGACON_SOFT_SCROLLBACK
-       range 1 1024
-       default "64"
-       help
+	int "Scrollback Buffer Size (in KB)"
+	depends on VGACON_SOFT_SCROLLBACK
+	range 1 1024
+	default "64"
+	help
 	  Enter the amount of System RAM to allocate for scrollback
 	  buffers of VGA consoles. Each 64KB will give you approximately
 	  16 80x25 screenfuls of scrollback buffer.
@@ -83,37 +83,37 @@ config MDA_CONSOLE
 	  If unsure, say N.
 
 config SGI_NEWPORT_CONSOLE
-        tristate "SGI Newport Console support"
+	tristate "SGI Newport Console support"
 	depends on SGI_IP22 && HAS_IOMEM
-        select FONT_SUPPORT
-        help
-          Say Y here if you want the console on the Newport aka XL graphics
-          card of your Indy.  Most people say Y here.
+	select FONT_SUPPORT
+	help
+	  Say Y here if you want the console on the Newport aka XL graphics
+	  card of your Indy.  Most people say Y here.
 
 config DUMMY_CONSOLE
 	bool
-	depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y 
+	depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y
 	default y
 
 config DUMMY_CONSOLE_COLUMNS
-        int "Initial number of console screen columns"
-        depends on DUMMY_CONSOLE && !ARM
-        default 160 if PARISC
-        default 80
-        help
-          On PA-RISC, the default value is 160, which should fit a 1280x1024
-          monitor.
-          Select 80 if you use a 640x480 resolution by default.
+	int "Initial number of console screen columns"
+	depends on DUMMY_CONSOLE && !ARM
+	default 160 if PARISC
+	default 80
+	help
+	  On PA-RISC, the default value is 160, which should fit a 1280x1024
+	  monitor.
+	  Select 80 if you use a 640x480 resolution by default.
 
 config DUMMY_CONSOLE_ROWS
-        int "Initial number of console screen rows"
-        depends on DUMMY_CONSOLE && !ARM
-        default 64 if PARISC
-        default 25
-        help
-          On PA-RISC, the default value is 64, which should fit a 1280x1024
-          monitor.
-          Select 25 if you use a 640x480 resolution by default.
+	int "Initial number of console screen rows"
+	depends on DUMMY_CONSOLE && !ARM
+	default 64 if PARISC
+	default 25
+	help
+	  On PA-RISC, the default value is 64, which should fit a 1280x1024
+	  monitor.
+	  Select 25 if you use a 640x480 resolution by default.
 
 config FRAMEBUFFER_CONSOLE
 	bool "Framebuffer Console support"
@@ -125,30 +125,30 @@ config FRAMEBUFFER_CONSOLE
 	  Low-level framebuffer-based console driver.
 
 config FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
-       bool "Map the console to the primary display device"
-       depends on FRAMEBUFFER_CONSOLE
-       default n
-       ---help---
-         If this option is selected, the framebuffer console will
-         automatically select the primary display device (if the architecture
-	 supports this feature).  Otherwise, the framebuffer console will
-         always select the first framebuffer driver that is loaded. The latter
-         is the default behavior.
+	bool "Map the console to the primary display device"
+	depends on FRAMEBUFFER_CONSOLE
+	default n
+	---help---
+	  If this option is selected, the framebuffer console will
+	  automatically select the primary display device (if the architecture
+	  supports this feature).  Otherwise, the framebuffer console will
+	  always select the first framebuffer driver that is loaded. The latter
+	  is the default behavior.
 
-	 You can always override the automatic selection of the primary device
-	 by using the fbcon=map: boot option.
+	  You can always override the automatic selection of the primary device
+	  by using the fbcon=map: boot option.
 
-	 If unsure, select n.
+	  If unsure, select n.
 
 config FRAMEBUFFER_CONSOLE_ROTATION
-       bool "Framebuffer Console Rotation"
-       depends on FRAMEBUFFER_CONSOLE
-       help
-         Enable display rotation for the framebuffer console.  This is done
-         in software and may be significantly slower than a normally oriented
-         display.  Note that the rotation is done at the console level only
-         such that other users of the framebuffer will remain normally
-         oriented.
+	bool "Framebuffer Console Rotation"
+	depends on FRAMEBUFFER_CONSOLE
+	help
+	  Enable display rotation for the framebuffer console.  This is done
+	  in software and may be significantly slower than a normally oriented
+	  display.  Note that the rotation is done at the console level only
+	  such that other users of the framebuffer will remain normally
+	  oriented.
 
 config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	bool "Framebuffer Console Deferred Takeover"
@@ -162,14 +162,13 @@ config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	  black screen as soon as fbcon loads.
 
 config STI_CONSOLE
-        bool "STI text console"
+	bool "STI text console"
 	depends on PARISC && HAS_IOMEM
-        select FONT_SUPPORT
-        default y
-        help
-          The STI console is the builtin display/keyboard on HP-PARISC
-          machines.  Say Y here to build support for it into your kernel.
-          The alternative is to use your primary serial port as a console.
+	select FONT_SUPPORT
+	default y
+	help
+	  The STI console is the builtin display/keyboard on HP-PARISC
+	  machines.  Say Y here to build support for it into your kernel.
+	  The alternative is to use your primary serial port as a console.
 
 endmenu
-
-- 
1.9.1

