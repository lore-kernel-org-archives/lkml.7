Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7788CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C01921852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505440AbfJRPoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:44:14 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408937AbfJRPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:42 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MhDAi-1hr5aP3RY2-00eKEx; Fri, 18 Oct 2019 17:42:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>
Subject: [PATCH 12/46] ARM: pxa: make addr-map.h header local
Date:   Fri, 18 Oct 2019 17:41:27 +0200
Message-Id: <20191018154201.1276638-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8WoOYpFjU7VWVDju/eEJLMj2+XGDEzE9YwdV9g62F5wRGpwSEAH
 9Nl2dp8EgqQjF6Bpzq+oxUNbh9GabQyK/XF9d5BFAPggcSEjWQLhw0vplYeToUl4PQeZMzY
 FfelPX9bKVQ5NPpxDdOMX18TmSVgdo9yaZNvAsnsC0rl5jGES262IvSTsgAgPubrYQiXv7h
 KMQhW1HIdgo1jC4JKkcOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KFSZbybX0NQ=:cAV3UCZ9dED3v79KGzQDQm
 jaaHcwMByoDbWGaLU5ipaA0BOTip1EFY4V8Hesrbv7uMZ/PnWXgXS2aJksblS8sE4NRZKJNcs
 j4q6Zt/OJ8QcCz4FR9AVYg0uPrY2an3H859SfijuswAeKa5CoZwHjxUzFQDa0mAOBwbh6NgSt
 uPI+qMONy824pAhEVbSUtxst/z5GOy127HTQbDYre6ru34vFk2M9HgDW6n7toBdqbN7xNwyG/
 /0aT7HEqP99VHQ1KqLjuFo0NZ3XJyD2KfIduyaTPV2sZcnQicq8UO9FNyNDz5VpkE9P9Txdaj
 Hmkb30t0XuBYYsNlzScZ+qStcbQkklaAiPL8Z0VRkYAeaWmN5Diwo7fp6EnYuA0bhf2jCoE/h
 lpgyLtQZiNPyzvsO98LR73KaH8w31JVNE3xFJ2whPAEZMMxSE2DyhkiM72BAqTMcA/h7FZbxM
 nbcrRxtvp3f5rZPLYN+VPs4CRNyIjsPnN+kPDkSvuLk7bmwgOBZNGqlUaVxz4l1z6O0Ghwpac
 DwApcPvFcf4OFd657oh102WbBTd3vEoWt0lFseaNaT+S229sP+1kFzrjdS2rDDVBwEMYF7BLu
 3iNNnqzjmoybdLBpe11BxYyLqTwv7r2xEcpoB5oQyNDl6Es1Eh8B3BxFVOxOtIDRxWcDTcM3j
 MJ7L9s5EOhp3EnZRx9+2I/ZFLe8ItdBe1qcnZb5I0+A58nmGJGVI3R+xxfUGkSIOey5ja4Y2O
 91Su67sVpcAqwijNukO8Sd529hx20gtGEejU5e9bs14ymMuo89A9EgCtxADPxVJsh27qZ30hh
 dNXHU85MeLZVIC67Mqm6FKJtLSpBOeklcws3M/CniR/Lq2rilJHViR7LdiMR4Mi1iZgL+lxAf
 ycDCeFzRlJg8YoQhiPNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should not rely on the contents of this file, so
move it into the platform directory directly.

Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/{include/mach => }/addr-map.h | 0
 arch/arm/mach-pxa/cm-x2xx.c                     | 2 +-
 arch/arm/mach-pxa/generic.c                     | 2 +-
 arch/arm/mach-pxa/hx4700.c                      | 2 +-
 arch/arm/mach-pxa/include/mach/trizeps4.h       | 2 +-
 arch/arm/mach-pxa/lpd270.c                      | 2 +-
 arch/arm/mach-pxa/magician.c                    | 2 +-
 arch/arm/mach-pxa/mainstone.c                   | 2 +-
 arch/arm/mach-pxa/pxa25x.c                      | 2 +-
 arch/arm/mach-pxa/pxa25x.h                      | 2 +-
 arch/arm/mach-pxa/pxa27x.c                      | 2 +-
 arch/arm/mach-pxa/pxa27x.h                      | 2 +-
 arch/arm/mach-pxa/pxa3xx.c                      | 2 +-
 arch/arm/mach-pxa/pxa3xx.h                      | 2 +-
 arch/arm/mach-pxa/xcep.c                        | 2 +-
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/addr-map.h (100%)

