Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4220C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECDB21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfCUPPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:15:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbfCUPPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:15:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 914E05C6847931BD5BC2;
        Thu, 21 Mar 2019 23:15:06 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 23:14:57 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <tglx@linutronix.de>, <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] irqchip/irq-mvebu-sei: Make mvebu_sei_ap806_caps static
Date:   Thu, 21 Mar 2019 23:14:48 +0800
Message-ID: <20190321151448.15600-1-yuehaibing@huawei.com>
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

drivers/irqchip/irq-mvebu-sei.c:481:23: warning:
 symbol 'mvebu_sei_ap806_caps' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/irqchip/irq-mvebu-sei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index add4c9c..18832cc 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -478,7 +478,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	return ret;
 }
 
-struct mvebu_sei_caps mvebu_sei_ap806_caps = {
+static struct mvebu_sei_caps mvebu_sei_ap806_caps = {
 	.ap_range = {
 		.first = 0,
 		.size = 21,
-- 
2.7.0


