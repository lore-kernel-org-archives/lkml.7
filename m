Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_75_100,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8352147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556559397;
	bh=yE24FEyTF2C8cN5/dSKPH6GLAs85kDRq9wj5o8UEXBI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2S34Yr7V3u8NTaEiDrHgfI4MxaKrXgc6eHqizO25LLH215md41AthcUq57e6OQtf
	 P5xHw2xy9ASp7ni4nos283YCBL2cVOXboR9EEGDq/GoeTi2mS/Nex/5zWkUGDv9VT6
	 VLzflcJUI8IrCz1iltu1FW0+Ll3oHYadzdJLxkhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfD2Rgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfD2Rgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:36:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9982147A;
        Mon, 29 Apr 2019 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556559393;
        bh=yE24FEyTF2C8cN5/dSKPH6GLAs85kDRq9wj5o8UEXBI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j4i0gt9jn8tJ3JWTAicxu5Qx6vmTQgpn3WwObdKy5zZTLBF03TbJsL65Kh0Ve9gbG
         hSyzUvvnQiECaIjvcnWljXcT7jhUBamIw3trkLL9zVTL6iAkizi2wgyU91dyAQC8mN
         0tLsf7+hxgpWcTcc2+G3BlMdDgw0cz33AEYLUW6c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: exynos_defconfig: Trim and reorganize with savedefconfig
Date:   Mon, 29 Apr 2019 19:36:20 +0200
Message-Id: <20190429173620.5078-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429173620.5078-1-krzk@kernel.org>
References: <20190429173620.5078-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trim and reorganize the defconfig with savedefconfig on latest
linux-next.  The ARCH_EXYNOS3 is removed because it become the default.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/exynos_defconfig | 62 ++++++++++++++-----------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c95c54284da2..8d08eed99aa1 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -1,21 +1,15 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_EXYNOS=y
-CONFIG_ARCH_EXYNOS3=y
 CONFIG_SMP=y
 CONFIG_BIG_LITTLE=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -37,6 +31,16 @@ CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_ADVANCED_DEBUG=y
+CONFIG_ARM_CRYPTO=y
+CONFIG_CRYPTO_SHA1_ARM_NEON=m
+CONFIG_CRYPTO_SHA256_ARM=m
+CONFIG_CRYPTO_SHA512_ARM=m
+CONFIG_CRYPTO_AES_ARM_BS=m
+CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -60,10 +64,7 @@ CONFIG_BT_HCIBTSDIO=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_BCSP=y
 CONFIG_BT_HCIUART_ATH3K=y
-CONFIG_BT_HCIUART_3WIRE=y
 CONFIG_BT_HCIUART_INTEL=y
-CONFIG_BT_HCIUART_BCM=y
-CONFIG_BT_HCIUART_QCA=y
 CONFIG_BT_HCIUART_AG6XX=y
 CONFIG_BT_HCIUART_MRVL=y
 CONFIG_BT_HCIBCM203X=m
@@ -86,8 +87,6 @@ CONFIG_NFC_SHDLC=y
 CONFIG_NFC_S3FWRN5_I2C=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_DMA_CMA=y
-CONFIG_CMA_SIZE_MBYTES=96
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -155,8 +154,6 @@ CONFIG_THERMAL_EMULATION=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MFD_CROS_EC=y
-CONFIG_CROS_EC_I2C=y
-CONFIG_CROS_EC_SPI=y
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
@@ -282,16 +279,17 @@ CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
-CONFIG_CROS_EC_CHARDEV=y
+CONFIG_CROS_EC_I2C=y
+CONFIG_CROS_EC_SPI=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_S2MPS11=y
+CONFIG_EXYNOS_IOMMU=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
-CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14577=y
 CONFIG_EXTCON_MAX77693=y
@@ -319,21 +317,9 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_FS=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_SOFTLOCKUP_DETECTOR=y
-# CONFIG_DETECT_HUNG_TASK is not set
-CONFIG_PROVE_LOCKING=y
-CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO_RSA=m
-CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_TEST=m
+CONFIG_CRYPTO_DH=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_MD5=m
@@ -348,12 +334,18 @@ CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
 CONFIG_CRYPTO_DEV_S5P=y
-CONFIG_ARM_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM_NEON=m
-CONFIG_CRYPTO_SHA256_ARM=m
-CONFIG_CRYPTO_SHA512_ARM=m
-CONFIG_CRYPTO_AES_ARM_BS=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRC_CCITT=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=96
 CONFIG_FONTS=y
 CONFIG_FONT_7x14=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+# CONFIG_DETECT_HUNG_TASK is not set
+CONFIG_PROVE_LOCKING=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_USER=y
-- 
2.17.1

