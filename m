Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F2F213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCTOK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:10:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfCTOK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:10:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5ECB182E29FF4D44CE6E;
        Wed, 20 Mar 2019 22:10:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 22:10:00 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <richard@nod.at>, <dedekind1@gmail.com>, <adrian.hunter@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ubifs: remove unused function __ubifs_shash_final
Date:   Wed, 20 Mar 2019 22:09:55 +0800
Message-ID: <20190320140955.11576-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

There is no callers in tree, and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ubifs/auth.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index 5bf5fd0..2a40ccce 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -147,24 +147,6 @@ struct shash_desc *__ubifs_hash_get_desc(const struct ubifs_info *c)
 }
 
 /**
- * __ubifs_shash_final - finalize shash
- * @c: UBIFS file-system description object
- * @desc: the descriptor
- * @out: the output hash
- *
- * Simple wrapper around crypto_shash_final(), safe to be called with
- * disabled authentication.
- */
-int __ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
-			u8 *out)
-{
-	if (ubifs_authenticated(c))
-		return crypto_shash_final(desc, out);
-
-	return 0;
-}
-
-/**
  * ubifs_bad_hash - Report hash mismatches
  * @c: UBIFS file-system description object
  * @node: the node
-- 
2.7.0


