Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EBBC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087E0215A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfK1AuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:50:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbfK1AuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:50:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BAA0C8C86F4CEBD82275;
        Thu, 28 Nov 2019 08:50:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 28 Nov 2019 08:49:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <pmladek@suse.com>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <tj@kernel.org>, <arnd@arndb.de>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/4] staging: isdn: gigaset: Use pr_warn instead of pr_warning
Date:   Thu, 28 Nov 2019 08:47:50 +0800
Message-ID: <20191128004752.35268-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_warn() instead of the remaining pr_warning() calls.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/staging/isdn/gigaset/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/isdn/gigaset/interface.c b/drivers/staging/isdn/gigaset/interface.c
index 17fa615a8c68..9ddadd07e707 100644
--- a/drivers/staging/isdn/gigaset/interface.c
+++ b/drivers/staging/isdn/gigaset/interface.c
@@ -518,7 +518,7 @@ void gigaset_if_init(struct cardstate *cs)
 	if (!IS_ERR(cs->tty_dev))
 		dev_set_drvdata(cs->tty_dev, cs);
 	else {
-		pr_warning("could not register device to the tty subsystem\n");
+		pr_warn("could not register device to the tty subsystem\n");
 		cs->tty_dev = NULL;
 	}
 	mutex_unlock(&cs->mutex);
-- 
2.20.1

