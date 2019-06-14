Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F9C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB4B2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfFNIOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:14:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:12651 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfFNIOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:14:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 01:14:31 -0700
X-ExtLoop1: 1
Received: from rajneesh-desk.iind.intel.com ([10.66.234.53])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2019 01:14:28 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     vishwanath.somayaji@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: intel_pmc_core: Add ICL-NNPI support to PMC Core
Date:   Fri, 14 Jun 2019 13:39:40 +0530
Message-Id: <20190614080940.13640-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ice Lake Neural Network Processor for deep learning inference a.k.a.
ICL-NNPI can re-use Ice Lake Mobile regmap to enable Intel PMC Core
driver on it.

Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Link: https://lkml.org/lkml/2019/6/5/1034
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 1d902230ba61..be6cda89dcf5 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -815,6 +815,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
 	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
+	INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
 	{}
 };
 
-- 
2.17.1

