Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4A520656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfH0KSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:18:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfH0KSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:18:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2E49CF1152E440C0EF29;
        Tue, 27 Aug 2019 18:18:04 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 18:17:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add missing documents of reserve_root/resuid/resgid
Date:   Tue, 27 Aug 2019 18:17:55 +0800
Message-ID: <20190827101755.27911-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documents.

Fixes: 7e65be49ed94f ("f2fs: add reserved blocks for root user")
Fixes: 7c2e59632b846 ("f2fs: add resgid and resuid to reserve root blocks")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 5fa38ab373ca..7e1991328473 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -157,6 +157,11 @@ noinline_data          Disable the inline data feature, inline data feature is
                        enabled by default.
 data_flush             Enable data flushing before checkpoint in order to
                        persist data of regular and symlink.
+reserve_root=%d        Support configuring reserved space which is used for
+                       allocation from a privileged user with specified uid or
+                       gid, unit: 4KB, the default limit is 0.2% of user blocks.
+resuid=%d              The user ID which may use the reserved blocks.
+resgid=%d              The group ID which may use the reserved blocks.
 fault_injection=%d     Enable fault injection in all supported types with
                        specified injection rate.
 fault_type=%d          Support configuring fault injection type, should be
-- 
2.18.0.rc1

