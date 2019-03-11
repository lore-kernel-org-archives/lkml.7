Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7922084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfCKNZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mc02T-1gV7Hb1V8h-00dVky for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 066/114] drivers: mtd: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:18 +0100
Message-Id: <1552310346-7629-67-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:pzw7tGH7AWmVTKjWckilU7fqqOIaHjo0D9EO7BEkWWdw8lnN7u3
 FDnFEsbld0PN1I4Ou6K5J9K2OOI9YG0mPULCI8zxfwD1sx7QagcCR3x9C1rGlbZ55JvkdCD
 4/VmpKaX51AYzMSyn/fLOlH3YEgcOk+mEHvWfhClbuxdFpKILOsrQVVENI5QjbsGfbVnjze
 xsLcHKHBV8kSkxvewvgjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pAiLUi9XvrY=:S1KNtTLX3l+ODFt2ZtSFac
 5JYuhSmJ6du6c5zxssWp2MwhvYOalaPAh0pjzGhIPYOI4GlNFlR+kpsjI+gX0znVFDywGdSni
 hkV5PRD9m1JQtmfWU3pIydu3S7P8B6DnJa3sGddYmcjdtCHoQ3ZtCh5iInxTYFsi68iTXYPYR
 KbjVK7NaIAShlxCarY8DweXxzpbfxoA+qRV2vzvtQD4G0Lg/31qBobLwtUrKWaGcQ8DaND0Xj
 zyQpmWZNVfPdXaLgaZ9TXCq7RPHi6wkFWFKeU7wLZthlnWIQEED172ycbiHa1eWzrAPILTNan
 Sq50NDkzh5v3GxmweeIz1U4HpSrlW9wNaRVV7ej7zNW0mabTC1Jr0EFYEZD6fdNf4+m2j68OX
 JM2WBFk1YH5rDv1aYuOQksagU1A3YX+PWgXE762m+y4n+GqNUgbiFqBs7bGwIBi/kMKB378Vk
 PtOa77Oy1A4QOZ9vN3I3OxHLct+3O9TXTb1pU58jBvdU4I3HCdNQMtphpk/zq3Kyp4lF4uXPD
 jrC3pBUNZTX4sJuPpkV3FvWso0uFGGI1V8b6xZLfmSGpYAbWS1OJLE4/k4tV1elzleKFvmPJG
 fS8q5tpw4a4r+nSOVTXbp6U5AULw/1GfcHMyLDYXV0CK4NNPMo44h0DLu/D8UoT7BaK7AQE4l
 i6fNvT7krpBRINlip6IEbpXd57Z0f+ZUJDo1I/ZgSntSDUALXGWBQ6t/oNpSPBLg37oJmmpKT
 hVnieU66wjecoGAlEWYYW/erFjA47IVRACsAnw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/mtd/nand/onenand/Kconfig | 12 ++++----
 drivers/mtd/ubi/Kconfig          | 60 ++++++++++++++++++++--------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
index 9dc1574..dfa0f45 100644
--- a/drivers/mtd/nand/onenand/Kconfig
+++ b/drivers/mtd/nand/onenand/Kconfig
@@ -32,12 +32,12 @@ config MTD_ONENAND_OMAP2
 	  Enable dmaengine and gpiolib for better performance.
 
 config MTD_ONENAND_SAMSUNG
-        tristate "OneNAND on Samsung SOC controller support"
-        depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS4
-        help
-          Support for a OneNAND flash device connected to an Samsung SOC.
-          S3C64XX uses command mapping method.
-          S5PC110/S5PC210 use generic OneNAND method.
+	tristate "OneNAND on Samsung SOC controller support"
+	depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS4
+	help
+	  Support for a OneNAND flash device connected to an Samsung SOC.
+	  S3C64XX uses command mapping method.
+	  S5PC110/S5PC210 use generic OneNAND method.
 
 config MTD_ONENAND_OTP
 	bool "OneNAND OTP Support"
diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index 43d131f..e010dd5 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -60,47 +60,47 @@ config MTD_UBI_FASTMAP
 	bool "UBI Fastmap (Experimental feature)"
 	default n
 	help
-	   Important: this feature is experimental so far and the on-flash
-	   format for fastmap may change in the next kernel versions
-
-	   Fastmap is a mechanism which allows attaching an UBI device
-	   in nearly constant time. Instead of scanning the whole MTD device it
-	   only has to locate a checkpoint (called fastmap) on the device.
-	   The on-flash fastmap contains all information needed to attach
-	   the device. Using fastmap makes only sense on large devices where
-	   attaching by scanning takes long. UBI will not automatically install
-	   a fastmap on old images, but you can set the UBI module parameter
-	   fm_autoconvert to 1 if you want so. Please note that fastmap-enabled
-	   images are still usable with UBI implementations without
-	   fastmap support. On typical flash devices the whole fastmap fits
-	   into one PEB. UBI will reserve PEBs to hold two fastmaps.
-
-	   If in doubt, say "N".
+	  Important: this feature is experimental so far and the on-flash
+	  format for fastmap may change in the next kernel versions
+
+	  Fastmap is a mechanism which allows attaching an UBI device
+	  in nearly constant time. Instead of scanning the whole MTD device it
+	  only has to locate a checkpoint (called fastmap) on the device.
+	  The on-flash fastmap contains all information needed to attach
+	  the device. Using fastmap makes only sense on large devices where
+	  attaching by scanning takes long. UBI will not automatically install
+	  a fastmap on old images, but you can set the UBI module parameter
+	  fm_autoconvert to 1 if you want so. Please note that fastmap-enabled
+	  images are still usable with UBI implementations without
+	  fastmap support. On typical flash devices the whole fastmap fits
+	  into one PEB. UBI will reserve PEBs to hold two fastmaps.
+
+	  If in doubt, say "N".
 
 config MTD_UBI_GLUEBI
 	tristate "MTD devices emulation driver (gluebi)"
 	help
-	   This option enables gluebi - an additional driver which emulates MTD
-	   devices on top of UBI volumes: for each UBI volumes an MTD device is
-	   created, and all I/O to this MTD device is redirected to the UBI
-	   volume. This is handy to make MTD-oriented software (like JFFS2)
-	   work on top of UBI. Do not enable this unless you use legacy
-	   software.
+	  This option enables gluebi - an additional driver which emulates MTD
+	  devices on top of UBI volumes: for each UBI volumes an MTD device is
+	  created, and all I/O to this MTD device is redirected to the UBI
+	  volume. This is handy to make MTD-oriented software (like JFFS2)
+	  work on top of UBI. Do not enable this unless you use legacy
+	  software.
 
 config MTD_UBI_BLOCK
 	bool "Read-only block devices on top of UBI volumes"
 	default n
 	depends on BLOCK
 	help
-	   This option enables read-only UBI block devices support. UBI block
-	   devices will be layered on top of UBI volumes, which means that the
-	   UBI driver will transparently handle things like bad eraseblocks and
-	   bit-flips. You can put any block-oriented file system on top of UBI
-	   volumes in read-only mode (e.g., ext4), but it is probably most
-	   practical for read-only file systems, like squashfs.
+	  This option enables read-only UBI block devices support. UBI block
+	  devices will be layered on top of UBI volumes, which means that the
+	  UBI driver will transparently handle things like bad eraseblocks and
+	  bit-flips. You can put any block-oriented file system on top of UBI
+	  volumes in read-only mode (e.g., ext4), but it is probably most
+	  practical for read-only file systems, like squashfs.
 
-	   When selected, this feature will be built in the UBI driver.
+	  When selected, this feature will be built in the UBI driver.
 
-	   If in doubt, say "N".
+	  If in doubt, say "N".
 
 endif # MTD_UBI
-- 
1.9.1

