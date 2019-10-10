Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C65CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA54208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfJJUdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:33:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfJJUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:33:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MzkK9-1hwIm602W9-00vgsN; Thu, 10 Oct 2019 22:33:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/36] ARM: samsung: move CONFIG_DEBUG_S3C_UART to Kconfig.debug
Date:   Thu, 10 Oct 2019 22:29:50 +0200
Message-Id: <20191010203043.1241612-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VmHDwku6i4VFjARXnLpCnVfD1UydvgapREzXhkJu6fdnoPO6rGu
 wYNUVRWspbYvsxlJp6FrcEsKsYXxN3QY10wAjgP+Q+GpOa8M78RLLLgVXBRpwKxB7nuFrT5
 m8BNvREHqKlmoiI+7tmh6PYfqdVQC4WbmJm61FLBpeqopAU09S4pH+sNtF4zKqhSqS99Xk7
 XETf6ONqXOzE5fohLQDsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:syw+MREByLs=:yac/rd2RcuQULIkRgyTTBo
 c+o1mKThTiyRhSdrr6qj5jCq0IsmzixGLCkiNO/dhMmPRSmIurHIxL6kec769amngCLt6PbtS
 boTNDNG6d/rg+51TYiHYvNkNpB0s1RHaYhTRYWraq4VSjMTJMA6Av/TbF8iV/3zfiZz/OM4RM
 +Apn5+/gZKOPySfwFFMU2FFNHOSAf9bQHSD++6L6/lWZbXrDh+Ra+ld5OmINnwPh6XwXD2YKf
 YV1zXsJBhFXIpQIWLjQPfsSFamHDvGFPZcCztCwI0k4uANXziPuoPavP9ksEDWDRCRRakRPt+
 5AA5UQVfsL71mHQUSQ9S3cBwiuv9SzPab9sPtA38yIdE14y6Ui1h58DVgu9e6ou+mRo9PNpBs
 wPPy4TA+B9op+XSHi3IRYGL3Sk7Nm0ZGMOE1CsOS2QnjeFGTo0UA0xwNe8gj7Y51XzhzfdAfM
 babYDy1qVE5INVd0Xz9FiLe++3wKG9e7BBxc4yurfxzKNgpfgXpqY1freUuNn26dTaGqTnA8G
 g5Wdkjt0d1RwGJ7LXZ/BjTqUHKrpLOuOOmJOPfxq7q1MDAWavY84Slr8ijB3iLs9oSjwXdkDn
 sZYV2ne5dtJEdL4JKOvxxKOTwLAmjmzMzm9Ynx70ZSkbk4YsbjXUXGxrl5VJmluMYWF8oJwyC
 EkkqiGMlYoEkEzjwBk1r0uOZZKzPr0w5GntVdWskV3IjPeIF2YoJsIfKxrkz56PXYZUPS+wre
 RHAlhkcjD/rMh5uoHSONiLVpxb11mY9mpF4wEE675fqAHATgjm0LtjzIE9A14Phnj/Q29/PNc
 jcRW0KAEooAEgAm7080BbxrMJ/z7lhoQkmvda4IB4aGcM1tE6WK2ye2hiF9LCMgmwuErCohd0
 SNtANEAe5rYehMohjGCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we can plat-samsung from the individual platforms,
this one has to get moved to a place where it remains
accessible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug        | 10 ++++++++++
 arch/arm/plat-samsung/Kconfig |  8 --------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8bcbd0cd739b..d05b836dfeb2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1464,6 +1464,16 @@ config DEBUG_S3C64XX_UART
 config DEBUG_S5PV210_UART
 	bool
 
+config DEBUG_S3C_UART
+	depends on DEBUG_S3C2410_UART || DEBUG_S3C24XX_UART || \
+		   DEBUG_S3C64XX_UART ||  DEBUG_S5PV210_UART || \
+		   DEBUG_EXYNOS_UART
+	int
+	default "0" if DEBUG_S3C_UART0
+	default "1" if DEBUG_S3C_UART1
+	default "2" if DEBUG_S3C_UART2
+	default "3" if DEBUG_S3C_UART3
+
 config DEBUG_OMAP2PLUS_UART
 	bool
 	depends on ARCH_OMAP2PLUS
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 301e572651c0..832ab0e6cd72 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -296,13 +296,5 @@ config SAMSUNG_WDT_RESET
 	  Compile support for system restart by triggering watchdog reset.
 	  Used on SoCs that do not provide dedicated reset control.
 
-config DEBUG_S3C_UART
-	depends on PLAT_SAMSUNG
-	int
-	default "0" if DEBUG_S3C_UART0
-	default "1" if DEBUG_S3C_UART1
-	default "2" if DEBUG_S3C_UART2
-	default "3" if DEBUG_S3C_UART3
-
 endmenu
 endif
-- 
2.20.0

