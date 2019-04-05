Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAE421871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfDELyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:54:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDELyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:54:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35Bscr42739182
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:54:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BscAQ2739178;
        Fri, 5 Apr 2019 04:54:38 -0700
Date:   Fri, 5 Apr 2019 04:54:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-d2243329ef3c5107d00dee4327a9884a394ef715@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kan.liang@intel.com, mingo@kernel.org, ak@linux.intel.com
Reply-To: acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          jolsa@kernel.org, mingo@kernel.org, kan.liang@intel.com,
          linux-kernel@vger.kernel.org, ak@linux.intel.com
In-Reply-To: <20190315165219.GA21223@tassilo.jf.intel.com>
References: <20190315165219.GA21223@tassilo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Update Broadwell-DE
 events to v7
Git-Commit-ID: d2243329ef3c5107d00dee4327a9884a394ef715
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

Commit-ID:  d2243329ef3c5107d00dee4327a9884a394ef715
Gitweb:     https://git.kernel.org/tip/d2243329ef3c5107d00dee4327a9884a394ef715
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 08:37:33 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:23:14 -0300

perf vendor events intel: Update Broadwell-DE events to v7

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
