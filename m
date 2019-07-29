Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F99C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41512073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfG2Gwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:52:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbfG2Gwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:34 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 18580111DE9E06CEEB4B;
        Mon, 29 Jul 2019 14:52:30 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:21 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 07/22] staging: erofs: remove redundant #include "internal.h"
Date:   Mon, 29 Jul 2019 14:51:44 +0800
Message-ID: <20190729065159.62378-8-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because #include "internal.h" is included in xattr.h

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/namei.c | 1 -
 drivers/staging/erofs/super.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index 50816b4c05fc..8e06526da023 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -6,7 +6,6 @@
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
-#include "internal.h"
 #include "xattr.h"
 
 #include <trace/events/erofs.h>
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 55f51d2b3930..c20a94b035a7 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -11,7 +11,6 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
-#include "internal.h"
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
-- 
2.17.1

