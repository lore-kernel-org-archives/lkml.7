Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2EFC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE39B27F97
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LEsq6s7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfFCNHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:07:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFCNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:07:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D77LQ604628
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:07:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D77LQ604628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567228;
        bh=nm0X+VTfV7lilagsWwkhno7UnYkvxSAoEBkUO2FOqe8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LEsq6s7ympFhoUntBhys+Pi3jLpXGsQELMy2OQpjZl2AGwLCzvVIKS5cGL/kaKz8a
         NWdOQDvlNd4lMzjUf+xhp/UOo2f01zTsiqp693Q0Qijcaq4QZiupaa/s7bKhJhSUob
         GjgNl2if8pSlUtDGhx2nkbAOxmefX9psVhNpD4ABMybYlfoMgJFr2HzfcyfXLXQOua
         ST5MOxmLDJkrNMQ0uTyHsdxzIBm6Gatlepk0lPN78QPEmxtfuZ4JvgvKk+W5nhJ+py
         u0O7ILzVm+ukKxzQ38W7OB0Y3yNbdMZ6o0oE49pTvTmkZWXt6k2VxykF8s3zqdjw05
         /RkBJ0eXOPy9Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D77bS604625;
        Mon, 3 Jun 2019 06:07:07 -0700
Date:   Mon, 3 Jun 2019 06:07:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-c01fbbc83f42748b3ed094497933601e6c9e0a03@git.kernel.org>
Cc:     duyuyang@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, duyuyang@gmail.com,
          peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190506081939.74287-3-duyuyang@gmail.com>
References: <20190506081939.74287-3-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Add description and explanation
 in lockdep design doc
Git-Commit-ID: c01fbbc83f42748b3ed094497933601e6c9e0a03
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

Commit-ID:  c01fbbc83f42748b3ed094497933601e6c9e0a03
Gitweb:     https://git.kernel.org/tip/c01fbbc83f42748b3ed094497933601e6c9e0a03
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:18 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:34 +0200

locking/lockdep: Add description and explanation in lockdep design doc

More words are added to lockdep design document regarding key concepts,
which should help people without lockdep experience read and understand
lockdep reports.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-3-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/locking/lockdep-design.txt | 79 ++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 39fae143c9cb..ae65758383ea 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -15,34 +15,48 @@ tens of thousands of) instantiations. For example a lock in the inode
 struct is one class, while each inode has its own instantiation of that
 lock class.
 
-The validator tracks the 'state' of lock-classes, and it tracks
-dependencies between different lock-classes. The validator maintains a
-rolling proof that the state and the dependencies are correct.
-
-Unlike an lock instantiation, the lock-class itself never goes away: when
-a lock-class is used for the first time after bootup it gets registered,
-and all subsequent uses of that lock-class will be attached to this
-lock-class.
+The validator tracks the 'usage state' of lock-classes, and it tracks
+the dependencies between different lock-classes. Lock usage indicates
+how a lock is used with regard to its IRQ contexts, while lock
+dependency can be understood as lock order, where L1 -> L2 suggests that
+a task is attempting to acquire L2 while holding L1. From lockdep's
+perspective, the two locks (L1 and L2) are not necessarily related; that
+dependency just means the order ever happened. The validator maintains a
+continuing effort to prove lock usages and dependencies are correct or
+the validator will shoot a splat if incorrect.
+
+A lock-class's behavior is constructed by its instances collectively:
+when the first instance of a lock-class is used after bootup the class
+gets registered, then all (subsequent) instances will be mapped to the
+class and hence their usages and dependecies will contribute to those of
+the class. A lock-class does not go away when a lock instance does, but
+it can be removed if the memory space of the lock class (static or
+dynamic) is reclaimed, this happens for example when a module is
+unloaded or a workqueue is destroyed.
 
 State
 -----
 
-The validator tracks lock-class usage history into 4 * nSTATEs + 1 separate
-state bits:
+The validator tracks lock-class usage history and divides the usage into
+(4 usages * n STATEs + 1) categories:
 
+where the 4 usages can be:
 - 'ever held in STATE context'
 - 'ever held as readlock in STATE context'
 - 'ever held with STATE enabled'
 - 'ever held as readlock with STATE enabled'
 
-Where STATE can be either one of (kernel/locking/lockdep_states.h)
- - hardirq
- - softirq
+where the n STATEs are coded in kernel/locking/lockdep_states.h and as of
+now they include:
+- hardirq
+- softirq
 
+where the last 1 category is:
 - 'ever used'                                       [ == !unused        ]
 
-When locking rules are violated, these state bits are presented in the
-locking error messages, inside curlies. A contrived example:
+When locking rules are violated, these usage bits are presented in the
+locking error messages, inside curlies, with a total of 2 * n STATEs bits.
+A contrived example:
 
    modprobe/2287 is trying to acquire lock:
     (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
@@ -51,15 +65,44 @@ locking error messages, inside curlies. A contrived example:
     (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
 
-The bit position indicates STATE, STATE-read, for each of the states listed
-above, and the character displayed in each indicates:
+For a given lock, the bit positions from left to right indicate the usage
+of the lock and readlock (if exists), for each of the n STATEs listed
+above respectively, and the character displayed at each bit position
+indicates:
 
    '.'  acquired while irqs disabled and not in irq context
    '-'  acquired in irq context
    '+'  acquired with irqs enabled
    '?'  acquired in irq context with irqs enabled.
 
-Unused mutexes cannot be part of the cause of an error.
+The bits are illustrated with an example:
+
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
+                         ||||
+                         ||| \-> softirq disabled and not in softirq context
+                         || \--> acquired in softirq context
+                         | \---> hardirq disabled and not in hardirq context
+                          \----> acquired in hardirq context
+
+
+For a given STATE, whether the lock is ever acquired in that STATE
+context and whether that STATE is enabled yields four possible cases as
+shown in the table below. The bit character is able to indicate which
+exact case is for the lock as of the reporting time.
+
+   -------------------------------------------
+  |              | irq enabled | irq disabled |
+  |-------------------------------------------|
+  | ever in irq  |      ?      |       -      |
+  |-------------------------------------------|
+  | never in irq |      +      |       .      |
+   -------------------------------------------
+
+The character '-' suggests irq is disabled because if otherwise the
+charactor '?' would have been shown instead. Similar deduction can be
+applied for '+' too.
+
+Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 
 
 Single-lock state rules:
