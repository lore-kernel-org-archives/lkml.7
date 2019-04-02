Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0417DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E8D20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221265;
	bh=5v+CBc5KyxjG1DUZroEbLpclp2P+LRcom1wtTvdEFms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F7qZcdPduCVkaB6VNl0y332jXv2GUNPXuywM052MWgIRPtV2OI93IXTPUAeGZa5EL
	 POcdbyadD/TokBFpA319T94pb+RtEIOGddRgZPJ/HiYJ8vhSv2p2+xBr40uEkbCPH0
	 ENi9cCiQWi2xgfcIfGzgN/b4B+MKopvjb5jWZpck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfDBQHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbfDBQHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:42 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9513A2133D;
        Tue,  2 Apr 2019 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221261;
        bh=5v+CBc5KyxjG1DUZroEbLpclp2P+LRcom1wtTvdEFms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1UZhwh5H7l3SvNcABHTY+gKxuvSHzPkTXII3j43jbKIR+zLA8fnKtE09307ChpyK
         XssXwycS+E6FbymJMeGIxpkWLTsaJ0o1HOCOrKUB/IjnnZChwNAn9xyKWX/SRUKzRZ
         rlKw2gakcQVoqNAztogmoiV/WVFQDSi0VRlfoFUw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/44] perf vendor events intel: Update Broadwell-DE events to v7
Date:   Tue,  2 Apr 2019 13:05:35 -0300
Message-Id: <20190402160549.13544-31-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/broadwellde/cache.json    | 4 ++--
 tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
index 4ad425312bdc..bf243fe2a0ec 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
@@ -439,7 +439,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -451,7 +451,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "L1_Hit_Indication": "1",
         "CounterHTOff": "0,1,2,3"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 0d04bf9db000..e2f0540625a2 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -1,6 +1,5 @@
 [
     {
-        "EventCode": "0x00",
         "UMask": "0x1",
         "BriefDescription": "Instructions retired from execution.",
         "Counter": "Fixed counter 0",
@@ -10,7 +9,6 @@
         "CounterHTOff": "Fixed counter 0"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x2",
         "BriefDescription": "Core cycles when the thread is not in halt state",
         "Counter": "Fixed counter 1",
@@ -20,7 +18,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x2",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
         "Counter": "Fixed counter 1",
@@ -30,7 +27,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x3",
         "BriefDescription": "Reference cycles when the core is not in halt state.",
         "Counter": "Fixed counter 2",
@@ -322,7 +318,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
         "Counter": "0,1,2,3",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-- 
2.20.1

