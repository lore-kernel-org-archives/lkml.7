Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DC6C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA049207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfCIOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:38:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43315 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCIOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:38:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29EamsW3108892
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:36:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Eal453108886;
        Sat, 9 Mar 2019 06:36:47 -0800
Date:   Sat, 9 Mar 2019 06:36:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-66856ff8e727e7da7da44a634f314b236510f419@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, luto@kernel.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, bp@alien8.de,
        riel@surriel.com
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, riel@surriel.com, bp@alien8.de,
          mingo@kernel.org, peterz@infradead.org,
          valentin.schneider@arm.com, luto@kernel.org,
          dave.hansen@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20190211175946.4961-2-valentin.schneider@arm.com>
References: <20190211175946.4961-2-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Comment some nohz_balancer_kick()
 kick conditions
Git-Commit-ID: 66856ff8e727e7da7da44a634f314b236510f419
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

Commit-ID:  66856ff8e727e7da7da44a634f314b236510f419
Gitweb:     https://git.kernel.org/tip/66856ff8e727e7da7da44a634f314b236510f419
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 11 Feb 2019 17:59:44 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:03:52 +0100

sched/fair: Comment some nohz_balancer_kick() kick conditions

We now have a comment explaining the first sched_domain based NOHZ kick,
so might as well comment them all.

While at it, unwrap a line that fits under 80 characters.

Co-authored-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dietmar.Eggemann@arm.com
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20190211175946.4961-2-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8213ff6e365d..e6f7d39d4d45 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9612,8 +9612,12 @@ static void nohz_balancer_kick(struct rq *rq)
 
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
-		if ((rq->cfs.h_nr_running >= 1) &&
-		    check_cpu_capacity(rq, sd)) {
+		/*
+		 * If there's a CFS task and the current CPU has reduced
+		 * capacity; kick the ILB to see if there's a better CPU to run
+		 * on.
+		 */
+		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
@@ -9621,6 +9625,11 @@ static void nohz_balancer_kick(struct rq *rq)
 
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
+		/*
+		 * When ASYM_PACKING; see if there's a more preferred CPU
+		 * currently idle; in which case, kick the ILB to move tasks
+		 * around.
+		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_KICK_MASK;
