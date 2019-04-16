Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E538FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDAF20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfDPPbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:31:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfDPPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:31:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GFVRau3495066
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 08:31:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GFVR5O3495063;
        Tue, 16 Apr 2019 08:31:27 -0700
Date:   Tue, 16 Apr 2019 08:31:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-e2abb398115e9c33f3d1e25bf6d1d08badc58b13@git.kernel.org>
Cc:     valentin.schneider@arm.com, mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, quentin.perret@arm.com
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          mingo@kernel.org, valentin.schneider@arm.com, tglx@linutronix.de,
          hpa@zytor.com, quentin.perret@arm.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190416140621.19884-1-valentin.schneider@arm.com>
References: <20190416140621.19884-1-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Remove unneeded prototype of
 capacity_of()
Git-Commit-ID: e2abb398115e9c33f3d1e25bf6d1d08badc58b13
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

Commit-ID:  e2abb398115e9c33f3d1e25bf6d1d08badc58b13
Gitweb:     https://git.kernel.org/tip/e2abb398115e9c33f3d1e25bf6d1d08badc58b13
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Tue, 16 Apr 2019 15:06:21 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 16:48:51 +0200

sched/fair: Remove unneeded prototype of capacity_of()

The prototype of that function was already hoisted up in:

  commit 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")

but that seems to have been missed. Get rid of the extra prototype.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Link: http://lkml.kernel.org/r/20190416140621.19884-1-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed7f5f8107b7..b6cc0703b850 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5116,7 +5116,6 @@ static inline void hrtick_update(struct rq *rq)
 
 #ifdef CONFIG_SMP
 static inline unsigned long cpu_util(int cpu);
-static unsigned long capacity_of(int cpu);
 
 static inline bool cpu_overutilized(int cpu)
 {
