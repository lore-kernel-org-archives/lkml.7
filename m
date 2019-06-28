Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A86C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F31208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724657;
	bh=1g7vJEQ6/CF1SIJVgUII61Bp94b0UastyYbt0uqwe2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NfMU13Z7bmkSGa4aVF7N0A2b9QZKU9/CHlExeysMa4IFC/Yt0gV7nhKc9wsPJ+ggi
	 DYsg1+24wNpZZ44rqCXZ1859JznqykTB6S671/J+TLS1C5QJRK74+jTrCGkwp8Ev+O
	 PLgZREACbvuYbk7SeJpvTg/hqiiOCJw/f+K6s0dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfF1MUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:20:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1MUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HAJuKUiHQKt3MBmdA/4cWV4ejnsLzff3e+C0p/a7BJ0=; b=gkXKanWK1l9DBeskdMIprVWaaG
        qqiVgsTJIqZ0hTN6DlJiZkSIZ5z8w3UP5SnfwiZzSvdyhIbu0H6gLlM9y0gn58CDt6NOMrVtKISzM
        53vbCTWjpkFtbJ+Pr9AOCI+X4usod9Cv75mQjs9u+nRnVq/qn8utU9mUTWe4S6SY11s+m+Gb+rqyR
        /D+CLoYnvze6yoct9SyjefTEb2rOSexXUjn8NCY7AO/RLrcmHwO7pLwUWZj2QS7cVfnu/tJGcb948
        1KOt47G0crTZQ84zsXFSxiSNnkEMr/5h7hWcFRbFVMwJ7vWd5x31kEmUP6SFU387Eh2lDbptf2+1H
        3iQpQ8ig==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-00009v-37; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00057Q-8F; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 08/43] docs: lp855x-driver.txt: convert to ReST and move to kernel-api
Date:   Fri, 28 Jun 2019 09:20:04 -0300
Message-Id: <ec5d7a3a716474f2bc68e97ff1fbc32060c2c676.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small file seems to be an attempt to start documenting
backlight drivers.

It contains descriptions of the controls for the driver
with could sound as an somewhat user-faced description, but
it's main focus is to describe, instead, the data that should
be passed via platform data and some driver-specific stuff.

While this is not part of the driver-api book, mark it as
:orphan:, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/backlight/lp855x-driver.rst | 83 +++++++++++++++++++++++
 Documentation/backlight/lp855x-driver.txt | 66 ------------------
 MAINTAINERS                               |  2 +-
 3 files changed, 84 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/backlight/lp855x-driver.rst
 delete mode 100644 Documentation/backlight/lp855x-driver.txt

