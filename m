Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272CAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E228A2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271992;
	bh=Duq5rY5zdK2IbC+D/olVWFtIaLEOopUUk9GZlavj/co=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2FS8w7mgr8YGpD9QUtl3vBt7dtZ62qIqsv0pp9s59EsPS83DXaAeK5gwyQJ/Uh0V4
	 JAdL6d/JzjNI8PPBRNZbKaqu3ZBxWCTSCrSWyf/IIRQnW7wEtELxoYqOT8C8RZPnbj
	 e5/6uHBesmRKgQhzhF7OI5dEFuJUqlnlGNZiIVdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfDZJp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:45:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfDZJpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bCO3F4jGoWbbF2kzN76H5v5L+ImBbS6Epz66gQMEttY=; b=xeZAsm9aO0EB
        o6nBKA/29o/Iv5Q+s8v7ZBP6sVA469eImA34kruBV9lx1926TC9PoSwdyiaj0o+mRzdnEV0BfIvWm
        p8MT3EbrXo5OaisZYsqBz9ZVpv5y/r5LJD850GT4Zd1T4bByITbOnYZvzSLm5wAshjVhGXLeBHmBw
        REWgk=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxQV-0003SM-Kx; Fri, 26 Apr 2019 09:45:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 97F4F441D3B; Fri, 26 Apr 2019 10:45:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: mcp16502: Remove unneeded fields from struct mcp16502" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094550.97F4F441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:45:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mcp16502: Remove unneeded fields from struct mcp16502

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

From 4cf469539b635d2588df4f48bf721890f5f2ade5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Apr 2019 09:59:22 +0800
Subject: [PATCH] regulator: mcp16502: Remove unneeded fields from struct
 mcp16502

At the context with rdev, we can use rdev->regmap instead of mcp->rmap.
The *rdev[NUM_REGULATORS] is not required because current code uses
devm_regulator_register() so we don't need to store *rdev for clean up
paths.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mcp16502.c | 40 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 3a8004abe044..9292ab8736c7 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -119,8 +119,6 @@ enum {
  * @lpm: LPM GPIO descriptor
  */
 struct mcp16502 {
-	struct regulator_dev *rdev[NUM_REGULATORS];
-	struct regmap *rmap;
 	struct gpio_desc *lpm;
 };
 
@@ -179,13 +177,12 @@ static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
 {
 	unsigned int val;
 	int ret, reg;
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 
 	reg = mcp16502_get_reg(rdev, MCP16502_OPMODE_ACTIVE);
 	if (reg < 0)
 		return reg;
 
-	ret = regmap_read(mcp->rmap, reg, &val);
+	ret = regmap_read(rdev->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -211,7 +208,6 @@ static int _mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode,
 {
 	int val;
 	int reg;
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 
 	reg = mcp16502_get_reg(rdev, op_mode);
 	if (reg < 0)
@@ -228,7 +224,7 @@ static int _mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode,
 		return -EINVAL;
 	}
 
-	reg = regmap_update_bits(mcp->rmap, reg, MCP16502_MODE, val);
+	reg = regmap_update_bits(rdev->regmap, reg, MCP16502_MODE, val);
 	return reg;
 }
 
@@ -247,9 +243,8 @@ static int mcp16502_get_status(struct regulator_dev *rdev)
 {
 	int ret;
 	unsigned int val;
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 
-	ret = regmap_read(mcp->rmap, MCP16502_STAT_BASE(rdev_get_id(rdev)),
+	ret = regmap_read(rdev->regmap, MCP16502_STAT_BASE(rdev_get_id(rdev)),
 			  &val);
 	if (ret)
 		return ret;
@@ -290,7 +285,6 @@ static int mcp16502_suspend_get_target_reg(struct regulator_dev *rdev)
  */
 static int mcp16502_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 {
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 	int sel = regulator_map_voltage_linear_range(rdev, uV, uV);
 	int reg = mcp16502_suspend_get_target_reg(rdev);
 
@@ -300,7 +294,7 @@ static int mcp16502_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	if (reg < 0)
 		return reg;
 
-	return regmap_update_bits(mcp->rmap, reg, MCP16502_VSEL, sel);
+	return regmap_update_bits(rdev->regmap, reg, MCP16502_VSEL, sel);
 }
 
 /*
@@ -328,13 +322,12 @@ static int mcp16502_set_suspend_mode(struct regulator_dev *rdev,
  */
 static int mcp16502_set_suspend_enable(struct regulator_dev *rdev)
 {
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 	int reg = mcp16502_suspend_get_target_reg(rdev);
 
 	if (reg < 0)
 		return reg;
 
-	return regmap_update_bits(mcp->rmap, reg, MCP16502_EN, MCP16502_EN);
+	return regmap_update_bits(rdev->regmap, reg, MCP16502_EN, MCP16502_EN);
 }
 
 /*
@@ -342,13 +335,12 @@ static int mcp16502_set_suspend_enable(struct regulator_dev *rdev)
  */
 static int mcp16502_set_suspend_disable(struct regulator_dev *rdev)
 {
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 	int reg = mcp16502_suspend_get_target_reg(rdev);
 
 	if (reg < 0)
 		return reg;
 
-	return regmap_update_bits(mcp->rmap, reg, MCP16502_EN, 0);
+	return regmap_update_bits(rdev->regmap, reg, MCP16502_EN, 0);
 }
 #endif /* CONFIG_SUSPEND */
 
@@ -441,17 +433,16 @@ static const struct regmap_config mcp16502_regmap_config = {
 static int setup_regulators(struct mcp16502 *mcp, struct device *dev,
 			    struct regulator_config config)
 {
+	struct regulator_dev *rdev;
 	int i;
 
 	for (i = 0; i < NUM_REGULATORS; i++) {
-		mcp->rdev[i] = devm_regulator_register(dev,
-						       &mcp16502_desc[i],
-						       &config);
-		if (IS_ERR(mcp->rdev[i])) {
+		rdev = devm_regulator_register(dev, &mcp16502_desc[i], &config);
+		if (IS_ERR(rdev)) {
 			dev_err(dev,
 				"failed to register %s regulator %ld\n",
-				mcp16502_desc[i].name, PTR_ERR(mcp->rdev[i]));
-			return PTR_ERR(mcp->rdev[i]);
+				mcp16502_desc[i].name, PTR_ERR(rdev));
+			return PTR_ERR(rdev);
 		}
 	}
 
@@ -464,6 +455,7 @@ static int mcp16502_probe(struct i2c_client *client,
 	struct regulator_config config = { };
 	struct device *dev;
 	struct mcp16502 *mcp;
+	struct regmap *rmap;
 	int ret = 0;
 
 	dev = &client->dev;
@@ -473,15 +465,15 @@ static int mcp16502_probe(struct i2c_client *client,
 	if (!mcp)
 		return -ENOMEM;
 
-	mcp->rmap = devm_regmap_init_i2c(client, &mcp16502_regmap_config);
-	if (IS_ERR(mcp->rmap)) {
-		ret = PTR_ERR(mcp->rmap);
+	rmap = devm_regmap_init_i2c(client, &mcp16502_regmap_config);
+	if (IS_ERR(rmap)) {
+		ret = PTR_ERR(rmap);
 		dev_err(dev, "regmap init failed: %d\n", ret);
 		return ret;
 	}
 
 	i2c_set_clientdata(client, mcp);
-	config.regmap = mcp->rmap;
+	config.regmap = rmap;
 	config.driver_data = mcp;
 
 	mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
-- 
2.20.1

