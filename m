Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A686C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51CD208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJJUez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:34:55 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:34:55 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MuF4v-1hxQGJ3NEb-00uawx; Thu, 10 Oct 2019 22:34:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 08/36] ARM: exynos: stop selecting PLAT_SAMSUNG
Date:   Thu, 10 Oct 2019 22:29:52 +0200
Message-Id: <20191010203043.1241612-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uwZUxKfHU6aXQrxq5LBsqRjtGw4Jouv7a9Oj5nhgoB0hlXyrcjq
 cQyW2Cc79CrgKEOR6AddSkd8kEBELnOavaFnpiNz+2wYC6JLZtkFkNgiIgcAb7IBPMKOVw0
 /4ytjJKtS7vIIFSkZF7IEeIC9HtyP3lGkyhZhf4Pi3jKK/5gN5ZDuHWv+OUxglNHQchIV00
 9MUCnTUKaPQYLOuhuq7Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MjZuD1WSriM=:hwMzUoxCknZvCwSvNSjCMN
 7y6Uvi/BhIjqy3zK9+GLPLSNPmAYLF6XMR5MVm9RdReMkMhEpRn9U0e2Bqx/jFGajmKkkwPaF
 OwPQDZ/+fO1eN5nL+6z52rQyDTWBG/uTALbBrsxJFjw2IXpGkynCbp+CvOZSYprMJ+B+R4ASg
 8BLcQdVkFnlwHipnDjJMzkOCDq8f/K/fea3DmU+S6WllVxMBke4EAGCFCz+N7DLEAdxr1uit2
 UHXrt4ArSWWE1IOV1hWsBjL9OoKUx6cb9T4rAhjcQrYQRjP8dXIy1yExNCq/K1pvVZm+chtMl
 gpJJYL3sYB5Hg7Aa6mC4X2/uNwbpQyBbZCXB1Lcxc6Rj402rXZQCV2Xjc4m5va6u+CCtnXL4x
 4yC/wMNz5qcSvYatDm8uHxsqOXJ2qvf4Eh7HcD8JzxLmcY1MjSa3NB8LRnEZgol+ONBYmvDoz
 OEh2KpTH7cbgo3nQxW3+JuTkmuCV+x+NlnA1/PJKIzzxG2jj7xoi1GAS7ZrZwhGb/J9FU/oZa
 sMXSrcHyKE9XN+8rl6ymRIH1La+GHJZXvQw6Sd70xeGKzq5WJSqpklT2Ql4aKALBCxsLCaGxt
 Gvs7d/Fj8p4WWGHEyJNaHyK0X5ltlQo2XUe7WBqDH65jq+4uEstinmPiWPi7rgkwSppRrlyu+
 kBzlPLcpQxheqyt2DqjQ9FMOnqx5mGNz1Oj6JaLtBKUDi8RpaZp7TGvCZ+njWgcqEhIGm/FQQ
 S5Y24w/1H9yJpgB9XlgNpINBNfESIaOnFJqyFXF7R12fdZ4/L7hfjdGcZ74xss1Qn9i4MeOBB
 t3OBWaJsXz357+6RJFLHXKD3cL1S4doTsLpMWmh5tniImws1g/Gy4X2PoBsyOv3h5d3eZfz6l
 rMhwf0F77SGifPySmcCg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that no code in arch/arm is shared between mach-exynos and the
others, make the split formal.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug        | 8 ++++----
 arch/arm/Makefile             | 1 -
 arch/arm/mach-exynos/Makefile | 4 ----
 arch/arm/plat-samsung/Kconfig | 4 ++--
 drivers/mmc/host/Kconfig      | 2 +-
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d05b836dfeb2..9c4f2d6deb06 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -998,7 +998,7 @@ choice
 		  via SCIFA4 on Renesas SH-Mobile AG5 (SH73A0).
 
 	config DEBUG_S3C_UART0
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1010,7 +1010,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART1
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1022,7 +1022,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART2
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1034,7 +1034,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART3
-		depends on PLAT_SAMSUNG && (ARCH_EXYNOS || ARCH_S5PV210)
+		depends on ARCH_EXYNOS || ARCH_S5PV210
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index db857d07114f..f492d7c338fe 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -233,7 +233,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-plat-$(CONFIG_ARCH_EXYNOS)	+= samsung
 plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
 plat-$(CONFIG_ARCH_S5PV210)	+= samsung
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 0fd3fcf8bfb0..53fa363c8e44 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -3,10 +3,6 @@
 # Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
-
-# Core
-
 obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 832ab0e6cd72..e31a156a27df 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -4,7 +4,7 @@
 
 config PLAT_SAMSUNG
 	bool
-	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_EXYNOS || ARCH_S5PV210
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	default y
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
@@ -240,7 +240,7 @@ config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
 	depends on PM && DEBUG_KERNEL
 	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
-	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
+	depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
 	  Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 49ea02c467bf..400a581c918c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -275,7 +275,7 @@ config MMC_SDHCI_TEGRA
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && PLAT_SAMSUNG
+	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_EXYNOS)
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
-- 
2.20.0

