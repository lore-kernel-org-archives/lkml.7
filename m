Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF365C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931732171F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbfDRRDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:03:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44734 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:03:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hHARy-0004nu-UO; Thu, 18 Apr 2019 17:03:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firestream: fix spelling mistake "tramsitted" -> "transmitted"
Date:   Thu, 18 Apr 2019 18:03:50 +0100
Message-Id: <20190418170350.23247-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/atm/firestream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 11e1663bdc4d..b2c06da4f62e 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1646,7 +1646,7 @@ static irqreturn_t fs_irq (int irq, void *dev_id)
 	}
 
 	if (status & ISR_TBRQ_W) {
-		fs_dprintk (FS_DEBUG_IRQ, "Data tramsitted!\n");
+		fs_dprintk (FS_DEBUG_IRQ, "Data transmitted!\n");
 		process_txdone_queue (dev, &dev->tx_relq);
 	}
 
-- 
2.20.1

