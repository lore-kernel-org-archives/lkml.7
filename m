Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1B9218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180858;
	bh=zGHNprjptgjefhlZEh5OsNii1CIm4jyqlW+Azkf2oPg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nkEjKDgBmNimEiy15DeU5n574k5JKtej1SJj4ruTmol8QSoIszuWei9S3PV2idR9J
	 wrHAoYld3/gp1p3FzTFwASN7m7wjx/C2lpXSvtBYj+xY4SlH9ON83w+4AnLTeycy1g
	 0wwjWYmDbCywz+4VJZmbxgiM/WWV+RNIjmyKxCX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfCUPHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:07:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48250 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfCUPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TUoBfOSN0oTKgcor7KGPYJX7ubBnM3OHJ742jMdkl78=; b=KUfzFobPKMO0
        XYtXGZNRQNrpic9ISYIMhnCutEZlyz5mz1sM9cMdSupHHUDdaRIJuUy9nAzZUKrB8colRmrt7+LkO
        XoQdlgpoOxXl2YEFnccqJFx4tWukKYFS9VjRdGks7kZkA5B3HsKcZHH2NJWmNxKNjruHs5S1fozL3
        ze7+Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zI2-0005dh-CK; Thu, 21 Mar 2019 15:07:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7EFAE11288F0; Thu, 21 Mar 2019 15:07:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps65132: Remove unneeded fields from struct tps65132_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190321150729.7EFAE11288F0@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:07:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65132: Remove unneeded fields from struct tps65132_regulator

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

From 2e62e03333bb41277c920844e72bf26a29724b14 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 21 Mar 2019 20:00:37 +0800
Subject: [PATCH] regulator: tps65132: Remove unneeded fields from struct
 tps65132_regulator

These fields are not really need, remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65132-regulator.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 73978dd440f7..1f627e161b99 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -55,10 +55,7 @@ struct tps65132_reg_pdata {
 
 struct tps65132_regulator {
 	struct device *dev;
-	struct regmap *rmap;
-	struct regulator_desc *rdesc[TPS65132_MAX_REGULATORS];
 	struct tps65132_reg_pdata reg_pdata[TPS65132_MAX_REGULATORS];
-	struct regulator_dev *rdev[TPS65132_MAX_REGULATORS];
 };
 
 static int tps65132_regulator_enable(struct regulator_dev *rdev)
@@ -225,6 +222,8 @@ static int tps65132_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct tps65132_regulator *tps;
+	struct regulator_dev *rdev;
+	struct regmap *rmap;
 	struct regulator_config config = { };
 	int id;
 	int ret;
@@ -233,9 +232,9 @@ static int tps65132_probe(struct i2c_client *client,
 	if (!tps)
 		return -ENOMEM;
 
-	tps->rmap = devm_regmap_init_i2c(client, &tps65132_regmap_config);
-	if (IS_ERR(tps->rmap)) {
-		ret = PTR_ERR(tps->rmap);
+	rmap = devm_regmap_init_i2c(client, &tps65132_regmap_config);
+	if (IS_ERR(rmap)) {
+		ret = PTR_ERR(rmap);
 		dev_err(dev, "regmap init failed: %d\n", ret);
 		return ret;
 	}
@@ -244,18 +243,16 @@ static int tps65132_probe(struct i2c_client *client,
 	tps->dev = dev;
 
 	for (id = 0; id < TPS65132_MAX_REGULATORS; ++id) {
-		tps->rdesc[id] = &tps_regs_desc[id];
-
-		config.regmap = tps->rmap;
+		config.regmap = rmap;
 		config.dev = dev;
 		config.driver_data = tps;
 
-		tps->rdev[id] = devm_regulator_register(dev,
-					tps->rdesc[id], &config);
-		if (IS_ERR(tps->rdev[id])) {
-			ret = PTR_ERR(tps->rdev[id]);
+		rdev = devm_regulator_register(dev, &tps_regs_desc[id],
+					       &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
 			dev_err(dev, "regulator %s register failed: %d\n",
-				tps->rdesc[id]->name, ret);
+				tps_regs_desc[id].name, ret);
 			return ret;
 		}
 	}
-- 
2.20.1

