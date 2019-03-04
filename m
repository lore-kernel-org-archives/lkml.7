Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81928C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BB220842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658021;
	bh=5IaQBfnlKSwHv6S4KTVlAyHAJkuOIp64q45mPOjc/q4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BYLhhhavymT/YBjKcm+zTtPatOuAiXwzoSBxeFL2w29nsV8su8bilECFW5hET3xfa
	 yIP7fZTz3SKcNpJTLTCovVD5IU3DqlRspcebPuJNuiIROL97o3tnTX3v1A1l5JuWF9
	 gpmKwP+F5HR+GozrZk+EDtrJyy0bZnws69LiSd2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfCDAHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:07:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54586 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfCDAG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=45T8UtWIR+4Bfy0ODQaq7nbEVCMjPc0tUznSfDa+hz0=; b=eGHNZS4BMn/B
        8tBmmQswF50+egqmT5tH9+TQmReIk9/lTjIa0ORVycGSj5ElFh+j6KF6KkgOugrWNHQ+Nh1fuZrIp
        8XNIlw1E7KcJ7wKiSaKkB3KHXgusPodsLrY145ARjo9UzgYtTM5YSSldvIsXDUJUYoYUBglHe1Bn5
        UTkZk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b85-0007QQ-EC; Mon, 04 Mar 2019 00:06:49 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BDBE1440082; Mon,  4 Mar 2019 00:06:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9210: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000648.BDBE1440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9210: Convert to use regulator_set/get_current_limit_regmap

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

From 8b3216c40136a3d6594edeec56e6ef1910709432 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:15 +0800
Subject: [PATCH] regulator: da9210: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9210-regulator.c | 53 ++++------------------------
 1 file changed, 7 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 84dba64ed11e..528303771723 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -41,10 +41,6 @@ static const struct regmap_config da9210_regmap_config = {
 	.val_bits = 8,
 };
 
-static int da9210_set_current_limit(struct regulator_dev *rdev, int min_uA,
-				    int max_uA);
-static int da9210_get_current_limit(struct regulator_dev *rdev);
-
 static const struct regulator_ops da9210_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -52,8 +48,8 @@ static const struct regulator_ops da9210_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
-	.set_current_limit = da9210_set_current_limit,
-	.get_current_limit = da9210_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 /* Default limits measured in millivolts and milliamps */
@@ -62,7 +58,7 @@ static const struct regulator_ops da9210_buck_ops = {
 #define DA9210_STEP_MV		10
 
 /* Current limits for buck (uA) indices corresponds with register values */
-static const int da9210_buck_limits[] = {
+static const unsigned int da9210_buck_limits[] = {
 	1600000, 1800000, 2000000, 2200000, 2400000, 2600000, 2800000, 3000000,
 	3200000, 3400000, 3600000, 3800000, 4000000, 4200000, 4400000, 4600000
 };
@@ -80,47 +76,12 @@ static const struct regulator_desc da9210_reg = {
 	.enable_reg = DA9210_REG_BUCK_CONT,
 	.enable_mask = DA9210_BUCK_EN,
 	.owner = THIS_MODULE,
+	.curr_table = da9210_buck_limits,
+	.n_current_limits = ARRAY_SIZE(da9210_buck_limits),
+	.csel_reg = DA9210_REG_BUCK_ILIM,
+	.csel_mask = DA9210_BUCK_ILIM_MASK,
 };
 
-static int da9210_set_current_limit(struct regulator_dev *rdev, int min_uA,
-				    int max_uA)
-{
-	struct da9210 *chip = rdev_get_drvdata(rdev);
-	unsigned int sel;
-	int i;
-
-	/* search for closest to maximum */
-	for (i = ARRAY_SIZE(da9210_buck_limits)-1; i >= 0; i--) {
-		if (min_uA <= da9210_buck_limits[i] &&
-		    max_uA >= da9210_buck_limits[i]) {
-			sel = i;
-			sel = sel << DA9210_BUCK_ILIM_SHIFT;
-			return regmap_update_bits(chip->regmap,
-						  DA9210_REG_BUCK_ILIM,
-						  DA9210_BUCK_ILIM_MASK, sel);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int da9210_get_current_limit(struct regulator_dev *rdev)
-{
-	struct da9210 *chip = rdev_get_drvdata(rdev);
-	unsigned int data;
-	unsigned int sel;
-	int ret;
-
-	ret = regmap_read(chip->regmap, DA9210_REG_BUCK_ILIM, &data);
-	if (ret < 0)
-		return ret;
-
-	/* select one of 16 values: 0000 (1600mA) to 1111 (4600mA) */
-	sel = (data & DA9210_BUCK_ILIM_MASK) >> DA9210_BUCK_ILIM_SHIFT;
-
-	return da9210_buck_limits[sel];
-}
-
 static irqreturn_t da9210_irq_handler(int irq, void *data)
 {
 	struct da9210 *chip = data;
-- 
2.20.1

