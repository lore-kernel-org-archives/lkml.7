Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB78C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D60206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eknrOevo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfK1FK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 00:10:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfK1FKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 00:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l+NBq4hr2KRRSPHU68VrtargZDFHklaSzkUUjI+g3kY=; b=eknrOevoXGVBjGctmGm1T1yYM
        GpcDuTUpcecCjIE+YrQX8CIlJaSk1TZk0kkaT1WY8TOgzr2ZK0ZtP4pTt2LF8TLPNiYdynwpHkw1o
        XmHJtwqWtAwdJ4IGqzJynUitWN0VSpoB/TL+v636S+/HvYZnuwS6zcLE10gkMCuGDpbsw7xTPY0kY
        nJ6ISt7VsZk/tBggIX6QL+Ffz99+r+m0kHjM/Due/pGied2AtaCmMmFo6JMshl12WGtXuKaTR+JEG
        lAEFLLSEuBc8bROCeVZ1uzSQhBC8Rw8ddOlBiUQ76JtWZMdEZMSHIvmanOTIzH+aKuzbYEYvNpOpl
        IURWbD23A==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaC4N-00065F-L5; Thu, 28 Nov 2019 05:10:23 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] clocksource: fix Kconfig miscues
Message-ID: <4deb42a9-82f2-72f9-891f-972a9a399f4f@infradead.org>
Date:   Wed, 27 Nov 2019 21:10:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix lots of typo, spelling, punctuation, and grammar miscues in
drivers/clocksource/Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
Interesting that NSPIRE_TIMER is for timer-zevio.c, which says
nothing about NSpire.

 drivers/clocksource/Kconfig |   48 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

--- linux-next-20191127.orig/drivers/clocksource/Kconfig
+++ linux-next-20191127/drivers/clocksource/Kconfig
@@ -88,7 +88,7 @@ config ROCKCHIP_TIMER
 	select TIMER_OF
 	select CLKSRC_MMIO
 	help
-	  Enables the support for the rockchip timer driver.
+	  Enables the support for the Rockchip timer driver.
 
 config ARMADA_370_XP_TIMER
 	bool "Armada 370 and XP timer driver" if COMPILE_TEST
@@ -162,13 +162,13 @@ config NPCM7XX_TIMER
 	select CLKSRC_MMIO
 	help
 	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx architecture,
-	  While TIMER0 serves as clockevent and TIMER1 serves as clocksource.
+	  where TIMER0 serves as clockevent and TIMER1 serves as clocksource.
 
 config CADENCE_TTC_TIMER
 	bool "Cadence TTC timer driver" if COMPILE_TEST
 	depends on COMMON_CLK
 	help
-	  Enables support for the cadence ttc driver.
+	  Enables support for the Cadence TTC driver.
 
 config ASM9260_TIMER
 	bool "ASM9260 timer driver" if COMPILE_TEST
@@ -190,10 +190,10 @@ config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer" if COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  Use the always on PRCMU Timer as clocksource
+	  Use the always on PRCMU Timer as clocksource.
 
 config CLPS711X_TIMER
-	bool "Cirrus logic timer driver" if COMPILE_TEST
+	bool "Cirrus Logic timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
 	  Enables support for the Cirrus Logic PS711 timer.
@@ -205,11 +205,11 @@ config ATLAS7_TIMER
 	  Enables support for the Atlas7 timer.
 
 config MXS_TIMER
-	bool "Mxs timer driver" if COMPILE_TEST
+	bool "MXS timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	select STMP_DEVICE
 	help
-	  Enables support for the Mxs timer.
+	  Enables support for the MXS timer.
 
 config PRIMA2_TIMER
 	bool "Prima2 timer driver" if COMPILE_TEST
@@ -238,10 +238,10 @@ config KEYSTONE_TIMER
 	  Enables support for the Keystone timer.
 
 config INTEGRATOR_AP_TIMER
-	bool "Integrator-ap timer driver" if COMPILE_TEST
+	bool "Integrator-AP timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
-	  Enables support for the Integrator-ap timer.
+	  Enables support for the Integrator-AP timer.
 
 config CLKSRC_EFM32
 	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
@@ -283,8 +283,8 @@ config CLKSRC_NPS
 	select TIMER_OF if OF
 	help
 	  NPS400 clocksource support.
