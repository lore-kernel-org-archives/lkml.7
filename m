Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70709C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435E62075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfECDuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 23:50:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbfECDuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 23:50:10 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 82DAF3FC22A4FC0A21D6;
        Fri,  3 May 2019 11:50:07 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.188.190) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 May 2019 11:49:56 +0800
From:   ChenGang <cg.chen@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>, <jiangqi903@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>, <joseph.qi@linux.alibaba.com>,
        ChenGang <cg.chen@huawei.com>
Subject: [PATCH v2] fs: ocfs: fix spelling mistake "hearbeating" -> "heartbeat"
Date:   Fri, 3 May 2019 11:53:56 +0800
Message-ID: <1556855636-121101-1-git-send-email-cg.chen@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.188.190]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some spelling mistakes in ocfs, fix it.

Signed-off-by: ChenGang <cg.chen@huawei.com>
---
 fs/ocfs2/cluster/heartbeat.c | 2 +-
 fs/ocfs2/cluster/quorum.c    | 2 +-
 fs/ocfs2/cluster/tcp.c       | 2 +-
 fs/ocfs2/dlm/dlmmaster.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index f3c20b2..e4e7df1 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1198,7 +1198,7 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
 	if (atomic_read(&reg->hr_steady_iterations) != 0) {
 		if (atomic_dec_and_test(&reg->hr_unsteady_iterations)) {
 			printk(KERN_NOTICE "o2hb: Unable to stabilize "
-			       "heartbeart on region %s (%s)\n",
+			       "heartbeat on region %s (%s)\n",
 			       config_item_name(&reg->hr_item),
 			       reg->hr_dev_name);
 			atomic_set(&reg->hr_steady_iterations, 0);
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
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index e9f236a..7a43c04 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1776,7 +1776,7 @@ static void o2net_hb_node_up_cb(struct o2nm_node *node, int node_num,
 		(msecs_to_jiffies(o2net_reconnect_delay()) + 1);
 
 	if (node_num != o2nm_this_node()) {
-		/* believe it or not, accept and node hearbeating testing
+		/* believe it or not, accept and node heartbeating testing
 		 * can succeed for this node before we got here.. so
 		 * only use set_nn_state to clear the persistent error
 		 * if that hasn't already happened */
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

