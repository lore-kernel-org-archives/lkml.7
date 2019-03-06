Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA958C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF47206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCFUqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:46:24 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:44575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCFUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:46:23 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N30VJ-1gwasM41bJ-013Kzy; Wed, 06 Mar 2019 21:46:00 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Subject: [PATCH] arch: sh: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 21:45:58 +0100
Message-Id: <1551905158-29665-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:0+JFSVX9h5o+ReAbAyp384WjtCVAMcaAjj+Uy9hCJjEvHg+f+7a
 WQWmW+w/fAfBBKQ6hgCFWDY34WrUJHIumKjM/dDJznsuBDL3D1jo/QcXzTUZBunl+4TARHe
 IxrDwE3pRh4CeE8xl6FJGAhvdMQjRiCgZA14YpZuqgOs4Lv7S1lcLNPcXPg1Yzvw5Vb6fjC
 2q1ZPeEgL/JT5m/RizulQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iPS96Fe4fRA=:7qlFVwEUW3DAyiFk6M1UOc
 G/++oSrLFlOBjLW/Vh7PlmkkLLGOtnVwrIc5bkzfEPltAJlAPpppeRJAQdjUlCQy3SY1jEf7q
 3hC8hLz8ZyPY94rk/R3RwUBzd6Bvhoh/KV9CfLXXI72bB6E5b9+0nFwlrDYHJKvkSLkBaoInY
 RABq8K/3+VeEHpIOigEZx175XYMVgKuYwZ50rPBncOsw2QJB2p5HsjYk4tRweBrnMeJZ2VXae
 kQU2MRJK/6tMFilLvioNKai5tCY8dGMQ30v6VNJsy8hrpvCrzMsmmPzpHA1+1DK5skQMrhIoZ
 PAAktw8Hg3cgnXdIpZoOWDKLMWFiSCognE5zdubT31/lQD2kFs7V2MmMsVd/t4UlZlbPxR5VZ
 AA92p5qO813r701T5SXB6EMElJm5J6PQGlsJ9AxbdFc0lzcN1pEg+RFnujKt4t4vKeMPwY+vN
 +2jJYPSCiAd0/lUyE/Cz5Ajfse0DoHBVXxALamBttVPyz1aDdxzAyvvzqAv/diI24B0oi+rtj
 siUlg9gP3322TlY3ZEgJehtRItaUprJUHETevc73pln38bwV6JWBQA6LaMp3ek5QNBwwspbSi
 3lZfqabalLrXVEcgyA6YFqr5k6AwJFX31UTG7/cFc+sB3sXeCg0GiUYxjobF03vcLHQGoNUtU
 cCh/vqkss1P60bCimP2XCTdfH3VMG8hLUfHs9yke0U/PzUkMPbMP3FmYFOq0D2BVrn6mFE91N
 sLTB6SNdOYxawKmgc56JkjcIxXY0yciwWObWlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

