Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09A9CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA0121479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfJ2Auf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:50:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfJ2Auf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 20:50:35 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 92A7527782FF23F62B66
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:50:33 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Tue, 29 Oct 2019 08:50:22 +0800
From:   Tian Tao <tiantao6@huawei.com>
To:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] mailbox: no need to set .owner platform_driver_register
Date:   Tue, 29 Oct 2019 08:51:04 +0800
Message-ID: <1572310264-36373-1-git-send-email-tiantao6@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the platform_driver_register will set the .owner to THIS_MODULE

Signed-off-by: Tian Tao <tiantao6@huawei.com>
---
 drivers/mailbox/hi6220-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index 8b9eb56..cc236ac 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -354,7 +354,6 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 static struct platform_driver hi6220_mbox_driver = {
 	.driver = {
 		.name = "hi6220-mbox",
-		.owner = THIS_MODULE,
 		.of_match_table = hi6220_mbox_of_match,
 	},
 	.probe	= hi6220_mbox_probe,
-- 
2.7.4

