Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E87C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209222075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfDPLZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:25:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56848 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:25:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGMDl-0001fY-PC; Tue, 16 Apr 2019 11:25:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     reiserfs-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] reiserfs: fix spelling mistake "enrty" -> "entry"
Date:   Tue, 16 Apr 2019 12:25:49 +0100
Message-Id: <20190416112549.25175-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/reiserfs/lbalance.c | 2 +-
 fs/reiserfs/namei.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/reiserfs/lbalance.c b/fs/reiserfs/lbalance.c
index f5cebd70d903..e7cebd05a882 100644
--- a/fs/reiserfs/lbalance.c
+++ b/fs/reiserfs/lbalance.c
@@ -1164,7 +1164,7 @@ void leaf_cut_from_buffer(struct buffer_info *bi, int cut_item_num,
 		if (pos_in_item == 0) {
 			/* change key */
 			RFALSE(cut_item_num,
-			       "when 0-th enrty of item is cut, that item must be first in the node, not %d-th",
+			       "when 0-th entry of item is cut, that item must be first in the node, not %d-th",
 			       cut_item_num);
 			/* change item key by key of first entry in the item */
 			set_le_ih_k_offset(ih, deh_offset(B_I_DEH(bh, ih)));
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 97f3fc4fdd79..c97c36b4a31c 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -536,7 +536,7 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
 		pathrelse(&path);
 		return -EBUSY;
 	}
-	/* adjust offset of directory enrty */
+	/* adjust offset of directory entry */
 	put_deh_offset(deh, SET_GENERATION_NUMBER(deh_offset(deh), gen_number));
 	set_cpu_key_k_offset(&entry_key, deh_offset(deh));
 
-- 
2.20.1

