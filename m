Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9018C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08C2206E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfLDBHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:07:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfLDBHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:07:36 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6BFE199094A260B0DC59;
        Wed,  4 Dec 2019 09:07:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Dec 2019 09:07:23 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] power: supply: ab8500: Drop pointless static qualifier in ab8500_btemp_batctrl_volt_to_res()
Date:   Wed, 4 Dec 2019 09:05:06 +0800
Message-ID: <20191204010506.159128-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'T *v' variable static
since new value always be assigned before use it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/power/supply/ab8500_btemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 909f0242bacb..d3d4f7327d1b 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -180,7 +180,7 @@ static int ab8500_btemp_batctrl_volt_to_res(struct ab8500_btemp *di,
 static int ab8500_btemp_read_batctrl_voltage(struct ab8500_btemp *di)
 {
 	int vbtemp, ret;
-	static int prev;
+	int prev;
 
 	ret = iio_read_channel_processed(di->bat_ctrl, &vbtemp);
 	if (ret < 0) {
-- 
2.20.1

