Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4006C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85B2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k/WIMon6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfDDGfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:35:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53394 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDDGfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:35:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x346ZXvE112805;
        Thu, 4 Apr 2019 01:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554359733;
        bh=AO4Wx7Cx7SVrWllTbR9M1qgzg6N01hAQWIHYsDD0QHw=;
        h=From:To:CC:Subject:Date;
        b=k/WIMon6Dleg2J0Nuf/DWHYpqd0PJ3SL3M3y4SgNz66MA/TzDLFLA2hu/KcpLXh+W
         wfK+kLN9B7b+o4L5sbbMR6G7ot6kieglbpBT5YG76BH4D5tejdTq6/TtH89RQQvlPw
         MpryGBkhUSWqICBHm2S+vIdLdxLAP+xtzKS21bLI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x346ZXjF035454
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 01:35:33 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 01:35:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 01:35:33 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x346ZUhN004858;
        Thu, 4 Apr 2019 01:35:31 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <tony@atomide.com>, <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>
Subject: [PATCH] clocksource: timer-ti-dm: Remove unused omap_dm_timer_set_load_start
Date:   Thu, 4 Apr 2019 12:05:36 +0530
Message-ID: <20190404063536.23958-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

omap_dm_timer_set_load_start is no longer used hence delete the
function and remove the below warning.

drivers/clocksource/timer-ti-dm.c:589:12:
warning: ‘omap_dm_timer_set_load_start’ defined but not used

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/clocksource/timer-ti-dm.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 3352da6ed61f..ee8ec5a8cb16 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -585,34 +585,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	return 0;
 }
 
-/* Optimized set_load which removes costly spin wait in timer_start */
-static int omap_dm_timer_set_load_start(struct omap_dm_timer *timer,
-					int autoreload, unsigned int load)
-{
-	u32 l;
-
-	if (unlikely(!timer))
-		return -EINVAL;
-
-	omap_dm_timer_enable(timer);
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload) {
-		l |= OMAP_TIMER_CTRL_AR;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
-	} else {
-		l &= ~OMAP_TIMER_CTRL_AR;
-	}
-	l |= OMAP_TIMER_CTRL_ST;
-
-	__omap_dm_timer_load_start(timer, l, load, timer->posted);
-
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tldr = load;
-	timer->context.tcrr = load;
-	return 0;
-}
 static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 				   unsigned int match)
 {
-- 
2.17.1

