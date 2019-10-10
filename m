Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B913208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfJJUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:48:48 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:48:47 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTfgb-1ifaUZ33Ur-00U5u3; Thu, 10 Oct 2019 22:48:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/36] ARM: s3c: include mach/irqs.h where needed
Date:   Thu, 10 Oct 2019 22:30:08 +0200
Message-Id: <20191010203043.1241612-24-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mxR2atMIkFLn1IgJFwrmFpipyrqnk7641DccCJyjICtC4J7j5YR
 9EAWFeoHeBXLUfhhhmvgttKCxljJ1ys2sQ/cCilSl03dwLrvgwxuIv3Tn5d3RVHQ5nPsfWT
 7MJ/qMgYYvU+7VhT2As0ZvQBR/EoIkJP7+4lawhMfXBrDNlqi0LMDyfzWD/m/sekrGpwW1j
 QfuwcSrnJpeH014Y8jFAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z61gxMjaFVs=:Ih3uXFePxNcmJWJvunNRK+
 a42+5Emq9WsBlyCKcwMEIv11ikzptUKw4hOu5fy2eKjYFbAMpbi4fwf6xj09eu0vA1btJainS
 SrYfAPCG8WEWT4Wc570ENO4HD90TYXP/N8QxnGBxz6W6I/3kOdqUVwYILzPGXlwi2gSPiXAwV
 k2ADuuG+gihtNHztSjDrL9LCviLd6gB4chSZnOni7uRd2tWNyZQy3zQhvw8zojzli/i8Aj2j5
 8Eieqryg2oXn7d8Xns1DXcz4sJgJbyuYLhZL1Nhc1FDjMfXu7KDnilQbM48YpvFCO1O7IXzfb
 V9GjsePa4oXqxrpaDq3Kh72WUsDtVR5s7f+GcTcp22zvoAIBHHWOSRZmw2GWNe/YHJXr+9MVu
 8p8GGywKQuNDCz/buIFiRvuA/O4KETGSPsqLyk7YGzQ2SxAK6R3ZHu+/C+9HdryTJyhhr0Sjx
 k0M4NgTxZpqGOCbbANBGbUAVMQi8yrx4IpEuJuEL3c1obC28/BGwZrtsp9whpxkKLtdi/KyTH
 wHj4x1g87s43AAzEJouRQuoTO8LFspykPuz87PQPVDcnNtpb3hhj3Ecrc+qnQAMrSiqeDrwVH
 zV/a2TvN4zP7bgKoDR3EqUB2Wosl3m9UjLPae3ZYIrs46V5OpriIBCJuMxqEjMxbJHlKnXZJ+
 IPBGoMZV+HOdQOUynXx0ZQLP9SWlay5GKFPOSz16SLrdt64gN101rs3euTyDiTi8DpI8oOqz6
 DkUkqPGIQ1OJXO9sAEkGJXoTXfB1JfUInfzMTqslQDEBT5Wgc10njpsCMGC1qFq82YJCQOWDE
 3gSrhRFy2QnjnhvQJGRn21flQXQ/+1RlVYKo/F5OEW5TnLJCFZSaAulG/4aQbA1OvGfEwQ39P
 hP1/CjFjJ20Fe7d9iNkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparing for a later conversion to sparse IRQs, this ensures that
the mach/irqs.h header is still visible in files that reference
an IRQ number.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/bast-ide.c    | 1 +
 arch/arm/mach-s3c24xx/bast-irq.c    | 1 +
 arch/arm/mach-s3c24xx/common.h      | 1 +
 arch/arm/mach-s3c24xx/irq-s3c24xx.c | 1 +
 arch/arm/mach-s3c24xx/pm-s3c2412.c  | 2 ++
 arch/arm/mach-s3c24xx/s3c2443.c     | 1 +
 arch/arm/mach-s3c24xx/simtec-usb.c  | 1 +
 7 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/bast-ide.c b/arch/arm/mach-s3c24xx/bast-ide.c
index 067944398f46..ee6fbb407640 100644
--- a/arch/arm/mach-s3c24xx/bast-ide.c
+++ b/arch/arm/mach-s3c24xx/bast-ide.c
@@ -20,6 +20,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 
 #include "bast.h"
 
diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
index 03728058d58d..4cec084ae443 100644
--- a/arch/arm/mach-s3c24xx/bast-irq.c
+++ b/arch/arm/mach-s3c24xx/bast-irq.c
@@ -17,6 +17,7 @@
 
 #include <mach/hardware.h>
 #include <mach/regs-irq.h>
+#include <mach/irqs.h>
 
 #include "bast.h"
 
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index d087b20e8857..97eb72f1d8bf 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -10,6 +10,7 @@
 #define __ARCH_ARM_MACH_S3C24XX_COMMON_H __FILE__
 
 #include <linux/reboot.h>
+#include <mach/irqs.h>
 
 struct s3c2410_uartcfg;
 
diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx.c b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
index d2031fecc386..b0e879ee14c1 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
@@ -25,6 +25,7 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
+#include <mach/irqs.h>
 #include <mach/regs-irq.h>
 #include <mach/regs-gpio.h>
 
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index 2dfdaab0aa1f..1ad9c61f9253 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -20,6 +20,8 @@
 #include <asm/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
+
 #include <mach/regs-gpio.h>
 
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index 313e369c3ddd..f404ecac4baf 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -25,6 +25,7 @@
 
 #include <mach/hardware.h>
 #include <mach/gpio-samsung.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
diff --git a/arch/arm/mach-s3c24xx/simtec-usb.c b/arch/arm/mach-s3c24xx/simtec-usb.c
index dc1016ffed94..b15e0c49fa11 100644
--- a/arch/arm/mach-s3c24xx/simtec-usb.c
+++ b/arch/arm/mach-s3c24xx/simtec-usb.c
@@ -25,6 +25,7 @@
 
 #include <mach/hardware.h>
 #include <mach/gpio-samsung.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 
 #include <linux/platform_data/usb-ohci-s3c2410.h>
-- 
2.20.0

