Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D6C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120B6205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IZPwFYo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfDSSog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:44:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43069 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfDSSof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:44:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIiNnS387608
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:44:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIiNnS387608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699465;
        bh=78WOlUoQkA63lnYB92tJ95tbhKHPPqpndB9HfwUn8Yw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IZPwFYo3UkGefB94m065fLn8BHxUeblYwwuwwbERzmmVIhj1NHkd9e8qobZ09109p
         erRRdNqDHvAE0di3UDOzG7z6wnj9hWTeSGAOeGgBMoI7dXWGVeeJQUStxU9+3hjbUe
         065D/ngdjne185WkCRhAHA8/qWwisRkEwbjA9zVocjTGJFNL3xoqpw7wXe8qVRcx46
         GrrJfNF8nlXBxRMsqsixW1Yb4Jnb555iC37GcExYXPiWeo1wfPUuDQa+6Rtz3TuZ9j
         DGpgVIdeqQN2huIG6LOq2nwCg0vM441boOa2Bwu8PEH7p6jF6CqjuGYeS54Hou4p32
         RNZa8oRRM5oKQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIiMbQ387605;
        Fri, 19 Apr 2019 11:44:22 -0700
Date:   Fri, 19 Apr 2019 11:44:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-cb0c04143b6196f4a479ba113706329fc667ee15@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        juri.lelli@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tj@kernel.org,
        peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          juri.lelli@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tj@kernel.org, peterz@infradead.org
In-Reply-To: <20181219133445.31982-2-juri.lelli@redhat.com>
References: <20181219133445.31982-2-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Update init_sched_domains()
 comment
Git-Commit-ID: cb0c04143b6196f4a479ba113706329fc667ee15
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

Commit-ID:  cb0c04143b6196f4a479ba113706329fc667ee15
Gitweb:     https://git.kernel.org/tip/cb0c04143b6196f4a479ba113706329fc667ee15
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Wed, 19 Dec 2018 14:34:45 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:44:15 +0200

sched/topology: Update init_sched_domains() comment

Holding hotplug lock is not a requirement anymore for callers of sched_
init_domains after commit:

  6acce3ef8452 ("sched: Remove get_online_cpus() usage")

Update the relative comment preceding init_sched_domains().

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: cgroups@vger.kernel.org
Cc: lizefan@huawei.com
Link: http://lkml.kernel.org/r/20181219133445.31982-2-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c65b31e9458b..f53f89df837d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2081,9 +2081,8 @@ void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms)
 }
 
 /*
- * Set up scheduler domains and groups. Callers must hold the hotplug lock.
- * For now this just excludes isolated CPUs, but could be used to
- * exclude other special cases in the future.
+ * Set up scheduler domains and groups.  For now this just excludes isolated
+ * CPUs, but could be used to exclude other special cases in the future.
  */
 int sched_init_domains(const struct cpumask *cpu_map)
 {
