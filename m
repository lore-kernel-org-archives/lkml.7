Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1ECC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA079222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLSKhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:37:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbfLSKhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:37:35 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CEACD2CF50DD0D6A9E70
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 18:37:32 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 18:37:25 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <mikulas@artax.karlin.mff.cuni.cz>, <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] hpfs: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 18:44:46 +0800
Message-ID: <1576752286-17549-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

fs/hpfs/buffer.c:56:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/hpfs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/buffer.c b/fs/hpfs/buffer.c
index e285d6b..d392468 100644
--- a/fs/hpfs/buffer.c
+++ b/fs/hpfs/buffer.c
@@ -53,7 +53,7 @@ void hpfs_prefetch_sectors(struct super_block *s, unsigned secno, int n)
 			return;
 		}
 		brelse(bh);
-	};
+	}

 	blk_start_plug(&plug);
 	while (n > 0) {
--
2.7.4