diff --git a/arch/arm/mach-pxa/include/mach/addr-map.h b/arch/arm/mach-pxa/addr-map.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/addr-map.h
rename to arch/arm/mach-pxa/addr-map.h
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index b13fcc72abab..9b030eccd548 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -33,7 +33,7 @@
 #undef GPIO88_GPIO
 #undef GPIO89_GPIO
 #include <linux/platform_data/asoc-pxa.h>
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/smemc.h>
 
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 3c3cd90bb9b4..f9083c4f0aea 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -22,7 +22,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/irqs.h>
 #include <mach/reset.h>
 #include <mach/smemc.h>
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 4dce8834c5b6..b3dcbe291e13 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -41,7 +41,7 @@
 #include <asm/mach/arch.h>
 
 #include "pxa27x.h"
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/hx4700.h>
 #include <linux/platform_data/irda-pxaficp.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/trizeps4.h b/arch/arm/mach-pxa/include/mach/trizeps4.h
index 27926629f9c6..b6c19d155ef9 100644
--- a/arch/arm/mach-pxa/include/mach/trizeps4.h
+++ b/arch/arm/mach-pxa/include/mach/trizeps4.h
@@ -11,7 +11,7 @@
 #ifndef _TRIPEPS4_H_
 #define _TRIPEPS4_H_
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include "irqs.h" /* PXA_GPIO_TO_IRQ */
 
 /* physical memory regions */
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index c59fd2624f91..6f3b7ca4d899 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -38,7 +38,7 @@
 
 #include "pxa27x.h"
 #include "lpd270.h"
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <linux/platform_data/asoc-pxa.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index ce4c677be868..e925f7a8d349 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -35,7 +35,7 @@
 #include <asm/system_info.h>
 
 #include "pxa27x.h"
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/magician.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index ed505de6b5d9..5f7bc5a9215e 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -51,7 +51,7 @@
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/keypad-pxa27x.h>
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index dfc90b41fba3..8d21c7eef1d2 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -34,7 +34,7 @@
 #include "pxa25x.h"
 #include <mach/reset.h>
 #include "pm.h"
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/pxa25x.h b/arch/arm/mach-pxa/pxa25x.h
index 403bc16c2ed2..4699ebf7b486 100644
--- a/arch/arm/mach-pxa/pxa25x.h
+++ b/arch/arm/mach-pxa/pxa25x.h
@@ -2,7 +2,7 @@
 #ifndef __MACH_PXA25x_H
 #define __MACH_PXA25x_H
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/pxa2xx-regs.h>
 #include "mfp-pxa25x.h"
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 38fdd22c4dc5..c36a9784fab8 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -33,7 +33,7 @@
 #include <mach/reset.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include "pm.h"
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/pxa27x.h b/arch/arm/mach-pxa/pxa27x.h
index 6c99090647d2..bf2755561fe5 100644
--- a/arch/arm/mach-pxa/pxa27x.h
+++ b/arch/arm/mach-pxa/pxa27x.h
@@ -3,7 +3,7 @@
 #define __MACH_PXA27x_H
 
 #include <linux/suspend.h>
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/pxa2xx-regs.h>
 #include "mfp-pxa27x.h"
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 7c569fa2a6da..7881888107c7 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -32,7 +32,7 @@
 #include <mach/reset.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include "pm.h"
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/smemc.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-pxa/pxa3xx.h b/arch/arm/mach-pxa/pxa3xx.h
index 22ace053ea25..6b424d328680 100644
--- a/arch/arm/mach-pxa/pxa3xx.h
+++ b/arch/arm/mach-pxa/pxa3xx.h
@@ -2,7 +2,7 @@
 #ifndef __MACH_PXA3XX_H	
 #define __MACH_PXA3XX_H
 
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/pxa3xx-regs.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index e6ab428287ae..7389e0199144 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -25,7 +25,7 @@
 #include <asm/mach/map.h>
 
 #include "pxa25x.h"
-#include <mach/addr-map.h>
+#include "addr-map.h"
 #include <mach/smemc.h>
 
 #include "generic.h"
-- 
2.20.0

