Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE32C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFD720830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658005;
	bh=9UK6rTED1Ce9BIRanBB84P3oUGLu7Gizf0RiipAcQF8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2DDs64wyXryOxU3RPjEyY1lGU1xaMmTQnVCFVEVv12fAjpgofepffVB8muqdiNY7g
	 re+W1igmC5Cn4U3OcKhaWbiKTRq80187zcfTwqo7ptKKShQgqa+dRb5XvPu+6tDm6X
	 acJTX3UCY/PsbVZ1tm0ONZ0WM1jK2hW8YcmKQ7r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCDAGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54110 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCDAGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=o96x4IrF/4Vh4FSGQbgxPPxJ1eJ/IvV9B+QOXh0NgP0=; b=Qx8UrfPAHb4p
        VaNKy+K5BerYxLfnOjBjxGosNBfldyVIPzFRyZzVgpshMjeB6kjANY475+sVxEOPjjOmGUwqL+S9c
        0SYhVESD1OZcRc8GynKVLVRDOzCiTryAs9P7FGXJAj/K+LvywT21oEaUkPsPcxDuiYmMpxHQGweNK
        S4rXU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7u-0007Pr-4e; Mon, 04 Mar 2019 00:06:38 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 80997440082; Mon,  4 Mar 2019 00:06:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pv88080: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000637.80997440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pv88080: Convert to use regulator_set/get_current_limit_regmap

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

From 989a99bc64e8f905b8b5908149f20f9d79510957 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:20 +0800
Subject: [PATCH] regulator: pv88080: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pv88080-regulator.c | 55 ++++-----------------------
 1 file changed, 8 insertions(+), 47 deletions(-)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 6770e4de2097..bdddacdbeb99 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -45,12 +45,7 @@ enum pv88080_types {
 
 struct pv88080_regulator {
 	struct regulator_desc desc;
-	/* Current limiting */
-	unsigned int n_current_limits;
-	const int *current_limits;
-	unsigned int limit_mask;
 	unsigned int mode_reg;
-	unsigned int limit_reg;
 	unsigned int conf2;
 	unsigned int conf5;
 };
@@ -102,11 +97,11 @@ static const struct regmap_config pv88080_regmap_config = {
  * Entry indexes corresponds to register values.
  */
 
-static const int pv88080_buck1_limits[] = {
+static const unsigned int pv88080_buck1_limits[] = {
 	3230000, 5130000, 6960000, 8790000
 };
 
-static const int pv88080_buck23_limits[] = {
+static const unsigned int pv88080_buck23_limits[] = {
 	1496000, 2393000, 3291000, 4189000
 };
 
@@ -272,40 +267,6 @@ static int pv88080_buck_set_mode(struct regulator_dev *rdev,
 					PV88080_BUCK1_MODE_MASK, val);
 }
 
-static int pv88080_set_current_limit(struct regulator_dev *rdev, int min,
-				    int max)
-{
-	struct pv88080_regulator *info = rdev_get_drvdata(rdev);
-	int i;
-
-	/* search for closest to maximum */
-	for (i = info->n_current_limits - 1; i >= 0; i--) {
-		if (min <= info->current_limits[i]
-			&& max >= info->current_limits[i]) {
-				return regmap_update_bits(rdev->regmap,
-					info->limit_reg,
-					info->limit_mask,
-					i << PV88080_BUCK1_ILIM_SHIFT);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int pv88080_get_current_limit(struct regulator_dev *rdev)
-{
-	struct pv88080_regulator *info = rdev_get_drvdata(rdev);
-	unsigned int data;
-	int ret;
-
-	ret = regmap_read(rdev->regmap, info->limit_reg, &data);
-	if (ret < 0)
-		return ret;
-
-	data = (data & info->limit_mask) >> PV88080_BUCK1_ILIM_SHIFT;
-	return info->current_limits[data];
-}
-
 static const struct regulator_ops pv88080_buck_ops = {
 	.get_mode = pv88080_buck_get_mode,
 	.set_mode = pv88080_buck_set_mode,
@@ -315,8 +276,8 @@ static const struct regulator_ops pv88080_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
-	.set_current_limit = pv88080_set_current_limit,
-	.get_current_limit = pv88080_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static const struct regulator_ops pv88080_hvbuck_ops = {
@@ -341,9 +302,9 @@ static const struct regulator_ops pv88080_hvbuck_ops = {
 		.min_uV = min, \
 		.uV_step = step, \
 		.n_voltages = ((max) - (min))/(step) + 1, \
+		.curr_table = limits_array, \
+		.n_current_limits = ARRAY_SIZE(limits_array), \
 	},\
-	.current_limits = limits_array, \
-	.n_current_limits = ARRAY_SIZE(limits_array), \
 }
 
 #define PV88080_HVBUCK(chip, regl_name, min, step, max) \
@@ -521,9 +482,9 @@ static int pv88080_i2c_probe(struct i2c_client *i2c,
 		if (init_data)
 			config.init_data = &init_data[i];
 
-		pv88080_regulator_info[i].limit_reg
+		pv88080_regulator_info[i].desc.csel_reg
 			= regmap_config->buck_regmap[i].buck_limit_reg;
-		pv88080_regulator_info[i].limit_mask
+		pv88080_regulator_info[i].desc.csel_mask
 			= regmap_config->buck_regmap[i].buck_limit_mask;
 		pv88080_regulator_info[i].mode_reg
 			= regmap_config->buck_regmap[i].buck_mode_reg;
-- 
2.20.1

