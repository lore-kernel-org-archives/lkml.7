Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E43C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6D620840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221309;
	bh=INu/lDFdhGKg4Gub3WIecuffZjl7caddtbybnGJ6dKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6+yUGyg3pjthvv7/kVXYD2bop1dFBuTvtqlwxl2xSoJWpNV6y1S0qw0knu4TSq7b
	 KjtsvRtfeKHcK0QkjAe+ZwULF/+ovLVd1tNxBBIzDb+uL+fKrpr93laOGtQiobKD0k
	 0GCYdcX+QcUbZ/unSkTCmGf8R+sF5lHo0rlqDoTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfDBQI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbfDBQIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:08:25 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318AE2133D;
        Tue,  2 Apr 2019 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221303;
        bh=INu/lDFdhGKg4Gub3WIecuffZjl7caddtbybnGJ6dKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTinq5GcTNd0ctnrVGjmLdqYBCYAMt+77TbPr2RxeJS4F1CPv5n8FXK0CKSejvwap
         OpJDHts2A76VUHyBtoofDccpPzIZ3+k0Tx0ydmZqLJoc2iNYq76ctjhrD4yaWv3w4O
         LaboSOmY7ktNW6Evbc2/RMMvAmN3wrw7RfDotBhg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 44/44] perf vendor events intel: Update Silvermont to v14
Date:   Tue,  2 Apr 2019 13:05:49 -0300
Message-Id: <20190402160549.13544-45-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
 .../pmu-events/arch/x86/silvermont/cache.json |  2 +-
 .../pmu-events/arch/x86/silvermont/other.json | 20 +++++++++++++++++++
 .../arch/x86/silvermont/pipeline.json         |  5 +----
 3 files changed, 22 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/other.json

diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/p=
erf/pmu-events/arch/x86/silvermont/cache.json
index 82be7d1b8b81..805ef1436539 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -36,7 +36,7 @@
         "BriefDescription": "L2 cache request misses"
     },
     {
-        "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.\r\nCounts cycles tha=
t fetch is stalled due to any reason. That is, the decoder queue is able to=
 accept bytes, but the fetch unit is unable to provide bytes.  This will in=
clude cycles due to an ITLB miss, ICache miss and other events. \r\n",
+        "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ICache miss. That is, the decoder queue is able to accept byt=
es, but the fetch unit is unable to provide bytes due to an ICache miss.  N=
ote: this event is not the same as the total number of cycles spent retriev=
ing instruction cache lines from the memory hierarchy.\r\nCounts cycles tha=
t fetch is stalled due to any reason. That is, the decoder queue is able to=
 accept bytes, but the fetch unit is unable to provide bytes.  This will in=
clude cycles due to an ITLB miss, ICache miss and other events.",
         "EventCode": "0x86",
         "Counter": "0,1",
         "UMask": "0x4",
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/p=
erf/pmu-events/arch/x86/silvermont/other.json
new file mode 100644
index 000000000000..47814046fa9d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
@@ -0,0 +1,20 @@
+[
+    {
+        "PublicDescription": "Counts cycles that fetch is stalled due to a=
n outstanding ITLB miss. That is, the decoder queue is able to accept bytes=
, but the fetch unit is unable to provide bytes due to an ITLB miss.  Note:=
 this event is not the same as page walk cycles to retrieve an instruction =
translation.",
+        "EventCode": "0x86",
+        "Counter": "0,1",
+        "UMask": "0x2",
+        "EventName": "FETCH_STALL.ITLB_FILL_PENDING_CYCLES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Cycles code-fetch stalled due to an outstandi=
ng ITLB miss."
+    },
+    {
+        "PublicDescription": "Counts cycles that fetch is stalled due to a=
ny reason. That is, the decoder queue is able to accept bytes, but the fetc=
h unit is unable to provide bytes.  This will include cycles due to an ITLB=
 miss, ICache miss and other events.",
+        "EventCode": "0x86",
+        "Counter": "0,1",
+        "UMask": "0x3f",
+        "EventName": "FETCH_STALL.ALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Cycles code-fetch stalled due to any reason."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 7468af99190a..1ed62ad4cf77 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -210,7 +210,7 @@
         "UMask": "0x4",
         "EventName": "NO_ALLOC_CYCLES.MISPREDICTS",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of cycles when no uops are =
allocated and the alloc pipe is stalled waiting for a mispredicted jump to =
retire.  After the misprediction is detected, the front end will start imme=
diately but the allocate pipe stalls until the mispredicted "
+        "BriefDescription": "Counts the number of cycles when no uops are =
allocated and the alloc pipe is stalled waiting for a mispredicted jump to =
retire.  After the misprediction is detected, the front end will start imme=
diately but the allocate pipe stalls until the mispredicted"
     },
     {
         "EventCode": "0xCA",
@@ -275,7 +275,6 @@
     },
     {
         "PublicDescription": "This event counts the number of instructions=
 that retire.  For instructions that consist of multiple micro-ops, this ev=
ent counts exactly once, as the last micro-op of the instruction retires.  =
The event continues counting while instructions retire, including during in=
terrupt service routines caused by hardware interrupts, faults or traps.  B=
ackground: Modern microprocessors employ extensive pipelining and speculati=
ve techniques.  Since sometimes an instruction is started but never complet=
ed, the notion of \"retirement\" is introduced.  A retired instruction is o=
ne that commits its states. Or stated differently, an instruction might be =
abandoned at some point. No instruction is truly finished until it retires.=
  This counter measures the number of completed instructions.  The fixed ev=
ent is INST_RETIRED.ANY and the programmable event is INST_RETIRED.ANY_P.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -284,7 +283,6 @@
     },
     {
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
  The core frequency may change from time to time. For this reason this eve=
nt may have a changing ratio with regards to time. In systems with a consta=
nt core frequency, this event can give you a measurement of the elapsed tim=
e while the core was not in halt state by dividing the event count by the c=
ore frequency. This event is architecturally defined and is a designated fi=
xed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the cor=
e frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC an=
d CPU_CLK_UNHALTED.REF are not affected by core frequency changes but count=
s as if the core is running at the maximum frequency all the time.  The fix=
ed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the pr=
ogrammable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.CORE",
@@ -293,7 +291,6 @@
     },
     {
         "PublicDescription": "Counts the number of reference cycles while =
the core is not in a halt state. The core enters the halt state when it is =
running the HLT instruction. This event is a component in many key event ra=
tios.  The core frequency may change from time. This event is not affected =
by core frequency changes but counts as if the core is running at the maxim=
um frequency all the time.  Divide this event count by core frequency to de=
termine the elapsed time while the core was not in halt state.  Divide this=
 event count by core frequency to determine the elapsed time while the core=
 was not in halt state.  This event is architecturally defined and is a des=
ignated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P u=
se the core frequency which may change from time to time.  CPU_CLK_UNHALTE.=
REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency changes=
 but counts as if the core is running at the maximum frequency all the time=
.  The fixed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC =
and the programmable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTE=
D.REF.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 3",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
--=20
2.20.1

