Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14760CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD8621D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438589AbfJYJaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:30:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438521AbfJYJay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:30:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DFE559FBAB0490E9D0C7;
        Fri, 25 Oct 2019 17:30:52 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 17:30:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <3chas3@gmail.com>, <davem@davemloft.net>
CC:     <linux-atm-general@lists.sourceforge.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] atm: remove unneeded semicolon
Date:   Fri, 25 Oct 2019 17:30:30 +0800
Message-ID: <20191025093030.956-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded semicolon.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/atm/firestream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 2bbab02..aad00d2 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1070,7 +1070,7 @@ static int fs_open(struct atm_vcc *atm_vcc)
 					RC_FLAGS_BFPS_BFP * bfp |
 					RC_FLAGS_RXBM_PSB, 0, 0);
 			break;
-		};
+		}
 		if (IS_FS50 (dev)) {
 			submit_command (dev, &dev->hp_txq, 
 					QE_CMD_REG_WR | QE_CMD_IMM_INQ,
-- 
2.7.4


