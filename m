Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45290C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CE12086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfHPOMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:12:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4725 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfHPOML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:12:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2CFA7DCCF5BDC3D35796;
        Fri, 16 Aug 2019 22:11:54 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 22:11:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: npcm7xx: remove unused code
Date:   Fri, 16 Aug 2019 22:11:32 +0800
Message-ID: <20190816141132.55060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/clk-npcm7xx.c:365:48: warning:
 npcm7xx_divs_fx defined but not used [-Wunused-const-variable=]
drivers/clk/clk-npcm7xx.c:438:43: warning:
 npcm7xx_gates defined but not used [-Wunused-const-variable=]

The two variables are never used, so remove them,
also remove related type declarations.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/clk-npcm7xx.c | 157 ----------------------------------------------
 1 file changed, 157 deletions(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 27a86b7..9c5390c 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -100,9 +100,6 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 	return hw;
 }
 
-#define NPCM7XX_CLKEN1          (0x00)
-#define NPCM7XX_CLKEN2          (0x28)
-#define NPCM7XX_CLKEN3          (0x30)
 #define NPCM7XX_CLKSEL          (0x04)
 #define NPCM7XX_CLKDIV1         (0x08)
 #define NPCM7XX_CLKDIV2         (0x2C)
@@ -110,38 +107,7 @@ npcm7xx_clk_register_pll(void __iomem *pllcon, const char *name,
 #define NPCM7XX_PLLCON0         (0x0C)
 #define NPCM7XX_PLLCON1         (0x10)
 #define NPCM7XX_PLLCON2         (0x54)
-#define NPCM7XX_SWRSTR          (0x14)
-#define NPCM7XX_IRQWAKECON      (0x18)
-#define NPCM7XX_IRQWAKEFLAG     (0x1C)
-#define NPCM7XX_IPSRST1         (0x20)
-#define NPCM7XX_IPSRST2         (0x24)
-#define NPCM7XX_IPSRST3         (0x34)
-#define NPCM7XX_WD0RCR          (0x38)
-#define NPCM7XX_WD1RCR          (0x3C)
-#define NPCM7XX_WD2RCR          (0x40)
-#define NPCM7XX_SWRSTC1         (0x44)
-#define NPCM7XX_SWRSTC2         (0x48)
-#define NPCM7XX_SWRSTC3         (0x4C)
-#define NPCM7XX_SWRSTC4         (0x50)
-#define NPCM7XX_CORSTC          (0x5C)
 #define NPCM7XX_PLLCONG         (0x60)
-#define NPCM7XX_AHBCKFI         (0x64)
-#define NPCM7XX_SECCNT          (0x68)
-#define NPCM7XX_CNTR25M         (0x6C)
-
-struct npcm7xx_clk_gate_data {
-	u32 reg;
-	u8 bit_idx;
-	const char *name;
-	const char *parent_name;
-	unsigned long flags;
-	/*
-	 * If this clock is exported via DT, set onecell_idx to constant
-	 * defined in include/dt-bindings/clock/nuvoton, NPCM7XX-clock.h for
-	 * this specific clock.  Otherwise, set to -1.
-	 */
-	int onecell_idx;
-};
 
 struct npcm7xx_clk_mux_data {
 	u8 shift;
@@ -160,21 +126,6 @@ struct npcm7xx_clk_mux_data {
 
 };
 
-struct npcm7xx_clk_div_fixed_data {
-	u8 mult;
-	u8 div;
-	const char *name;
-	const char *parent_name;
-	u8 clk_divider_flags;
-	/*
-	 * If this clock is exported via DT, set onecell_idx to constant
-	 * defined in include/dt-bindings/clock/nuvoton, NPCM7XX-clock.h for
-	 * this specific clock.  Otherwise, set to -1.
-	 */
-	int onecell_idx;
-};
-
-
 struct npcm7xx_clk_div_data {
 	u32 reg;
 	u8 shift;
@@ -361,13 +312,6 @@ static const struct npcm7xx_clk_mux_data npcm7xx_muxes[] __initconst = {
 	dvcssel_mux_parents, ARRAY_SIZE(dvcssel_mux_parents), 0, -1},
 };
 
-/* fixed ratio dividers (no register): */
-static const struct npcm7xx_clk_div_fixed_data npcm7xx_divs_fx[] __initconst = {
-	{ 1, 2, NPCM7XX_CLK_S_MC, NPCM7XX_CLK_S_MC_MUX, 0, NPCM7XX_CLK_MC},
-	{ 1, 2, NPCM7XX_CLK_S_PLL1_DIV2, NPCM7XX_CLK_S_PLL1, 0, -1},
-	{ 1, 2, NPCM7XX_CLK_S_PLL2_DIV2, NPCM7XX_CLK_S_PLL2, 0, -1},
-};
-
 /* configurable dividers: */
 static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
 	{NPCM7XX_CLKDIV1, 28, 3, NPCM7XX_CLK_S_ADC,
@@ -435,107 +379,6 @@ static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
 
 };
 
-static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst = {
-	{NPCM7XX_CLKEN1, 31, "smb1-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 30, "smb0-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 29, "smb7-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 28, "smb6-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 27, "adc-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 26, "wdt-gate", NPCM7XX_CLK_S_TIMER, 0},
-	{NPCM7XX_CLKEN1, 25, "usbdev3-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 24, "usbdev6-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 23, "usbdev5-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 22, "usbdev4-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 21, "emc2-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 20, "timer5_9-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 19, "timer0_4-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 18, "pwmm0-gate", NPCM7XX_CLK_S_APB3, 0},
-	{NPCM7XX_CLKEN1, 17, "huart-gate", NPCM7XX_CLK_S_UART, 0},
-	{NPCM7XX_CLKEN1, 16, "smb5-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 15, "smb4-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 14, "smb3-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 13, "smb2-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 12, "mc-gate", NPCM7XX_CLK_S_MC, 0},
-	{NPCM7XX_CLKEN1, 11, "uart01-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 10, "aes-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 9, "peci-gate", NPCM7XX_CLK_S_APB3, 0},
-	{NPCM7XX_CLKEN1, 8, "usbdev2-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 7, "uart23-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 6, "emc1-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 5, "usbdev1-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 4, "shm-gate", NPCM7XX_CLK_S_AHB, 0},
-	/* bit 3 is reserved */
-	{NPCM7XX_CLKEN1, 2, "kcs-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 1, "spi3-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 0, "spi0-gate", NPCM7XX_CLK_S_AHB, 0},
-
-	{NPCM7XX_CLKEN2, 31, "cp-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 30, "tock-gate", NPCM7XX_CLK_S_TOCK, 0},
-	/* bit 29 is reserved */
-	{NPCM7XX_CLKEN2, 28, "gmac1-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 27, "usbif-gate", NPCM7XX_CLK_S_USBIF, 0},
-	{NPCM7XX_CLKEN2, 26, "usbhost-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 25, "gmac2-gate", NPCM7XX_CLK_S_AHB, 0},
-	/* bit 24 is reserved */
-	{NPCM7XX_CLKEN2, 23, "pspi2-gate", NPCM7XX_CLK_S_APB5, 0},
-	{NPCM7XX_CLKEN2, 22, "pspi1-gate", NPCM7XX_CLK_S_APB5, 0},
-	{NPCM7XX_CLKEN2, 21, "3des-gate", NPCM7XX_CLK_S_AHB, 0},
-	/* bit 20 is reserved */
-	{NPCM7XX_CLKEN2, 19, "siox2-gate", NPCM7XX_CLK_S_APB3, 0},
-	{NPCM7XX_CLKEN2, 18, "siox1-gate", NPCM7XX_CLK_S_APB3, 0},
-	/* bit 17 is reserved */
-	{NPCM7XX_CLKEN2, 16, "fuse-gate", NPCM7XX_CLK_S_APB4, 0},
-	/*  bit 15 is reserved */
-	{NPCM7XX_CLKEN2, 14, "vcd-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 13, "ece-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 12, "vdma-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 11, "ahbpcibrg-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 10, "gfxsys-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN2, 9, "sdhc-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 8, "mmc-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 7, "mft7-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 6, "mft6-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 5, "mft5-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 4, "mft4-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 3, "mft3-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 2, "mft2-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 1, "mft1-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 0, "mft0-gate", NPCM7XX_CLK_S_APB4, 0},
-
-	{NPCM7XX_CLKEN3, 31, "gpiom7-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 30, "gpiom6-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 29, "gpiom5-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 28, "gpiom4-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 27, "gpiom3-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 26, "gpiom2-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 25, "gpiom1-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 24, "gpiom0-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 23, "espi-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 22, "smb11-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 21, "smb10-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 20, "smb9-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 19, "smb8-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 18, "smb15-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 17, "rng-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 16, "timer10_14-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 15, "pcirc-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 14, "sececc-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 13, "sha-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 12, "smb14-gate", NPCM7XX_CLK_S_APB2, 0},
-	/* bit 11 is reserved */
-	/* bit 10 is reserved */
-	{NPCM7XX_CLKEN3, 9, "pcimbx-gate", NPCM7XX_CLK_S_AHB, 0},
-	/* bit 8 is reserved */
-	{NPCM7XX_CLKEN3, 7, "usbdev9-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 6, "usbdev8-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 5, "usbdev7-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 4, "usbdev0-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 3, "smb13-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 2, "spix-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 1, "smb12-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 0, "pwmm1-gate", NPCM7XX_CLK_S_APB3, 0},
-};
-
 static DEFINE_SPINLOCK(npcm7xx_clk_lock);
 
 static void __init npcm7xx_clk_init(struct device_node *clk_np)
-- 
2.7.4


