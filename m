Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4159FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20067206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLWOXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:23:21 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:3416 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfLWOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:23:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tll1RuF_1577110987;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0Tll1RuF_1577110987)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Dec 2019 22:23:15 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH 2/3] firmware: arm_sdei: Removed multiple white lines.
Date:   Mon, 23 Dec 2019 22:22:54 +0800
Message-Id: <1577110975-54782-2-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577110975-54782-1-git-send-email-zhangliguang@linux.alibaba.com>
References: <1577110975-54782-1-git-send-email-zhangliguang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liguang Zhang <zhangliguang@linux.alibaba.com>

Remove one unnecessary white line.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/firmware/arm_sdei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index b122927..0a366cf 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -595,7 +595,6 @@ static int _sdei_event_register(struct sdei_event *event)
 					       event->registered,
 					       SDEI_EVENT_REGISTER_RM_ANY, 0);
 
-
 	err = sdei_do_cross_call(_local_event_register, event);
 	if (err) {
 		spin_lock(&sdei_list_lock);
-- 
1.8.3.1

