Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14548205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfCSPU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:20:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbfCSPU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:20:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31B86817246F9BB49716;
        Tue, 19 Mar 2019 23:20:56 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 23:20:46 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drivers: base: swnode: Make two functions static
Date:   Tue, 19 Mar 2019 23:20:42 +0800
Message-ID: <20190319152042.9780-1-yuehaibing@huawei.com>
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

drivers/base/swnode.c:475:22: warning: symbol 'software_node_get_parent' was not declared. Should it be static?
drivers/base/swnode.c:484:22: warning: symbol 'software_node_get_next_child' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/base/swnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 1fad929..7fc5a18 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -472,7 +472,7 @@ static int software_node_read_string_array(const struct fwnode_handle *fwnode,
 						val, nval);
 }
 
-struct fwnode_handle *
+static struct fwnode_handle *
 software_node_get_parent(const struct fwnode_handle *fwnode)
 {
 	struct software_node *swnode = to_software_node(fwnode);
@@ -481,7 +481,7 @@ software_node_get_parent(const struct fwnode_handle *fwnode)
 			NULL;
 }
 
-struct fwnode_handle *
+static struct fwnode_handle *
 software_node_get_next_child(const struct fwnode_handle *fwnode,
 			     struct fwnode_handle *child)
 {
-- 
2.7.4


