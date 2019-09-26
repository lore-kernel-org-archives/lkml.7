Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908ADC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657BC21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458006;
	bh=DcCMe5b29vx0/KGIAh4dObZDT2ewRVOn8htgf69JY8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMczo2tlo5rO3++wQs/c2Rvs7Ay7vhq16u4XtREw/ZPOBSXgvEi94wUrjvOyX7W4F
	 EHS+7WxUkwFEUAG5m36ynKdKgEGSqSktsh0szQW09scFhxe4l0CfME2zCT3mLzyTnS
	 4RNM2q8S6EHw+vR/lgczTJ6873CwDQOi/ZegQVHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfIZAdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfIZAdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:22 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC9EA21D7B;
        Thu, 26 Sep 2019 00:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458001;
        bh=DcCMe5b29vx0/KGIAh4dObZDT2ewRVOn8htgf69JY8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrDOQDmu0EQctsfK0YYoNFK8oY1NLfFWnTJfW2lS7kXIOxPo9sx6xY4iC62gkSnDD
         uSkWbwK8UZ7nvmohZLHYPandfW3wkJ8dIKwr1dv819OoY3tWLIe8HeA7S9HhsqAfZv
         LdLNzyY1IYmXD3gUwQe8whglDWpBchLY/U2U5qpk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Janakarajan Natarajan <janakarajan.natarajan@amd.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Luke Mujica <lukemujica@google.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/66] perf vendor events: Minor fixes to the README
Date:   Wed, 25 Sep 2019 21:31:43 -0300
Message-Id: <20190926003244.13962-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Some grammatical fixes, and updates to some path references that have
since changed.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <janakarajan.natarajan@amd.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190919204306.12598-3-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/README | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index e62b09b6a844..de7efa2cebd1 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -30,9 +30,9 @@ the topic. Eg: "Floating-point.json".
 All the topic JSON files for a CPU model/family should be in a separate
 sub directory. Thus for the Silvermont X86 CPU:
 
-	$ ls tools/perf/pmu-events/arch/x86/Silvermont_core
-	Cache.json 	Memory.json 	Virtual-Memory.json
-	Frontend.json 	Pipeline.json
+	$ ls tools/perf/pmu-events/arch/x86/silvermont
+	cache.json     memory.json    virtual-memory.json
+	frontend.json  pipeline.json
 
 The JSONs folder for a CPU model/family may be placed in the root arch
 folder, or may be placed in a vendor sub-folder under the arch folder
@@ -94,7 +94,7 @@ users to specify events by their name:
 
 where 'pm_1plus_ppc_cmpl' is a Power8 PMU event.
 
-However some errors in processing may cause the perf build to fail.
+However some errors in processing may cause the alias build to fail.
 
 Mapfile format
 ===============
@@ -119,7 +119,7 @@ where:
 
 	Header line
 		The header line is the first line in the file, which is
-		always _IGNORED_. It can empty.
+		always _IGNORED_. It can be empty.
 
 	CPUID:
 		CPUID is an arch-specific char string, that can be used
@@ -138,15 +138,15 @@ where:
 		files, relative to the directory containing the mapfile.csv
 
 	Type:
-		indicates whether the events or "core" or "uncore" events.
+		indicates whether the events are "core" or "uncore" events.
 
 
 	Eg:
 
-	$ grep Silvermont tools/perf/pmu-events/arch/x86/mapfile.csv
-	GenuineIntel-6-37,V13,Silvermont_core,core
-	GenuineIntel-6-4D,V13,Silvermont_core,core
-	GenuineIntel-6-4C,V13,Silvermont_core,core
+	$ grep silvermont tools/perf/pmu-events/arch/x86/mapfile.csv
+	GenuineIntel-6-37,v13,silvermont,core
+	GenuineIntel-6-4D,v13,silvermont,core
+	GenuineIntel-6-4C,v13,silvermont,core
 
 	i.e the three CPU models use the JSON files (i.e PMU events) listed
-	in the directory 'tools/perf/pmu-events/arch/x86/Silvermont_core'.
+	in the directory 'tools/perf/pmu-events/arch/x86/silvermont'.
-- 
2.21.0

