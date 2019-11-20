Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D11C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AB622529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257127;
	bh=gHBm8yONn1xiZsHJ3LmRceNT0Sg02G5dhIjLRvp7MX4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Sf25CjpKVGUdmrIVajoVGfrS6Rdayf8AULE3miP6opV2Ouc4Cge9tM/wPG9cKS3Cg
	 G0o+7IWHtj88qlumAuHttS/e7n4Z85vo1g+pSBTPTbNErW/osY6j9/2teeAUfw3k+b
	 gEUbA0HrnSXL7fWWiEZv4JEi7A+tUseUsA8xuF6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfKTNiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbfKTNio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:44 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCE7224D2;
        Wed, 20 Nov 2019 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257122;
        bh=gHBm8yONn1xiZsHJ3LmRceNT0Sg02G5dhIjLRvp7MX4=;
        h=From:To:Cc:Subject:Date:From;
        b=KkWkvNsJxAhY8BOgu1SQ8uzFIuYkOHbxafMdh/XSigEsySA2qB59O2FL2zErZ417/
         CCRxZ0HI54uU8JZtxjcVHrW7VG2KOsQEcmCV2Ii18cK67AZgpxhyw19qC7KpUZuBS8
         DVBLsxenogZI+xUp9gADgvG4daxtJkZWtj5VyjZo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] video: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:38 +0800
Message-Id: <20191120133838.13132-1-krzk@kernel.org>
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
 drivers/video/backlight/Kconfig |  8 ++--
 drivers/video/console/Kconfig   | 76 ++++++++++++++++-----------------
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 403707a3e503..95e2000c1491 100644
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
@@ -272,7 +272,7 @@ config BACKLIGHT_APPLE
        tristate "Apple Backlight Driver"
        depends on X86 && ACPI
        help
-         If you have an Intel-based Apple say Y to enable a driver for its
+	 If you have an Intel-based Apple say Y to enable a driver for its
 	 backlight.
 
 config BACKLIGHT_TOSA
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index c10e17fb9a9a..ac3a28c08f78 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -27,7 +27,7 @@ config VGACON_SOFT_SCROLLBACK
        depends on VGA_CONSOLE
        default n
        help
-         The scrollback buffer of the standard VGA console is located in
+	 The scrollback buffer of the standard VGA console is located in
 	 the VGA RAM.  The size of this RAM is fixed and is quite small.
 	 If you require a larger scrollback buffer, this can be placed in
 	 System RAM which is dynamically allocated during initialization.
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
@@ -130,11 +130,11 @@ config FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
        depends on FRAMEBUFFER_CONSOLE
        default n
        ---help---
-         If this option is selected, the framebuffer console will
-         automatically select the primary display device (if the architecture
+	 If this option is selected, the framebuffer console will
+	 automatically select the primary display device (if the architecture
 	 supports this feature).  Otherwise, the framebuffer console will
-         always select the first framebuffer driver that is loaded. The latter
-         is the default behavior.
+	 always select the first framebuffer driver that is loaded. The latter
+	 is the default behavior.
 
 	 You can always override the automatic selection of the primary device
 	 by using the fbcon=map: boot option.
@@ -145,11 +145,11 @@ config FRAMEBUFFER_CONSOLE_ROTATION
        bool "Framebuffer Console Rotation"
        depends on FRAMEBUFFER_CONSOLE
        help
-         Enable display rotation for the framebuffer console.  This is done
-         in software and may be significantly slower than a normally oriented
-         display.  Note that the rotation is done at the console level only
-         such that other users of the framebuffer will remain normally
-         oriented.
+	 Enable display rotation for the framebuffer console.  This is done
+	 in software and may be significantly slower than a normally oriented
+	 display.  Note that the rotation is done at the console level only
+	 such that other users of the framebuffer will remain normally
+	 oriented.
 
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
2.17.1

