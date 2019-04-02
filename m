Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD2620856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221291;
	bh=c13urPbOEZBzEJsK+9/YNKwAeSnmptdNWhkIwbudRqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=doLhBokfJJ1Uojm+i1fYlqhEzDJHfEwUoJbGkKTWSzhRzXPC8o8sX0KWnz4lKVSCh
	 7LiQEsoR59ApL2KT9KCNW8UFqa6156X8USDyewN6TdFlPkLxcsDhq63STqwhG4c7Ba
	 hdraIWOZ4101L4kc/fCvt5dvEIZu1tmh6LbKdu8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfDBQIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbfDBQIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:08:06 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A8D2084C;
        Tue,  2 Apr 2019 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221285;
        bh=c13urPbOEZBzEJsK+9/YNKwAeSnmptdNWhkIwbudRqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VVhnY7Nc3e4r86X+Q3pEoH53gel6aFRi/j3FUtQxZMuUOs+IYFSZ5bPFuoLSfWXEj
         1aVqSvid8l8WY1tfT04hanfwVBF4mLJ4Ua0IpsiSb0R5gyINPT4ZaK7S0lQkGksaK5
         I74z+/+SF47z74FUrMuR4R3ekazWpZ2Phr7QAaPs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/44] perf vendor events intel: Update IvyBridge events to v21
Date:   Tue,  2 Apr 2019 13:05:43 -0300
Message-Id: <20190402160549.13544-39-acme@kernel.org>
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
-- 
2.20.1

