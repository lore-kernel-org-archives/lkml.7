Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F49F20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfH1HmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:42:24 -0400
Received: from shell.v3.sk ([90.176.6.54]:40444 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfH1HmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:42:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F2C06D831C;
        Wed, 28 Aug 2019 09:42:20 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Kb_t2tL3vZHw; Wed, 28 Aug 2019 09:42:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6FBECD8321;
        Wed, 28 Aug 2019 09:42:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yjTNDN1ha-T8; Wed, 28 Aug 2019 09:42:13 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DBB28D831C;
        Wed, 28 Aug 2019 09:42:12 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: enable MMP2 platform
Date:   Wed, 28 Aug 2019 09:42:04 +0200
Message-Id: <20190828074204.287415-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell MMP/PXA/MMP2 platforms seem to be excluded from the defconfig
for no good reasons. Enable the DT-based boards and the modules for
their peripherals.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/configs/multi_v7_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
index 6a40bc2ef2718..091693797ce98 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -51,6 +51,8 @@ CONFIG_ARCH_MEDIATEK=3Dy
 CONFIG_ARCH_MESON=3Dy
 CONFIG_ARCH_MILBEAUT=3Dy
 CONFIG_ARCH_MILBEAUT_M10V=3Dy
+CONFIG_ARCH_MMP=3Dy
+CONFIG_MACH_MMP2_DT=3Dy
 CONFIG_ARCH_MVEBU=3Dy
 CONFIG_MACH_ARMADA_370=3Dy
 CONFIG_MACH_ARMADA_375=3Dy
@@ -278,6 +280,7 @@ CONFIG_INPUT_EVDEV=3Dy
 CONFIG_KEYBOARD_QT1070=3Dm
 CONFIG_KEYBOARD_GPIO=3Dy
 CONFIG_KEYBOARD_TEGRA=3Dy
+CONFIG_KEYBOARD_PXA27x=3Dm
 CONFIG_KEYBOARD_SAMSUNG=3Dm
 CONFIG_KEYBOARD_ST_KEYSCAN=3Dy
 CONFIG_KEYBOARD_SPEAR=3Dy
@@ -312,6 +315,7 @@ CONFIG_SERIAL_8250_EM=3Dy
 CONFIG_SERIAL_8250_OMAP=3Dy
 CONFIG_SERIAL_8250_MT6577=3Dy
 CONFIG_SERIAL_8250_UNIPHIER=3Dy
+CONFIG_SERIAL_8250_PXA=3Dm
 CONFIG_SERIAL_OF_PLATFORM=3Dy
 CONFIG_SERIAL_AMBA_PL011=3Dy
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
@@ -590,6 +594,7 @@ CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
 CONFIG_MEDIA_USB_SUPPORT=3Dy
 CONFIG_USB_VIDEO_CLASS=3Dm
 CONFIG_V4L_PLATFORM_DRIVERS=3Dy
+CONFIG_VIDEO_MMP_CAMERA=3Dm
 CONFIG_VIDEO_STM32_DCMI=3Dm
 CONFIG_VIDEO_SAMSUNG_EXYNOS4_IS=3Dm
 CONFIG_VIDEO_S5P_FIMC=3Dm
@@ -684,6 +689,9 @@ CONFIG_SND_ATMEL_SOC_PDMIC=3Dm
 CONFIG_SND_ATMEL_SOC_I2S=3Dm
 CONFIG_SND_BCM2835_SOC_I2S=3Dm
 CONFIG_SND_SOC_FSL_SAI=3Dm
+CONFIG_SND_MMP_SOC=3Dy
+CONFIG_SND_PXA_SOC_SSP=3Dm
+CONFIG_SND_PXA910_SOC=3Dm
 CONFIG_SND_SOC_ROCKCHIP=3Dm
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=3Dm
 CONFIG_SND_SOC_ROCKCHIP_MAX98090=3Dm
@@ -722,6 +730,7 @@ CONFIG_USB_EHCI_HCD=3Dy
 CONFIG_USB_EHCI_HCD_STI=3Dy
 CONFIG_USB_EHCI_TEGRA=3Dy
 CONFIG_USB_EHCI_EXYNOS=3Dy
+CONFIG_USB_EHCI_MV=3Dm
 CONFIG_USB_OHCI_HCD=3Dy
 CONFIG_USB_OHCI_HCD_STI=3Dy
 CONFIG_USB_OHCI_EXYNOS=3Dm
@@ -791,6 +800,7 @@ CONFIG_MMC_SDHCI_DOVE=3Dy
 CONFIG_MMC_SDHCI_TEGRA=3Dy
 CONFIG_MMC_SDHCI_S3C=3Dy
 CONFIG_MMC_SDHCI_PXAV3=3Dy
+CONFIG_MMC_SDHCI_PXAV2=3Dm
 CONFIG_MMC_SDHCI_SPEAR=3Dy
 CONFIG_MMC_SDHCI_S3C_DMA=3Dy
 CONFIG_MMC_SDHCI_BCM_KONA=3Dy
@@ -856,6 +866,7 @@ CONFIG_RTC_DRV_DA9063=3Dm
 CONFIG_RTC_DRV_EFI=3Dm
 CONFIG_RTC_DRV_DIGICOLOR=3Dm
 CONFIG_RTC_DRV_S3C=3Dm
+CONFIG_RTC_DRV_SA1100=3Dm
 CONFIG_RTC_DRV_PL031=3Dy
 CONFIG_RTC_DRV_AT91RM9200=3Dm
 CONFIG_RTC_DRV_AT91SAM9=3Dm
--=20
2.21.0

