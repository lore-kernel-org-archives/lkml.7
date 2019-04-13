Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3706BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E11206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDMONB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:13:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbfDMONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 10:13:00 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CAA648618FA8893DE35;
        Sat, 13 Apr 2019 22:12:58 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Sat, 13 Apr 2019
 22:12:47 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <ssantosh@kernel.org>, <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soc: ti: pm33xx: Make two symbols static
Date:   Sat, 13 Apr 2019 22:12:43 +0800
Message-ID: <20190413141243.38620-1-yuehaibing@huawei.com>
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

Fix sparse warnings:

drivers/soc/ti/pm33xx.c:144:27: warning: symbol 'rtc_wake_src' was not declared. Should it be static?
drivers/soc/ti/pm33xx.c:160:5: warning: symbol 'am33xx_rtc_only_idle' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/ti/pm33xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index fc5802c..b22383c 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -141,7 +141,7 @@ static int __init am43xx_map_gic(void)
 }
 
 #ifdef CONFIG_SUSPEND
-struct wkup_m3_wakeup_src rtc_wake_src(void)
+static struct wkup_m3_wakeup_src rtc_wake_src(void)
 {
 	u32 i;
 
@@ -157,7 +157,7 @@ struct wkup_m3_wakeup_src rtc_wake_src(void)
 	return rtc_ext_wakeup;
 }
 
-int am33xx_rtc_only_idle(unsigned long wfi_flags)
+static int am33xx_rtc_only_idle(unsigned long wfi_flags)
 {
 	omap_rtc_power_off_program(&omap_rtc->dev);
 	am33xx_do_wfi_sram(wfi_flags);
-- 
2.7.4


