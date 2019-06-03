Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A351C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ED4273F3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eX+al6lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfFCNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:24:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfFCNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:24:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DNrgr607286
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:23:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DNrgr607286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568234;
        bh=3rOCBD0pYnGngLUkGvdos89p0/HPicH6N8xdKlpmWt4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eX+al6lDwLmCEq7YdnGi1HL14B9UabCd0RYfzPYf2wc78rQ2VZyoZ9ChoQjXB8E0Y
         zL2zUor/Y+Ktwr6IL9HTRjihKUvwZJ+lba5aSAb/jp3nprt1FWqxTclSf0pkbeDgZm
         KgQKNdoVyNH4ZeGEqZOngwRU7WD6pPH+nDRm3N4kIlnEzh6hCQsf9/U0SkiRsI7wF+
         wxL7OeVTy8Rk0ux7+/MG1TUfxk+5nwo6XrNnt89WfnzZupgzHdL+xNVw0ZtfQz/GiC
         x7WILDrFZb3lvxyVDbaZxOQBWReJvTV5ym8wnrYubSaYA7ZTJQRoR8UIOoj/e5t4PW
         eSBmKHUa0OMAQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DNq1r607283;
        Mon, 3 Jun 2019 06:23:52 -0700
Date:   Mon, 3 Jun 2019 06:23:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gayatri Kammela <tipbot@zytor.com>
Message-ID: <tip-76a16b217a7f086c1c7c2d5f52efddb0c855b278@git.kernel.org>
Cc:     peterz@infradead.org, torvalds@linux-foundation.org, hpa@zytor.com,
        gayatri.kammela@intel.com, mingo@kernel.org, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        charles.d.prestopine@intel.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          charles.d.prestopine@intel.com, kan.liang@intel.com,
          mingo@kernel.org, gayatri.kammela@intel.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          hpa@zytor.com
In-Reply-To: <20190511000311.20733-1-gayatri.kammela@intel.com>
References: <20190511000311.20733-1-gayatri.kammela@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Add tabs to Uncore IMC PCI
 IDs
Git-Commit-ID: 76a16b217a7f086c1c7c2d5f52efddb0c855b278
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  76a16b217a7f086c1c7c2d5f52efddb0c855b278
Gitweb:     https://git.kernel.org/tip/76a16b217a7f086c1c7c2d5f52efddb0c855b278
Author:     Gayatri Kammela <gayatri.kammela@intel.com>
AuthorDate: Fri, 10 May 2019 17:03:10 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:19 +0200

perf/x86/intel/uncore: Add tabs to Uncore IMC PCI IDs

Improve code readability by adding tabs after #define macros

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Charles Prestopine <charles.d.prestopine@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190511000311.20733-1-gayatri.kammela@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snb.c | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index f8431819b3e1..db9eb64ce756 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -3,27 +3,27 @@
 #include "uncore.h"
 
 /* Uncore IMC PCI IDs */
-#define PCI_DEVICE_ID_INTEL_SNB_IMC	0x0100
-#define PCI_DEVICE_ID_INTEL_IVB_IMC	0x0154
-#define PCI_DEVICE_ID_INTEL_IVB_E3_IMC	0x0150
-#define PCI_DEVICE_ID_INTEL_HSW_IMC	0x0c00
-#define PCI_DEVICE_ID_INTEL_HSW_U_IMC	0x0a04
-#define PCI_DEVICE_ID_INTEL_BDW_IMC	0x1604
-#define PCI_DEVICE_ID_INTEL_SKL_U_IMC	0x1904
-#define PCI_DEVICE_ID_INTEL_SKL_Y_IMC	0x190c
-#define PCI_DEVICE_ID_INTEL_SKL_HD_IMC	0x1900
-#define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC	0x1910
-#define PCI_DEVICE_ID_INTEL_SKL_SD_IMC	0x190f
-#define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC	0x191f
-#define PCI_DEVICE_ID_INTEL_KBL_Y_IMC	0x590c
-#define PCI_DEVICE_ID_INTEL_KBL_U_IMC	0x5904
-#define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC	0x5914
-#define PCI_DEVICE_ID_INTEL_KBL_SD_IMC	0x590f
-#define PCI_DEVICE_ID_INTEL_KBL_SQ_IMC	0x591f
-#define PCI_DEVICE_ID_INTEL_CFL_2U_IMC	0x3ecc
-#define PCI_DEVICE_ID_INTEL_CFL_4U_IMC	0x3ed0
-#define PCI_DEVICE_ID_INTEL_CFL_4H_IMC	0x3e10
-#define PCI_DEVICE_ID_INTEL_CFL_6H_IMC	0x3ec4
+#define PCI_DEVICE_ID_INTEL_SNB_IMC		0x0100
+#define PCI_DEVICE_ID_INTEL_IVB_IMC		0x0154
+#define PCI_DEVICE_ID_INTEL_IVB_E3_IMC		0x0150
+#define PCI_DEVICE_ID_INTEL_HSW_IMC		0x0c00
+#define PCI_DEVICE_ID_INTEL_HSW_U_IMC		0x0a04
+#define PCI_DEVICE_ID_INTEL_BDW_IMC		0x1604
+#define PCI_DEVICE_ID_INTEL_SKL_U_IMC		0x1904
+#define PCI_DEVICE_ID_INTEL_SKL_Y_IMC		0x190c
+#define PCI_DEVICE_ID_INTEL_SKL_HD_IMC		0x1900
+#define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC		0x1910
+#define PCI_DEVICE_ID_INTEL_SKL_SD_IMC		0x190f
+#define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC		0x191f
+#define PCI_DEVICE_ID_INTEL_KBL_Y_IMC		0x590c
+#define PCI_DEVICE_ID_INTEL_KBL_U_IMC		0x5904
+#define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC		0x5914
+#define PCI_DEVICE_ID_INTEL_KBL_SD_IMC		0x590f
+#define PCI_DEVICE_ID_INTEL_KBL_SQ_IMC		0x591f
+#define PCI_DEVICE_ID_INTEL_CFL_2U_IMC		0x3ecc
+#define PCI_DEVICE_ID_INTEL_CFL_4U_IMC		0x3ed0
+#define PCI_DEVICE_ID_INTEL_CFL_4H_IMC		0x3e10
+#define PCI_DEVICE_ID_INTEL_CFL_6H_IMC		0x3ec4
 #define PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC	0x3e0f
 #define PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC	0x3e1f
 #define PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC	0x3ec2
