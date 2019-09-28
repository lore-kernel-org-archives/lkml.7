Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CEDC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 08:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E3A2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 08:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfI1I4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 04:56:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfI1I4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 04:56:11 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 521D5E4610E89206989F;
        Sat, 28 Sep 2019 16:55:52 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 16:55:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] regulator: pcap-regulator: remove unused variable 'SW3_table'
Date:   Sat, 28 Sep 2019 16:55:40 +0800
Message-ID: <20190928085540.45332-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/regulator/pcap-regulator.c:89:27: warning:
 SW3_table defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/regulator/pcap-regulator.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/pcap-regulator.c b/drivers/regulator/pcap-regulator.c
index c246926..0345f38 100644
--- a/drivers/regulator/pcap-regulator.c
+++ b/drivers/regulator/pcap-regulator.c
@@ -86,10 +86,6 @@ static const unsigned int SW1_table[] = {
 
 #define SW2_table SW1_table
 
-static const unsigned int SW3_table[] = {
-	4000000, 4500000, 5000000, 5500000,
-};
-
 struct pcap_regulator {
 	const u8 reg;
 	const u8 en;
-- 
2.7.4


