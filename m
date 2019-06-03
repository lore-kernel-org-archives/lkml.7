Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D645C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432B425162
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VjmeaWuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfFCNS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:18:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:18:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DIml9606529
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:18:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DIml9606529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567928;
        bh=7x3A5oWFpgYr0tVgBDY3EP7l4/sPmFLYG4URyzXl+QI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VjmeaWuhOf5U7tvbTxVRI1KQ7KsiCJTk1Hh3Md8S7HWwLJVTw0wYerqy9Xat0/QRD
         Y8UJxrkkyOtLcbNr/nUrTfU1ripxRBNrKFKLKEP10T7XPyG+w8iZvInXtcy+lRiA8F
         Zf6u9gwqj/xmXYk/TrDyGPbAaINn7YzyLgKive7UGgLMvRZO/L+sSl7MtMx1epOOU1
         fXSiTJmgsdITOLb4c09f2xgjus5H8G8fnpIlmo/1xS+K7TdqsAazzXg0EmiMy1kJl1
         fsuX81AO94CttAsHnE7isvjWe47aNyPXlgA3JA+nUWMbzsz/6E14aSBc9l9cJm4kvU
         yN8ZIj+s5wdew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DIl00606524;
        Mon, 3 Jun 2019 06:18:47 -0700
Date:   Mon, 3 Jun 2019 06:18:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-b4adfe8e05f15d7e73309c93c2c337df7eb5278f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, duyuyang@gmail.com
Reply-To: hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
          duyuyang@gmail.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190506081939.74287-19-duyuyang@gmail.com>
References: <20190506081939.74287-19-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove unused argument in
 __lock_release
Git-Commit-ID: b4adfe8e05f15d7e73309c93c2c337df7eb5278f
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

Commit-ID:  b4adfe8e05f15d7e73309c93c2c337df7eb5278f
Gitweb:     https://git.kernel.org/tip/b4adfe8e05f15d7e73309c93c2c337df7eb5278f
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:34 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:49 +0200

locking/lockdep: Remove unused argument in __lock_release

The @nested is not used in __release_lock so remove it despite that it
is not used in lock_release in the first place.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-19-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index be4c1348ddcd..8169706df767 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4096,7 +4096,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
  * @nested is an hysterical artifact, needs a tree wide cleanup.
  */
 static int
-__lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
+__lock_release(struct lockdep_map *lock, unsigned long ip)
 {
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
@@ -4384,7 +4384,7 @@ void lock_release(struct lockdep_map *lock, int nested,
 	check_flags(flags);
 	current->lockdep_recursion = 1;
 	trace_lock_release(lock, ip);
-	if (__lock_release(lock, nested, ip))
+	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