-	  Got 64 bit counter with update rate up to 1000MHz.
-	  This counter is accessed via couple of 32 bit memory mapped registers.
+	  It has a 64-bit counter with update rate up to 1000MHz.
+	  This counter is accessed via couple of 32-bit memory-mapped registers.
 
 config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
@@ -305,14 +305,14 @@ config ARC_TIMERS
 	help
 	  These are legacy 32-bit TIMER0 and TIMER1 counters found on all ARC cores
 	  (ARC700 as well as ARC HS38).
-	  TIMER0 serves as clockevent while TIMER1 provides clocksource
+	  TIMER0 serves as clockevent while TIMER1 provides clocksource.
 
 config ARC_TIMERS_64BIT
 	bool "Support for 64-bit counters in ARC HS38 cores" if COMPILE_TEST
 	depends on ARC_TIMERS
 	select TIMER_OF
 	help
-	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP)
+	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP).
 	  RTC is implemented inside the core, while GFRC sits outside the core in
 	  ARConnect IP block. Driver automatically picks one of them for clocksource
 	  as appropriate.
@@ -390,7 +390,7 @@ config ARM_GLOBAL_TIMER
 	select TIMER_OF if OF
 	depends on ARM
 	help
-	  This options enables support for the ARM global timer unit
+	  This option enables support for the ARM global timer unit.
 
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
@@ -403,14 +403,14 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLO
 	depends on ARM_GLOBAL_TIMER
 	default y
 	help
-	 Use ARM global timer clock source as sched_clock
+	  Use ARM global timer clock source as sched_clock.
 
 config ARMV7M_SYSTICK
 	bool "Support for the ARMv7M system time" if COMPILE_TEST
 	select TIMER_OF if OF
 	select CLKSRC_MMIO
 	help
-	  This options enables support for the ARMv7M system timer unit
+	  This option enables support for the ARMv7M system timer unit.
 
 config ATMEL_PIT
 	bool "Atmel PIT support" if COMPILE_TEST
@@ -460,7 +460,7 @@ config VF_PIT_TIMER
 	bool
 	select CLKSRC_MMIO
 	help
-	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
+	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
 
 config OXNAS_RPS_TIMER
 	bool "Oxford Semiconductor OXNAS RPS Timers driver" if COMPILE_TEST
@@ -523,7 +523,7 @@ config SH_TIMER_MTU2
 	help
 	  This enables build of a clockevent driver for the Multi-Function
 	  Timer Pulse Unit 2 (MTU2) hardware available on SoCs from Renesas.
-	  This hardware comes with 16 bit-timer registers.
+	  This hardware comes with 16-bit timer registers.
 
 config RENESAS_OSTM
 	bool "Renesas OSTM timer driver" if COMPILE_TEST
@@ -580,7 +580,7 @@ config CLKSRC_TANGO_XTAL
 	select TIMER_OF
 	select CLKSRC_MMIO
 	help
-	  This enables the clocksource for Tango SoC
+	  This enables the clocksource for Tango SoC.
 
 config CLKSRC_PXA
 	bool "Clocksource for PXA or SA-11x0 platform" if COMPILE_TEST
@@ -600,15 +600,15 @@ config H8300_TMR16
         bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
         depends on HAS_IOMEM
 	help
-	  This enables the 16 bits timer for the H8300 platform with the
-	  H83069 cpu.
+	  This enables the 16-bits timer for the H8300 platform with the
+	  H83069 CPU.
 
 config H8300_TPU
         bool "Clocksource for the H8300 platform" if COMPILE_TEST
         depends on HAS_IOMEM
 	help
 	  This enables the clocksource for the H8300 platform with the
-	  H8S2678 cpu.
+	  H8S2678 CPU.
 
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
@@ -666,8 +666,8 @@ config CSKY_MP_TIMER
 	help
 	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
 	  system.
-	  csky,mptimer is not only used in SMP system, it also could be used
-	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
+	  csky,mptimer is not only used in SMP system, it also could be used in
+	  single core system. It's not a mmio reg and it uses mtcr/mfcr instruction.
 
 config GX6605S_TIMER
 	bool "Gx6605s SOC system timer driver" if COMPILE_TEST

