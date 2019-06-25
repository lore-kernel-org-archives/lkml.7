Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83701C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F96021655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iRe6+A1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfFYIsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:48:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:47:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8lZV63536042
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:47:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8lZV63536042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452456;
        bh=ryX8v7tj7G7wPWNZ8zfZ0V7lLgGrMj2/mk3YLXLmFqo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iRe6+A1zvkV7CTyV1VLkPAdiozK1z1Qh2jVGN6riSJ02W8p8wo+PvIF4NMyJIAVR3
         WtulJVYExqt0z7qS78hV1RrmsCrJ2SrBeLYYzZMkBM2PIA17O4WBE/EV5sSNu1lgzt
         y7f4qVhuv1i4jAiim+oO5SXbBo00mBT1YKiLojBAh0XfAomPAahtqEMaogDyUM20Y9
         1HlzgU89AzW+xF7yFBp1/820KbypDdPlBaxbSdJMdCQrYSaUImI0mSgbFqlvyH4tti
         KUt40cBZbemgcevBacQuYuzhCH1QdxazJ7xb8lldHkt661WfOpfmdpVfJ/FLsNd15v
         RJoOkf0130jLQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8lYtu3536038;
        Tue, 25 Jun 2019 01:47:34 -0700
Date:   Tue, 25 Jun 2019 01:47:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kobe Wu <tipbot@zytor.com>
Message-ID: <tip-9156e545765e467e6268c4814cfa609ebb16237e@git.kernel.org>
Cc:     kobe-cp.wu@mediatek.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de,
        linux-mediatek@lists.infradead.org, torvalds@linux-foundation.org,
        wsd_upstream@mediatek.com, eason-yh.lin@mediatek.com,
        will.deacon@arm.com
Reply-To: will.deacon@arm.com, wsd_upstream@mediatek.com,
          eason-yh.lin@mediatek.com, linux-mediatek@lists.infradead.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          kobe-cp.wu@mediatek.com
In-Reply-To: <1561365348-16050-1-git-send-email-kobe-cp.wu@mediatek.com>
References: <1561365348-16050-1-git-send-email-kobe-cp.wu@mediatek.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: increase size of counters for
 lockdep statistics
Git-Commit-ID: 9156e545765e467e6268c4814cfa609ebb16237e
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

Commit-ID:  9156e545765e467e6268c4814cfa609ebb16237e
Gitweb:     https://git.kernel.org/tip/9156e545765e467e6268c4814cfa609ebb16237e
Author:     Kobe Wu <kobe-cp.wu@mediatek.com>
AuthorDate: Mon, 24 Jun 2019 16:35:48 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 25 Jun 2019 10:17:08 +0200

locking/lockdep: increase size of counters for lockdep statistics

When system has been running for a long time, signed integer
counters are not enough for some lockdep statistics. Using
unsigned long counters can satisfy the requirement. Besides,
most of lockdep statistics are unsigned. It is better to use
unsigned int instead of int.

Remove unused variables.
- max_recursion_depth
- nr_cyclic_check_recursions
- nr_find_usage_forwards_recursions
- nr_find_usage_backwards_recursions

Signed-off-by: Kobe Wu <kobe-cp.wu@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <linux-mediatek@lists.infradead.org>
Cc: <wsd_upstream@mediatek.com>
Cc: Eason Lin <eason-yh.lin@mediatek.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/1561365348-16050-1-git-send-email-kobe-cp.wu@mediatek.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep_internals.h | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 150ec3f0c5b5..cc83568d5012 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -131,7 +131,6 @@ extern unsigned int nr_hardirq_chains;
 extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
 extern unsigned int max_lockdep_depth;
-extern unsigned int max_recursion_depth;
 
 extern unsigned int max_bfs_queue_depth;
 
@@ -160,25 +159,22 @@ lockdep_count_backward_deps(struct lock_class *class)
  * and we want to avoid too much cache bouncing.
  */
 struct lockdep_stats {
-	int	chain_lookup_hits;
-	int	chain_lookup_misses;
-	int	hardirqs_on_events;
-	int	hardirqs_off_events;
-	int	redundant_hardirqs_on;
-	int	redundant_hardirqs_off;
-	int	softirqs_on_events;
-	int	softirqs_off_events;
-	int	redundant_softirqs_on;
-	int	redundant_softirqs_off;
-	int	nr_unused_locks;
-	int	nr_redundant_checks;
-	int	nr_redundant;
-	int	nr_cyclic_checks;
-	int	nr_cyclic_check_recursions;
-	int	nr_find_usage_forwards_checks;
-	int	nr_find_usage_forwards_recursions;
-	int	nr_find_usage_backwards_checks;
-	int	nr_find_usage_backwards_recursions;
+	unsigned long  chain_lookup_hits;
+	unsigned int   chain_lookup_misses;
+	unsigned long  hardirqs_on_events;
+	unsigned long  hardirqs_off_events;
+	unsigned long  redundant_hardirqs_on;
+	unsigned long  redundant_hardirqs_off;
+	unsigned long  softirqs_on_events;
+	unsigned long  softirqs_off_events;
+	unsigned long  redundant_softirqs_on;
+	unsigned long  redundant_softirqs_off;
+	int            nr_unused_locks;
+	unsigned int   nr_redundant_checks;
+	unsigned int   nr_redundant;
+	unsigned int   nr_cyclic_checks;
+	unsigned int   nr_find_usage_forwards_checks;
+	unsigned int   nr_find_usage_backwards_checks;
 
 	/*
 	 * Per lock class locking operation stat counts
