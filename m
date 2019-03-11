Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3846C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB4220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfCKNVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:21:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfCKNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:44 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPooP-1hP0hB22xH-00MwHY for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:42 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 112/114] drivers: misc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:19:04 +0100
Message-Id: <1552310346-7629-113-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:TiZV94vPlncTFQ0XFXHl46uWsgOeV5uIb8kQzE+lX0WRZOzL0fy
 OrP0cqPQfahT8FHFUSajGyVKO46pemkTQG4JK410iiOdIhdupdrhWk5uzEqLHEenRE+/5OA
 9SMbg/GuDpMbA0qVdYICTghe3NqE+pokrzoUjIYtDLt0LhmzuXpc5R8CBK/DtGzXAs/sKdn
 0cV0bD5xkHJlI87A6f3UQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7b1o7vkQVg=:r/Tzd7idP9MdbyfydHTcht
 CmLvK1zpwAxa6qY/99/re8SAWJXndM4dq+ZvaZtp04ePrANIRliSVeYrvOGCZwXis1Q7hC/Yv
 j1wKMrvHtj3Fden+ZRirp4uShFrOtIZs+6c4wEhbWrWPpOV0y4Oyn7OF1zL/bI7CEptp5g8+y
 bPwDKsYNNB48xd0lV1W7GTThtmRl4+h4x1kJyA66vFPIRJmsUDKi8tD6hFVdLUOpJALhjgwJv
 oBhK/ajlYyQ/dQMM4Rxm/OeffwIGQ+XUK/sZSKoFChNZEngBG7Fi8RNUivgaWGbwVuFxEsgpa
 7pLb8fzBMVg2LDCeVlPbKRFEQJ8JXkTplbjbqWp076vpUoWqwKGz3MnziXOzO6AeYF9yztYVk
 QnobJignuMAw21ehxGbLAA2YphIdrh/5G0fb4TFvrtBhabusdZhjlWzDG4GJDx+35iCptK0b+
 ZfQjIHU4cZ7TS+UnFuBXTbnw+/Nmb33/fOGBO6lLKA0DagWc2C/P31DvbYplFHf20tz9dmDNh
 ess5pjKnz5ImA1PumaSZIi4R+3re5eQE+2fmDzn6N8ZvWV3biW7AewtFDvY3sJWin84wLWF4b
 yITGeP5dK9srFeaZFxs/yPh26Wx4LRIO+5y7dm4dtl9X/hyv+cEer3Y0NZPHw7k+bN0SGZb2N
 KBhoSL2s76K6uS/37eGCFfNK+lb5U3ZZAOjEWlAlgSzbKuAzfBQrSLf+ozfZPFFC1AyJZNlZ6
 Kv0MBKyvhcDNvn4xTYEOtbzMYtIKl2uhusRBRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/misc/Kconfig | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec..4cc60aa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -370,25 +370,25 @@ config SENSORS_TSL2550
 	  will be called tsl2550.
 
 config SENSORS_BH1770
-         tristate "BH1770GLC / SFH7770 combined ALS - Proximity sensor"
-         depends on I2C
-         ---help---
-           Say Y here if you want to build a driver for BH1770GLC (ROHM) or
-	   SFH7770 (Osram) combined ambient light and proximity sensor chip.
+	tristate "BH1770GLC / SFH7770 combined ALS - Proximity sensor"
+	depends on I2C
+	---help---
+	  Say Y here if you want to build a driver for BH1770GLC (ROHM) or
+	  SFH7770 (Osram) combined ambient light and proximity sensor chip.
 
-           To compile this driver as a module, choose M here: the
-           module will be called bh1770glc. If unsure, say N here.
+	  To compile this driver as a module, choose M here: the
+	  module will be called bh1770glc. If unsure, say N here.
 
 config SENSORS_APDS990X
-	 tristate "APDS990X combined als and proximity sensors"
-	 depends on I2C
-	 default n
-	 ---help---
-	   Say Y here if you want to build a driver for Avago APDS990x
-	   combined ambient light and proximity sensor chip.
+	tristate "APDS990X combined als and proximity sensors"
+	depends on I2C
+	default n
+	---help---
+	  Say Y here if you want to build a driver for Avago APDS990x
+	  combined ambient light and proximity sensor chip.
 
-	   To compile this driver as a module, choose M here: the
-	   module will be called apds990x. If unsure, say N here.
+	  To compile this driver as a module, choose M here: the
+	  module will be called apds990x. If unsure, say N here.
 
 config HMC6352
 	tristate "Honeywell HMC6352 compass"
@@ -412,10 +412,10 @@ config SPEAR13XX_PCIE_GADGET
 	depends on ARCH_SPEAR13XX && BROKEN
 	default n
 	help
-	 This option enables gadget support for PCIe controller. If
-	 board file defines any controller as PCIe endpoint then a sysfs
-	 entry will be created for that controller. User can use these
-	 sysfs node to configure PCIe EP as per his requirements.
+	  This option enables gadget support for PCIe controller. If
+	  board file defines any controller as PCIe endpoint then a sysfs
+	  entry will be created for that controller. User can use these
+	  sysfs node to configure PCIe EP as per his requirements.
 
 config VMWARE_BALLOON
 	tristate "VMware Balloon Driver"
@@ -467,7 +467,7 @@ config LATTICE_ECP3_CONFIG
 	tristate "Lattice ECP3 FPGA bitstream configuration via SPI"
 	depends on SPI && SYSFS
 	select FW_LOADER
-	default	n
+	default n
 	help
 	  This option enables support for bitstream configuration (programming
 	  or loading) of the Lattice ECP3 FPGA family via SPI.
@@ -517,8 +517,8 @@ config PCI_ENDPOINT_TEST
 	select CRC32
 	tristate "PCI Endpoint Test driver"
 	---help---
-           Enable this configuration option to enable the host side test driver
-           for PCI Endpoint.
+	  Enable this configuration option to enable the host side test driver
+	  for PCI Endpoint.
 
 config MISC_RTSX
 	tristate
-- 
1.9.1

