Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64C221871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfDEMC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:02:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfDEMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:02:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35C2G6l2740975
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 05:02:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35C2G722740972;
        Fri, 5 Apr 2019 05:02:16 -0700
Date:   Fri, 5 Apr 2019 05:02:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-b1580f542ca7d4bec387559b05e62b1b2f5f08d2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
        ak@linux.intel.com, kan.liang@intel.com
Reply-To: kan.liang@intel.com, ak@linux.intel.com, acme@redhat.com,
          jolsa@kernel.org, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190315165219.GA21223@tassilo.jf.intel.com>
References: <20190315165219.GA21223@tassilo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Update Bonnell to V4
Git-Commit-ID: b1580f542ca7d4bec387559b05e62b1b2f5f08d2
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

Commit-ID:  b1580f542ca7d4bec387559b05e62b1b2f5f08d2
Gitweb:     https://git.kernel.org/tip/b1580f542ca7d4bec387559b05e62b1b2f5f08d2
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 14:55:07 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:23:42 -0300

perf vendor events intel: Update Bonnell to V4

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
