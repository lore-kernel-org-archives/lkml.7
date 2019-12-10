Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72FDC2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9092B2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950211;
	bh=kszLF0bT7aHHUG9zA3c6FJ6o71gT16dHrEBieWTigng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aEpj6cTox3bgrPZ52ODPcfgm+DqC/XHtvwKYHmWbd9nbI2oqWiwjT2p06Rc0DEWFG
	 eX29VVVMGGIUL5W1cWZqaUifyzMxR+sKS4j82er1VNtJ5X0gS0/a0tKs/SF6NEm3Fq
	 IAIfDNi0VW3Lk2X1AuIY9IRZ8b2/Kid8z6LQHjLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLJD4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfLJD4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:56:48 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10892465C;
        Tue, 10 Dec 2019 03:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950208;
        bh=kszLF0bT7aHHUG9zA3c6FJ6o71gT16dHrEBieWTigng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngOj1QsnKGkCZuTnMzSmkk+sYCEJWaE8bRTVgoyvJNA9ID1JkYFyEuQClh4J+OJPQ
         wwq77yjcFZL4w2HalJxSfHHEOnfL5xrcT4auXDVcfOHOEnmX4WMRS0qZwvRG42JyGi
         MyOqN9H7wGRAjKEx4sMr+sO4jjod+MUkhZWQc6hg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 7/7] doc: Fix typo s/deference/dereference/
Date:   Mon,  9 Dec 2019 19:56:41 -0800
Message-Id: <20191210035641.2226-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210035539.GA792@paulmck-ThinkPad-P72>
References: <20191210035539.GA792@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/lockdep-splat.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/lockdep-splat.txt b/Documentation/RCU/lockdep-splat.txt
index 9c01597..b809631 100644
--- a/Documentation/RCU/lockdep-splat.txt
+++ b/Documentation/RCU/lockdep-splat.txt
@@ -99,7 +99,7 @@ With this change, the rcu_dereference() is always within an RCU
 read-side critical section, which again would have suppressed the
 above lockdep-RCU splat.
 
-But in this particular case, we don't actually deference the pointer
+But in this particular case, we don't actually dereference the pointer
 returned from rcu_dereference().  Instead, that pointer is just compared
 to the cic pointer, which means that the rcu_dereference() can be replaced
 by rcu_access_pointer() as follows:
-- 
2.9.5

