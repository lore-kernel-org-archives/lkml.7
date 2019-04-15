Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A74C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A99520833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfDOH3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:29:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfDOH2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:28:51 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 97CCC826DA2637195F4A;
        Mon, 15 Apr 2019 15:28:49 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 15:28:48 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 15:28:48 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 03/13] f2fs: remove new blank line of f2fs kernel message
Date:   Mon, 15 Apr 2019 15:28:32 +0800
Message-ID: <20190415072842.2438-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190415072842.2438-1-yuchao0@huawei.com>
References: <20190415072842.2438-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just removing '\n' in f2fs_msg(, "\n") to avoid redundant new blank line.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c  | 4 ++--
 fs/f2fs/super.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f19a2ec9f0ef..333d1fed956e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2587,7 +2587,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 	if (!f2fs_is_multi_device(sbi) || sbi->s_ndevs - 1 <= range.dev_num ||
 			__is_large_section(sbi)) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
-			"Can't flush %u in %d for segs_per_sec %u != 1\n",
+			"Can't flush %u in %d for segs_per_sec %u != 1",
 				range.dev_num, sbi->s_ndevs,
 				sbi->segs_per_sec);
 		return -EINVAL;
@@ -2869,7 +2869,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 
 	if (fi->i_gc_failures[GC_FAILURE_PIN] > sbi->gc_pin_file_threshold) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
-			"%s: Enable GC = ino %lx after %x GC trials\n",
+			"%s: Enable GC = ino %lx after %x GC trials",
 			__func__, inode->i_ino,
 			fi->i_gc_failures[GC_FAILURE_PIN]);
 		clear_inode_flag(inode, FI_PIN_FILE);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0b6fa77c35f3..2cd78583218a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2454,7 +2454,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	/* Currently, support only 4KB page cache size */
 	if (F2FS_BLKSIZE != PAGE_SIZE) {
 		f2fs_msg(sb, KERN_INFO,
-			"Invalid page_cache_size (%lu), supports only 4KB\n",
+			"Invalid page_cache_size (%lu), supports only 4KB",
 			PAGE_SIZE);
 		return 1;
 	}
@@ -2463,7 +2463,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	blocksize = 1 << le32_to_cpu(raw_super->log_blocksize);
 	if (blocksize != F2FS_BLKSIZE) {
 		f2fs_msg(sb, KERN_INFO,
-			"Invalid blocksize (%u), supports only 4KB\n",
+			"Invalid blocksize (%u), supports only 4KB",
 			blocksize);
 		return 1;
 	}
@@ -2471,7 +2471,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	/* check log blocks per segment */
 	if (le32_to_cpu(raw_super->log_blocks_per_seg) != 9) {
 		f2fs_msg(sb, KERN_INFO,
-			"Invalid log blocks per segment (%u)\n",
+			"Invalid log blocks per segment (%u)",
 			le32_to_cpu(raw_super->log_blocks_per_seg));
 		return 1;
 	}
@@ -3113,7 +3113,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #ifndef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		f2fs_msg(sb, KERN_ERR,
-			 "Zoned block device support is not enabled\n");
+			 "Zoned block device support is not enabled");
 		err = -EOPNOTSUPP;
 		goto free_sb_buf;
 	}
-- 
2.18.0.rc1

