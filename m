Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB30C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF40208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306411;
	bh=s+QsmEgOr+csgbZHAoMXoQmPkbsck6p+PUk6xQi1T0A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mdCvQ6RWmyEln9J/tESzXIDz8oA0WAJOiZYkDepZoktIAiPHSPoMcCrHDH+hHgMIb
	 ZvDt/kK5ETsw3KftSwd3veFvm5yFidJuIzT19cZZVsPyaT+PsBgOE8r130+ZGZILf2
	 /cpwMn/Wi15giVBMVxvYtCUzDPN3inWxcwsn4q08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKUDUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfKUDUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:09 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FBD208A1;
        Thu, 21 Nov 2019 03:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306407;
        bh=s+QsmEgOr+csgbZHAoMXoQmPkbsck6p+PUk6xQi1T0A=;
        h=From:To:Cc:Subject:Date:From;
        b=xJXXIvNjN6nqSRBR1adxravinmdoqkmSvF5AI7c675Oe/mKJW9eqfTiCsc533avx4
         IxMUyG+UkAaZMEs5NIT0e4YFz3z3i4yt41WsL1awN2G0FYYzwsnMOyplKpdfC7zy+T
         Cym9LMOqDa2mctFCb3XStmYhrnH8io+iDSANfjLs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2] video: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:03 +0100
Message-Id: <1574306404-17703-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/video/Kconfig           |   4 +-
 drivers/video/backlight/Kconfig |  16 ++---
 drivers/video/console/Kconfig   | 132 ++++++++++++++++++++--------------------
 3 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 427a993c7f57..74c2f39cec90 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -26,8 +26,8 @@ endmenu
 source "drivers/video/backlight/Kconfig"
 
 config VGASTATE
-       tristate
-       default n
+	tristate
+	default n
 
 config VIDEOMODE_HELPERS
 	bool
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 403707a3e503..e25fdd8ce3e7 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -9,7 +9,7 @@ menu "Backlight & LCD device support"
 # LCD
 #
 config LCD_CLASS_DEVICE
-        tristate "Lowlevel LCD controls"
+	tristate "Lowlevel LCD controls"
 	help
 	  This framework adds support for low-level control of LCD.
 	  Some framebuffer devices connect to platform-specific LCD modules
@@ -141,10 +141,10 @@ endif # LCD_CLASS_DEVICE
 # Backlight
 #
 config BACKLIGHT_CLASS_DEVICE
-        tristate "Lowlevel Backlight controls"
+	tristate "Lowlevel Backlight controls"
 	help
 	  This framework adds support for low-level control of the LCD
-          backlight. This includes support for brightness and power.
+	  backlight. This includes support for brightness and power.
 
 	  To have support for your specific LCD panel you will have to
 	  select the proper drivers which depend on this option.
@@ -269,11 +269,11 @@ config BACKLIGHT_MAX8925
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
index c10e17fb9a9a..ed8480d324b1 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -23,26 +23,26 @@ config VGA_CONSOLE
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
@@ -84,12 +84,12 @@ config MDA_CONSOLE
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
@@ -97,24 +97,24 @@ config DUMMY_CONSOLE
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
@@ -126,30 +126,30 @@ config FRAMEBUFFER_CONSOLE
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
@@ -163,14 +163,14 @@ config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
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
 
-- 
2.7.4

