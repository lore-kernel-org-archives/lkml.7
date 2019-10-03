Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB297C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AF122466
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066103;
	bh=jYb6PLJxKNd9LF++H/PLSDwTIf7b8iJz+MMZGyL3Qok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XUBNsOJzKdoFqyxxOs4JqQkezMFljK7iYSlzDjZ6Ol7nrdx8nkaX8l+3pifZr1G2c
	 +YsqeYYH81k1pB+TU3JYEZTwwl5I/SW9Paj8YtX6X1ddc30uF5nYTF6jSluE+4hDz/
	 PDFDid1c54c8p41QyKoIzCW8b598l6OuLZp9V2Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfJCB2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfJCB2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:28:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1019E222CC;
        Thu,  3 Oct 2019 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066101;
        bh=jYb6PLJxKNd9LF++H/PLSDwTIf7b8iJz+MMZGyL3Qok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=By5Yfaw16RvX/et3M4fexhD6Znk37fXohUBQpsrwPOL5HeRTSpdSWaI9gMvP7uJs7
         qUuBtWewhhfS+xbjcVOLJZRBUqbmkvwEIdjiDhPftl17vA58Y+mQSWK0Q4TpKlPifB
         LLXo2WEbB3sLCyiZnvHgNIv+NChQH18KjnR9ItB0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 6/9] Restore docs "treewide: Rename rcu_dereference_raw_notrace() to _check()"
Date:   Wed,  2 Oct 2019 18:28:12 -0700
Message-Id: <20191003012815.12639-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003012741.GA12456@paulmck-ThinkPad-P72>
References: <20191003012741.GA12456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This restores docs back in ReST format.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index a33b5fb..0b22246 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1997,7 +1997,7 @@ Tracing and RCU
 ~~~~~~~~~~~~~~~
 
 It is possible to use tracing on RCU code, but tracing itself uses RCU.
-For this reason, ``rcu_dereference_raw_notrace()`` is provided for use
+For this reason, ``rcu_dereference_raw_check()`` is provided for use
 by tracing, which avoids the destructive recursion that could otherwise
 ensue. This API is also used by virtualization in some architectures,
 where RCU readers execute in environments in which tracing cannot be
-- 
2.9.5

