Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C081EC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81572206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfDMOYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:24:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfDMOYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 10:24:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D8386A07E59970F0E2DA;
        Sat, 13 Apr 2019 22:24:01 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Sat, 13 Apr 2019
 22:23:53 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] eventfd: Make eventfd_ida static
Date:   Sat, 13 Apr 2019 22:23:48 +0800
Message-ID: <20190413142348.34716-1-yuehaibing@huawei.com>
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

Fix sparse warning:

fs/eventfd.c:26:1: warning:
 symbol 'eventfd_ida' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index ce8fa15..93b1fa7 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -23,7 +23,7 @@
 #include <linux/seq_file.h>
 #include <linux/idr.h>
 
-DEFINE_IDA(eventfd_ida);
+static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
 	struct kref kref;
-- 
2.7.4


