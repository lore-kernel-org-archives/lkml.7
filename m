Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06D1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD66D214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfIVKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:52:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55563 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbfIVKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:52:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBzTc-0000uz-Ou; Sun, 22 Sep 2019 12:52:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 057E21C07C3;
        Sun, 22 Sep 2019 12:52:24 +0200 (CEST)
Date:   Sun, 22 Sep 2019 10:52:23 -0000
From:   "tip-bot2 for Roy Ben Shlomo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix several typos in comments
Cc:     Roy Ben Shlomo <royb@sentinelone.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190920171254.31373-1-royb@sentinelone.com>
References: <20190920171254.31373-1-royb@sentinelone.com>
MIME-Version: 1.0
Message-ID: <156914954391.24167.12320372146686080125.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9f014e3a66bc936412b6614304a4e6c70c70230e
Gitweb:        https://git.kernel.org/tip/9f014e3a66bc936412b6614304a4e6c70c70230e
Author:        Roy Ben Shlomo <roy.benshlomo@gmail.com>
AuthorDate:    Fri, 20 Sep 2019 20:12:53 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 16:05:20 -03:00

perf/core: Fix several typos in comments

Fix typos in a few functions' documentation comments.

Signed-off-by: Roy Ben Shlomo <royb@sentinelone.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: royb@sentinelone.com
Link: http://lore.kernel.org/lkml/20190920171254.31373-1-royb@sentinelone.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f08b17..275eae0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2239,7 +2239,7 @@ static void __perf_event_disable(struct perf_event *event,
  *
  * If event->ctx is a cloned context, callers must make sure that
  * every task struct that event->ctx->task could possibly point to
- * remains valid.  This condition is satisifed when called through
+ * remains valid.  This condition is satisfied when called through
  * perf_event_for_each_child or perf_event_for_each because they
  * hold the top-level event's child_mutex, so any descendant that
  * goes to exit will block in perf_event_exit_event().
@@ -6054,7 +6054,7 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
  * Get remaining task size from user stack pointer.
  *
  * It'd be better to take stack vma map and limit this more
- * precisly, but there's no way to get it safely under interrupt,
+ * precisely, but there's no way to get it safely under interrupt,
  * so using TASK_SIZE as limit.
  */
 static u64 perf_ustack_task_size(struct pt_regs *regs)
@@ -6616,7 +6616,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_STACK_USER) {
 		/*
-		 * Either we need PERF_SAMPLE_STACK_USER bit to be allways
+		 * Either we need PERF_SAMPLE_STACK_USER bit to be always
 		 * processed as the last one or have additional check added
 		 * in case new sample type is added, because we could eat
 		 * up the rest of the sample size.
