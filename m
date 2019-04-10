Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9934C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4F520854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbfDJOBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:01:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbfDJOBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:01:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 68756997ED979392EA33;
        Wed, 10 Apr 2019 22:00:59 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 22:00:48 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <bbrezillon@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <paul@crapouillou.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mtd: rawnand: ingenic: Make jz4725b_ooblayout_ops static
Date:   Wed, 10 Apr 2019 22:00:35 +0800
Message-ID: <20190410140035.33004-1-yuehaibing@huawei.com>
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

drivers/mtd/nand/raw/ingenic/ingenic_nand.c:140:32: warning:
 symbol 'jz4725b_ooblayout_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/ingenic/ingenic_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index ad0c905..d7b7c0f 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
@@ -137,7 +137,7 @@ static int jz4725b_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-const struct mtd_ooblayout_ops jz4725b_ooblayout_ops = {
+static const struct mtd_ooblayout_ops jz4725b_ooblayout_ops = {
 	.ecc = jz4725b_ooblayout_ecc,
 	.free = jz4725b_ooblayout_free,
 };
-- 
2.7.4


