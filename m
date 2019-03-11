Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD103C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C072084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfCKNXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:23:22 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfCKNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:42 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDhpZ-1hAjUK0MBb-00AkVY for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 087/114] drivers: hwmon: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:39 +0100
Message-Id: <1552310346-7629-88-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/kuAPayLk6oiCPrHci4MJom7QapS+B9NdbhfxpYZZlPJiBylFz2
 fpCr56s5F9QTs8dUn8TIXBm+w8ao/qMh/ivwC5bea8aJe7FRfdkBWi5tdo0jLaY6kMbuSdg
 umXiil64APYci9u61ijrRjaLRAjJPSZjt9OEmwlCpHnXPnOSbOIDZgeIDw/EOuSQQWbuIA8
 LOihyKsWvh6DcxDsfwFdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1UrguBPYAKM=:qG7KysUVhRPgMMLk+0ihBe
 pCARrh3bmSgSWBV86RFPfjPWGOvNIHjTCa732qgLYwKg2zMZhD4rd5JdcJOWPAOLdQL9ikDaw
 OmZDS37J/ZBtkdKbbblstV+lyYQB896NG8e/RQongVKhgfAI/XLiHggXFoYkQBwFQS9Q0pe8U
 YUGb8JT1ctRHcjwJ48kmKA7Qp33bEmjJqjaFrb6M2BjvgpLLtf2LiW5F9xYLillEYZoGZtCTj
 NSqIaSo122pMN0cdCl8zrCvWxR9p6G3wh1tQK2mxyvuvdstCTFjJpiq9zEf20DuCpVirhm2t/
 5h/lOrOj+qWiPAMIifVEd/BnsUZOyGZItrsRIvLRwVkG3HgI1FLVc8v+ENO2BCVprLtChGCkr
 rGmcp5Hg9u7wuu5SSc+HP8dHnIUwam+dDTQyOHl9qUHhfxG86WQA4dWDD+Y6vYXXjwHyAsZm6
 8HTzJ+blci66SpJlXUzPOkuShlPbbB1ztmSls66DsQVPJTewj9wzH9qu4+PYrv7vum1xrA1nG
 YUek+4VgmKO+y29zWOADkxoBb8ceiV67xlTmhW1qPyvDrFm0gjXRfzdFrxvakhKyp+AjVNhsu
 +pjqw0hOTaF3ixFGqMYVlYLSxZ/1iucm2u/MELfww+lQzr80R+6ucpeuXs9Nx2h+XKcPiRqoe
 xvKJedDS6/y5qC9H0LWQgxvDMXuRkNJSnE+msszOlYtIi5bBzn2zddjbbenQyFTOWB50n7XSG
 +gowVEQp/SA2Fb9aTEMAWIAs0n2cCFswg8pSww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/hwmon/Kconfig     | 40 ++++++++++++++++++++--------------------
 drivers/hwmon/occ/Kconfig | 20 ++++++++++----------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6f929bf..0ea07fe 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -484,10 +484,10 @@ config SENSORS_F75375S
 	  will be called f75375s.
 
 config SENSORS_MC13783_ADC
-        tristate "Freescale MC13783/MC13892 ADC"
-        depends on MFD_MC13XXX
-        help
-          Support for the A/D converter on MC13783 and MC13892 PMIC.
+	tristate "Freescale MC13783/MC13892 ADC"
+	depends on MFD_MC13XXX
+	help
+	  Support for the A/D converter on MC13783 and MC13892 PMIC.
 
 config SENSORS_FSCHMD
 	tristate "Fujitsu Siemens Computers sensor chips"
@@ -1027,18 +1027,18 @@ config SENSORS_LM75
 	  If you say yes here you get support for one common type of
 	  temperature sensor chip, with models including:
 
-		- Analog Devices ADT75
-		- Dallas Semiconductor DS75, DS1775 and DS7505
-		- Global Mixed-mode Technology (GMT) G751
-		- Maxim MAX6625 and MAX6626
-		- Microchip MCP980x
-		- National Semiconductor LM75, LM75A
-		- NXP's LM75A
-		- ST Microelectronics STDS75
-		- ST Microelectronics STLM75
-		- TelCom (now Microchip) TCN75
-		- Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75,
-		  TMP175, TMP275
+	        - Analog Devices ADT75
+	        - Dallas Semiconductor DS75, DS1775 and DS7505
+	        - Global Mixed-mode Technology (GMT) G751
+	        - Maxim MAX6625 and MAX6626
+	        - Microchip MCP980x
+	        - National Semiconductor LM75, LM75A
+	        - NXP's LM75A
+	        - ST Microelectronics STDS75
+	        - ST Microelectronics STLM75
+	        - TelCom (now Microchip) TCN75
+	        - Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75,
+	          TMP175, TMP275
 
 	  This driver supports driver model based binding through board
 	  specific I2C device tables.
@@ -1275,10 +1275,10 @@ config SENSORS_NPCM7XX
 	imply THERMAL
 	help
 	  This driver provides support for Nuvoton NPCM750/730/715/705 PWM
-          and Fan controllers.
+	  and Fan controllers.
 
-          This driver can also be built as a module. If so, the module
-          will be called npcm750-pwm-fan.
+	  This driver can also be built as a module. If so, the module
+	  will be called npcm750-pwm-fan.
 
 config SENSORS_NSA320
 	tristate "ZyXEL NSA320 and compatible fan speed and temperature sensors"
@@ -1591,7 +1591,7 @@ config SENSORS_ADS7871
 
 config SENSORS_AMC6821
 	tristate "Texas Instruments AMC6821"
-	depends on I2C 
+	depends on I2C
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  AMC6821 hardware monitoring chips.
diff --git a/drivers/hwmon/occ/Kconfig b/drivers/hwmon/occ/Kconfig
index 6668662..82f32c0 100644
--- a/drivers/hwmon/occ/Kconfig
+++ b/drivers/hwmon/occ/Kconfig
@@ -7,24 +7,24 @@ config SENSORS_OCC_P8_I2C
 	depends on I2C
 	select SENSORS_OCC
 	help
-	 This option enables support for monitoring sensors provided by the
-	 On-Chip Controller (OCC) on a POWER8 processor. Communications with
-	 the OCC are established through I2C bus.
+	  This option enables support for monitoring sensors provided by the
+	  On-Chip Controller (OCC) on a POWER8 processor. Communications with
+	  the OCC are established through I2C bus.
 
-	 This driver can also be built as a module. If so, the module will be
-	 called occ-p8-hwmon.
+	  This driver can also be built as a module. If so, the module will be
+	  called occ-p8-hwmon.
 
 config SENSORS_OCC_P9_SBE
 	tristate "POWER9 OCC through SBE"
 	depends on FSI_OCC
 	select SENSORS_OCC
 	help
-	 This option enables support for monitoring sensors provided by the
-	 On-Chip Controller (OCC) on a POWER9 processor. Communications with
-	 the OCC are established through SBE fifo on an FSI bus.
+	  This option enables support for monitoring sensors provided by the
+	  On-Chip Controller (OCC) on a POWER9 processor. Communications with
+	  the OCC are established through SBE fifo on an FSI bus.
 
-	 This driver can also be built as a module. If so, the module will be
-	 called occ-p9-hwmon.
+	  This driver can also be built as a module. If so, the module will be
+	  called occ-p9-hwmon.
 
 config SENSORS_OCC
 	bool "POWER On-Chip Controller"
-- 
1.9.1

