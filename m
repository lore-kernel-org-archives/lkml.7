Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D875EC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66CE2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfILRHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:07:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727209AbfILRHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:07:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE1895DD6A35682ACFE8;
        Fri, 13 Sep 2019 01:07:12 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 13 Sep 2019 01:07:04 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: rtsx: Remove unneeded variable in rts5260_card_power_on
Date:   Fri, 13 Sep 2019 01:04:01 +0800
Message-ID: <1568307841-44065-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rts5260_card_power_on do not need local variable to store different value,
Hence just remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/misc/cardreader/rts5260.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 40a6d19..4214f02 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -191,7 +191,6 @@ static int sd_set_sample_push_timing_sd30(struct rtsx_pcr *pcr)
 
 static int rts5260_card_power_on(struct rtsx_pcr *pcr, int card)
 {
-	int err = 0;
 	struct rtsx_cr_option *option = &pcr->option;
 
 	if (option->ocp_en)
@@ -231,7 +230,7 @@ static int rts5260_card_power_on(struct rtsx_pcr *pcr, int card)
 
 	rtsx_pci_write_register(pcr, REG_PRE_RW_MODE, EN_INFINITE_MODE, 0);
 
-	return err;
+	return 0;
 }
 
 static int rts5260_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
-- 
1.7.12.4

