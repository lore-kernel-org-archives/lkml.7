Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E13AC32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B85B2464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578151321;
	bh=EQcqcjjuv0ouoB59KSHZHDUV1ulzaGFtTg7hG/A0CYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nZy0PmL4F/8kTcv9ZwRiybjZj1TQdrdQ+sTW64sy3bAWVvhvpA6S8Sg296Adj1MuA
	 4zkJeadwGLE9FwYeweRYIzRItOoz4VKJVzoXHS0hhCLXnr9Qjn6Qe18ONLGkca/Z1W
	 8J7PTzUmDJ3bx0kLJZa5wMjuGd3Y6BYAz1L474cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgADPV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgADPV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:21:58 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 396B82464E;
        Sat,  4 Jan 2020 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151316;
        bh=EQcqcjjuv0ouoB59KSHZHDUV1ulzaGFtTg7hG/A0CYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLMuVvEaWGCbCegYXJlpdmRAOu7dKrufwcvtboIHnFMehI8rKl139rmnhFMrt4E1W
         EiouZtSUM7pczl53PuVxc0sC0huu6kRWHAwYDfuwksA+f/QbqFKPOvPr78FvgssbN6
         QWQVTk+Ihy8S16+g89A+bBROHaDNPs2i0qDMRbVo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 05/20] soc: samsung: Rename Samsung and Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:20:52 +0100
Message-Id: <20200104152107.11407-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
and "Exynos" names.

"SAMSUNG" and "EXYNOS" are not abbreviations but regular trademarked
names.  Therefore they should be written with lowercase letters starting
with capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/samsung/Kconfig                 |  2 +-
 drivers/soc/samsung/exynos-chipid.c         |  2 +-
 drivers/soc/samsung/exynos-pmu.c            |  2 +-
 drivers/soc/samsung/exynos-pmu.h            |  2 +-
 drivers/soc/samsung/exynos3250-pmu.c        |  2 +-
 drivers/soc/samsung/exynos4-pmu.c           |  2 +-
 drivers/soc/samsung/exynos5250-pmu.c        |  2 +-
 drivers/soc/samsung/exynos5420-pmu.c        |  2 +-
 include/linux/soc/samsung/exynos-pmu.h      |  2 +-
 include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++++--------
 10 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 27fc59bbb520..c7a2003687c7 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# SAMSUNG SoC drivers
+# Samsung SoC drivers
 #
 menuconfig SOC_SAMSUNG
 	bool "Samsung SoC driver support" if COMPILE_TEST
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index b89c26a71c6e..2dad4961a80b 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2019 Samsung Electronics Co., Ltd.
  *	      http://www.samsung.com/
  *
- * EXYNOS - CHIP ID support
+ * Exynos - CHIP ID support
  * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
  * Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
  */
diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 7da2701c871a..17304fa18429 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
 //		http://www.samsung.com/
 //
-// EXYNOS - CPU PMU(Power Management Unit) support
+// Exynos - CPU PMU(Power Management Unit) support
 
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
index 977e4daf5a0f..5e851f32307e 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -3,7 +3,7 @@
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * Header for EXYNOS PMU Driver support
+ * Header for Exynos PMU Driver support
  */
 
 #ifndef __EXYNOS_PMU_H
diff --git a/drivers/soc/samsung/exynos3250-pmu.c b/drivers/soc/samsung/exynos3250-pmu.c
index 275d348ed9c9..30f230ed1769 100644
--- a/drivers/soc/samsung/exynos3250-pmu.c
+++ b/drivers/soc/samsung/exynos3250-pmu.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
 //		http://www.samsung.com/
 //
-// EXYNOS3250 - CPU PMU (Power Management Unit) support
+// Exynos3250 - CPU PMU (Power Management Unit) support
 
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
index a7cdbf1aac0c..cb35103565a6 100644
--- a/drivers/soc/samsung/exynos4-pmu.c
+++ b/drivers/soc/samsung/exynos4-pmu.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
 //		http://www.samsung.com/
 //
-// EXYNOS4 - CPU PMU(Power Management Unit) support
+// Exynos4 - CPU PMU(Power Management Unit) support
 
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
diff --git a/drivers/soc/samsung/exynos5250-pmu.c b/drivers/soc/samsung/exynos5250-pmu.c
index 19b38e008145..7a2d50be6b4a 100644
--- a/drivers/soc/samsung/exynos5250-pmu.c
+++ b/drivers/soc/samsung/exynos5250-pmu.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
 //		http://www.samsung.com/
 //
