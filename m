Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43AAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADED120709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNJmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:42:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34067 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:42:36 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iVBdz-0002lV-0H; Thu, 14 Nov 2019 09:42:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: fix indentation issue
Date:   Thu, 14 Nov 2019 09:42:26 +0000
Message-Id: <20191114094226.131317-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of debug statements that are indented
too deeply, remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/jffs2/nodemgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
index a7bbe879cfc3..4699a4ab519f 100644
--- a/fs/jffs2/nodemgmt.c
+++ b/fs/jffs2/nodemgmt.c
@@ -624,8 +624,8 @@ void jffs2_mark_node_obsolete(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 					  ref->flash_offset, jeb->used_size);
 			BUG();
 		})
-			jffs2_dbg(1, "Obsoleting previously unchecked node at 0x%08x of len %x\n",
-				  ref_offset(ref), freed_len);
+		jffs2_dbg(1, "Obsoleting previously unchecked node at 0x%08x of len %x\n",
+			  ref_offset(ref), freed_len);
 		jeb->unchecked_size -= freed_len;
 		c->unchecked_size -= freed_len;
 	} else {
@@ -635,8 +635,8 @@ void jffs2_mark_node_obsolete(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 					  ref->flash_offset, jeb->used_size);
 			BUG();
 		})
-			jffs2_dbg(1, "Obsoleting node at 0x%08x of len %#x: ",
-				  ref_offset(ref), freed_len);
+		jffs2_dbg(1, "Obsoleting node at 0x%08x of len %#x: ",
+			  ref_offset(ref), freed_len);
 		jeb->used_size -= freed_len;
 		c->used_size -= freed_len;
 	}
-- 
2.20.1

