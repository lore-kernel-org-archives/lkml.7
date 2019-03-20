Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43634C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C75E213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfCTMlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:41:14 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56741 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfCTMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:41:12 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BFBB51BF20F;
        Wed, 20 Mar 2019 12:41:09 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/6] rtc: at91sam9: correct trivial checkpatch warnings
Date:   Wed, 20 Mar 2019 13:40:42 +0100
Message-Id: <20190320124042.14141-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
References: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct trivial checkpatch warnings, mostly whitespace issues and
unbalanced braces.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91sam9.c | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index d8a23b89ba73..4daf3789b978 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -43,21 +43,21 @@
  * registers available, likewise usable for more than "RTC" support.
  */
 
-#define AT91_RTT_MR		0x00			/* Real-time Mode Register */
-#define AT91_RTT_RTPRES		(0xffff << 0)		/* Real-time Timer Prescaler Value */
-#define AT91_RTT_ALMIEN		(1 << 16)		/* Alarm Interrupt Enable */
-#define AT91_RTT_RTTINCIEN	(1 << 17)		/* Real Time Timer Increment Interrupt Enable */
-#define AT91_RTT_RTTRST		(1 << 18)		/* Real Time Timer Restart */
+#define AT91_RTT_MR		0x00		/* Real-time Mode Register */
+#define AT91_RTT_RTPRES		(0xffff << 0)	/* Timer Prescaler Value */
+#define AT91_RTT_ALMIEN		BIT(16)		/* Alarm Interrupt Enable */
+#define AT91_RTT_RTTINCIEN	BIT(17)		/* Increment Interrupt Enable */
+#define AT91_RTT_RTTRST		BIT(18)		/* Timer Restart */
 
-#define AT91_RTT_AR		0x04			/* Real-time Alarm Register */
-#define AT91_RTT_ALMV		(0xffffffff)		/* Alarm Value */
+#define AT91_RTT_AR		0x04		/* Real-time Alarm Register */
+#define AT91_RTT_ALMV		(0xffffffff)	/* Alarm Value */
 
-#define AT91_RTT_VR		0x08			/* Real-time Value Register */
-#define AT91_RTT_CRTV		(0xffffffff)		/* Current Real-time Value */
+#define AT91_RTT_VR		0x08		/* Real-time Value Register */
+#define AT91_RTT_CRTV		(0xffffffff)	/* Current Real-time Value */
 
-#define AT91_RTT_SR		0x0c			/* Real-time Status Register */
-#define AT91_RTT_ALMS		(1 << 0)		/* Real-time Alarm Status */
-#define AT91_RTT_RTTINC		(1 << 1)		/* Real-time Timer Increment */
+#define AT91_RTT_SR		0x0c		/* Real-time Status Register */
+#define AT91_RTT_ALMS		BIT(0)		/* Alarm Status */
+#define AT91_RTT_RTTINC		BIT(1)		/* Timer Increment */
 
 /*
  * We store ALARM_DISABLED in ALMV to record that no alarm is set.
@@ -65,14 +65,13 @@
  */
 #define ALARM_DISABLED	((u32)~0)
 
-
 struct sam9_rtc {
 	void __iomem		*rtt;
 	struct rtc_device	*rtcdev;
 	u32			imr;
 	struct regmap		*gpbr;
 	unsigned int		gpbr_offset;
-	int 			irq;
+	int			irq;
 	struct clk		*sclk;
 	bool			suspended;
 	unsigned long		events;
@@ -253,7 +252,7 @@ static int at91_rtc_proc(struct device *dev, struct seq_file *seq)
 	u32 mr = rtt_readl(rtc, MR);
 
 	seq_printf(seq, "update_IRQ\t: %s\n",
-			(mr & AT91_RTT_RTTINCIEN) ? "yes" : "no");
+		   (mr & AT91_RTT_RTTINCIEN) ? "yes" : "no");
 	return 0;
 }
 
@@ -289,7 +288,7 @@ static void at91_rtc_flush_events(struct sam9_rtc *rtc)
 	rtc->events = 0;
 
 	pr_debug("%s: num=%ld, events=0x%02lx\n", __func__,
-		rtc->events >> 8, rtc->events & 0x000000FF);
+		 rtc->events >> 8, rtc->events & 0x000000FF);
 }
 
 /*
@@ -367,8 +366,8 @@ static int at91_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(rtc->rtt);
 
 	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
-					"atmel,rtt-rtc-time-reg", 1, 0,
-					&args);
+					       "atmel,rtt-rtc-time-reg", 1, 0,
+					       &args);
 	if (ret)
 		return ret;
 
@@ -434,7 +433,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 
 	if (gpbr_readl(rtc) == 0)
 		dev_warn(&pdev->dev, "%s: SET TIME!\n",
-				dev_name(&rtc->rtcdev->dev));
+			 dev_name(&rtc->rtcdev->dev));
 
 	return rtc_register_device(rtc->rtcdev);
 
@@ -494,8 +493,9 @@ static int at91_rtc_suspend(struct device *dev)
 			/* don't let RTTINC cause wakeups */
 			if (mr & AT91_RTT_RTTINCIEN)
 				rtt_writel(rtc, MR, mr & ~AT91_RTT_RTTINCIEN);
-		} else
+		} else {
 			rtt_writel(rtc, MR, mr & ~rtc->imr);
+		}
 	}
 
 	return 0;
-- 
2.20.1

