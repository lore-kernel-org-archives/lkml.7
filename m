Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C86C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4519D2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271844;
	bh=Rcr/mti6j2+dzBuDJFX0rRYjawcVNYS+r3jVhp0r+4Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pUxURwHEZc66QzPaF5GYOT7JM/yhgB3rr11rHKDsYogBfbZpGud7X6w7ZgOxxLR5A
	 9ADgT1vjaSLW8MvTBIKP+BZsGDUyc0CR6+Azt72Tu1wQV6Q/setoNiUX9XpDY+WS8C
	 +dFgI+7KwR/NJFGHUVXfW/HL5Z2jZXB6esywdjuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDZJoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:44:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDZJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RcNJRTHqTTG/1gDWVFtW8IGjBT/xF2F5B2RbB2kx9Jg=; b=pPB38g0Tb1eN
        a28VptnumcCpmqL8tsyOaJfOvcNTWebuATsLFTxq7U0w4PkVkhuoHYLOCYaApVNMgBh6MUYKNAqd6
        UI1wnATKwLqrk9811kD+AhEM7VyZkDkzIgLuLy7a+fuvOWqLQh2W1V7bOVJ68w8erXLxqePJFDdox
        V0RvA=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxL8-0003IA-E1; Fri, 26 Apr 2019 09:40:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 15B5E441D3B; Fri, 26 Apr 2019 10:40:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Wadim Egorov <w.egorov@phytec.de>,
        Yunfan Zhang <yfzhang@marvell.com>
Subject: Applied "regulator: fan53555: Clean up unneeded fields from struct fan53555_device_info" to the regulator tree
In-Reply-To: <20190419005824.21533-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190426094017.15B5E441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fan53555: Clean up unneeded fields from struct fan53555_device_info

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

From a69929c7aa7006990975e0c5f8de16a6215265ec Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 19 Apr 2019 08:58:23 +0800
Subject: [PATCH] regulator: fan53555: Clean up unneeded fields from struct
 fan53555_device_info

