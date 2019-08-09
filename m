Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03BDC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24D420820
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407226AbfHIOqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:46:14 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406127AbfHIOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:46:14 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpTpc-1if78t25mO-00py9b; Fri, 09 Aug 2019 16:45:59 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 12/13] ARM: lpc32xx: clean up header files
Date:   Fri,  9 Aug 2019 16:40:38 +0200
Message-Id: <20190809144043.476786-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809144043.476786-1-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gUv5Djd/kUqZty7AwE14hMF4BlO136N+kfe2FDOX9t6V9ZTl3xJ
 RyDl101DmZmiqt6fWRNui6ntR+M8v6PNq36iqqfyAIEP4TNYQgNva6vtZMNBiqQ5whyMYJl
 uME5uFSbE50zOjXnMdLR0vuRF67iM6tFcgPcX4lSproSYFO+rw88afqDIy4juJQlXKUZE0t
 wesLQIQyeBR+lrUPQBxYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4LZhuL+dm+4=:3OE/ZUQHPHOVTVdznznZXx
 F2OyfC2OjeZoVmm9lNylI73g6dCm780+Ipwl1Jdi2DPqBHoI8GoIw+bBlr2VltLNH6i0vr1q8
 rIF/ySmGXW7tZMB0VllI3+/4vxM8OUyrN6FY6GJ6s+D2Vc8ebnqqAVSRkz6wr0fw7Tw1e6/iV
 44ggRUunEJPwvBl7QtfDFC/qMfm0HGOVMYVKS54R4WSUElA+rnXSN1KKFzrT4NSDePDoKCZtS
 BvCspyedjyK/lMqDDQ9lCcokNNtEJ/pG0dzskxpw/QgrWoQBYsKP8j9FE/oqseoUDJW8t5u7a
 weT9b0bBW8olKPCKmcqPk5g1u7lvm8WvJqNfegItKNeunq1T6YMzyh3xy5FH0psNAOaKeOkDV
 zs5wlKCRUSyJtZk3qc+hRSebTZtQXIFXZXywAYiXFoav/E2JBbefh/yDJwBHwGYt0Sj7LNT4m
 WtWKrDFA4qwAwtjbLZQwCRiATSD95DmAIkB4wwwwZXGAijS9uW3rHvry1L//1C7l9JTIdbAfj
 149HFxwj+/+v5cn805YbC9cXL8BL2skeJz4ITkeL0cC+b7tIc3S6LB/lhkoBAaWnuWMmYnMiE
 QzTXlj+kILJ3jL6TzzPDHVjeV8H4Oxfh4Xm5NS7DmNIRjI7URFYufNbf9yi6WkSEH47AEDN0H
 s/W7fKBWJQl9WozDUmfJSOo5bIGRbo99oghLJCpkag3UMvXddho/VUu7TRFKEjcvc3TXuQ5SU
 IVVDb8PCe6GE4A6py4qZkRfx3pWAjSE1AADxWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All device drivers have stopped relying on mach/*.h headers,
so move the remaining headers into arch/arm/mach-lpc32xx/lpc32xx.h
to prepare for multiplatform builds.

The mach/entry-macro.S file has been unused for a long time now
and can simply get removed.

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-lpc32xx/common.c                |  3 +-
 .../mach-lpc32xx/include/mach/entry-macro.S   | 28 -------------------
 arch/arm/mach-lpc32xx/include/mach/hardware.h | 25 -----------------
 .../mach-lpc32xx/include/mach/uncompress.h    |  4 +--
 .../{include/mach/platform.h => lpc32xx.h}    | 18 ++++++++++--
 arch/arm/mach-lpc32xx/pm.c                    |  3 +-
 arch/arm/mach-lpc32xx/serial.c                |  3 +-
 arch/arm/mach-lpc32xx/suspend.S               |  3 +-
 8 files changed, 21 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/hardware.h
 rename arch/arm/mach-lpc32xx/{include/mach/platform.h => lpc32xx.h} (98%)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index a475339333c1..304ea61a0716 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -13,8 +13,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_info.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "lpc32xx.h"
 #include "common.h"
 
 /*
diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
deleted file mode 100644
index eec0f5f7e722..000000000000
--- a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * arch/arm/mach-lpc32xx/include/mach/entry-macro.S
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
- */
-
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
-#define LPC32XX_INTC_MASKED_STATUS_OFS	0x8
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =IO_ADDRESS(LPC32XX_MIC_BASE)
-	.endm
-
-/*
- * Return IRQ number in irqnr. Also return processor Z flag status in CPSR
- * as set if an interrupt is pending.
- */
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\irqstat, [\base, #LPC32XX_INTC_MASKED_STATUS_OFS]
-	clz	\irqnr, \irqstat
-	rsb	\irqnr, \irqnr, #31
-	teq	\irqstat, #0
-	.endm
diff --git a/arch/arm/mach-lpc32xx/include/mach/hardware.h b/arch/arm/mach-lpc32xx/include/mach/hardware.h
deleted file mode 100644
index 4866f096ffce..000000000000
--- a/arch/arm/mach-lpc32xx/include/mach/hardware.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * arch/arm/mach-lpc32xx/include/mach/hardware.h
- *
- * Copyright (c) 2005 MontaVista Software, Inc. <source@mvista.com>
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-/*
- * Start of virtual addresses for IO devices
- */
-#define IO_BASE		0xF0000000
-
-/*
- * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
- */
-#define IO_ADDRESS(x)	IOMEM(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
-			 IO_BASE)
-
-#define io_p2v(x)	((void __iomem *) (unsigned long) IO_ADDRESS(x))
-#define io_v2p(x)	((((x) & 0x0ff00000) << 4) | ((x) & 0x000fffff))
-
-#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
index a568812a0b91..74b7aa0da0e4 100644
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -12,15 +12,13 @@
 
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
 /*
  * Uncompress output is hardcoded to standard UART 5
  */
 
 #define UART_FIFO_CTL_TX_RESET	(1 << 2)
 #define UART_STATUS_TX_MT	(1 << 6)
