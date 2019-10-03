Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8649DC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EB2222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066106;
	bh=1lJv91vKKrdKjRgdRQor94squQr610oBJvHIaY9YZCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EP6t6E55s8FSOzjICBlTNSefsLtfCj1QEOry9LSJ5l7b523FTPQ6MmHTiK59y7bXW
	 VAu1Z2lcuA9Tcj2hIbAWNcjbO/7vnTDIiC07Oh0Y8p6zOsfITFePEvhKpIRpOeh/Bf
	 IKIj1lpFi/85IJW9+7wiOhX8QF41AkVVSHNADw3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfJCB2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfJCB2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:28:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2990222D3;
        Thu,  3 Oct 2019 01:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066100;
        bh=1lJv91vKKrdKjRgdRQor94squQr610oBJvHIaY9YZCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZkc4rNBPwjMsc5gXiEFqScyzrjIWuzlcH6z9qI1U529plG/6k4ac0EPIZMV1xARv
         JctoBvy+pIzGhnSlYBzxjcReXLXlxm2vKb/HZUB0UQSwOxnCFl4EgwyaMeaLXFWI11
         rEGGpm+3QbZhZAhqPO3MHnDLx+raeJfP5fy6VoDk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 5/9] docs: rcu: Increase toctree to 3
Date:   Wed,  2 Oct 2019 18:28:11 -0700
Message-Id: <20191003012815.12639-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003012741.GA12456@paulmck-ThinkPad-P72>
References: <20191003012741.GA12456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

These documents are long and have various sections. Provide a good
toc nesting level.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 94427dc..5c99185 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -5,7 +5,7 @@ RCU concepts
 ============
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 3
 
    rcu
    listRCU
-- 
2.9.5

