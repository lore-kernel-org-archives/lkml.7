Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9897C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB94F21872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfDEMEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:04:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53353 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:04:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35C4RTE2743023
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 05:04:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35C4QpR2743015;
        Fri, 5 Apr 2019 05:04:26 -0700
Date:   Fri, 5 Apr 2019 05:04:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-1c3a2c864d2da0454bca1e41d3e0090c18678909@git.kernel.org>
Cc:     kan.liang@intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, ak@linux.intel.com,
        acme@redhat.com, mingo@kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, kan.liang@intel.com,
          acme@redhat.com, tglx@linutronix.de, ak@linux.intel.com
In-Reply-To: <20190315165219.GA21223@tassilo.jf.intel.com>
References: <20190315165219.GA21223@tassilo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Update Silvermont to v14
Git-Commit-ID: 1c3a2c864d2da0454bca1e41d3e0090c18678909
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

Commit-ID:  1c3a2c864d2da0454bca1e41d3e0090c18678909
Gitweb:     https://git.kernel.org/tip/1c3a2c864d2da0454bca1e41d3e0090c18678909
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 14:56:26 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:23:48 -0300

perf vendor events intel: Update Silvermont to v14

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/silvermont/cache.json |  2 +-
 tools/perf/pmu-events/arch/x86/silvermont/other.json | 20 ++++++++++++++++++++
 .../pmu-events/arch/x86/silvermont/pipeline.json     |  5 +----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
index 82be7d1b8b81..805ef1436539 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -36,7 +36,7 @@
         "BriefDescription": "L2 cache request misses"
     },
     {
-        "PublicDescription": "Counts cycles that fetch is stalled due to an outstanding ICache miss. That is, the decoder queue is able to accept bytes, but the fetch unit is unable to provide bytes due to an ICache miss.  Note: this event is not the same as the total number of cycles spent retrieving instruction cache lines from the memory hierarchy.\r\nCounts cycles that fetch is stalled due to any reason. That is, the decoder queue is able to accept bytes, but the fetch unit is unable to provide bytes.  This will include cycles due to an ITLB miss, ICache miss and other events. \r\n",
+        "PublicDescription": "Counts cycles that fetch is stalled due to an outstanding ICache miss. That is, the decoder queue is able to accept bytes, but the fetch unit is unable to provide bytes due to an ICache miss.  Note: this event is not the same as the total number of cycles spent retrieving instruction cache lines from the memory hierarchy.\r\nCounts cycles that fetch is stalled due to any reason. That is, the decoder queue is able to accept bytes, but the fetch unit is unable to provide bytes.  This will include cycles due to an ITLB miss, ICache miss and other events.",
         "EventCode": "0x86",
         "Counter": "0,1",
         "UMask": "0x4",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/perf/pmu-events/arch/x86/silvermont/other.json
new file mode 100644
index 000000000000..47814046fa9d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
@@ -0,0 +1,20 @@
+[
+    {
+        "PublicDescription": "Counts cycles that fetch is stalled due to an outstanding ITLB miss. That is, the decoder queue is able to accept bytes, but the fetch unit is unable to provide bytes due to an ITLB miss.  Note: this event is not the same as page walk cycles to retrieve an instruction translation.",
+        "EventCode": "0x86",
+        "Counter": "0,1",
+        "UMask": "0x2",
+        "EventName": "FETCH_STALL.ITLB_FILL_PENDING_CYCLES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Cycles code-fetch stalled due to an outstanding ITLB miss."
+    },
+    {
+        "PublicDescription": "Counts cycles that fetch is stalled due to any reason. That is, the decoder queue is able to accept bytes, but the fetch unit is unable to provide bytes.  This will include cycles due to an ITLB miss, ICache miss and other events.",
+        "EventCode": "0x86",
+        "Counter": "0,1",
+        "UMask": "0x3f",
+        "EventName": "FETCH_STALL.ALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Cycles code-fetch stalled due to any reason."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 7468af99190a..1ed62ad4cf77 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -210,7 +210,7 @@
         "UMask": "0x4",
         "EventName": "NO_ALLOC_CYCLES.MISPREDICTS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of cycles when no uops are allocated and the alloc pipe is stalled waiting for a mispredicted jump to retire.  After the misprediction is detected, the front end will start immediately but the allocate pipe stalls until the mispredicted "
+        "BriefDescription": "Counts the number of cycles when no uops are allocated and the alloc pipe is stalled waiting for a mispredicted jump to retire.  After the misprediction is detected, the front end will start immediately but the allocate pipe stalls until the mispredicted"
     },
     {
         "EventCode": "0xCA",
@@ -275,7 +275,6 @@
     },
     {
         "PublicDescription": "This event counts the number of instructions that retire.  For instructions that consist of multiple micro-ops, this event counts exactly once, as the last micro-op of the instruction retires.  The event continues counting while instructions retire, including during interrupt service routines caused by hardware interrupts, faults or traps.  Background: Modern microprocessors employ extensive pipelining and speculative techniques.  Since sometimes an instruction is started but never completed, the notion of \"retirement\" is introduced.  A retired instruction is one that commits its states. Or stated differently, an instruction might be abandoned at some point. No instruction is truly finished until it retires.  This counter measures the number of completed instructions.  The fixed event is INST_RETIRED.ANY and the programmable event is INST_RETIRED.ANY_P.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -284,7 +283,6 @@
     },
     {
         "PublicDescription": "Counts the number of core cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios.  The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time. In systems with a constant core frequency, this event can give you a measurement of the elapsed time while the core was not in halt state by dividing the event count by the core frequency. This event is architecturally defined and is a designated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the core frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  The fixed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the programmable eve!
 nts are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.CORE",
@@ -293,7 +291,6 @@
     },
     {
         "PublicDescription": "Counts the number of reference cycles while the core is not in a halt state. The core enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios.  The core frequency may change from time. This event is not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  Divide this event count by core frequency to determine the elapsed time while the core was not in halt state.  Divide this event count by core frequency to determine the elapsed time while the core was not in halt state.  This event is architecturally defined and is a designated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the core frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency changes but counts as if the core is running at the maximum frequency all the time.  The fixed e!
 vents are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the programmable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 3",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
