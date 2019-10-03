Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9847CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B97222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570062463;
	bh=3elrFw8mG2RF8GFE6+qw0fOSV8Z6Vl7d7zJd50Ul4e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hIYcBEgljdUS7oToG2PSp0BHd5Ey6OK5pG0wtFixi8aunR4Et2aR1icRVxbBB7BCK
	 lA2eWI8+hNVIYoj84E00yDOldrIhEdPCJDMEFl+QhIZVL5ow6i+vd69Xhp7sypcRGw
	 20/QlC7i5c6fO05j7mp8ENZJVKAO1ALaw+m8XhaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfJCA1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbfJCA1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A904222C0;
        Thu,  3 Oct 2019 00:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062420;
        bh=3elrFw8mG2RF8GFE6+qw0fOSV8Z6Vl7d7zJd50Ul4e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PbjIFKsvtWTbf/CZeUG8jazdXjv4Gfadc8I9x0Fud8RH3aGHGD6o6zPAtnd4DO6qo
         jmflttIwnNh4dIl+NVkxbcrujXu4n6m4obCMvu4O0wfnytwTA6LQQAbxWePs1FwZXB
         PyBdY9x3pRV+odNV2Hpq007thNNPgHhdgLa1+NGw=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 28/32] tools/memory-model: Repair parseargs.sh header comment
Date:   Wed,  2 Oct 2019 17:26:46 -0700
Message-Id: <20191003002650.11249-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 7aa5875..08ded59 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# the corresponding .litmus.out file, and does not judge the result.
+# Parse arguments common to the various scripts.
 #
 # . scripts/parseargs.sh
 #
-- 
2.9.5

