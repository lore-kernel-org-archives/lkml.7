Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E7EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C6F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ugua6F+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfDSSnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:43:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDSSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:43:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIhdm9385955
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:43:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIhdm9385955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699420;
        bh=D6BAU7advjGM0NwTI+CO8dwucVy/DsS4lfTY3lPaq74=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ugua6F+4SZjD+AChqQ9y37X3Gbsldl0G8Lvug5CBxxIr9xHtfhBBmnoX0brurq52K
         dZpDnwuZffXjDgX8EpNJArvEqbAYLJM+YhmehAei8IJNf+6JlFH1rq3G38+mqt0OQT
         LjMjgO7YsC/omm4GDJF0blbs6c6you6o4Wq90Ebh1JG6I2Z2TH2LWsv09FresbyuJb
         ePwNt01Qzmvf5RNiJKnlN1mL4OblV+eSby7KBSQfwsM60vYDgmfsYlIQFr+dF1Oezd
         OjA74GDUr0nRyT/llzjEp4SPoQKY8ouTJcZUryiA0IvjsP8NxtWXjruTXSFn7dFduj
         jFLXyTgOxKHDg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIhdYu385952;
        Fri, 19 Apr 2019 11:43:39 -0700
Date:   Fri, 19 Apr 2019 11:43:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-b6fbbf31d15b5072250ec6ed79e415a1160e5621@git.kernel.org>
Cc:     juri.lelli@redhat.com, torvalds@linux-foundation.org,
        tj@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, juri.lelli@redhat.com,
          torvalds@linux-foundation.org, hpa@zytor.com, tj@kernel.org
In-Reply-To: <20181219133445.31982-1-juri.lelli@redhat.com>
References: <20181219133445.31982-1-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cgroup/cpuset: Update stale
 generate_sched_domains() comments
Git-Commit-ID: b6fbbf31d15b5072250ec6ed79e415a1160e5621
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

Commit-ID:  b6fbbf31d15b5072250ec6ed79e415a1160e5621
Gitweb:     https://git.kernel.org/tip/b6fbbf31d15b5072250ec6ed79e415a1160e5621
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Wed, 19 Dec 2018 14:34:44 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:44:14 +0200

cgroup/cpuset: Update stale generate_sched_domains() comments

Commit:

  fc560a26acce ("cpuset: replace cpuset->stack_list with cpuset_for_each_descendant_pre()")

removed the local list (q) that was used to perform a top-down scan
of all cpusets; however, comments mentioning it were not updated.

Update comments to reflect current implementation.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: cgroups@vger.kernel.org
Cc: lizefan@huawei.com
Link: http://lkml.kernel.org/r/20181219133445.31982-1-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/cgroup/cpuset.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4834c4214e9c..6a1942ed781c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -740,11 +740,10 @@ static inline int nr_cpusets(void)
  * Must be called with cpuset_mutex held.
  *
  * The three key local variables below are:
- *    q  - a linked-list queue of cpuset pointers, used to implement a
- *	   top-down scan of all cpusets.  This scan loads a pointer
- *	   to each cpuset marked is_sched_load_balance into the
- *	   array 'csa'.  For our purposes, rebuilding the schedulers
- *	   sched domains, we can ignore !is_sched_load_balance cpusets.
+ *    cp - cpuset pointer, used (together with pos_css) to perform a
+ *	   top-down scan of all cpusets. For our purposes, rebuilding
+ *	   the schedulers sched domains, we can ignore !is_sched_load_
+ *	   balance cpusets.
  *  csa  - (for CpuSet Array) Array of pointers to all the cpusets
  *	   that need to be load balanced, for convenient iterative
  *	   access by the subsequent code that finds the best partition,
@@ -775,7 +774,7 @@ static inline int nr_cpusets(void)
 static int generate_sched_domains(cpumask_var_t **domains,
 			struct sched_domain_attr **attributes)
 {
-	struct cpuset *cp;	/* scans q */
+	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
 	int i, j, k;		/* indices for partition finding loops */
