Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7852BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B312087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfD0MTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:19:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfD0MS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:18:59 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9F52574E80E277DEDA13;
        Sat, 27 Apr 2019 20:18:57 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.188.190) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Sat, 27 Apr 2019 20:18:49 +0800
From:   ChenGang <cg.chen@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>, ChenGang <cg.chen@huawei.com>
Subject: [PATCH] fs: ocfs: fix spelling mistake "heartbeart" -> "heartbeat"
Date:   Sat, 27 Apr 2019 20:22:35 +0800
Message-ID: <1556367755-118120-1-git-send-email-cg.chen@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.188.190]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in o2hb_do_disk_heartbeat debug message.Fix it.

Signed-off-by: ChenGang <cg.chen@huawei.com>
---
 fs/ocfs2/cluster/heartbeat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.8.5.6

