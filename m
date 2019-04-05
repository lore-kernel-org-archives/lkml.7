Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D1C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D02221871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfDEMDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:03:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfDEMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:03:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35C3eBo2741353
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 05:03:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35C3eAE2741350;
        Fri, 5 Apr 2019 05:03:40 -0700
Date:   Fri, 5 Apr 2019 05:03:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-c53dd58988385c3f0861ea1d487489bad8cc69a7@git.kernel.org>
Cc:     kan.liang@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
        ak@linux.intel.com, jolsa@kernel.org, hpa@zytor.com
Reply-To: jolsa@kernel.org, ak@linux.intel.com, hpa@zytor.com,
          mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, kan.liang@intel.com
In-Reply-To: <20190315165219.GA21223@tassilo.jf.intel.com>
References: <20190315165219.GA21223@tassilo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Update GoldmontPlus to
 v1.01
Git-Commit-ID: c53dd58988385c3f0861ea1d487489bad8cc69a7
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

Commit-ID:  c53dd58988385c3f0861ea1d487489bad8cc69a7
Gitweb:     https://git.kernel.org/tip/c53dd58988385c3f0861ea1d487489bad8cc69a7
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 14:55:53 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:23:46 -0300

perf vendor events intel: Update GoldmontPlus to v1.01

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/x86/goldmontplus/cache.json    | 74 +++++++++++++---------
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |  5 +-
 .../arch/x86/goldmontplus/virtual-memory.json      |  9 ++-
 3 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json b/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
index b4791b443a66..5a6ac8285ad4 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
@@ -92,7 +92,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Locked load uops retired (Precise event capable)"
+        "BriefDescription": "Locked load uops retired (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -104,7 +105,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Load uops retired that split a cache-line (Precise event capable)"
+        "BriefDescription": "Load uops retired that split a cache-line (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -116,7 +118,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Stores uops retired that split a cache-line (Precise event capable)"
+        "BriefDescription": "Stores uops retired that split a cache-line (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -128,7 +131,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Memory uops retired that split a cache-line (Precise event capable)"
+        "BriefDescription": "Memory uops retired that split a cache-line (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -140,7 +144,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Load uops retired (Precise event capable)"
+        "BriefDescription": "Load uops retired (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -152,7 +157,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Store uops retired (Precise event capable)"
+        "BriefDescription": "Store uops retired (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -164,7 +170,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.ALL",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Memory uops retired (Precise event capable)"
+        "BriefDescription": "Memory uops retired (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -176,7 +183,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Load uops retired that hit L1 data cache (Precise event capable)"
+        "BriefDescription": "Load uops retired that hit L1 data cache (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -188,7 +196,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Load uops retired that hit L2 (Precise event capable)"
+        "BriefDescription": "Load uops retired that hit L2 (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -200,7 +209,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Load uops retired that missed L1 data cache (Precise event capable)"
+        "BriefDescription": "Load uops retired that missed L1 data cache (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -212,7 +222,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Load uops retired that missed L2 (Precise event capable)"
+        "BriefDescription": "Load uops retired that missed L2 (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -224,7 +235,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Memory uop retired where cross core or cross module HITM occurred (Precise event capable)"
+        "BriefDescription": "Memory uop retired where cross core or cross module HITM occurred (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -236,7 +248,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.WCB_HIT",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Loads retired that hit WCB (Precise event capable)"
+        "BriefDescription": "Loads retired that hit WCB (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -248,7 +261,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Loads retired that came from DRAM (Precise event capable)"
+        "BriefDescription": "Loads retired that came from DRAM (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "CollectPEBSRecord": "1",
@@ -292,7 +306,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data reads of full cache lines true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts demand cacheable data reads of full cache lines true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -367,7 +381,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand reads for ownership (RFO) requests generated by a write to full data cache line true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts demand reads for ownership (RFO) requests generated by a write to full data cache line true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -442,7 +456,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand instruction cacheline and I-side prefetch requests that miss the instruction cache true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts demand instruction cacheline and I-side prefetch requests that miss the instruction cache true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -517,7 +531,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts the number of writeback transactions caused by L1 or L2 cache evictions true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts the number of writeback transactions caused by L1 or L2 cache evictions true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -592,7 +606,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts data cacheline reads generated by hardware L2 cache prefetcher true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts data cacheline reads generated by hardware L2 cache prefetcher true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -667,7 +681,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts reads for ownership (RFO) requests generated by L2 prefetcher true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts reads for ownership (RFO) requests generated by L2 prefetcher true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -742,7 +756,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts bus lock and split lock requests true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts bus lock and split lock requests true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -817,7 +831,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts full cache line data writes to uncacheable write combining (USWC) memory region and full cache-line non-temporal writes true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts full cache line data writes to uncacheable write combining (USWC) memory region and full cache-line non-temporal writes true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -892,7 +906,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts data cache lines requests by software prefetch instructions true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts data cache lines requests by software prefetch instructions true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -967,7 +981,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts data cache line reads generated by hardware L1 data cache prefetcher true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts data cache line reads generated by hardware L1 data cache prefetcher true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -1042,7 +1056,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any data writes to uncacheable write combining (USWC) memory region  true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts any data writes to uncacheable write combining (USWC) memory region  true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -1117,7 +1131,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts requests to the uncore subsystem true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts requests to the uncore subsystem true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -1192,7 +1206,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts data reads generated by L1 or L2 prefetchers true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts data reads generated by L1 or L2 prefetchers true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -1267,7 +1281,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts data reads (demand & prefetch) true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts data reads (demand & prefetch) true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -1342,7 +1356,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts reads for ownership (RFO) requests (demand & prefetch) true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts reads for ownership (RFO) requests (demand & prefetch) true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
@@ -1417,7 +1431,7 @@
         "PDIR_COUNTER": "na",
         "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts data read, code read, and read for ownership (RFO) requests (demand & prefetch) true miss for the L2 cache with a snoop miss in the other processor module. ",
