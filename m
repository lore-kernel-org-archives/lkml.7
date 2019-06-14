Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60952168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFNPvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:51:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18611 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfFNPvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:51:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63FCCF5455CB3C68DAB6;
        Fri, 14 Jun 2019 23:51:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 23:51:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tyhicks@canonical.com>, <viro@zeniv.linux.org.uk>,
        <agruenba@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <ecryptfs@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ecryptfs: Make ecryptfs_xattr_handler static
Date:   Fri, 14 Jun 2019 23:51:17 +0800
Message-ID: <20190614155117.28988-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

fs/ecryptfs/inode.c:1138:28: warning:
 symbol 'ecryptfs_xattr_handler' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ecryptfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 1e994d7..18426f4 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1121,7 +1121,7 @@ static int ecryptfs_xattr_set(const struct xattr_handler *handler,
 	}
 }
 
-const struct xattr_handler ecryptfs_xattr_handler = {
+static const struct xattr_handler ecryptfs_xattr_handler = {
 	.prefix = "",  /* match anything */
 	.get = ecryptfs_xattr_get,
 	.set = ecryptfs_xattr_set,
-- 
2.7.4


