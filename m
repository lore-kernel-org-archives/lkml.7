Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A70B20842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658009;
	bh=moM0kK8jr7MdQYF4Phxqn91pPgro6TUNDomVfXMHkAk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jB8b1dz6VMd7y2++Gd/qa4ZNZToowDcHFE4KHTVq2J9MB4SmPsRm1qA6PayPXaEiG
	 0CF/iTaDYC0y5cS7WMP783hBIF/IUN6syqYvHhn+os1cCYbvHs5GXliMCx0fcHZf68
	 xS5fTU/+6p2kpYYT/HTxDsAjsTHzmexMaJ+Pzm90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCDAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCDAGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=G215TTsadyrEMPSxE65sCoDqvL7YTTHZRvpOZRwo954=; b=wDf2uB7FO0a4
        MNR+X/bSMuX2Pp8WIzM7HUJuVtOlrRvJ33IZeuN8dIhA8IYXJoeyuJOYzFjG4lj8dD0JYj0qLIyLu
        tjtw8EI/978P9z4BLSxIIwGY8Wt6Q/BY91dj0DVadO0zRsF2zO4oWGkMug4x/hqs/+yy2sie1foFw
        jC8Sc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7y-0007Q8-K9; Mon, 04 Mar 2019 00:06:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 08056440082; Mon,  4 Mar 2019 00:06:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77650: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000642.08056440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: Convert to use regulator_set/get_current_limit_regmap

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

From 6c98ac2a347f4849885bd9f966bda50fc25f8d55 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:18 +0800
Subject: [PATCH] regulator: max77650: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 74 +++++++++-----------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index a1af414db751..31ebf34b01ec 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -26,9 +26,6 @@
 #define MAX77650_REGULATOR_AD_ENABLED		BIT(3)
 
 #define MAX77650_REGULATOR_CURR_LIM_MASK	GENMASK(7, 6)
-#define MAX77650_REGULATOR_CURR_LIM_BITS(_reg) \
-		(((_reg) & MAX77650_REGULATOR_CURR_LIM_MASK) >> 6)
-#define MAX77650_REGULATOR_CURR_LIM_SHIFT(_val)	((_val) << 6)
 
 enum {
 	MAX77650_REGULATOR_ID_LDO = 0,
@@ -82,7 +79,7 @@ static const u32 max77651_sbb1_regulator_volt_table[] = {
 		_val = MAX77651_REGULATOR_SBB1_SEL_ENC(_val);		\
 	} while (0)
 
-static const int max77650_current_limit_table[] = {
+static const unsigned int max77650_current_limit_table[] = {
 	1000000, 866000, 707000, 500000,
 };
 
@@ -220,47 +217,6 @@ static int max77651_regulator_sbb1_set_voltage_sel(struct regulator_dev *rdev,
 	return 0;
 }
 
-static int max77650_regulator_get_current_limit(struct regulator_dev *rdev)
-{
-	struct max77650_regulator_desc *rdesc;
-	struct regmap *map;
-	int val, rv, limit;
-
-	rdesc = rdev_get_drvdata(rdev);
-	map = rdev_get_regmap(rdev);
-
-	rv = regmap_read(map, rdesc->regA, &val);
-	if (rv)
-		return rv;
-
-	limit = MAX77650_REGULATOR_CURR_LIM_BITS(val);
-
-	return max77650_current_limit_table[limit];
-}
-
-static int max77650_regulator_set_current_limit(struct regulator_dev *rdev,
-						int min_uA, int max_uA)
-{
-	struct max77650_regulator_desc *rdesc;
-	struct regmap *map;
-	int i, limit;
-
-	rdesc = rdev_get_drvdata(rdev);
-	map = rdev_get_regmap(rdev);
-
-	for (i = 0; i < ARRAY_SIZE(max77650_current_limit_table); i++) {
-		limit = max77650_current_limit_table[i];
-
-		if (limit >= min_uA && limit <= max_uA) {
-			return regmap_update_bits(map, rdesc->regA,
-					MAX77650_REGULATOR_CURR_LIM_MASK,
-					MAX77650_REGULATOR_CURR_LIM_SHIFT(i));
-		}
-	}
-
-	return -EINVAL;
-}
-
 static const struct regulator_ops max77650_regulator_LDO_ops = {
 	.is_enabled		= max77650_regulator_is_enabled,
 	.enable			= max77650_regulator_enable,
@@ -280,8 +236,8 @@ static const struct regulator_ops max77650_regulator_SBB_ops = {
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
-	.get_current_limit	= max77650_regulator_get_current_limit,
-	.set_current_limit	= max77650_regulator_set_current_limit,
+	.get_current_limit	= regulator_get_current_limit_regmap,
+	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
@@ -293,8 +249,8 @@ static const struct regulator_ops max77651_SBB1_regulator_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= max77651_regulator_sbb1_set_voltage_sel,
-	.get_current_limit	= max77650_regulator_get_current_limit,
-	.set_current_limit	= max77650_regulator_set_current_limit,
+	.get_current_limit	= regulator_get_current_limit_regmap,
+	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
@@ -343,6 +299,10 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB0_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB0_A,
 	.regB		= MAX77650_REG_CNFG_SBB0_B,
@@ -368,6 +328,10 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
@@ -392,6 +356,10 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
@@ -417,6 +385,10 @@ static struct max77650_regulator_desc max77650_SBB2_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB2_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
@@ -442,6 +414,10 @@ static struct max77650_regulator_desc max77651_SBB2_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB2_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
-- 
2.20.1

