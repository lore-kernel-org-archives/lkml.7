Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F91FC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB060208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfD0NH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:07:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54016 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfD0NH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:07:56 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DB5FC8E434E1577076BB;
        Sat, 27 Apr 2019 21:07:53 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.188.190) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Sat, 27 Apr 2019 21:07:47 +0800
From:   ChenGang <cg.chen@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>, ChenGang <cg.chen@huawei.com>
Subject: [PATCH 1/3] fs: ocfs: fix spelling mistake "hearbeat" -> "heartbeat"
Date:   Sat, 27 Apr 2019 21:11:31 +0800
Message-ID: <1556370691-119217-1-git-send-email-cg.chen@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.188.190]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in dlm_assert_master_worker comment, fix it.

Signed-off-by: ChenGang <cg.chen@huawei.com>
---
 fs/ocfs2/dlm/dlmmaster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 826f056..41b80d5 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2176,7 +2176,7 @@ static void dlm_assert_master_worker(struct dlm_work_item *item, void *data)
  * think that $RECOVERY is currently mastered by a dead node.  If so,
  * we wait a short time to allow that node to get notified by its own
  * heartbeat stack, then check again.  All $RECOVERY lock resources
- * mastered by dead nodes are purged when the hearbeat callback is
+ * mastered by dead nodes are purged when the heartbeat callback is
  * fired, so we can know for sure that it is safe to continue once
  * the node returns a live node or no node.  */
 static int dlm_pre_master_reco_lockres(struct dlm_ctxt *dlm,
-- 
1.8.5.6

