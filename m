Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D39D21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfCTMpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:45:50 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58355 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCTMpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:45:50 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id F123F100005;
        Wed, 20 Mar 2019 12:45:47 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: omap: checkpatch cleanup
Date:   Wed, 20 Mar 2019 13:45:35 +0100
Message-Id: <20190320124535.14606-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124535.14606-1-alexandre.belloni@bootlin.com>
References: <20190320124535.14606-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly align code with opening parenthesis.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-omap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 78082f94495e..ec3957c43cb6 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -450,7 +450,7 @@ static void omap_rtc_power_off(void)
 	 */
 	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
-			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
+		   val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
 
 	/* Retry in case roll over happened before alarm was armed. */
 	if (rtc_read(rtc, OMAP_RTC_SECONDS_REG) != seconds) {
@@ -538,7 +538,7 @@ static int rtc_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
 }
 
 static const char *rtc_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
-					unsigned int group)
+					      unsigned int group)
 {
 	return NULL;
 }
@@ -563,7 +563,7 @@ static const struct pin_config_item rtc_conf_items[ARRAY_SIZE(rtc_params)] = {
 #endif
 
 static int rtc_pinconf_get(struct pinctrl_dev *pctldev,
-			unsigned int pin, unsigned long *config)
+			   unsigned int pin, unsigned long *config)
 {
 	struct omap_rtc *rtc = pinctrl_dev_get_drvdata(pctldev);
 	unsigned int param = pinconf_to_config_param(*config);
@@ -591,8 +591,8 @@ static int rtc_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int rtc_pinconf_set(struct pinctrl_dev *pctldev,
-			unsigned int pin, unsigned long *configs,
-			unsigned int num_configs)
+			   unsigned int pin, unsigned long *configs,
+			   unsigned int num_configs)
 {
 	struct omap_rtc *rtc = pinctrl_dev_get_drvdata(pctldev);
 	u32 val;
@@ -757,7 +757,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (rtc->type->has_32kclk_en) {
 		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
 		rtc_writel(rtc, OMAP_RTC_OSC_REG,
-				reg | OMAP_RTC_OSC_32KCLK_EN);
+			   reg | OMAP_RTC_OSC_32KCLK_EN);
 	}
 
 	/* clear old status */
@@ -835,13 +835,13 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	/* handle periodic and alarm irqs */
 	ret = devm_request_irq(&pdev->dev, rtc->irq_timer, rtc_irq, 0,
-			dev_name(&rtc->rtc->dev), rtc);
+			       dev_name(&rtc->rtc->dev), rtc);
 	if (ret)
 		goto err;
 
 	if (rtc->irq_timer != rtc->irq_alarm) {
 		ret = devm_request_irq(&pdev->dev, rtc->irq_alarm, rtc_irq, 0,
-				dev_name(&rtc->rtc->dev), rtc);
+				       dev_name(&rtc->rtc->dev), rtc);
 		if (ret)
 			goto err;
 	}
@@ -889,7 +889,7 @@ static int omap_rtc_remove(struct platform_device *pdev)
 	u8 reg;
 
 	if (pm_power_off == omap_rtc_power_off &&
-			omap_rtc_power_off_rtc == rtc) {
+	    omap_rtc_power_off_rtc == rtc) {
 		pm_power_off = NULL;
 		omap_rtc_power_off_rtc = NULL;
 	}
-- 
2.20.1

