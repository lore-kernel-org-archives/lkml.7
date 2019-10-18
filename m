Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3CDCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9947B20659
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394076AbfJRQbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:31:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443020AbfJRQbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:31:14 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MK3mS-1icTm63Lji-00LXiw; Fri, 18 Oct 2019 18:31:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH 3/6] ARM: ep93xx: make mach/ep93xx-regs.h local
Date:   Fri, 18 Oct 2019 18:29:16 +0200
Message-Id: <20191018163047.1284736-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018163047.1284736-1-arnd@arndb.de>
References: <20191018163047.1284736-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Tlr/kGU2mrcS/i0RZ/FxB2SYCWQT8PnsZqB5BcF7KAjcRmXLUoF
 F9tlGC+3wNa5O5ykqO5dAN2TDQM0ig59FE1SOufdFwBDz5f7Eln7CUeDvq9Y5oe8gDIq3g6
 0fDwY3z/aNnIGAGFB9uIwbx/4hf4Sc2khW/mncHRod8MA9YGAGM5IP+7H767jo4JR3PB0F4
 8sIvE5utwNvgPaEv9jxSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+IHzhn3/5XI=:3+rOIP+88JYxotOIBrvwLn
 epLEJlm/bm1m6smJnYwY6LsWyjAWKtgnQ9SOQ1u1kLeWB4lVdkM1zyfETbpfqKTI3gtUQGb31
 7qvGQHo1ULmo3Kcwtgr/UMu/gNteiLmFh/FAjMCsWYbuv2y/FHnMPcmxDE6i4Wcg8hG6AHe5D
 auu0neWcvGuz5x6a4Pm6qHdFAELbHITngSBERzCYCkXBslEu1GcriGPbjubkt1nSMubPeOotQ
 /wUVDcOCmjJW8SlkBXiyaq7FBonl9BJUiwHHae6BrNzbwIJ0Z0WBywyTwqa7KzCAAZ9uZAGeY
 Rwn8hCH/JxbigA6n0Mu3WItmFLp4q9G6BXZFOggU1gFZg8kQB2B9e040Vk1B9axLzdu4NCGas
 NwPyzWqBGQd/SKn+S5jj4N5o41KkOk6HIJHLo/8uowM6eNHLCoX9iCZtfV+JbcCGLUPB0gva+
 etKp0YR9PCqjM3XjNiEwG9GysIP3HwQhZsQXRevLaqxtKPPh4QMkiw8tSoBMcPmFg6LYA5TTP
 dUWZOa/RvaL0rWzwdkgHOKi1sQmPotgs/y1WT5TI6uFHbFcFa3gNH9xhbDn1Wh/6uGx30cnbJ
 BgSlkjCou75M88kQbYGA1AOFWlIjW61hwm3jgPyWDon5z9bSGabmFB3DpHvFyOk+/oVw0dmrT
 NiD4hjy1o/Qsl5x7GWyNtJielZuoTj0gA3hSqaSdbQ0bpTbj9WMm6VpfNIE0qO5Rxvpx/ORgk
 jiM+56LMmAnxwY+UHxwG2so4GiG7WoNonQZSjUZj4BolzLlCXquFNDA/GgN/HVDSEpGMNU5Xx
 dtZtdH5FQp92SsdBIp11mJF5v0aPISl62FxZ6rx1yWCCNbdxZHOGiBHJ4XhoW5OgL0wlUtbx8
 gHaq77S5t+W3wz9jnl3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing relies on it outside of arch/arm/mach-ep93xx/, so just move
it there.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ep93xx/crunch-bits.S                    | 2 +-
 arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h | 4 ----
 arch/arm/mach-ep93xx/gpio-ep93xx.h                    | 2 +-
 arch/arm/mach-ep93xx/include/mach/uncompress.h        | 1 -
 arch/arm/mach-ep93xx/soc.h                            | 2 +-
 5 files changed, 3 insertions(+), 8 deletions(-)
 rename arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h (94%)

diff --git a/arch/arm/mach-ep93xx/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
index fb2dbf76f09e..e6dd08538bb9 100644
--- a/arch/arm/mach-ep93xx/crunch-bits.S
+++ b/arch/arm/mach-ep93xx/crunch-bits.S
@@ -14,7 +14,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
-#include <mach/ep93xx-regs.h>
+#include "ep93xx-regs.h"
 
 /*
  * We can't use hex constants here due to a bug in gas.
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/ep93xx-regs.h
similarity index 94%
rename from arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
rename to arch/arm/mach-ep93xx/ep93xx-regs.h
index 6839ea032e58..8fa3646de0a4 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/ep93xx-regs.h
@@ -1,8 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
- */
-
 #ifndef __ASM_ARCH_EP93XX_REGS_H
 #define __ASM_ARCH_EP93XX_REGS_H
 
diff --git a/arch/arm/mach-ep93xx/gpio-ep93xx.h b/arch/arm/mach-ep93xx/gpio-ep93xx.h
index 242af4a401ea..7b46eb7e5507 100644
--- a/arch/arm/mach-ep93xx/gpio-ep93xx.h
+++ b/arch/arm/mach-ep93xx/gpio-ep93xx.h
@@ -4,7 +4,7 @@
 #ifndef __GPIO_EP93XX_H
 #define __GPIO_EP93XX_H
 
-#include <mach/ep93xx-regs.h>
+#include "ep93xx-regs.h"
 
 #define EP93XX_GPIO_PHYS_BASE		EP93XX_APB_PHYS(0x00040000)
 #define EP93XX_GPIO_BASE		EP93XX_APB_IOMEM(0x00040000)
diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index b3ec1db988db..e20bcab702b2 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -5,7 +5,6 @@
  * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
  */
 
-#include <mach/ep93xx-regs.h>
 #include <asm/mach-types.h>
 
 static unsigned char __raw_readb(unsigned int ptr)
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index 770743bbaf80..670884ba754e 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -9,7 +9,7 @@
 #ifndef _EP93XX_SOC_H
 #define _EP93XX_SOC_H
 
-#include <mach/ep93xx-regs.h>
+#include "ep93xx-regs.h"
 #include "irqs.h"
 
 /*
-- 
2.20.0

