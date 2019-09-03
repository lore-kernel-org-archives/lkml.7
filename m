Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8BFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01A32053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfICIcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:32:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfICIb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Dk-0002eI-By; Tue, 03 Sep 2019 10:31:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CD0971C0772;
        Tue,  3 Sep 2019 10:31:23 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:23 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched, perf: MAINTAINERS update, add submaintainers
 and reviewers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156749948366.12868.10186842854628988431.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bb87481612c4a87d0d9ce8bcb3b9e8ce0ff89a71
Gitweb:        https://git.kernel.org/tip/bb87481612c4a87d0d9ce8bcb3b9e8ce0ff89a71
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Aug 2019 14:02:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:12:51 +02:00

sched, perf: MAINTAINERS update, add submaintainers and reviewers

The below entries are a little unorthodox; I've not found other entries in
MAINTAINER that subdivide responsibilities like this, and certainly the lovely
get_maintainers.pl script will not get it, but I'm thinking to a human it
should be plenty clear and we're all very good at ignoring email anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e..bab0ca4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12590,6 +12590,7 @@ PERFORMANCE EVENTS SUBSYSTEM
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Arnaldo Carvalho de Melo <acme@kernel.org>
+R:	Mark Rutland <mark.rutland@arm.com>
 R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 R:	Jiri Olsa <jolsa@redhat.com>
 R:	Namhyung Kim <namhyung@kernel.org>
@@ -14176,6 +14177,12 @@ F:	drivers/watchdog/sc1200wdt.c
 SCHEDULER
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
+M:	Juri Lelli <juri.lelli@redhat.com> (SCHED_DEADLINE)
+M:	Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)
+R:	Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
+R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
+R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
+R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
 S:	Maintained
