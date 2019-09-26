Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8F6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C433F207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfIZSms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:42:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:57431 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbfIZSms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:42:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 11:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="214574485"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.161])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2019 11:42:47 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     vishwanath.somayaji@intel.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v1 1/5] x86/intel_pmc_core: Clean up: Remove comma after the termination line
Date:   Thu, 26 Sep 2019 12:25:59 -0700
Message-Id: <20190926192603.18647-2-gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926192603.18647-1-gayatri.kammela@intel.com>
References: <20190926192603.18647-1-gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is common practice to place a comma after the last entry in an
initialized array to avoid the need to add one in future patches that
extend the array. But when the last element is a termination marker, the
comma could be harmful. Any new entries must be added before the
terminator (and the comma would prevent the compiler from issuing a
warning about an entry after the terminator).

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 94a008efb09b..6ad829915689 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -49,7 +49,7 @@ static const struct pmc_bit_map spt_pll_map[] = {
 	{"GEN2 USB2PCIE2 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE1},
 	{"DMIPCIE3 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE2},
 	{"SATA PLL",			SPT_PMC_BIT_MPHY_CMN_LANE3},
-	{},
+	{}
 };
 
 static const struct pmc_bit_map spt_mphy_map[] = {
@@ -69,7 +69,7 @@ static const struct pmc_bit_map spt_mphy_map[] = {
 	{"MPHY CORE LANE 13",          SPT_PMC_BIT_MPHY_LANE13},
 	{"MPHY CORE LANE 14",          SPT_PMC_BIT_MPHY_LANE14},
 	{"MPHY CORE LANE 15",          SPT_PMC_BIT_MPHY_LANE15},
-	{},
+	{}
 };
 
 static const struct pmc_bit_map spt_pfear_map[] = {
@@ -113,7 +113,7 @@ static const struct pmc_bit_map spt_pfear_map[] = {
 	{"CSME_SMS1",			SPT_PMC_BIT_CSME_SMS1},
 	{"CSME_RTC",			SPT_PMC_BIT_CSME_RTC},
 	{"CSME_PSF",			SPT_PMC_BIT_CSME_PSF},
-	{},
+	{}
 };
 
 static const struct pmc_bit_map spt_ltr_show_map[] = {
@@ -299,7 +299,7 @@ static const struct pmc_bit_map *cnp_slps0_dbg_maps[] = {
 	cnp_slps0_dbg0_map,
 	cnp_slps0_dbg1_map,
 	cnp_slps0_dbg2_map,
-	NULL,
+	NULL
 };
 
 static const struct pmc_bit_map cnp_ltr_show_map[] = {
@@ -820,7 +820,7 @@ MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
 
 static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID), 0},
-	{ 0, },
+	{ 0, }
 };
 
 /*
-- 
2.17.1

