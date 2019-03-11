Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC69C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5549206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfCKN02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:28 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hMt-1h81o92SqP-004iuQ for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 068/114] drivers: mfd: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:20 +0100
Message-Id: <1552310346-7629-69-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:igAfWZUYWDC6ZluDIuCr4aBw/rCo7VquVLlfze5yJAa1mMUGED9
 6TI3Np61fccDHynBWoj9qAadP5N0VX7XHG5EMW36CdakI7D9riRskHUmJUJNtITxm+hrP8K
 MdM+yMs6n8PxXTh78VJZ+j3AJvZZGEiaeUIoN/VvwA6KZQ6WKwpdGhreIHF3HWDXYY/hZld
 cFBGokfjTqqbBNMEkaG/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1yze1H0taeo=:vmVDXJRajEJdwQB5iL4pYE
 x+2JIpurF9RvIHU1ccEfhLQgEtfqTI36I1c3rfsFugXci/6vjCqXXt7OaNpsHTjzA8oXGN2kc
 YNLMe2jDPVq1sqb44ZMl48F+DYuOWk09lqiHgU9TvKmggVVZtqIXH0PwwBwav1JfCNOwmb4eB
 FUeT0bHbB4Z9c33fNBIyR7vbXYD9TRofGP+HqZi+wQJqCr6AWaRjFPxie/3zNQKMvGLnLnMwy
 W1igm/VBNKJ0h1mdoFHHx5mun//iMzCY0Z3FvocvG2dToMUd+DoixCa73i/TfPwf9TaxezBDB
 Z37zZwWuyki0/lNVbdv31nrIZSmoll4wPuJ1cGDXgAb/z/Nkfxi9T1icYUqXOpS1kSHtrgp5m
 /I7C1qasxrhIeymdbcC5Qn4fuLh571HBUde4DuM84S3/s+4ofi2tYQu577E49PG1pqPo+1iTe
 idpsrDkL/grGgOqHr3nF1gbaXmjw1AZeNOpftN5z/4XAuQ+hvpaT2gPdxmnzWXslh95X89f53
 eaJTkQMdKOF0pnYNHaljj1BCNK4iKTnhXxgzVmCeI63TS4TUe8VcbZ6/SMs/n3yf8KD/7SbXv
 fDUyT7rjjm0LjeCR7yfAZQnf8ZEbQQcGEyhEdvvLLNSwa9f5xo1Pjt5FO2BzG52vVGGdM5vOr
 Kxow8OU7AWjD0AkVC/xZk5jzObzg/q7JKFlNxPHvUVmBJosuoLen+fdEWdYKeKplYxfhhKChz
 9ChPWR4BJiHDXhjRosI4QaebdUQsRO+SU2/hqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/mfd/Kconfig | 62 ++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0ce2d8d..3443f1a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -16,7 +16,7 @@ config MFD_CS5535
 	depends on PCI && (X86_32 || (X86 && COMPILE_TEST))
 	---help---
 	  This is the core driver for CS5535/CS5536 MFD functions.  This is
-          necessary for using the board's GPIO and MFGPT functionality.
+	  necessary for using the board's GPIO and MFGPT functionality.
 
 config MFD_ALTERA_A10SR
 	bool "Altera Arria10 DevKit System Resource chip"
@@ -213,13 +213,13 @@ config MFD_CROS_EC
 	  protocol for talking to the EC is defined by the bus driver.
 
 config MFD_CROS_EC_CHARDEV
-        tristate "Chrome OS Embedded Controller userspace device interface"
-        depends on MFD_CROS_EC
-        ---help---
-          This driver adds support to talk with the ChromeOS EC from userspace.
+	tristate "Chrome OS Embedded Controller userspace device interface"
+	depends on MFD_CROS_EC
+	---help---
+	  This driver adds support to talk with the ChromeOS EC from userspace.
 
-          If you have a supported Chromebook, choose Y or M here.
-          The module will be called cros_ec_dev.
+	  If you have a supported Chromebook, choose Y or M here.
+	  The module will be called cros_ec_dev.
 
 config MFD_MADERA
 	tristate "Cirrus Logic Madera codecs"
@@ -867,7 +867,7 @@ config MFD_CPCAP
 	  At least Motorola Droid 4 is known to use CPCAP.
 
 config MFD_VIPERBOARD
-        tristate "Nano River Technologies Viperboard"
+	tristate "Nano River Technologies Viperboard"
 	select MFD_CORE
 	depends on USB
 	default n
@@ -903,15 +903,15 @@ config PCF50633_ADC
 	tristate "NXP PCF50633 ADC"
 	depends on MFD_PCF50633
 	help
-	 Say yes here if you want to include support for ADC in the
-	 NXP PCF50633 chip.
+	  Say yes here if you want to include support for ADC in the
+	  NXP PCF50633 chip.
 
 config PCF50633_GPIO
 	tristate "NXP PCF50633 GPIO"
 	depends on MFD_PCF50633
 	help
-	 Say yes here if you want to include support GPIO for pins on
-	 the PCF50633 chip.
+	  Say yes here if you want to include support GPIO for pins on
+	  the PCF50633 chip.
 
 config UCB1400_CORE
 	tristate "Philips UCB1400 Core driver"
@@ -1026,7 +1026,7 @@ config MFD_RN5T618
 	select REGMAP_I2C
 	help
 	  Say yes here to add support for the Ricoh RN5T567,
-          RN5T618, RC5T619 PMIC.
+	  RN5T618, RC5T619 PMIC.
 	  This driver provides common support for accessing the device,
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
@@ -1079,9 +1079,9 @@ config MFD_SM501_GPIO
 	bool "Export GPIO via GPIO layer"
 	depends on MFD_SM501 && GPIOLIB
 	 ---help---
-	 This option uses the gpio library layer to export the 64 GPIO
-	 lines on the SM501. The platform data is used to supply the
-	 base number for the first GPIO line to register.
+	  This option uses the gpio library layer to export the 64 GPIO
+	  lines on the SM501. The platform data is used to supply the
+	  base number for the first GPIO line to register.
 
 config MFD_SKY81452
 	tristate "Skyworks Solutions SKY81452"
@@ -1096,16 +1096,16 @@ config MFD_SKY81452
 	  will be called sky81452.
 
 config MFD_SMSC
-       bool "SMSC ECE1099 series chips"
-       depends on I2C=y
-       select MFD_CORE
-       select REGMAP_I2C
-       help
-        If you say yes here you get support for the
-        ece1099 chips from SMSC.
+	bool "SMSC ECE1099 series chips"
+	depends on I2C=y
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the
+	  ece1099 chips from SMSC.
 
-        To compile this driver as a module, choose M here: the
-        module will be called smsc.
+	  To compile this driver as a module, choose M here: the
+	  module will be called smsc.
 
 config MFD_SC27XX_PMIC
 	tristate "Spreadtrum SC27xx PMICs"
@@ -1171,12 +1171,12 @@ config AB8500_CORE
 	  This chip embeds various other multimedia funtionalities as well.
 
 config AB8500_DEBUG
-       bool "Enable debug info via debugfs"
-       depends on AB8500_GPADC && DEBUG_FS
-       default y if DEBUG_FS
-       help
-         Select this option if you want debug information using the debug
-         filesystem, debugfs.
+	bool "Enable debug info via debugfs"
+	depends on AB8500_GPADC && DEBUG_FS
+	default y if DEBUG_FS
+	help
+	  Select this option if you want debug information using the debug
+	  filesystem, debugfs.
 
 config AB8500_GPADC
 	bool "ST-Ericsson AB8500 GPADC driver"
-- 
1.9.1

