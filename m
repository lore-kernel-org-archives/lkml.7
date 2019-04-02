Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2562CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAD22082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221324;
	bh=yqTu62958iIjifZD1j4b0a4k+Ngw2t3SqbOh/WUV1AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EWg5oRjuNniiJpCUXTS+fn+qI7kJWvMnj0plv+U+ml+oNmkpVTcgiQqpBUWRPJH0J
	 nvR7SArP1LkcAojuP/lEp7ScT20Aj/UMOm4rjzaanxxYV7dUsUBXQY2jvuOXx8VT/j
	 7kVJoD+0qgCuYLhLyHs+R0zIhkcJwAgNrAdb6hWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfDBQIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbfDBQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:08:15 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AB94214AF;
        Tue,  2 Apr 2019 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221294;
        bh=yqTu62958iIjifZD1j4b0a4k+Ngw2t3SqbOh/WUV1AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtZXkg4scybOaFj7hEEmIsL4ESw1XFusGi50Pvj8XJVUTx4fsRoPqjSYnuzOtZ5Z+
         MLO9HDtFiMP/9/JhREb2KCQrW49L0zwRFKJG5lxkuQVFvNlChVya63m2EGoDwj1SGo
         tN4sWxHNfCeEL+kksf6HMbffpqEmd7vb/PMgXcx0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/44] perf vendor events intel: Update Bonnell to V4
Date:   Tue,  2 Apr 2019 13:05:46 -0300
Message-Id: <20190402160549.13544-42-acme@kernel.org>
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
 tools/perf/pmu-events/arch/x86/bonnell/frontend.json | 2 +-
 tools/perf/pmu-events/arch/x86/bonnell/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
index 935b7dcf067d..ef69540ab61d 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/frontend.json
@@ -77,7 +77,7 @@
         "UMask": "0x1",
         "EventName": "UOPS.MS_CYCLES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "This event counts the cycles where 1 or more uops are issued by the micro-sequencer (MS), including microcode assists and inserted flows, and written to the IQ. ",
+        "BriefDescription": "This event counts the cycles where 1 or more uops are issued by the micro-sequencer (MS), including microcode assists and inserted flows, and written to the IQ.",
         "CounterMask": "1"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
index b2e681c78466..09c6de13de20 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
@@ -189,7 +189,7 @@
         "UMask": "0x8",
         "EventName": "BR_MISSP_TYPE_RETIRED.IND_CALL",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Mispredicted indirect calls, including both register and memory indirect. "
+        "BriefDescription": "Mispredicted indirect calls, including both register and memory indirect."
     },
     {
         "EventCode": "0x89",
-- 
2.20.1