The *regmap and *rdev can be replaced by local variables.
The slew_rate is no longer used since commit dd7e71fbeefe
("regulator: fan53555: use set_ramp_delay to set the ramp up slew rate").

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fan53555.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 771a06d1900d..e2caf4173ab5 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -91,10 +91,8 @@ enum {
 
 struct fan53555_device_info {
 	enum fan53555_vendor vendor;
-	struct regmap *regmap;
 	struct device *dev;
 	struct regulator_desc desc;
-	struct regulator_dev *rdev;
 	struct regulator_init_data *regulator;
 	/* IC Type and Rev */
 	int chip_id;
@@ -106,8 +104,6 @@ struct fan53555_device_info {
 	unsigned int vsel_min;
 	unsigned int vsel_step;
 	unsigned int vsel_count;
-	/* Voltage slew rate limiting */
-	unsigned int slew_rate;
 	/* Mode */
 	unsigned int mode_reg;
 	unsigned int mode_mask;
@@ -125,7 +121,7 @@ static int fan53555_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	ret = regulator_map_voltage_linear(rdev, uV, uV);
 	if (ret < 0)
 		return ret;
-	ret = regmap_update_bits(di->regmap, di->sleep_reg,
+	ret = regmap_update_bits(rdev->regmap, di->sleep_reg,
 				 di->desc.vsel_mask, ret);
 	if (ret < 0)
 		return ret;
@@ -140,7 +136,7 @@ static int fan53555_set_suspend_enable(struct regulator_dev *rdev)
 {
 	struct fan53555_device_info *di = rdev_get_drvdata(rdev);
 
-	return regmap_update_bits(di->regmap, di->sleep_reg,
+	return regmap_update_bits(rdev->regmap, di->sleep_reg,
 				  VSEL_BUCK_EN, VSEL_BUCK_EN);
 }
 
@@ -148,7 +144,7 @@ static int fan53555_set_suspend_disable(struct regulator_dev *rdev)
 {
 	struct fan53555_device_info *di = rdev_get_drvdata(rdev);
 
-	return regmap_update_bits(di->regmap, di->sleep_reg,
+	return regmap_update_bits(rdev->regmap, di->sleep_reg,
 				  VSEL_BUCK_EN, 0);
 }
 
@@ -158,11 +154,11 @@ static int fan53555_set_mode(struct regulator_dev *rdev, unsigned int mode)
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		regmap_update_bits(di->regmap, di->mode_reg,
+		regmap_update_bits(rdev->regmap, di->mode_reg,
 				   di->mode_mask, di->mode_mask);
 		break;
 	case REGULATOR_MODE_NORMAL:
-		regmap_update_bits(di->regmap, di->vol_reg, di->mode_mask, 0);
+		regmap_update_bits(rdev->regmap, di->vol_reg, di->mode_mask, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -176,7 +172,7 @@ static unsigned int fan53555_get_mode(struct regulator_dev *rdev)
 	unsigned int val;
 	int ret = 0;
 
-	ret = regmap_read(di->regmap, di->mode_reg, &val);
+	ret = regmap_read(rdev->regmap, di->mode_reg, &val);
 	if (ret < 0)
 		return ret;
 	if (val & di->mode_mask)
@@ -213,7 +209,7 @@ static int fan53555_set_ramp(struct regulator_dev *rdev, int ramp)
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(di->regmap, FAN53555_CONTROL,
+	return regmap_update_bits(rdev->regmap, FAN53555_CONTROL,
 				  CTL_SLEW_MASK, regval << CTL_SLEW_SHIFT);
 }
 
@@ -396,6 +392,7 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 			struct regulator_config *config)
 {
 	struct regulator_desc *rdesc = &di->desc;
+	struct regulator_dev *rdev;
 
 	rdesc->name = "fan53555-reg";
 	rdesc->supply_name = "vin";
@@ -410,8 +407,8 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 	rdesc->vsel_mask = di->vsel_count - 1;
 	rdesc->owner = THIS_MODULE;
 
-	di->rdev = devm_regulator_register(di->dev, &di->desc, config);
-	return PTR_ERR_OR_ZERO(di->rdev);
+	rdev = devm_regulator_register(di->dev, &di->desc, config);
+	return PTR_ERR_OR_ZERO(rdev);
 }
 
 static const struct regmap_config fan53555_regmap_config = {
@@ -466,6 +463,7 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 	struct fan53555_device_info *di;
 	struct fan53555_platform_data *pdata;
 	struct regulator_config config = { };
+	struct regmap *regmap;
 	unsigned int val;
 	int ret;
 
@@ -502,22 +500,22 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 		di->vendor = id->driver_data;
 	}
 
-	di->regmap = devm_regmap_init_i2c(client, &fan53555_regmap_config);
-	if (IS_ERR(di->regmap)) {
+	regmap = devm_regmap_init_i2c(client, &fan53555_regmap_config);
+	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to allocate regmap!\n");
-		return PTR_ERR(di->regmap);
+		return PTR_ERR(regmap);
 	}
 	di->dev = &client->dev;
 	i2c_set_clientdata(client, di);
 	/* Get chip ID */
-	ret = regmap_read(di->regmap, FAN53555_ID1, &val);
+	ret = regmap_read(regmap, FAN53555_ID1, &val);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to get chip ID!\n");
 		return ret;
 	}
 	di->chip_id = val & DIE_ID;
 	/* Get chip revision */
-	ret = regmap_read(di->regmap, FAN53555_ID2, &val);
+	ret = regmap_read(regmap, FAN53555_ID2, &val);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to get chip Rev!\n");
 		return ret;
@@ -534,7 +532,7 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 	/* Register regulator */
 	config.dev = di->dev;
 	config.init_data = di->regulator;
-	config.regmap = di->regmap;
+	config.regmap = regmap;
 	config.driver_data = di;
 	config.of_node = np;
 
-- 
2.20.1

