Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3B5C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14601213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDGVGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:06:34 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36483 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfDGVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:06:25 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 2C44B240008;
        Sun,  7 Apr 2019 21:06:23 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 8/8] rtc: ds1672: switch debug message to %ptR
Date:   Sun,  7 Apr 2019 23:05:41 +0200
Message-Id: <20190407210541.13409-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
References: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptR to simplify debug message.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1672.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 95c23b31c952..e9e8d02743ee 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -73,10 +73,7 @@ static int ds1672_read_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_time64_to_tm(time, tm);
 
-	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
-		"mday=%d, mon=%d, year=%d, wday=%d\n",
-		__func__, tm->tm_sec, tm->tm_min, tm->tm_hour,
-		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+	dev_dbg(&client->dev, "%s: tm is %ptR\n", __func__, tm);
 
 	return 0;
 }
-- 
2.20.1

