Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04FEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC72204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfDDKr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:47:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfDDKr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:47:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D96BF34CE1D455304EA7;
        Thu,  4 Apr 2019 18:47:23 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 18:47:16 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <bbrezillon@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <paul@crapouillou.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mtd: rawnand: ingenic: Add missing MODULE_* information
Date:   Thu, 4 Apr 2019 18:47:11 +0800
Message-ID: <20190404104711.23560-1-yuehaibing@huawei.com>
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

gcc warning this:

WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/raw/ingenic/ingenic_ecc.o

Add MODULE_LICENSE,MODULE_AUTHOR and MODULE_DESCRIPTION.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 9df5741a577e ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
index 7b07a6a..77e996e 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
@@ -158,3 +158,8 @@ int ingenic_ecc_probe(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL(ingenic_ecc_probe);
+
+MODULE_AUTHOR("Alex Smith <alex@alex-smith.me.uk>");
+MODULE_AUTHOR("Harvey Hunt <harveyhuntnexus@gmail.com>");
+MODULE_DESCRIPTION("Ingenic ECC common driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.0


