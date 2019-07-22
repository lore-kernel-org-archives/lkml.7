Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161BE2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfGVR06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:26:58 -0400
Received: from sauhun.de ([88.99.104.3]:42398 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731494AbfGVR0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:35 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id F2EFA4A148F;
        Mon, 22 Jul 2019 19:26:33 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: ir-kbd-i2c: remove outdated comments
Date:   Mon, 22 Jul 2019 19:26:32 +0200
Message-Id: <20190722172632.4402-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172632.4402-1-wsa+renesas@sang-engineering.com>
References: <20190722172632.4402-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "free memory" comment is obsolete since 2013 and the other ones
explain the obvious. Just remove the comments.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/i2c/ir-kbd-i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/i2c/ir-kbd-i2c.c b/drivers/media/i2c/ir-kbd-i2c.c
index f46717052efc..30fde0e025c9 100644
--- a/drivers/media/i2c/ir-kbd-i2c.c
+++ b/drivers/media/i2c/ir-kbd-i2c.c
@@ -916,13 +916,9 @@ static int ir_remove(struct i2c_client *client)
 {
 	struct IR_i2c *ir = i2c_get_clientdata(client);
 
-	/* kill outstanding polls */
 	cancel_delayed_work_sync(&ir->work);
-
-	/* unregister device */
 	rc_unregister_device(ir->rc);
 
-	/* free memory */
 	return 0;
 }
 
-- 
2.20.1

