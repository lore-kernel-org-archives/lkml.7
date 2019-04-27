Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B25721655
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfD0NJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:09:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfD0NJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:09:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B29234411D21CC95C20E;
        Sat, 27 Apr 2019 21:09:47 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.188.190) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 27 Apr 2019 21:09:38 +0800
From:   ChenGang <cg.chen@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>, ChenGang <cg.chen@huawei.com>
Subject: [PATCH 2/3] fs: ocfs: fix spelling mistake "hearbeat" -> "heartbeat"
Date:   Sat, 27 Apr 2019 21:13:24 +0800
Message-ID: <1556370804-119280-1-git-send-email-cg.chen@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.188.190]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in comment, fix it.

Signed-off-by: ChenGang <cg.chen@huawei.com>
---
 fs/ocfs2/cluster/quorum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
index af2e747..792132f 100644
--- a/fs/ocfs2/cluster/quorum.c
+++ b/fs/ocfs2/cluster/quorum.c
@@ -89,7 +89,7 @@ static void o2quo_fence_self(void)
 	};
 }
 
-/* Indicate that a timeout occurred on a hearbeat region write. The
+/* Indicate that a timeout occurred on a heartbeat region write. The
  * other nodes in the cluster may consider us dead at that time so we
  * want to "fence" ourselves so that we don't scribble on the disk
  * after they think they've recovered us. This can't solve all
-- 
1.8.5.6

