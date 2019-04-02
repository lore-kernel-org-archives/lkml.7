Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C84C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961CD206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221363;
	bh=S8xQAhsVsXf9gfxEgnbYcoyToslG3jKGhaJdMLPfFUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vIR+gzQ8dN9kELJZL0duxniWQ/fvefZevKJ7FPmI1XvFv4KIOv7MrJYufX/N/KM6v
	 wVok+QAng1LwHm0PExAvcVQchUN6uelnvnF8i7LwRXepHKpBzWdUlSkeXpVQNn73rz
	 oF39g5ywqPMv9ipBKNMmU3eCz3MrZfncS4DNkuSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfDBQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbfDBQH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:57 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3600B2146E;
        Tue,  2 Apr 2019 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221276;
        bh=S8xQAhsVsXf9gfxEgnbYcoyToslG3jKGhaJdMLPfFUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUNxyGjlE+7LEmERvqUSUGn+nk/GHmP1aGab2DFIMhOhRTeIPSVwvIQjRMNLVUsQ1
         IMep56Yt6pKisTO2de+3ktsmY4gYcaxhvP3rG5oorTOa+Zn0u7phG/x8cf+C6WfU7d
         os57TB957qSlsMEG1yx6FIQhZ1r/B6CmbSVOgatU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/44] perf vendor events intel: Update IvyTown events to v20
Date:   Tue,  2 Apr 2019 13:05:40 -0300
Message-Id: <20190402160549.13544-36-acme@kernel.org>
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
 tools/perf/pmu-events/arch/x86/ivytown/pipeline.json | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
index 0afbfd95ea30..2a0aad91d83d 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
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