+        "BriefDescription": "Counts data read, code read, and read for ownership (RFO) requests (demand & prefetch) true miss for the L2 cache with a snoop miss in the other processor module.",
         "Offcore": "1"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
index ccf1aed69197..e3fa1a0ba71b 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
@@ -3,7 +3,6 @@
         "PEBS": "2",
         "CollectPEBSRecord": "1",
         "PublicDescription": "Counts the number of instructions that retire execution. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. The counter continues counting during hardware interrupts, traps, and inside interrupt handlers.  This event uses fixed counter 0.  You cannot collect a PEBs record for this event.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 0",
         "UMask": "0x1",
         "PEBScounters": "32",
@@ -15,7 +14,6 @@
     {
         "CollectPEBSRecord": "1",
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. In mobile systems the core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.  You cannot collect a PEBs record for this event.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "PEBScounters": "33",
@@ -27,7 +25,6 @@
     {
         "CollectPEBSRecord": "1",
         "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction.  In mobile systems the core frequency may change from time.  This event is not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  This event uses fixed counter 2.  You cannot collect a PEBs record for this event.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x3",
         "PEBScounters": "34",
@@ -231,7 +228,7 @@
     },
     {
         "CollectPEBSRecord": "1",
-        "PublicDescription": "Counts the number of times that the processor detects that a program is writing to a code section and has to perform a machine clear because of that modification.  Self-modifying code (SMC) causes a severe penalty in all Intel architecture processors.",
+        "PublicDescription": "Counts the number of times that the processor detects that a program is writing to a code section and has to perform a machine clear because of that modification.  Self-modifying code (SMC) causes a severe penalty in all Intel\u00ae architecture processors.",
         "EventCode": "0xC3",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
index 0b53a3b0dfb8..0d32fd26ded1 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
@@ -189,7 +189,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Load uops retired that missed the DTLB (Precise event capable)"
+        "BriefDescription": "Load uops retired that missed the DTLB (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -201,7 +202,8 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Store uops retired that missed the DTLB (Precise event capable)"
+        "BriefDescription": "Store uops retired that missed the DTLB (Precise event capable)",
+        "Data_LA": "1"
     },
     {
         "PEBS": "2",
@@ -213,6 +215,7 @@
         "PEBScounters": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Memory uops retired that missed the DTLB (Precise event capable)"
+        "BriefDescription": "Memory uops retired that missed the DTLB (Precise event capable)",
+        "Data_LA": "1"
     }
 ]
\ No newline at end of file
