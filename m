Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A5DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC232075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKKJc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:32:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55815 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKJc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:32:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63q-00039c-2k; Mon, 11 Nov 2019 10:32:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 843B01C03AB;
        Mon, 11 Nov 2019 10:32:36 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Better document newidle_balance()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        ktkhai@virtuozzo.com, mgorman@suse.de, qais.yousef@arm.com,
        qperret@google.com, rostedt@goodmis.org,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108131909.488364308@infradead.org>
References: <20191108131909.488364308@infradead.org>
MIME-Version: 1.0
Message-ID: <157346475624.29376.10025173920245642380.tip-bot2@tip-bot2>
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

Commit-ID:     7277a34c6be0b2972bdd1fea88c7cef409bed5b4
Gitweb:        https://git.kernel.org/tip/7277a34c6be0b2972bdd1fea88c7cef409bed5b4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Nov 2019 14:15:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 08:35:18 +01:00

sched/fair: Better document newidle_balance()

Whilst chasing the pick_next_task() race, there was some confusion
about the newidle_balance() return values. Document them.

[ mingo: Minor edits. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bsegall@google.com
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: ktkhai@virtuozzo.com
Cc: mgorman@suse.de
Cc: qais.yousef@arm.com
Cc: qperret@google.com
Cc: rostedt@goodmis.org
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20191108131909.488364308@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e622f4..c48a695 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9941,6 +9941,11 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 /*
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
+ *
+ * Returns:
+ *   < 0 - we released the lock and there are !fair tasks present
+ *     0 - failed, no new tasks
+ *   > 0 - success, new (fair) tasks present
  */
 int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
