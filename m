Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCD2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFF620874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfJ3ICo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:02:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40234 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3ICo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:02:44 -0400
Received: from [91.217.168.176] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iPiwE-0007tC-Oe; Wed, 30 Oct 2019 08:02:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: ti-msgmgr: fix spelling mistake "queuid" -> "queue id"
Date:   Wed, 30 Oct 2019 09:02:41 +0100
Message-Id: <20191030080241.11262-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mailbox/ti-msgmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 88047d835211..f33b173c0bd0 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -592,7 +592,7 @@ static int ti_msgmgr_queue_setup(int idx, struct device *dev,
 	qinst->queue_id = qd->queue_id;
 
 	if (qinst->queue_id > d->queue_count) {
-		dev_err(dev, "Queue Data [idx=%d] queuid %d > %d\n",
+		dev_err(dev, "Queue Data [idx=%d] queue id %d > %d\n",
 			idx, qinst->queue_id, d->queue_count);
 		return -ERANGE;
 	}
-- 
2.20.1

