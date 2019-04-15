Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8704BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA2B20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfDOTcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:32:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50121 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfDOTcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:32:46 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MQNF3-1hTVSL1VFx-00MJa8; Mon, 15 Apr 2019 21:32:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Lukasz Majewski <lukma@denx.de>,
        Olof Johansson <olof@lixom.net>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: ep93xx: move private headers out of mach/*
Date:   Mon, 15 Apr 2019 21:31:50 +0200
Message-Id: <20190415193231.936070-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415192734.935387-1-arnd@arndb.de>
References: <20190415192734.935387-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ivPYvLLQ2j7TZufmWjXvXUfDmxVt/p/ExL/DvN/KwGxtp+3ub4o
 BOFcaeXUfmSyzCjflApEe+0APEuk1Zm97Xid0XmwZWBqpPxounHwtNu5mUDAXKdJI0ICF8b
 dP4bluOFs3Lhed5QKU/aR7R7mknzx3ogpm0269yUHA/YUOGU9zm9kpmmi2FhLSlJpsKh0AL
 8vsKEcCoQgpJTF174IM2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R6RaNR2FKfw=:9+PYJzJ4YGVkJXT5oF1gpf
 l7BAeuv0K2bZFie6Sby34HkL8lDbW2Sve1N615WI5V9VcssMZND/b5t+Tw/eyQylVlFgOJ+FG
 iBWoiDq8J4YpcRYhWbJRGa+pKNzhRW59+9W9h5sWA1Mivop57grravatgKRK42BqcaTsQyNSt
 rY1HIcNQ8bOUCuEm1O0gsLH5/QslxU75hnn3VeDsoByyetOCV1PeV93hlcgITVWV2hi24xT31
 Z6JR442lnKA5RHIf0ByUa8gxSHXts8gHgxJzCtU8BzU8J92hzMnd+a8hMVDPmTfFNFja0RD2J
 zk/Hdw/SYkpI6THLv3crWPnHo0986ElYEeJnJ2cfn0Axcd05LJRdl3sc8EW8uxb0mnL4exba/
 c2n6XuXUIXENzrcIgpjjuHTybEbDWY/diaKrzse+KozmebEvPdGcRm5yLEYPVzGfBr+OOI4x1
 FbohmfA71xR+vQIeV4EbWUjCbTor7b4TM1h0MSwC4x1S3AFpP4stn5ULaK1P+JAk2yo0gOjQE
 5k78FPZOOEIKtY0Uq+iQYzJSFNs9+gJFLAux0gioaNAMikYnMH3mCbnwUjlsrck4qsWKRUFyh
 fpvno05IhoU2qYW+9b+eQLIOAgdkFSU7FVMpfhe/Kx9B2dH0Vmt9xcUBMB+ch5J9G7YxM+eTq
 mlmSytUftZA2BQiV7O1z0zezNvYj+rMNgWPSsc8yaOD46Zm+zUKergZg1eLgXnvCwfIpzUAgc
 bj1DrKwks29pTidCWyi9a1cHYENBd+SiWO3Nmw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-ep93xx.h, hardware.h, and platform.h are only used in
arch/arm/mach-ep93xx, so we can move them one there and no
longer expose them to device drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ep93xx/adssphere.c                      | 2 +-
 arch/arm/mach-ep93xx/clock.c                          | 2 +-
 arch/arm/mach-ep93xx/core.c                           | 6 +++---
 arch/arm/mach-ep93xx/dma.c                            | 2 +-
 arch/arm/mach-ep93xx/edb93xx.c                        | 4 ++--
 arch/arm/mach-ep93xx/gesbc9312.c                      | 2 +-
 arch/arm/mach-ep93xx/{include/mach => }/gpio-ep93xx.h | 0
 arch/arm/mach-ep93xx/{include/mach => }/hardware.h    | 2 +-
 arch/arm/mach-ep93xx/micro9.c                         | 2 +-
 arch/arm/mach-ep93xx/{include/mach => }/platform.h    | 0
 arch/arm/mach-ep93xx/simone.c                         | 4 ++--
 arch/arm/mach-ep93xx/snappercl15.c                    | 4 ++--
 arch/arm/mach-ep93xx/ts72xx.c                         | 4 ++--
 arch/arm/mach-ep93xx/vision_ep9307.c                  | 4 ++--
 14 files changed, 19 insertions(+), 19 deletions(-)
 rename arch/arm/mach-ep93xx/{include/mach => }/gpio-ep93xx.h (100%)
 rename arch/arm/mach-ep93xx/{include/mach => }/hardware.h (96%)
 rename arch/arm/mach-ep93xx/{include/mach => }/platform.h (100%)

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index bda6c3a5c923..5d3a3e302012 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 9f43362eb62d..b9f523d9dc8c 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -22,7 +22,7 @@
 #include <linux/clkdev.h>
 #include <linux/soc/cirrus/ep93xx.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 
 #include <asm/div64.h>
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 3d245668846d..cc1382f879af 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -39,13 +39,13 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/random.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/keypad-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
 #include <linux/soc/cirrus/ep93xx.h>
 
-#include <mach/gpio-ep93xx.h>
+#include "gpio-ep93xx.h"
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -125,7 +125,7 @@ void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
 /**
  * ep93xx_chip_revision() - returns the EP93xx chip revision
  *
- * See <mach/platform.h> for more information.
+ * See "platform.h" for more information.
  */
 unsigned int ep93xx_chip_revision(void)
 {
diff --git a/arch/arm/mach-ep93xx/dma.c b/arch/arm/mach-ep93xx/dma.c
index 88a4c9b089a5..821427107b11 100644
--- a/arch/arm/mach-ep93xx/dma.c
+++ b/arch/arm/mach-ep93xx/dma.c
@@ -26,7 +26,7 @@
 #include <linux/platform_device.h>
 
 #include <linux/platform_data/dma-ep93xx.h>
-#include <mach/hardware.h>
+#include "hardware.h"
 
 #include "soc.h"
 
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 8e89ec8b6f0f..d96dd014dd23 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -32,10 +32,10 @@
 
 #include <sound/cs4271.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
-#include <mach/gpio-ep93xx.h>
+#include "gpio-ep93xx.h"
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 0cca5b183309..ac48e3476587 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h b/arch/arm/mach-ep93xx/gpio-ep93xx.h
similarity index 100%
rename from arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h
rename to arch/arm/mach-ep93xx/gpio-ep93xx.h
diff --git a/arch/arm/mach-ep93xx/include/mach/hardware.h b/arch/arm/mach-ep93xx/hardware.h
similarity index 96%
rename from arch/arm/mach-ep93xx/include/mach/hardware.h
rename to arch/arm/mach-ep93xx/hardware.h
index 8938906e780a..e7d850e04782 100644
--- a/arch/arm/mach-ep93xx/include/mach/hardware.h
+++ b/arch/arm/mach-ep93xx/hardware.h
@@ -6,7 +6,7 @@
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
 
-#include <mach/platform.h>
+#include "platform.h"
 
 /*
  * The EP93xx has two external crystal oscillators.  To generate the
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 373583c29825..c7f64e4ff6c7 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/platform.h
similarity index 100%
rename from arch/arm/mach-ep93xx/include/mach/platform.h
rename to arch/arm/mach-ep93xx/platform.h
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 80ccb984d521..adc17289cc23 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -27,8 +27,8 @@
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 
-#include <mach/hardware.h>
-#include <mach/gpio-ep93xx.h>
+#include "hardware.h"
+#include "gpio-ep93xx.h"
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index cf0cb58b3454..f8f89551dbed 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -25,9 +25,9 @@
 
 #include <linux/mtd/platnand.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <linux/platform_data/video-ep93xx.h>
-#include <mach/gpio-ep93xx.h>
+#include "gpio-ep93xx.h"
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 85b74ac943f0..bba6aa5d7106 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -23,8 +23,8 @@
 #include <linux/mmc/host.h>
 #include <linux/platform_data/spi-ep93xx.h>
 
-#include <mach/gpio-ep93xx.h>
-#include <mach/hardware.h>
+#include "gpio-ep93xx.h"
+#include "hardware.h"
 #include <mach/irqs.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 767ee64628dc..66e2b34aa779 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -31,10 +31,10 @@
 
 #include <sound/cs4271.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
-#include <mach/gpio-ep93xx.h>
+#include "gpio-ep93xx.h"
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
-- 
2.20.0

