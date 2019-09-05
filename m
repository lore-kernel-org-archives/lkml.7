Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3442067B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbfIEXhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 19:37:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:5012 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732160AbfIEXhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:37:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 16:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="190650478"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.155.245])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2019 16:37:50 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, darcari@redhat.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] platform/x86: ISST: Allow additional TRL MSRs
Date:   Thu,  5 Sep 2019 16:37:47 -0700
Message-Id: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional Turbo Ratio Limit (TRL) MSRs are required to get bucket vs core
count relationship. So add them to the list of allowed MSRs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel_speed_select_if/isst_if_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index 68d75391db57..3de5a3c66529 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -29,6 +29,8 @@ static struct isst_if_cmd_cb punit_callbacks[ISST_IF_DEV_MAX];
 static int punit_msr_white_list[] = {
 	MSR_TURBO_RATIO_LIMIT,
 	MSR_CONFIG_TDP_CONTROL,
+	MSR_TURBO_RATIO_LIMIT1,
+	MSR_TURBO_RATIO_LIMIT2,
 };
 
 struct isst_valid_cmd_ranges {
-- 
2.17.2