diff --git a/Documentation/backlight/lp855x-driver.rst b/Documentation/backlight/lp855x-driver.rst
new file mode 100644
index 000000000000..62b7ed847a77
--- /dev/null
+++ b/Documentation/backlight/lp855x-driver.rst
@@ -0,0 +1,83 @@
+:orphan:
+
+====================
+Kernel driver lp855x
+====================
+
+Backlight driver for LP855x ICs
+
+Supported chips:
+
+	Texas Instruments LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
+	LP8557
+
+Author: Milo(Woogyom) Kim <milo.kim@ti.com>
+
+Description
+-----------
+
+* Brightness control
+
+  Brightness can be controlled by the pwm input or the i2c command.
+  The lp855x driver supports both cases.
+
+* Device attributes
+
+  1) bl_ctl_mode
+
+  Backlight control mode.
+
+  Value: pwm based or register based
+
+  2) chip_id
+
+  The lp855x chip id.
+
+  Value: lp8550/lp8551/lp8552/lp8553/lp8555/lp8556/lp8557
+
+Platform data for lp855x
+------------------------
+
+For supporting platform specific data, the lp855x platform data can be used.
+
+* name:
+	Backlight driver name. If it is not defined, default name is set.
+* device_control:
+	Value of DEVICE CONTROL register.
+* initial_brightness:
+	Initial value of backlight brightness.
+* period_ns:
+	Platform specific PWM period value. unit is nano.
+	Only valid when brightness is pwm input mode.
+* size_program:
+	Total size of lp855x_rom_data.
+* rom_data:
+	List of new eeprom/eprom registers.
+
+Examples
+========
+
+1) lp8552 platform data: i2c register mode with new eeprom data::
+
+    #define EEPROM_A5_ADDR	0xA5
+    #define EEPROM_A5_VAL	0x4f	/* EN_VSYNC=0 */
+
+    static struct lp855x_rom_data lp8552_eeprom_arr[] = {
+	{EEPROM_A5_ADDR, EEPROM_A5_VAL},
+    };
+
+    static struct lp855x_platform_data lp8552_pdata = {
+	.name = "lcd-bl",
+	.device_control = I2C_CONFIG(LP8552),
+	.initial_brightness = INITIAL_BRT,
+	.size_program = ARRAY_SIZE(lp8552_eeprom_arr),
+	.rom_data = lp8552_eeprom_arr,
+    };
+
+2) lp8556 platform data: pwm input mode with default rom data::
+
+    static struct lp855x_platform_data lp8556_pdata = {
+	.device_control = PWM_CONFIG(LP8556),
+	.initial_brightness = INITIAL_BRT,
+	.period_ns = 1000000,
+    };
diff --git a/Documentation/backlight/lp855x-driver.txt b/Documentation/backlight/lp855x-driver.txt
deleted file mode 100644
index 01bce243d3d7..000000000000
--- a/Documentation/backlight/lp855x-driver.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Kernel driver lp855x
-====================
-
-Backlight driver for LP855x ICs
-
-Supported chips:
-	Texas Instruments LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
-	LP8557
-
-Author: Milo(Woogyom) Kim <milo.kim@ti.com>
-
-Description
------------
-
-* Brightness control
-
-Brightness can be controlled by the pwm input or the i2c command.
-The lp855x driver supports both cases.
-
-* Device attributes
-
-1) bl_ctl_mode
-Backlight control mode.
-Value : pwm based or register based
-
-2) chip_id
-The lp855x chip id.
-Value : lp8550/lp8551/lp8552/lp8553/lp8555/lp8556/lp8557
-
-Platform data for lp855x
-------------------------
-
-For supporting platform specific data, the lp855x platform data can be used.
-
-* name : Backlight driver name. If it is not defined, default name is set.
-* device_control : Value of DEVICE CONTROL register.
-* initial_brightness : Initial value of backlight brightness.
-* period_ns : Platform specific PWM period value. unit is nano.
-	     Only valid when brightness is pwm input mode.
-* size_program : Total size of lp855x_rom_data.
-* rom_data : List of new eeprom/eprom registers.
-
-example 1) lp8552 platform data : i2c register mode with new eeprom data
-
-#define EEPROM_A5_ADDR	0xA5
-#define EEPROM_A5_VAL	0x4f	/* EN_VSYNC=0 */
-
-static struct lp855x_rom_data lp8552_eeprom_arr[] = {
-	{EEPROM_A5_ADDR, EEPROM_A5_VAL},
-};
-
-static struct lp855x_platform_data lp8552_pdata = {
-	.name = "lcd-bl",
-	.device_control = I2C_CONFIG(LP8552),
-	.initial_brightness = INITIAL_BRT,
-	.size_program = ARRAY_SIZE(lp8552_eeprom_arr),
-	.rom_data = lp8552_eeprom_arr,
-};
-
-example 2) lp8556 platform data : pwm input mode with default rom data
-
-static struct lp855x_platform_data lp8556_pdata = {
-	.device_control = PWM_CONFIG(LP8556),
-	.initial_brightness = INITIAL_BRT,
-	.period_ns = 1000000,
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1606f6cac24d..e909436a2fa3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15906,7 +15906,7 @@ F:	sound/soc/codecs/isabelle*
 TI LP855x BACKLIGHT DRIVER
 M:	Milo Kim <milo.kim@ti.com>
 S:	Maintained
-F:	Documentation/backlight/lp855x-driver.txt
+F:	Documentation/backlight/lp855x-driver.rst
 F:	drivers/video/backlight/lp855x_bl.c
 F:	include/linux/platform_data/lp855x.h
 
-- 
2.21.0

