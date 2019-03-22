Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB4DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8482B21904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfCVOn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:43:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbfCVOn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:43:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B160B58A17CF8AA42476;
        Fri, 22 Mar 2019 22:43:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:43:11 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clocksource: timer-ti-dm: Make omap_dm_timer_set_load_start static
Date:   Fri, 22 Mar 2019 22:43:02 +0800
Message-ID: <20190322144302.6704-1-yuehaibing@huawei.com>
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

drivers/clocksource/timer-ti-dm.c:589:5: warning:
 symbol 'omap_dm_timer_set_load_start' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clocksource/timer-ti-dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index c364027..3352da6 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -586,8 +586,8 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 }
 
 /* Optimized set_load which removes costly spin wait in timer_start */
-int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
-                            unsigned int load)
+static int omap_dm_timer_set_load_start(struct omap_dm_timer *timer,
+					int autoreload, unsigned int load)
 {
 	u32 l;
 
-- 
2.7.0


