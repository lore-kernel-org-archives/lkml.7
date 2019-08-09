Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405F420C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405972AbfHIImu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:42:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfHIImt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:42:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C5A6BA0DCFA3A01AE7D0;
        Fri,  9 Aug 2019 16:42:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 16:42:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-afs@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] afs: remove unused variable 'afs_zero_fid'
Date:   Fri, 9 Aug 2019 16:42:31 +0800
Message-ID: <20190809084231.62132-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/afs/fsclient.c:18:29: warning:
 afs_zero_fid defined but not used [-Wunused-const-variable=]

It is never used since commit 025db80c9e42 ("afs: Trace
the initiation and completion of client calls")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/afs/fsclient.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 114f281..67af068 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -15,8 +15,6 @@
 #include "xdr_fs.h"
 #include "protocol_yfs.h"
 
-static const struct afs_fid afs_zero_fid;
-
 static inline void afs_use_fs_server(struct afs_call *call, struct afs_cb_interest *cbi)
 {
 	call->cbi = afs_get_cb_interest(cbi);
-- 
2.7.4


