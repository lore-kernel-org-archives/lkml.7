Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A4C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAC320C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405965AbfHIIky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:40:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfHIIkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:40:53 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4B0C2AD66DF0B8DD3D71;
        Fri,  9 Aug 2019 16:40:51 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 16:40:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-afs@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] afs: remove unused variable 'afs_voltypes'
Date:   Fri, 9 Aug 2019 16:40:37 +0800
Message-ID: <20190809084037.68784-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/afs/volume.c:15:26: warning:
 afs_voltypes defined but not used [-Wunused-const-variable=]

It is not used since commit d2ddc776a458 ("afs: Overhaul
volume and server record caching and fileserver rotation")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/afs/volume.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 1a41430..92ca5e2 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -12,8 +12,6 @@
 unsigned __read_mostly afs_volume_gc_delay = 10;
 unsigned __read_mostly afs_volume_record_life = 60 * 60;
 
-static const char *const afs_voltypes[] = { "R/W", "R/O", "BAK" };
-
 /*
  * Allocate a volume record and load it up from a vldb record.
  */
-- 
2.7.4