+#define LPC32XX_UART5_BASE	0x40090000
 
 #define _UARTREG(x)		(void __iomem *)(LPC32XX_UART5_BASE + (x))
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/lpc32xx.h
similarity index 98%
rename from arch/arm/mach-lpc32xx/include/mach/platform.h
rename to arch/arm/mach-lpc32xx/lpc32xx.h
index 1c53790444fc..5eeb884a1993 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/lpc32xx.h
@@ -7,8 +7,8 @@
  * Copyright (C) 2010 NXP Semiconductors
  */
 
-#ifndef __ASM_ARCH_PLATFORM_H
-#define __ASM_ARCH_PLATFORM_H
+#ifndef __ARM_LPC32XX_H
+#define __ARM_LPC32XX_H
 
 #define _SBF(f, v)				((v) << (f))
 #define _BIT(n)					_SBF(n, 1)
@@ -700,4 +700,18 @@
 #define LPC32XX_USB_OTG_DEV_CLOCK_ON	_BIT(1)
 #define LPC32XX_USB_OTG_HOST_CLOCK_ON	_BIT(0)
 
+/*
+ * Start of virtual addresses for IO devices
+ */
+#define IO_BASE		0xF0000000
+
+/*
+ * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
+ */
+#define IO_ADDRESS(x)	IOMEM(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
+			 IO_BASE)
+
+#define io_p2v(x)	((void __iomem *) (unsigned long) IO_ADDRESS(x))
+#define io_v2p(x)	((((x) & 0x0ff00000) << 4) | ((x) & 0x000fffff))
+
 #endif
diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index 32bca351a73b..b27fa1b9f56c 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -70,8 +70,7 @@
 
 #include <asm/cacheflush.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "lpc32xx.h"
 #include "common.h"
 
 #define TEMP_IRAM_AREA  IO_ADDRESS(LPC32XX_IRAM_BASE)
diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index cfb35e5691cd..3e765c4bf986 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -16,8 +16,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "lpc32xx.h"
 #include "common.h"
 
 #define LPC32XX_SUART_FIFO_SIZE	64
diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
index 374f9f07fe48..3f0a8282ef6f 100644
--- a/arch/arm/mach-lpc32xx/suspend.S
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -11,8 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <mach/platform.h>
-#include <mach/hardware.h>
+#include "lpc32xx.h"
 
 /* Using named register defines makes the code easier to follow */
 #define WORK1_REG			r0
-- 
2.20.0

