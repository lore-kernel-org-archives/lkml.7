Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358C3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B6F214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552415179;
	bh=khL0hZ/HuJlCvnF3YLaJmISLLrNV2hEmqI58ECHESBc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WLykUnb6Z6cxCQ33hbWaWNd4mUDC8xLyJKmMqTAX+xGJuG5k7ZW67CwTy7xW+Ol5A
	 XT7tPbRl5ieEV2k4tjfztD38rZnlLwsTgmrsTIGSX5jWCQdAVo6/um/eZew3MAV1sj
	 /XVIiQamFvHiorzHOVZLbeJAZCh7IElZaI+mLT/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfCLS0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfCLS0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:26:17 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975282087C;
        Tue, 12 Mar 2019 18:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552415176;
        bh=khL0hZ/HuJlCvnF3YLaJmISLLrNV2hEmqI58ECHESBc=;
        h=From:To:Cc:Subject:Date:From;
        b=N+zt5LrwSy4LkHcC7iDBKAqHN7dwSQOIaIBlpEbmU2e3WpwMRDqTW12xOTnNOzxPK
         G0n/+FTkxk0xq+6tPthc7tPMhC6JVKfQmeIiBmJHMXnwxABh7qlOXGA0LOSrels4OP
         NLJC9WxVi0rP1u7m7h63kMKpzl66YaFxdyWWNqr8=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix wrong #endif
Date:   Tue, 12 Mar 2019 11:26:13 -0700
Message-Id: <20190312182613.47642-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have to cover whole headerfile with last #endif.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1f0d2810852..19cbf17550c7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3626,8 +3626,6 @@ extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
 #define f2fs_build_fault_attr(sbi, rate, type)		do { } while (0)
 #endif
 
-#endif
-
 static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 {
 #ifdef CONFIG_QUOTA
@@ -3640,3 +3638,5 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 #endif
 	return false;
 }
+
+#endif
-- 
2.19.0.605.g01d371f741-goog

