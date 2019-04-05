Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82232C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C53D21872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfDEMAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:00:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:00:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35C0AgT2740443
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 05:00:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35C0Aqv2740437;
        Fri, 5 Apr 2019 05:00:10 -0700
Date:   Fri, 5 Apr 2019 05:00:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-2111da70ff1094ed65d15f00e6285b668f689b87@git.kernel.org>
Cc:     hpa@zytor.com, kan.liang@intel.com, jolsa@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, ak@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          ak@linux.intel.com, mingo@kernel.org, tglx@linutronix.de,
          kan.liang@intel.com, jolsa@kernel.org, hpa@zytor.com
In-Reply-To: <20190315165219.GA21223@tassilo.jf.intel.com>
References: <20190315165219.GA21223@tassilo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Update IvyBridge events
 to v21
Git-Commit-ID: 2111da70ff1094ed65d15f00e6285b668f689b87
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

Commit-ID:  2111da70ff1094ed65d15f00e6285b668f689b87
Gitweb:     https://git.kernel.org/tip/2111da70ff1094ed65d15f00e6285b668f689b87
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 08:41:35 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:23:35 -0300

perf vendor events intel: Update IvyBridge events to v21

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/ivybridge/cache.json    | 10 +++++-----
 tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json |  4 ----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
index 999a01bc6467..5f6cb2abc384 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
@@ -1012,7 +1012,7 @@
         "EventName": "OFFCORE_RESPONSE.SPLIT_LOCK_UC_LOCK.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts requests where the address of an atomic lock instruction spans a cache line boundary or the lock instruction is executed on uncacheable address ",
+        "BriefDescription": "Counts requests where the address of an atomic lock instruction spans a cache line boundary or the lock instruction is executed on uncacheable address",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1036,7 +1036,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data reads ",
+        "BriefDescription": "Counts all demand data reads",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1048,7 +1048,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand rfo's ",
+        "BriefDescription": "Counts all demand rfo's",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1084,7 +1084,7 @@
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch prefetch RFOs ",
+        "BriefDescription": "Counts all demand & prefetch prefetch RFOs",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1096,7 +1096,7 @@
         "EventName": "OFFCORE_RESPONSE.ALL_READS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo references (demand & prefetch) ",
+        "BriefDescription": "Counts all data/code/rfo references (demand & prefetch)",
         "CounterHTOff": "0,1,2,3"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
index 0afbfd95ea30..2a0aad91d83d 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
@@ -1,6 +1,5 @@
 [
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 0",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -9,7 +8,6 @@
         "CounterHTOff": "Fixed counter 0"
     },
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
@@ -19,7 +17,6 @@
     },
     {
         "PublicDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "AnyThread": "1",
@@ -29,7 +26,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
