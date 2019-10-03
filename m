Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8878FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA67222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570062510;
	bh=yq8Iu91LeazRr6pSTvF2GsW+4RlyaurgS2ODPFf75P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BFjjqDM+siONDI4i6e7N2H1I3DbBIIl3ucv0sfzvVG2evyzXLcnGgOZv2xFEMvszW
	 b+pjs8kp+VqKl9VtYYTTy3PsrGn/RyXSnOfVFeOMdM3iTVASJysi2lmpDMIuznhtBo
	 qDCAcDXhv7ccJ/ojjA2IK/oyArIltO1s66P/Gjl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfJCA23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbfJCA04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D92222D2;
        Thu,  3 Oct 2019 00:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062416;
        bh=yq8Iu91LeazRr6pSTvF2GsW+4RlyaurgS2ODPFf75P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGgiyKk+82PUJnLTB89ch4R33S4IY1jCGlvGfLhPMkvhd5zdxKaolTeKVr2ZlhDF+
         dTcWrCJK9e0Uc0eydlsAq3PmCo+4ug6ssgBrJypjtd2Dkp3okoOgi2mat3tnuUpIcs
         E3sTylBRYdmdjlKpj6VJKQjFYt3GVxoQuWgQRNiM=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 13/32] tools/memory-model: Fix checkalllitmus.sh comment
Date:   Wed,  2 Oct 2019 17:26:31 -0700
Message-Id: <20191003002650.11249-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The checkalllitmus.sh runs litmus tests in the litmus-tests directory,
not those in the github archive, so this commit updates the comment to
reflect this reality.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkalllitmus.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 10e14d9..54d8da8 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -30,8 +30,8 @@ else
 	exit 255
 fi
 
-# Create any new directories that have appeared in the github litmus
-# repo since the last run.
+# Create any new directories that have appeared in the litmus-tests
+# directory since the last run.
 if test "$LKMM_DESTDIR" != "."
 then
 	find $litmusdir -type d -print |
-- 
2.9.5

