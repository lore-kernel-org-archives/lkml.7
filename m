Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05562C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE48520820
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407229AbfHIOql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:46:41 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfHIOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:46:41 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M91Tq-1hzxWA3eR4-0068fZ; Fri, 09 Aug 2019 16:46:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 13/13] ARM: lpc32xx: allow multiplatform build
Date:   Fri,  9 Aug 2019 16:40:39 +0200
Message-Id: <20190809144043.476786-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809144043.476786-1-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZpjjCgarnGP5OJJp7WqQXWJgBqErfvsp1pHllIlsTishTCM846M
 jagMW25mCiPe3qu3M4uGN7g2QnCf34G9GnKrz0TqjJSnZ6Q+XkjB4nyDo8UTs99GPTy1W9+
 mVhPZdrw8O3cYMWo/365dZVg+gK46PHAFFZYy5FcyFbaoNKm8JEbKDRWzI+ikSvh3TL8+cg
 t0242PhtMh68LzzfofLMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mGfmQMJJPbM=:2+AUq2ZbO8MpEuFsuTDE3V
 /Wrx2sOiWCbaNdmELUyYovk+spLUFWeBJMcah1lTc/GaQWLv64cDA7p+pJhQU4qDQsG0z0y0I
 xJ+E2H4bWCF9ELfnBmJXulydXgn40JBRN+5CBpvShd4XY2ctVQdg+qcB9yBrbTMiN4IVpgh/4
 f9hlw1NtkFuWgeYybeBQsuy535prRveYOqn2BCIAHxWmNhVj2CnKNv7ySWPomminyBKgZzux/
 MEsPCXPyYE/YyiWzyd8yjazfKr2FnKM4swS6YKHb112HOSiNeznqxMN+xHdkxwcpj3sCJ+LlY
 CPWDK3UjP5TVfjV1LqPv2KZ/na1PR8D8rFVXg+LhqIKob9WbGqbMegl/7RY0V0gvu91gjopSD
 L6El8+Nw//G9NySUkDuXFpqtz4UENAMjsh/zXKos7xmjywn0OjUZRpg7uCvjF8cVt3YkwTzbl
 1yq7KtY2EJ/whp1KqtUdsIx5Lu7LwFECQqD4Q8dtMkbUs4aWzv1RG7Eio+XFkGYXuO0z770u9
 kWPktzcKQiO8GyxwAfXLOUckSaY4p9ZRkx4Z/avI+Yj3xjd+5dZfc0vVe6wv/5mDy4gknfzk3
 mBjH1tEAGc56m/qRIA0MBCL2aGZRE9jXwZlIOOkyKqIwiFdxReT/NqQx/QYBfZtvHOkegNXIJ
 UYIb7QJA7jST+yVcIsmS21pomW9dsHq0mU/CkxqloLr9nM9K8+0A1AIvjMxyNOCZVYxPDJvIn
 c0GsggycoOG0ikntFiudD2ZptPiVcBa4VsmlEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All preparation work is done, so the platform can finally
be moved into ARCH_MULTIPLATFORM. This requires a small
change to the defconfig file to enable the platform.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                              | 17 +------
 arch/arm/configs/lpc32xx_defconfig            |  1 +
 arch/arm/mach-lpc32xx/Kconfig                 | 11 +++++
 .../mach-lpc32xx/include/mach/uncompress.h    | 48 -------------------
 4 files changed, 14 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm/mach-lpc32xx/Kconfig
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 33b00579beff..65808e17cb3b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -478,21 +478,6 @@ config ARCH_W90X900
 	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
 		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
 
-config ARCH_LPC32XX
-	bool "NXP LPC32XX"
-	select ARM_AMBA
-	select CLKDEV_LOOKUP
-	select CLKSRC_LPC32XX
-	select COMMON_CLK
-	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_IRQ_MULTI_HANDLER
-	select GPIOLIB
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  Support for the NXP LPC32XX family of processors
-
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
@@ -746,6 +731,8 @@ source "arch/arm/mach-keystone/Kconfig"
 
 source "arch/arm/mach-ks8695/Kconfig"
 
+source "arch/arm/mach-lpc32xx/Kconfig"
+
 source "arch/arm/mach-mediatek/Kconfig"
 
 source "arch/arm/mach-meson/Kconfig"
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 3772d5a8975a..09deb57db942 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -12,6 +12,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_LPC32XX=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
new file mode 100644
index 000000000000..ec87c65f4536
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config ARCH_LPC32XX
+	bool "NXP LPC32XX"
+	depends on ARCH_MULTI_V5
+	select ARM_AMBA
+	select CLKSRC_LPC32XX
+	select CPU_ARM926T
+	select GPIOLIB
+	help
+	  Support for the NXP LPC32XX family of processors
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
deleted file mode 100644
index 74b7aa0da0e4..000000000000
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * arch/arm/mach-lpc32xx/include/mach/uncompress.h
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
- */
-
-#ifndef __ASM_ARM_ARCH_UNCOMPRESS_H
-#define __ASM_ARM_ARCH_UNCOMPRESS_H
-
-#include <linux/io.h>
-
-/*
- * Uncompress output is hardcoded to standard UART 5
- */
-
-#define UART_FIFO_CTL_TX_RESET	(1 << 2)
-#define UART_STATUS_TX_MT	(1 << 6)
-#define LPC32XX_UART5_BASE	0x40090000
-
-#define _UARTREG(x)		(void __iomem *)(LPC32XX_UART5_BASE + (x))
-
-#define LPC32XX_UART_DLLFIFO_O	0x00
-#define LPC32XX_UART_IIRFCR_O	0x08
-#define LPC32XX_UART_LSR_O	0x14
-
-static inline void putc(int ch)
-{
-	/* Wait for transmit FIFO to empty */
-	while ((__raw_readl(_UARTREG(LPC32XX_UART_LSR_O)) &
-		UART_STATUS_TX_MT) == 0)
-		;
-
-	__raw_writel((u32) ch, _UARTREG(LPC32XX_UART_DLLFIFO_O));
-}
-
-static inline void flush(void)
-{
-	__raw_writel(__raw_readl(_UARTREG(LPC32XX_UART_IIRFCR_O)) |
-		UART_FIFO_CTL_TX_RESET, _UARTREG(LPC32XX_UART_IIRFCR_O));
-}
-
-/* NULL functions; we don't presently need them */
-#define arch_decomp_setup()
-
-#endif
-- 
2.20.0

