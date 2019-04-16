Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE33C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2336A2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383612;
	bh=GODc89ijrpCaBOKqJ4frgvYYE8h8Ml1Adp/P4N5eOQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xzBSvKiuYTo9qwSC+KDngdO7jW0AY2mWGgIZWLl3kErJYSaupHGPhiSrTu7h8Jfuc
	 F41O1w5PasqnoyoFUfJlsB4b+10ruoqJ2HkJv6xw/PDNAauRi9V8g3kGx7Ryt+H08n
	 9osk5ieY8Im5XBSdXKK9yuU1N7fcf7hPN1lvkBEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfDPDAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:00:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfDPC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mVAr0l6RUJlSrojWvjxsu5uos/oGuj+XV3N9W44HcxY=; b=tdPr1qJ7kkXSZ6XSoTmbOgz63O
        rP6leWkR9UQIHKrkiFgeOixG7jzHIajHZJj11tj6cjDsABfvuLkLeCeHOzw2dGmpDq8A0groweIHv
        DMDL7QtvQqtTtl33PVvAhVTRrg2Z9sPSCUe5tdSo1i2ntVgNbEAjqKAAeYhfvt1cRkJekZq92ishw
        jwlg9xFyCQwQTez2jlZ356xf6n5ZewHVeiiNcj3BhoDYC+05eZzbgpcgmfwG7WnK035OAJ9TTvJnR
        nxetqnDa/BtBeNkfGPZQWy7HUZHicjPNDe6GmnGTh3//5PGbXt9aEJQqi17ddsTOPQCkMqKIujWdO
        T5rioCVA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007an-P7; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001pN-4G; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 44/57] docs: lp855x-driver.txt: convert to ReST and move to kernel-api
Date:   Mon, 15 Apr 2019 23:56:09 -0300
Message-Id: <fbb805364b5282a087bd632cbaaf14a35766a54d.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/backlight/lp855x-driver.txt | 65 ++++++++++++++---------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/Documentation/backlight/lp855x-driver.txt b/Documentation/backlight/lp855x-driver.txt
index 01bce243d3d7..1e0b224fc397 100644
--- a/Documentation/backlight/lp855x-driver.txt
+++ b/Documentation/backlight/lp855x-driver.txt
@@ -1,9 +1,11 @@
+====================
 Kernel driver lp855x
 ====================
 
 Backlight driver for LP855x ICs
 
 Supported chips:
+
 	Texas Instruments LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
 	LP8557
 
@@ -14,53 +16,66 @@ Description
 
 * Brightness control
 
-Brightness can be controlled by the pwm input or the i2c command.
-The lp855x driver supports both cases.
+  Brightness can be controlled by the pwm input or the i2c command.
+  The lp855x driver supports both cases.
 
 * Device attributes
 
-1) bl_ctl_mode
-Backlight control mode.
-Value : pwm based or register based
+  1) bl_ctl_mode
 
-2) chip_id
-The lp855x chip id.
-Value : lp8550/lp8551/lp8552/lp8553/lp8555/lp8556/lp8557
+  Backlight control mode.
+
+  Value: pwm based or register based
+
+  2) chip_id
+
+  The lp855x chip id.
+
+  Value: lp8550/lp8551/lp8552/lp8553/lp8555/lp8556/lp8557
 
 Platform data for lp855x
 ------------------------
 
 For supporting platform specific data, the lp855x platform data can be used.
 
-* name : Backlight driver name. If it is not defined, default name is set.
-* device_control : Value of DEVICE CONTROL register.
-* initial_brightness : Initial value of backlight brightness.
-* period_ns : Platform specific PWM period value. unit is nano.
-	     Only valid when brightness is pwm input mode.
-* size_program : Total size of lp855x_rom_data.
-* rom_data : List of new eeprom/eprom registers.
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
 
-example 1) lp8552 platform data : i2c register mode with new eeprom data
+Examples
+========
 
-#define EEPROM_A5_ADDR	0xA5
-#define EEPROM_A5_VAL	0x4f	/* EN_VSYNC=0 */
+1) lp8552 platform data: i2c register mode with new eeprom data::
 
-static struct lp855x_rom_data lp8552_eeprom_arr[] = {
+    #define EEPROM_A5_ADDR	0xA5
+    #define EEPROM_A5_VAL	0x4f	/* EN_VSYNC=0 */
+
+    static struct lp855x_rom_data lp8552_eeprom_arr[] = {
 	{EEPROM_A5_ADDR, EEPROM_A5_VAL},
-};
+    };
 
-static struct lp855x_platform_data lp8552_pdata = {
+    static struct lp855x_platform_data lp8552_pdata = {
 	.name = "lcd-bl",
 	.device_control = I2C_CONFIG(LP8552),
 	.initial_brightness = INITIAL_BRT,
 	.size_program = ARRAY_SIZE(lp8552_eeprom_arr),
 	.rom_data = lp8552_eeprom_arr,
-};
+    };
 
-example 2) lp8556 platform data : pwm input mode with default rom data
+2) lp8556 platform data: pwm input mode with default rom data::
 
-static struct lp855x_platform_data lp8556_pdata = {
+    static struct lp855x_platform_data lp8556_pdata = {
 	.device_control = PWM_CONFIG(LP8556),
 	.initial_brightness = INITIAL_BRT,
 	.period_ns = 1000000,
-};
+    };
-- 
2.20.1

