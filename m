Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E66C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7CF20857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfCKN0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:43 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43605 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfCKNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:37 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MpUQk-1giZPQ0xO0-00ppxP for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 065/114] drivers: regulator: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:17 +0100
Message-Id: <1552310346-7629-66-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:qAtbE6IJLnXFvlGxjoKhMa+nyxw2kXFcu7muRRrlpsxZqjXENqS
 sMl82HH8SE2oXVH4tRFBmgVAepydUD+a2emB1RWxgo+KHOQgfKsqeOoKjAKvW9LsCKist1H
 trwNYCs7JZU54ufDp58H+zrjwGm1MayZzEkMjtuVhTcBZaI6VUY4UvaAnoVTa6lEeSz/qIo
 HgdV8A2r+oZxOmZzPaxVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ApU7NnG4yjQ=:OitsxRSRcFy+51BjBK5g6A
 B656Nm3937cjrcEj7YP0SM+jsIeS2i3P7JIjDSGWKJ2brCWnu7a5dXLtdxGElsNTR6RKC8CK8
 3//ugvNMPAZFlfzf7uO9V4QO1TsJ+aLbWn389UhUk3AGeWojSJkaof0CaLjZMxUZUz8JITCRn
 cfX4g/1oEuWLQXhRhsXelcylwb5TF6RpjrjabfGbgZn4DYCXahcl1OopXSUeiEPT5O7zVvPZY
 n5pg+zOD7ZWVpFcAJ8H+yWn3encA37ylL7Ln0ywBvsuhp6XWnjM1DoNwyEGDTQ9tSQae4ZWeM
 A8pu3iSRG3QUF75wx7/Fh/LnCrl00zIGkcm0IZV70MhXTqc+4JB0re80q/SoDQ6VdwhxGgIz+
 JXDaNIwq0r5MyxZS6LQdc9WaBBQof+JKWOUSrgmtnW74kXDwxecDD1TLllszjlWEhlMgO4Nff
 bKzx9usfb10eQEOZtKbqjmRXLz5DSYZIVAcVG1Klb+4u014aL9RdbjmZmxFtEuGS6NgOlCdWA
 LW2IED09jtObHZB8VSikSS0qYjU7AMU9mW9X1hyeqwH/arZr3jRzGYGsBHtSNX+pDY2C0RTu2
 kb2YAZoyC0VkX+tvg0m/kPeG66pTx+o5ivMx8R43sJnsoENXLYukswJLR100JZk0/slLaAZli
 qMxhXXA1az8R6tb4OO428ADZ7hVwN76DKX9zOtCaFYaC2uYt30pMJOMmHRjqysmpIIil6nhay
 rEvYgfsqhVpDVnNGY0JWTVDuQPP8k8lIs9whdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/regulator/Kconfig | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b7f249e..43f92ed 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -123,9 +123,9 @@ config REGULATOR_AB3100
 	depends on AB3100_CORE
 	default y if AB3100_CORE
 	help
-	 These regulators correspond to functionality in the
-	 AB3100 analog baseband dealing with power regulators
-	 for the system.
+	  These regulators correspond to functionality in the
+	  AB3100 analog baseband dealing with power regulators
+	  for the system.
 
 config REGULATOR_AB8500
 	bool "ST-Ericsson AB8500 Power Regulators"
@@ -378,15 +378,15 @@ config REGULATOR_LP3971
 	tristate "National Semiconductors LP3971 PMIC regulator driver"
 	depends on I2C
 	help
-	 Say Y here to support the voltage regulators and convertors
-	 on National Semiconductors LP3971 PMIC
+	  Say Y here to support the voltage regulators and convertors
+	  on National Semiconductors LP3971 PMIC
 
 config REGULATOR_LP3972
 	tristate "National Semiconductors LP3972 PMIC regulator driver"
 	depends on I2C
 	help
-	 Say Y here to support the voltage regulators and convertors
-	 on National Semiconductors LP3972 PMIC
+	  Say Y here to support the voltage regulators and convertors
+	  on National Semiconductors LP3972 PMIC
 
 config REGULATOR_LP872X
 	tristate "TI/National Semiconductor LP8720/LP8725 voltage regulators"
@@ -649,24 +649,24 @@ config REGULATOR_PBIAS
 	tristate "PBIAS OMAP regulator driver"
 	depends on (ARCH_OMAP || COMPILE_TEST) && MFD_SYSCON
 	help
-	 Say y here to support pbias regulator for mmc1:SD card i/o
-	 on OMAP SoCs.
-	 This driver provides support for OMAP pbias modelled
-	 regulators.
+	  Say y here to support pbias regulator for mmc1:SD card i/o
+	  on OMAP SoCs.
+	  This driver provides support for OMAP pbias modelled
+	  regulators.
 
 config REGULATOR_PCAP
 	tristate "Motorola PCAP2 regulator driver"
 	depends on EZX_PCAP
 	help
-	 This driver provides support for the voltage regulators of the
-	 PCAP2 PMIC.
+	  This driver provides support for the voltage regulators of the
+	  PCAP2 PMIC.
 
 config REGULATOR_PCF50633
 	tristate "NXP PCF50633 regulator driver"
 	depends on MFD_PCF50633
 	help
-	 Say Y here to support the voltage regulators and converters
-	 on PCF50633
+	  Say Y here to support the voltage regulators and converters
+	  on PCF50633
 
 config REGULATOR_PFUZE100
 	tristate "Freescale PFUZE100/200/3000/3001 regulator driver"
@@ -789,25 +789,25 @@ config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
 	depends on MFD_SEC_CORE
 	help
-	 This driver controls Samsung S2MPA01 voltage output regulator
-	 via I2C bus. S2MPA01 has 10 Bucks and 26 LDO outputs.
+	  This driver controls Samsung S2MPA01 voltage output regulator
+	  via I2C bus. S2MPA01 has 10 Bucks and 26 LDO outputs.
 
 config REGULATOR_S2MPS11
 	tristate "Samsung S2MPS11/13/14/15/S2MPU02 voltage regulator"
 	depends on MFD_SEC_CORE
 	help
-	 This driver supports a Samsung S2MPS11/13/14/15/S2MPU02 voltage
-	 output regulator via I2C bus. The chip is comprised of high efficient
-	 Buck converters including Dual-Phase Buck converter, Buck-Boost
-	 converter, various LDOs.
+	  This driver supports a Samsung S2MPS11/13/14/15/S2MPU02 voltage
+	  output regulator via I2C bus. The chip is comprised of high efficient
+	  Buck converters including Dual-Phase Buck converter, Buck-Boost
+	  converter, various LDOs.
 
 config REGULATOR_S5M8767
 	tristate "Samsung S5M8767A voltage regulator"
 	depends on MFD_SEC_CORE
 	help
-	 This driver supports a Samsung S5M8767A voltage output regulator
-	 via I2C bus. S5M8767A have 9 Bucks and 28 LDOs output and
-	 supports DVS mode with 8bits of output voltage control.
+	  This driver supports a Samsung S5M8767A voltage output regulator
+	  via I2C bus. S5M8767A have 9 Bucks and 28 LDOs output and
+	  supports DVS mode with 8bits of output voltage control.
 
 config REGULATOR_SC2731
 	tristate "Spreadtrum SC2731 power regulator driver"
@@ -1058,4 +1058,3 @@ config REGULATOR_WM8994
 	  WM8994 CODEC.
 
 endif
-
-- 
1.9.1

