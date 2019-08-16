Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD0AC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E5F206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfHPS5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:57:32 -0400
Received: from shell.v3.sk ([90.176.6.54]:59117 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfHPS53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:57:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6F9E5D6DAC;
        Fri, 16 Aug 2019 20:57:25 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cuYSKFdpmuN3; Fri, 16 Aug 2019 20:57:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 029CAD6D83;
        Fri, 16 Aug 2019 20:57:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FfoLDIe9pu7U; Fri, 16 Aug 2019 20:57:18 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3AB74D6D5B;
        Fri, 16 Aug 2019 20:57:18 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] clk: tidy up the help tags in Kconfig
Date:   Fri, 16 Aug 2019 20:57:16 +0200
Message-Id: <20190816185716.530013-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes an extraneous "---help---" follows "help". That is probably a
copy&paste error stemming from their inconsistent use. Let's just replace
them all with "help", removing the extra ones along the way.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/Kconfig | 51 +++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 801fa1cd03217..0acc1a8590897 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -13,7 +13,7 @@ config COMMON_CLK
 	select CLKDEV_LOOKUP
 	select SRCU
 	select RATIONAL
-	---help---
+	help
 	  The common clock framework is a single definition of struct
 	  clk, useful across many platforms, as well as an
 	  implementation of the clock API in include/linux/clk.h.
@@ -26,7 +26,7 @@ menu "Common Clock Framework"
 config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
-	---help---
+	help
           Supports the clocking subsystem of the WM831x/2x series of
 	  PMICs from Wolfson Microelectronics.
=20
@@ -35,14 +35,14 @@ source "drivers/clk/versatile/Kconfig"
 config CLK_HSDK
 	bool "PLL Driver for HSDK platform"
 	depends on OF || COMPILE_TEST
-	---help---
+	help
 	  This driver supports the HSDK core, system, ddr, tunnel and hdmi PLLs
 	  control.
=20
 config COMMON_CLK_MAX77686
 	tristate "Clock driver for Maxim 77620/77686/77802 MFD"
 	depends on MFD_MAX77686 || MFD_MAX77620 || COMPILE_TEST
-	---help---
+	help
 	  This driver supports Maxim 77620/77686/77802 crystal oscillator
 	  clock.
=20
@@ -55,7 +55,7 @@ config COMMON_CLK_MAX9485
 config COMMON_CLK_RK808
 	tristate "Clock driver for RK805/RK808/RK809/RK817/RK818"
 	depends on MFD_RK808
-	---help---
+	help
 	  This driver supports RK805, RK809 and RK817, RK808 and RK818 crystal =
oscillator clock.
 	  These multi-function devices have two fixed-rate oscillators, clocked=
 at 32KHz each.
 	  Clkout1 is always on, Clkout2 can off by control register.
@@ -65,7 +65,7 @@ config COMMON_CLK_HI655X
 	depends on (MFD_HI655X_PMIC || COMPILE_TEST)
 	depends on REGMAP
 	default MFD_HI655X_PMIC
-	---help---
+	help
 	  This driver supports the hi655x PMIC clock. This
 	  multi-function device has one fixed-rate oscillator, clocked
 	  at 32KHz.
@@ -73,7 +73,7 @@ config COMMON_CLK_HI655X
 config COMMON_CLK_SCMI
 	tristate "Clock driver controlled via SCMI interface"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
-	  ---help---
+	  help
 	  This driver provides support for clocks that are controlled
 	  by firmware that implements the SCMI interface.
=20
@@ -83,7 +83,7 @@ config COMMON_CLK_SCMI
 config COMMON_CLK_SCPI
 	tristate "Clock driver controlled via SCPI interface"
 	depends on ARM_SCPI_PROTOCOL || COMPILE_TEST
-	  ---help---
+	  help
 	  This driver provides support for clocks that are controlled
 	  by firmware that implements the SCPI interface.
=20
@@ -106,7 +106,7 @@ config COMMON_CLK_SI5351
 	depends on I2C
 	select REGMAP_I2C
 	select RATIONAL
-	---help---
+	help
 	  This driver supports Silicon Labs 5351A/B/C programmable clock
 	  generators.
=20
@@ -116,7 +116,6 @@ config COMMON_CLK_SI514
 	depends on OF
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports the Silicon Labs 514 programmable clock
 	  generator.
=20
@@ -125,7 +124,6 @@ config COMMON_CLK_SI544
 	depends on I2C
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports the Silicon Labs 544 programmable clock
 	  generator.
=20
@@ -135,7 +133,6 @@ config COMMON_CLK_SI570
 	depends on OF
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports Silicon Labs 570/571/598/599 programmable
 	  clock generators.
=20
@@ -144,7 +141,7 @@ config COMMON_CLK_CDCE706
 	depends on I2C
 	select REGMAP_I2C
 	select RATIONAL
-	---help---
+	help
 	  This driver supports TI CDCE706 programmable 3-PLL clock synthesizer.
