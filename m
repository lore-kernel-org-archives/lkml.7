Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB1CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D8F2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfCKN36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfCKNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:32 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MK3eC-1hLQiq43I6-00LZMj for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 025/114] arch: sh: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:37 +0100
Message-Id: <1552310346-7629-26-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:KHSFDLja9d7Vj9zUTDEdxkJBCDcfiRWKdmRn6iL+LQ21FsC/Qft
 SPSOgvzwjpUtHTpQZxrxnJwsBLzeD7KIOb+lXAoR/0DoxlTrXOvgE78gKQ7sedXu7G9kGLn
 MTGDmjHcWigtNftkNHSOkufc76Q6IQiXMe1bnSZL6aCcIwbssvoWs+WNIzLOH0TwYRhIpzk
 Hr/jjVTjKqisYUo6w4JHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BZy7K1+j4OM=:v7r3M1LtvZdJMajhMPify+
 H4/nMhFuL4wt0VqnhNr2OHwuIibJc94iHb8pPPBmFYnyf72LiwNJh60r4VmDdw06D86oxfPRK
 JDeiG0GP3io7KX4aHktvNZd/yOsaACriodMWEo6cxWIXommlERteqFTGUlyFEGZWB6oxo5Eob
 vyzjLWTVT9EWZT9VRaECOtcAcQ+/wzWnfCD064LY2x5OQp1tyhKkk6GcHsdOCq9FMAzje9Kwg
 uekO0HVYVBhCM9uq79/93CwX8Suh6RkawAGO2au88tSDfuLVwMmWSNxS93uadfmCPZgr9w/Jc
 B3s0XrxSYRJBodErDZS3KXKsXMdzKThdWVbatfAZCxi/nirLxqbdYmtyhvzN1L1ks7As7HaC4
 ISN9ssxXGEoRKqDCTrflx+KBYmT+Oau7EixfUdeCQPQVz5JqR3UsliVVxa8IqWbqLNAPIw6D3
 aJWdRlzt3ZtDjw39XpQQPhKeVdqLpKv8R9uRjyBw8yAzkgtQxOPbVNpchy045qP3b+kL2uQg6
 Wo4VL6zL2CZLyIAZMoeqOvYbbi6KvLh1Le2OXRHfl8HOZysL+yYgdoUOT5tQMmvjmCH4OCGe5
 4ZoopAx+6BMM4xZa92GiRdMBz4OuJ7xKA2rj3VbXmd8jxxz/dDcgiYGdU6UAQCECfICtUd23i
 kBG6ShLxwoifFc9G+HEbjRRMleWe4FKikx2BX5/V3QedzYONAPZ1txNjgYOignpbm4gotu6Th
 8hxkmQzewEJv9Tj3B1iHCwAX2Z/35yqmxixNhg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/sh/Kconfig        | 24 ++++++++++++------------
 arch/sh/boards/Kconfig | 10 +++++-----
 arch/sh/mm/Kconfig     |  6 +++---
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index b1c91ea..75186bf 100644
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

