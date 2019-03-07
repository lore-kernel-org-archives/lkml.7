Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E216C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B9320840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCGWSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:18:50 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:43031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:18:50 -0500
Received: from orion.localdomain ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N49d1-1gsuds0StV-0108VY; Thu, 07 Mar 2019 23:18:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Subject: [PATCH v2] arch: sh: Kconfig: pedantic formatting
Date:   Thu,  7 Mar 2019 23:18:31 +0100
Message-Id: <1551997111-26115-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551905158-29665-1-git-send-email-info@metux.net>
References: <1551905158-29665-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:kgDSpbUy2ei1H0+2/uo7h3OWJ69meQ15rFkm+ezVdeOUYDZHsmw
 oAKYe3eiWm4V7zW6MrRVyMUfGi6exc0A74hpK9qVGZgvewz7gTbceYUvtg3d7zEGRgy5NYX
 e5jrlBd5LBg1crSPzqn/oNoq5IpXhsgn9bZ2Lwzuz/DZ2KxKCVV/SEYk1Nt7S0LdGb70Doz
 Sdr9yiPN2VYceFhcpXRyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ax1Ma+GG8Zs=:6fEEJe1Ly+kGlAbHOM/xYW
 Iddqh1jcManPP0KEeS7iUgvlm8bW4TUdyUVo5TzGhd2l1ukk/M3SRoSXZwQrCsSzHNdVVTD37
 C4glyOyHoyDVhaSZNwSaZsk6mMobKTHLHytK1YA4X8a+SnCE1Q0wOQQUHXUeaGMiJs6/hx/UO
 VpN5ElM5BIQy/D0DUgHL5G1B/hFR3uUNrvydhjdcGQAsZf90jXvC3pJUVpGd59fuICWdOyeq0
 oDdi6l0elY4Yj66Q3q2PMPcUSpRVV3A2+rL23pqBJcUPRBdzHDTkbzU3agC9mpSbZ/ocxKp3Y
 v+W1ojHmRuNuFpehi7PiH6INrkB3N2xWoYf1Sl6iv3mkbV51zCtCqqZbkblk1fBJxStjM2hPD
 6KSb2cT+6PfEuqIhl6xHZPLfC9bForFSial9EtfzkcIdHGaZW8c4rA8/EdB3tPWBxrHVIHHX3
 idQk7/JzeT8PXweuNMEf3kgapU1sXjZpjTB1gZXf2iQSzrt3Wogkl46FTlyegrRaZ/vpFfGHu
 Dh8TkyKQpPBUp6PXp/VebnAR/fv7uw19uA+tGdEDHY8uwN4iDR/QCH151Xp5D+adhE0Yklm7C
 uxrYJHWqRQvu5Qd72Ba1wFbZu+wuSpiuzQjALSSutail5lmLBBpxinfs5SOe3NVGu40wA9hDx
 YU5U7fE9h7fePIB8HzFmW+HwxXiDTOzpc7EGfZQCnPE8BXDIt8fSilSTzbpkqvyRjwnTgHboc
 2Vc1Mb7ksJ9j364BIHPKaW1Kau0c+KzeGLUnEQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up. Just indention changes.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/sh/Kconfig        | 24 ++++++++++++------------
 arch/sh/boards/Kconfig | 10 +++++-----
 arch/sh/mm/Kconfig     |  6 +++---
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d9a9144..e58a470 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -233,9 +233,9 @@ config ARCH_SHMOBILE
 	select PM
 
 config CPU_HAS_PMU
-       depends on CPU_SH4 || CPU_SH4A
-       default y
-       bool
+	depends on CPU_SH4 || CPU_SH4A
+	default y
+	bool
 
 if SUPERH32
 
@@ -266,7 +266,7 @@ config CPU_SUBTYPE_SH7201
 	select CPU_SH2A
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_SH_MTU2
- 
+
 config CPU_SUBTYPE_SH7203
 	bool "Support SH7203 processor"
 	select CPU_SH2A
@@ -549,7 +549,7 @@ endchoice
 endif
 
 source "arch/sh/mm/Kconfig"
- 
+
 source "arch/sh/Kconfig.cpu"
 
 source "arch/sh/boards/Kconfig"
@@ -716,7 +716,7 @@ config GUSA
 	  This is the default implementation for both UP and non-ll/sc
 	  CPUs, and is used by the libc, amongst others.
 
-	  For additional information, design information can be found 
+	  For additional information, design information can be found
 	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
 
 	  This should only be disabled for special cases where alternate
@@ -848,12 +848,12 @@ config MAPLE
 	bool "Maple Bus support"
 	depends on SH_DREAMCAST
 	help
-	 The Maple Bus is SEGA's serial communication bus for peripherals
-	 on the Dreamcast. Without this bus support you won't be able to
-	 get your Dreamcast keyboard etc to work, so most users
-	 probably want to say 'Y' here, unless you are only using the
-	 Dreamcast with a serial line terminal or a remote network
-	 connection.
+	  The Maple Bus is SEGA's serial communication bus for peripherals
+	  on the Dreamcast. Without this bus support you won't be able to
+	  get your Dreamcast keyboard etc to work, so most users
+	  probably want to say 'Y' here, unless you are only using the
+	  Dreamcast with a serial line terminal or a remote network
+	  connection.
 
 endmenu
 
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index b9a3705..a9dc96f 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -39,7 +39,7 @@ config SH_SOLUTION_ENGINE
 	select CPU_HAS_IPR_IRQ
 	depends on CPU_SUBTYPE_SH7705 || CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7710 || \
 	  CPU_SUBTYPE_SH7712 || CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
-	  CPU_SUBTYPE_SH7750R 
+	  CPU_SUBTYPE_SH7750R
 	help
 	  Select SolutionEngine if configuring for a Hitachi SH7705, SH7709,
 	  SH7710, SH7712, SH7750, SH7750S or SH7750R evaluation board.
@@ -97,7 +97,7 @@ config SH_7751_SOLUTION_ENGINE
 	help
 	  Select 7751 SolutionEngine if configuring for a Hitachi SH7751
 	  evaluation board.
-	  
+
 config SH_7780_SOLUTION_ENGINE
 	bool "SolutionEngine7780"
 	select SOLUTION_ENGINE
@@ -170,8 +170,8 @@ config SH_RSK
 	  CPU_SUBTYPE_SH7264 || CPU_SUBTYPE_SH7269
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
-	 Select this option if configuring for any of the RSK+ MCU
-	 evaluation platforms.
+	  Select this option if configuring for any of the RSK+ MCU
+	  evaluation platforms.
 
 config SH_SDK7780
 	bool "SDK7780R3"
@@ -239,7 +239,7 @@ config SH_MIGOR
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
-          by Renesas System Solutions Asia Pte. Ltd.
+	  by Renesas System Solutions Asia Pte. Ltd.
 
 config SH_AP325RXA
 	bool "AP-325RXA"
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 02ed2df..134ca45 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -5,7 +5,7 @@ config QUICKLIST
 	def_bool y
 
 config MMU
-        bool "Support for memory management hardware"
+	bool "Support for memory management hardware"
 	depends on !CPU_SH2
 	default y
 	help
@@ -154,8 +154,8 @@ config ARCH_MEMORY_PROBE
 	depends on MEMORY_HOTPLUG
 
 config IOREMAP_FIXED
-       def_bool y
-       depends on X2TLB || SUPERH64
+	def_bool y
+	depends on X2TLB || SUPERH64
 
 config UNCACHED_MAPPING
 	bool
-- 
1.9.1

