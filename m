Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C26C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E191F21901
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfCKN3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:12 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCKNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:33 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTRIg-1hUk6y1Coe-00TmpL for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 035/114] arch: arc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:47 +0100
Message-Id: <1552310346-7629-36-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:S1mxB/vAafYiOCx96H8lx9SezQ3y9bQjgt85EAVG4rrc49h5qyQ
 dv0fHFpegy4EDMkBn1tfLIiQGzZ1AO9HCvbkZZljSkLrAtIeNmim/5S66EQQpSb00Vnr8fD
 1UVhf8B6tSopmE/Koyh3EejCkv1k58vscKJ69jSzKmJmCUbvWVIOpkaVC4BUdVpAd4uIaJW
 Ti0lN3pmvw4UXtubzGTBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nHBeKdzdKsE=:rFy4XGK4P171fMNob/I5iO
 btoQYY0b8acF0CvncdXhYSWF1H4MVK7YqU+OSmTjVrR8JbScVsI9RRTwoyYDS9brl3kWM6Eii
 TUC2gEcG7DC4igkOzFPqunH92CruDJjAQWmXJG7gJqNgqtD/+W+wikmgiPU1CmgALZDN9OQtN
 d0yXAWCdtEyXdFmQM7CJ/ij8gLtQ8TillqkPqSL7StzcSUcpffuOV3zTHITxmrHNG3y1m/zTD
 T73ckBfGYgIasELLsxnXJggPk2FQlQzQS5xVDMEBA9qJd5hb6FCELLmPDhk3GZYq+YcTJafDc
 daGfzW7j4jxsL4FGfAXmybZBAd3eNXJ96bhqmw3S+TYnrIANbWU97oPdN1MTq2S94CZ7OgHKs
 hr4Icr2chigep/5WTe1w6OfQIOm9EoXozw5nhviNdheZRROOqprHJXhvLR3q1nh2cgDecimfW
 Up56A7PZ0mqDgMX6Pk85qPWP7b7iCh518/ZUn1mU9/SSw5j8SIgNXHiFD+nzD0VAvX61DagKP
 pkPAEDZfmSZlZ2qxS3xXv4Xy+ycl28L3phMzDVDn2qfS7WWn5AVtuBZdRLyrfo47ybOb2dp2E
 Lg0BOcCToJBrgTtFZshwB1FlmdMLhAQu0xKXsADjVtSvLkBkQoOgw1Jfpoo5wK3UHt5kXxrOI
 mKGaOpfP6DJtbnVl8CYjVVyNk80FGL/iZKx9dk5d5WQ4xL2UmwnxfAqtq0lpLM1Ifb00Sv5bh
 tc6DNaexjt2CugS8s24ZtyDAMej4hnr8QLQKdA==
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

