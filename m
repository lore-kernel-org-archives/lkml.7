Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DEBC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4903B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfJJUjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:39:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfJJUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:39:04 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MlL5x-1hoan32nCH-00llHL; Thu, 10 Oct 2019 22:38:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/36] ARM: s3c64xx: remove mach/hardware.h
Date:   Thu, 10 Oct 2019 22:29:56 +0200
Message-Id: <20191010203043.1241612-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OXe9QnfIOm2QB7E89P7eHTIAVvdAUR8mNrxxSaX9vBslXNpzA9w
 Lg+aJ+KE73cm6jXF7a1hIijERFXs9Yq/KzYJQAoVZk3PGgnOkaO+oS0kOazRYUFMvsVN9xI
 6zys/ptdflbTnlNoqYrjnMzd98Fn8RfCEglT6NWiG7Sl1sqH3/wb3uRbAh1P6NiYtYrDFH3
 9IImxelmRSj0RdAu1eiWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hs2OK14Huk4=:UoqLsaEEin+XUyqgAC0Bbu
 8DzXYBz0uUZcngn/LCWTOPtv5gd/AuAugN8yEUtvb9+uUz7f/QThRZ2vwWIVx0QGnXhDbvhZQ
 eYNUfVHgkHtL6QlL6RhucARKyWVZaxCPLhiTZ0cHWJBkI4w4DSzSqx9+fWw8WxaNeHRFurbDS
 28cqGO7FjkfeXVE4l1d7JW2VE2hxlHo4zIWT0KJfzJ6cXjkSDWeF3Cn5tjqdSc+IoEeUYt/KT
 xmLJNHI4KEsaKyMxOS0/TA2Uw+1vJUXeo4ERg6jOSyTqbyotKO4Rf0EJ9HoJ6CPJqHZ80sdOp
 GU8oW68vcNDeuPXFhzd0zHYMIrLHdP1SjJ3id0pDfZWxcnGBA/6cXwjEKVcmxitXXGTTIcEDW
 hOY/xlpijCx2UxAK+aTDa6q9NSL5gPsB1gEOci5+aLt+ZAqBD/qJRwNWiNVWdtl7cpyoM1Rnt
 uCKH7VnmuqTN3hJ3SoqLEw0LmvsTLiwwcjeJyYBXQ60/bDTgcoF0zAPN7zpUiWimGOFeVMhub
 usP/44lqKL7GGu7hG8pTR2BjN8XwJ98RM0plbqpuW3oi/gmnbvSBg3gRjtWfnUfKB464nizoC
 j4rCFQgt1ffip5sIusR2xYZfSoAmVHofEI4MClDtefSLRUUpfr8VRet5kP1EiZ3/hbyIIRp3m
 85+nUPPm5CHyQZt9b8bfol/8I5BmlDY2XP8ZA9j7VlPePzR0mp3gkn3s/niVv8ndNX93H5yDR
 aE8EgdUvHpF3Q1cLO33KutOMplv/n/61Eg3cBwRbxOiRukZamUlLgQvFW7+yJRZxzac15zSgx
 JJ0ax0++Xvua5WXN1PdKowbvMAlgYNR/6W/9opEZrtYwgGpirLvRFSzWrRDl8bAgk4uksHdeD
 92rdQipwb7tiSo0bheMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header is empty and conflicts with the s3c24xx version
of the same file when we merge the two, so stop including it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c64xx/common.c                |  1 -
 arch/arm/mach-s3c64xx/dev-uart.c              |  1 -
 arch/arm/mach-s3c64xx/include/mach/hardware.h | 17 -----------------
 arch/arm/mach-s3c64xx/mach-anw6410.c          |  1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c         |  1 -
 arch/arm/mach-s3c64xx/mach-hmt.c              |  1 -
 arch/arm/mach-s3c64xx/mach-ncp.c              |  1 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c         |  1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c         |  1 -
 arch/arm/mach-s3c64xx/s3c6400.c               |  1 -
 arch/arm/mach-s3c64xx/s3c6410.c               |  1 -
 11 files changed, 27 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/hardware.h

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 13e91074308a..19d544f6808a 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -36,7 +36,6 @@
 
 #include <mach/map.h>
 #include <mach/irqs.h>
-#include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 
diff --git a/arch/arm/mach-s3c64xx/dev-uart.c b/arch/arm/mach-s3c64xx/dev-uart.c
index 5fb59ad30008..021a2b7926fa 100644
--- a/arch/arm/mach-s3c64xx/dev-uart.c
+++ b/arch/arm/mach-s3c64xx/dev-uart.c
@@ -15,7 +15,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/hardware.h b/arch/arm/mach-s3c64xx/include/mach/hardware.h
deleted file mode 100644
index c4ed359474de..000000000000
--- a/arch/arm/mach-s3c64xx/include/mach/hardware.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* linux/arch/arm/mach-s3c6400/include/mach/hardware.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C6400 - Hardware support
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H __FILE__
-
-/* currently nothing here, placeholder */
-
-#endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 0d3d5befb806..44858c5aea5d 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -30,7 +30,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <mach/map.h>
 
 #include <asm/irq.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 8ec6a4f5eb05..da5b50981a14 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -44,7 +44,6 @@
 #include <asm/mach-types.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index bfe9881d12cc..a6634fd9e6c4 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -25,7 +25,6 @@
 #include <asm/mach/irq.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 13fea5c86ca3..34a00b33fae9 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -25,7 +25,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 
 #include <asm/irq.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index cbd16843c7d1..885158f0a304 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -23,7 +23,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 908e5aa831c8..95bdcfe95a53 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -45,7 +45,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/map.h>
 
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 545eea716db8..81233495d548 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -26,7 +26,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 
 #include <plat/cpu-freq.h>
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 47e04e019624..9465a6e0f068 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -27,7 +27,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 
 #include <plat/cpu-freq.h>
-- 
2.20.0

