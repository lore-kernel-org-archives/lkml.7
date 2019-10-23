Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3151CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7B720640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbfJWMvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:51:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49243 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391769AbfJWMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:50:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iNG6H-0001hZ-Dx; Wed, 23 Oct 2019 14:50:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 058671C0089;
        Wed, 23 Oct 2019 14:50:53 +0200 (CEST)
Date:   Wed, 23 Oct 2019 12:50:52 -0000
From:   "tip-bot2 for Yi Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-cpu-timers: Fix two trivial comments
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571643852-21848-1-git-send-email-wang.yi59@zte.com.cn>
References: <1571643852-21848-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Message-ID: <157183505271.29376.8207818611946366297.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     7f2cbcbcafbca5360efbd175b3320852b8f7c637
Gitweb:        https://git.kernel.org/tip/7f2cbcbcafbca5360efbd175b3320852b8f7c637
Author:        Yi Wang <wang.yi59@zte.com.cn>
AuthorDate:    Mon, 21 Oct 2019 15:44:12 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Oct 2019 14:48:24 +02:00

posix-cpu-timers: Fix two trivial comments

Recent changes modified the function arguments of
thread_group_sample_cputime() and task_cputimers_expired(), but forgot to
update the comments. Fix it up.

[ tglx: Changed the argument name of task_cputimers_expired() as the pointer
  	points to an array of samples. ]

Fixes: b7be4ef1365d ("posix-cpu-timers: Switch thread group sampling to array")
Fixes: 001f7971433a ("posix-cpu-timers: Make expiry checks array based")
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1571643852-21848-1-git-send-email-wang.yi59@zte.com.cn

---
 kernel/time/posix-cpu-timers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 92a4319..42d512f 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -266,7 +266,7 @@ static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
 /**
  * thread_group_sample_cputime - Sample cputime for a given task
  * @tsk:	Task for which cputime needs to be started
- * @iimes:	Storage for time samples
+ * @samples:	Storage for time samples
  *
  * Called from sys_getitimer() to calculate the expiry time of an active
  * timer. That means group cputime accounting is already active. Called
@@ -1038,12 +1038,12 @@ unlock:
  * member of @pct->bases[CLK].nextevt. False otherwise
  */
 static inline bool
-task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
+task_cputimers_expired(const u64 *samples, struct posix_cputimers *pct)
 {
 	int i;
 
 	for (i = 0; i < CPUCLOCK_MAX; i++) {
-		if (sample[i] >= pct->bases[i].nextevt)
+		if (samples[i] >= pct->bases[i].nextevt)
 			return true;
 	}
 	return false;
