Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9B720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfCKN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:58:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfCKN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:58:09 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9WmQ-1h6fMb2pYS-005VCg; Mon, 11 Mar 2019 14:58:01 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org
Subject: [PATCH] arch: arc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:57:59 +0100
Message-Id: <1552312679-26388-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:DNQyYLcEBUcSKT2imBer4ZQHuixIc6O8OYyvKHsXbEu+TjlHLSB
 r4YB0oLxXYbMTDbhVpc4vvdH4rJ/JO5MCfiIb57ND/wgbvw2TDIlRdA79HP7dEwwkSmud6x
 Q92GRBQZxNGWfpWnD4+yE5YtWrc9h921f+D18Sb4FiddyrxbI9z8cUKSbg4u7m/xPyCJXwc
 kpASTlFH35tGvryccMsaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H5mQ/DS7x4I=:YzPloki1xFUKET60NI5+XX
 pINsHpPMlsUH9uWeGgsv0bRmF6Fz6sYDQd6uZsQKKIblgipq8igJ2QN8ZZkmmhn20/n+oxhd1
 R8e3T4ZEevZSGwC6fY8kKF7fxrkFoJ8vX9gObIVjO7Nd5qHeG/fLWzSv0sqtk4KuHkzGQkvAX
 K/a2y0LSwywcosbtU1RivVXUzbOuVWOqyDg1IqpEP7XRMS5pezL5GyVp8w3dIus3yMUMnQauR
 kZujYxTyuYak/epbq5I/zG2PE5272gZjOMzNPsWF0BcO11pmSAbQ9S4Y2D/IVxI0ac337JlQb
 wp11W5T7EtybP92zncXKIH2LgKV6S95SUpCpmjskT2OaqLele3J01TEyOjZpE/ciIntqZ0qoP
 fgCJ2XpF9xomXafkAynYh7QheusGMUa72jBhwD+ujaTjRhBiJNqfOl/rWqLtLRiQJBqGkgJOv
 dDVfkpJhAaRpG9Rlb/5EPhKtei3LmQMeYLl0teB/z8TP7fzKuSzRO8Nvf1GOX3KJBSZRYLxHg
 BVfenlwX8ek3xvay1Xwoq0ep4Pz7tXNCanYomsD2o0f7aP31CvrXiQHb56/Pk6K4nOFB1UQXj
 7SrNbALVzHgKK/Iaz/WbTi+Mdjl6Pvev8XQayJI+KUwG4atvD8VVwNsqEm6vKqwgJtFGOksQo
 4XfE904FBwlda0V6sEKvTt+W8pX632Jq+jqAdX7UBz2vFcEADuISaMaIpTVnx2IOQij7mNMPv
 A8QvxNRE4jMPlXU2pbs6WOwoSFW7eHfrtEK24A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/arc/Kconfig            | 12 ++++++------
 arch/arc/plat-eznps/Kconfig | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index df55672..1414797 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -144,11 +144,11 @@ config ARC_CPU_770
 	  Support for ARC770 core introduced with Rel 4.10 (Summer 2011)
 	  This core has a bunch of cool new features:
 	  -MMU-v3: Variable Page Sz (4k, 8k, 16k), bigger J-TLB (128x4)
-                   Shared Address Spaces (for sharing TLB entries in MMU)
+	           Shared Address Spaces (for sharing TLB entries in MMU)
 	  -Caches: New Prog Model, Region Flush
 	  -Insns: endian swap, load-locked/store-conditional, time-stamp-ctr
 
-endif	#ISA_ARCOMPACT
+endif #ISA_ARCOMPACT
 
 config ARC_CPU_HS
 	bool "ARC-HS"
@@ -198,7 +198,7 @@ config ARC_SMP_HALT_ON_RESET
 	  at designated entry point. For other case, all jump to common
 	  entry point and spin wait for Master's signal.
 
-endif	#SMP
+endif #SMP
 
 config ARC_MCIP
 	bool "ARConnect Multicore IP (MCIP) Support "
@@ -249,7 +249,7 @@ config ARC_CACHE_VIPT_ALIASING
 	bool "Support VIPT Aliasing D$"
 	depends on ARC_HAS_DCACHE && ISA_ARCOMPACT
 
-endif	#ARC_CACHE
+endif #ARC_CACHE
 
 config ARC_HAS_ICCM
 	bool "Use ICCM"
@@ -370,7 +370,7 @@ config ARC_FPU_SAVE_RESTORE
 	  based on actual usage of FPU by a task. Thus our implemn does
 	  this for all tasks in system.
 
-endif	#ISA_ARCOMPACT
+endif #ISA_ARCOMPACT
 
 config ARC_CANT_LLSC
 	def_bool n
@@ -414,7 +414,7 @@ config ARC_IRQ_NO_AUTOSAVE
 	  This is programmable and can be optionally disabled in which case
 	  software INTERRUPT_PROLOGUE/EPILGUE do the needed work
 
-endif	# ISA_ARCV2
+endif # ISA_ARCV2
 
 endmenu   # "ARC CPU Configuration"
 
diff --git a/arch/arc/plat-eznps/Kconfig b/arch/arc/plat-eznps/Kconfig
index 8eff057..2eaecfb 100644
--- a/arch/arc/plat-eznps/Kconfig
+++ b/arch/arc/plat-eznps/Kconfig
@@ -26,8 +26,8 @@ config EZNPS_MTM_EXT
 	help
 	  Here we add new hierarchy for CPUs topology.
 	  We got:
-		Core
-		Thread
+	    Core
+	    Thread
 	  At the new thread level each CPU represent one HW thread.
 	  At highest hierarchy each core contain 16 threads,
 	  any of them seem like CPU from Linux point of view.
@@ -35,10 +35,10 @@ config EZNPS_MTM_EXT
 	  core and HW scheduler round robin between them.
 
 config EZNPS_MEM_ERROR_ALIGN
-       bool "ARC-EZchip Memory error as an exception"
-       depends on EZNPS_MTM_EXT
-       default n
-       help
+	bool "ARC-EZchip Memory error as an exception"
+	depends on EZNPS_MTM_EXT
+	default n
+	help
 	  On the real chip of the NPS, user memory errors are handled
 	  as a machine check exception, which is fatal, whereas on
 	  simulator platform for NPS, is handled as a Level 2 interrupt
-- 
1.9.1

