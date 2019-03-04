Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCF520830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658001;
	bh=YUAOfd6ASuzQ49+y1rCKjvB1Mc5AUOv7lW+3p0fIZ60=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=TBLWOKLttZzoJBbTdmqQjegGekxNKNnfy658fmzWvwck/UK4wGue8g0V2YKCAd/ky
	 H12pV2PQ1StAGyb+a4DWd6gI9B9YeHWen3eWfvg3j95IEyTYVQlqkJNdqIwbSj63o/
	 7Ir/BAgkdkl9JoVcwXQGPm8hIW7PbKNdE9hQXq9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCDAGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54010 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCDAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+JFXxlcjZPKbW50FjGrPIfSLIgOa0NE0RCgHU72flEA=; b=jAK90FvnCCfH
        2kwkcLUvlprblwq8kWp9z9OcTlvessDOVc/q1yC6I7LHnqr6uDcXB+O4soyUMvv+7RozkNiUDuL9J
        3y4Xvag0xQTc49vd69Zch9zzcUPof4XktyYMVv/7zRFVBZi+iYoCoqE2Vt03w6C2zSWP9a3SqCJDn
        lJkQg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7p-0007Pe-T2; Mon, 04 Mar 2019 00:06:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 36457440082; Mon,  4 Mar 2019 00:06:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm831x-dcdc: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000633.36457440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm831x-dcdc: Convert to use regulator_set/get_current_limit_regmap

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 20eb641e471a6a9ff64b10edb199e72cb847b9ef Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:22 +0800
Subject: [PATCH] regulator: wm831x-dcdc: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm831x-dcdc.c | 42 +++++----------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 828f262d6be0..12b422373580 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -308,48 +308,14 @@ static const unsigned int wm831x_dcdc_ilim[] = {
 	125000, 250000, 375000, 500000, 625000, 750000, 875000, 1000000
 };
 
-static int wm831x_buckv_set_current_limit(struct regulator_dev *rdev,
-					   int min_uA, int max_uA)
-{
-	struct wm831x_dcdc *dcdc = rdev_get_drvdata(rdev);
-	struct wm831x *wm831x = dcdc->wm831x;
-	u16 reg = dcdc->base + WM831X_DCDC_CONTROL_2;
-	int i;
-
-	for (i = ARRAY_SIZE(wm831x_dcdc_ilim) - 1; i >= 0; i--) {
-		if ((min_uA <= wm831x_dcdc_ilim[i]) &&
-		    (wm831x_dcdc_ilim[i] <= max_uA))
-			return wm831x_set_bits(wm831x, reg,
-					       WM831X_DC1_HC_THR_MASK,
-						i << WM831X_DC1_HC_THR_SHIFT);
-	}
-
-	return -EINVAL;
-}
-
-static int wm831x_buckv_get_current_limit(struct regulator_dev *rdev)
-{
-	struct wm831x_dcdc *dcdc = rdev_get_drvdata(rdev);
-	struct wm831x *wm831x = dcdc->wm831x;
-	u16 reg = dcdc->base + WM831X_DCDC_CONTROL_2;
-	int val;
-
-	val = wm831x_reg_read(wm831x, reg);
-	if (val < 0)
-		return val;
-
-	val = (val & WM831X_DC1_HC_THR_MASK) >> WM831X_DC1_HC_THR_SHIFT;
-	return wm831x_dcdc_ilim[val];
-}
-
 static const struct regulator_ops wm831x_buckv_ops = {
 	.set_voltage_sel = wm831x_buckv_set_voltage_sel,
 	.get_voltage_sel = wm831x_buckv_get_voltage_sel,
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.set_suspend_voltage = wm831x_buckv_set_suspend_voltage,
-	.set_current_limit = wm831x_buckv_set_current_limit,
-	.get_current_limit = wm831x_buckv_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
@@ -475,6 +441,10 @@ static int wm831x_buckv_probe(struct platform_device *pdev)
 	dcdc->desc.owner = THIS_MODULE;
 	dcdc->desc.enable_reg = WM831X_DCDC_ENABLE;
 	dcdc->desc.enable_mask = 1 << id;
+	dcdc->desc.csel_reg = dcdc->base + WM831X_DCDC_CONTROL_2;
+	dcdc->desc.csel_mask = WM831X_DC1_HC_THR_MASK;
+	dcdc->desc.n_current_limits = ARRAY_SIZE(wm831x_dcdc_ilim);
+	dcdc->desc.curr_table = wm831x_dcdc_ilim;
 
 	ret = wm831x_reg_read(wm831x, dcdc->base + WM831X_DCDC_ON_CONFIG);
 	if (ret < 0) {
-- 
2.20.1

