Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E113C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D2E213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCTMAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:00:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46453 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:00:08 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 970E41BF210;
        Wed, 20 Mar 2019 12:00:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: ab-b5ze-s3: correct checkpatch issues
Date:   Wed, 20 Mar 2019 12:59:59 +0100
Message-Id: <20190320115959.12044-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct trivial whitespace and split strings issues.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index ef895ae431c1..cdad6f00debf 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -468,8 +468,8 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 		if (alarm_secs > rtc_secs) {
-			dev_err(dev, "%s: alarm maximum is one month in the "
-				"future (%d)\n", __func__, ret);
+			dev_err(dev, "%s: alarm maximum is one month in the future (%d)\n",
+				__func__, ret);
 			return -EINVAL;
 		}
 	}
@@ -621,8 +621,9 @@ static int abb5zes3_rtc_check_setup(struct device *dev)
 		ABB5ZES3_REG_TIM_CLK_COF1 | ABB5ZES3_REG_TIM_CLK_COF2 |
 		ABB5ZES3_REG_TIM_CLK_TBM | ABB5ZES3_REG_TIM_CLK_TAM);
 	ret = regmap_update_bits(regmap, ABB5ZES3_REG_TIM_CLK, mask,
-		ABB5ZES3_REG_TIM_CLK_COF0 | ABB5ZES3_REG_TIM_CLK_COF1 |
-		ABB5ZES3_REG_TIM_CLK_COF2);
+				 ABB5ZES3_REG_TIM_CLK_COF0 |
+				 ABB5ZES3_REG_TIM_CLK_COF1 |
+				 ABB5ZES3_REG_TIM_CLK_COF2);
 	if (ret < 0) {
 		dev_err(dev, "%s: unable to initialize clkout register (%d)\n",
 			__func__, ret);
@@ -675,9 +676,9 @@ static int abb5zes3_rtc_check_setup(struct device *dev)
 	 * switchover flag but not battery low flag. The latter is checked
 	 * later below.
 	 */
-	mask = (ABB5ZES3_REG_CTRL3_PM0 | ABB5ZES3_REG_CTRL3_PM1 |
-		ABB5ZES3_REG_CTRL3_PM2 | ABB5ZES3_REG_CTRL3_BLIE |
-		ABB5ZES3_REG_CTRL3_BSIE| ABB5ZES3_REG_CTRL3_BSF);
+	mask = (ABB5ZES3_REG_CTRL3_PM0  | ABB5ZES3_REG_CTRL3_PM1 |
+		ABB5ZES3_REG_CTRL3_PM2  | ABB5ZES3_REG_CTRL3_BLIE |
+		ABB5ZES3_REG_CTRL3_BSIE | ABB5ZES3_REG_CTRL3_BSF);
 	ret = regmap_update_bits(regmap, ABB5ZES3_REG_CTRL3, mask, 0);
 	if (ret < 0) {
 		dev_err(dev, "%s: unable to initialize CTRL3 register (%d)\n",
@@ -694,10 +695,8 @@ static int abb5zes3_rtc_check_setup(struct device *dev)
 	}
 
 	if (reg & ABB5ZES3_REG_RTC_SC_OSC) {
-		dev_err(dev, "clock integrity not guaranteed. Osc. has stopped "
-			"or has been interrupted.\n");
-		dev_err(dev, "change battery (if not already done) and  "
-			"then set time to reset osc. failure flag.\n");
+		dev_err(dev, "clock integrity not guaranteed. Osc. has stopped or has been interrupted.\n");
+		dev_err(dev, "change battery (if not already done) and then set time to reset osc. failure flag.\n");
 	}
 
 	/*
@@ -715,13 +714,12 @@ static int abb5zes3_rtc_check_setup(struct device *dev)
 
 	data->battery_low = reg & ABB5ZES3_REG_CTRL3_BLF;
 	if (data->battery_low) {
-		dev_err(dev, "RTC battery is low; please, consider "
-			"changing it!\n");
+		dev_err(dev, "RTC battery is low; please, consider changing it!\n");
 
 		ret = _abb5zes3_rtc_battery_low_irq_enable(regmap, false);
 		if (ret)
-			dev_err(dev, "%s: disabling battery low interrupt "
-				"generation failed (%d)\n", __func__, ret);
+			dev_err(dev, "%s: disabling battery low interrupt generation failed (%d)\n",
+				__func__, ret);
 	}
 
 	return ret;
@@ -866,7 +864,7 @@ static int abb5zes3_probe(struct i2c_client *client,
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						_abb5zes3_rtc_interrupt,
-						IRQF_SHARED|IRQF_ONESHOT,
+						IRQF_SHARED | IRQF_ONESHOT,
 						DRV_NAME, client);
 		if (!ret) {
 			device_init_wakeup(dev, true);
@@ -888,8 +886,8 @@ static int abb5zes3_probe(struct i2c_client *client,
 	if (!data->battery_low && data->irq) {
 		ret = _abb5zes3_rtc_battery_low_irq_enable(regmap, true);
 		if (ret) {
-			dev_err(dev, "%s: enabling battery low interrupt "
-				"generation failed (%d)\n", __func__, ret);
+			dev_err(dev, "%s: enabling battery low interrupt generation failed (%d)\n",
+				__func__, ret);
 			goto err;
 		}
 	}
-- 
2.20.1