=20
 config COMMON_CLK_CDCE925
@@ -153,7 +150,6 @@ config COMMON_CLK_CDCE925
 	depends on OF
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports the TI CDCE913/925/937/949 programmable clock
 	  synthesizer. Each chip has different number of PLLs and outputs.
 	  For example, the CDCE925 contains two PLLs with spread-spectrum
@@ -176,7 +172,7 @@ config COMMON_CLK_GEMINI
 	depends on ARCH_GEMINI || COMPILE_TEST
 	select MFD_SYSCON
 	select RESET_CONTROLLER
-	---help---
+	help
 	  This driver supports the SoC clocks on the Cortina Systems Gemini
 	  platform, also known as SL3516 or CS3516.
=20
@@ -186,7 +182,7 @@ config COMMON_CLK_ASPEED
 	default ARCH_ASPEED
 	select MFD_SYSCON
 	select RESET_CONTROLLER
-	---help---
+	help
 	  This driver supports the SoC clocks on the Aspeed BMC platforms.
=20
 	  The G4 and G5 series, including the ast2400 and ast2500, are supporte=
d
@@ -195,7 +191,7 @@ config COMMON_CLK_ASPEED
 config COMMON_CLK_S2MPS11
 	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
 	depends on MFD_SEC_CORE || COMPILE_TEST
-	---help---
+	help
 	  This driver supports S2MPS11/S2MPS14/S5M8767 crystal oscillator
 	  clock. These multi-function devices have two (S2MPS14) or three
 	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
@@ -203,7 +199,7 @@ config COMMON_CLK_S2MPS11
 config CLK_TWL6040
 	tristate "External McPDM functional clock from twl6040"
 	depends on TWL6040_CORE
-	---help---
+	help
 	  Enable the external functional clock support on OMAP4+ platforms for
 	  McPDM. McPDM module is using the external bit clock on the McPDM bus
 	  as functional clock.
@@ -212,14 +208,13 @@ config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
 	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
 	help
-	---help---
 	  Support for the Analog Devices axi-clkgen pcore clock generator for X=
ilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
=20
 config CLK_QORIQ
 	bool "Clock driver for Freescale QorIQ platforms"
 	depends on (PPC_E500MC || ARM || ARM64 || COMPILE_TEST) && OF
-	---help---
+	help
 	  This adds the clock driver support for Freescale QorIQ platforms
 	  using common clock framework.
=20
@@ -227,7 +222,7 @@ config COMMON_CLK_XGENE
 	bool "Clock driver for APM XGene SoC"
 	default ARCH_XGENE
 	depends on ARM64 || COMPILE_TEST
-	---help---
+	help
 	  Sypport for the APM X-Gene SoC reference, PLL, and device clocks.
=20
 config COMMON_CLK_LOCHNAGAR
@@ -241,26 +236,26 @@ config COMMON_CLK_NXP
 	def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
 	select REGMAP_MMIO if ARCH_LPC32XX
 	select MFD_SYSCON if ARCH_LPC18XX
-	---help---
+	help
 	  Support for clock providers on NXP platforms.
=20
 config COMMON_CLK_PALMAS
 	tristate "Clock driver for TI Palmas devices"
 	depends on MFD_PALMAS
-	---help---
+	help
 	  This driver supports TI Palmas devices 32KHz output KG and KG_AUDIO
 	  using common clock framework.
=20
 config COMMON_CLK_PWM
 	tristate "Clock driver for PWMs used as clock outputs"
 	depends on PWM
-	---help---
+	help
 	  Adapter driver so that any PWM output can be (mis)used as clock signa=
l
 	  at 50% duty cycle.
=20
 config COMMON_CLK_PXA
 	def_bool COMMON_CLK && ARCH_PXA
-	---help---
+	help
 	  Support for the Marvell PXA SoC.
=20
 config COMMON_CLK_PIC32
@@ -270,7 +265,7 @@ config COMMON_CLK_OXNAS
 	bool "Clock driver for the OXNAS SoC Family"
 	depends on ARCH_OXNAS || COMPILE_TEST
 	select MFD_SYSCON
-	---help---
+	help
 	  Support for the OXNAS SoC Family clocks.
=20
 config COMMON_CLK_VC5
@@ -279,26 +274,22 @@ config COMMON_CLK_VC5
 	depends on OF
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
=20
 config COMMON_CLK_STM32MP157
 	def_bool COMMON_CLK && MACH_STM32MP157
 	help
-	---help---
 	  Support for stm32mp157 SoC family clocks
=20
 config COMMON_CLK_STM32F
 	def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F=
746)
 	help
-	---help---
 	  Support for stm32f4 and stm32f7 SoC families clocks
=20
 config COMMON_CLK_STM32H7
 	def_bool COMMON_CLK && MACH_STM32H743
 	help
-	---help---
 	  Support for stm32h7 SoC family clocks
=20
 config COMMON_CLK_BD718XX
--=20
2.21.0