-// EXYNOS5250 - CPU PMU (Power Management Unit) support
+// Exynos5250 - CPU PMU (Power Management Unit) support
 
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
diff --git a/drivers/soc/samsung/exynos5420-pmu.c b/drivers/soc/samsung/exynos5420-pmu.c
index b236d3b47b49..6fedcd78cb45 100644
--- a/drivers/soc/samsung/exynos5420-pmu.c
+++ b/drivers/soc/samsung/exynos5420-pmu.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
 //		http://www.samsung.com/
 //
-// EXYNOS5420 - CPU PMU (Power Management Unit) support
+// Exynos5420 - CPU PMU (Power Management Unit) support
 
 #include <linux/pm.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
index fc0b445bb36b..a4f5516cc956 100644
--- a/include/linux/soc/samsung/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -3,7 +3,7 @@
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * Header for EXYNOS PMU Driver support
+ * Header for Exynos PMU Driver support
  */
 
 #ifndef __LINUX_SOC_EXYNOS_PMU_H
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 5addaf5ccbce..fc9250fb3133 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -3,7 +3,7 @@
  * Copyright (c) 2010-2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * EXYNOS - Power management unit definition
+ * Exynos - Power management unit definition
  *
  * Notice:
  * This is not a list of all Exynos Power Management Unit SFRs.
@@ -185,7 +185,7 @@
 /* Only for S5Pv210 */
 #define S5PV210_EINT_WAKEUP_MASK	0xC004
 
-/* Only for EXYNOS4210 */
+/* Only for Exynos4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
 #define S5P_CMU_RESET_LCD1_LOWPWR	0x1174
 #define S5P_MODIMIF_MEM_LOWPWR		0x11C4
@@ -193,7 +193,7 @@
 #define S5P_SATA_MEM_LOWPWR		0x11E4
 #define S5P_LCD1_LOWPWR			0x1394
 
-/* Only for EXYNOS4x12 */
+/* Only for Exynos4x12 */
 #define S5P_ISP_ARM_LOWPWR			0x1050
 #define S5P_DIS_IRQ_ISP_ARM_LOCAL_LOWPWR	0x1054
 #define S5P_DIS_IRQ_ISP_ARM_CENTRAL_LOWPWR	0x1058
@@ -234,7 +234,7 @@
 #define S5P_SECSS_MEM_OPTION			0x2EC8
 #define S5P_ROTATOR_MEM_OPTION			0x2F48
 
-/* Only for EXYNOS4412 */
+/* Only for Exynos4412 */
 #define S5P_ARM_CORE2_LOWPWR			0x1020
 #define S5P_DIS_IRQ_CORE2			0x1024
 #define S5P_DIS_IRQ_CENTRAL2			0x1028
@@ -242,7 +242,7 @@
 #define S5P_DIS_IRQ_CORE3			0x1034
 #define S5P_DIS_IRQ_CENTRAL3			0x1038
 
-/* Only for EXYNOS3XXX */
+/* Only for Exynos3XXX */
 #define EXYNOS3_ARM_CORE0_SYS_PWR_REG			0x1000
 #define EXYNOS3_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG	0x1004
 #define EXYNOS3_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG	0x1008
@@ -347,7 +347,7 @@
 #define EXYNOS3_OPTION_USE_SC_FEEDBACK			(1 << 1)
 #define EXYNOS3_OPTION_SKIP_DEACTIVATE_ACEACP_IN_PWDN	(1 << 7)
 
-/* For EXYNOS5 */
+/* For Exynos5 */
 
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				0x0408
 #define EXYNOS5_MASK_WDTRESET_REQUEST				0x040C
@@ -484,7 +484,7 @@
 
 #define EXYNOS5420_SWRESET_KFC_SEL				0x3
 
-/* Only for EXYNOS5420 */
+/* Only for Exynos5420 */
 #define EXYNOS5420_L2RSTDISABLE_VALUE				BIT(3)
 
 #define EXYNOS5420_LPI_MASK					0x0004
@@ -645,7 +645,7 @@
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI2  \
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
 
-/* For EXYNOS5433 */
+/* For Exynos5433 */
 #define EXYNOS5433_EINT_WAKEUP_MASK				(0x060C)
 #define EXYNOS5433_USBHOST30_PHY_CONTROL			(0x0728)
 #define EXYNOS5433_PAD_RETENTION_AUD_OPTION			(0x3028)
-- 
2.17.1

