Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DBFC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F6C206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgAFUbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:31:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:10717 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgAFUaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:30:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 12:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="245699465"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 12:30:22 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 RESEND 05/14] perf/x86/intel: Fix the name of perf capabilities for perf METRICS
Date:   Mon,  6 Jan 2020 12:29:10 -0800
Message-Id: <20200106202919.2943-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106202919.2943-1-kan.liang@linux.intel.com>
References: <20200106202919.2943-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Bit 15 of PERF_CAPABILITIES MSR indicates this architecture provides
built in support for perf METRICS. The perf METRICS is not a PEBS
feature.

Rename pebs_metrics_available perf_metrics.

No one use the bit in current code. The following patch will use it.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

 arch/x86/events/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6ebca54f86df..ecce05141f71 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -532,7 +532,7 @@ union perf_capabilities {
 		 */
 		u64	full_width_write:1;
 		u64     pebs_baseline:1;
-		u64	pebs_metrics_available:1;
+		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
 	};
 	u64	capabilities;
-- 
2.17.1

