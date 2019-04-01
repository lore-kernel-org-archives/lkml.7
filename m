Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A249C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5453E20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108838;
	bh=Mwt/V/BDSBSdr18ZvoR65+0SdNvd1VFwN6ZKc0ODWEc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zWhMQNwUWA6RYsqSEjWaBMhM8wnJkP25bRiOeH1wkePpp7q/PtO7ZtX/MlaU8UMXV
	 OF2/tg+vpm4XUECsTnQS7pKw+Yl+iolCOHVtApfAnmwXB9IQ/vCYDpFAlCIneQ17oH
	 /cidDWjtAQp6ryoh0OqpUSkQlpAJbBAsxwsn1hwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfDAIx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:53:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfDAIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=snnWQyq3d+8Zh/3ff2exsJ/HL2sJQqn6T5VYR2y2FSg=; b=nqY1QrlD4nZ6
        8BHQJTOTQUbD8YORwy9e665vqIYe5bOneXqbknj7UYRXrrOvQDEVYM5p48jWwlXqBW7G5mMKE76Mb
        aXRtooPcAql4uzSX5uTZU5tcVmjkQap6JHkoMWbwzD7FRdQreHdbU8PipCh+HD9ZWRPrqBKVIBaiC
        zGX4E=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAshR-0008Ok-Gi; Mon, 01 Apr 2019 08:53:49 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9D3A2440082; Mon,  1 Apr 2019 09:53:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: as3722: Slightly improve readability" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190401085346.9D3A2440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:53:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: as3722: Slightly improve readability

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

From 7dc6c766a7d712e19cc03630610e037b9680d32f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 27 Mar 2019 09:29:47 +0800
Subject: [PATCH] regulator: as3722: Slightly improve readability

Add a local variable *desc to avoid too many change lines due to over 80
characters.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/as3722-regulator.c | 137 ++++++++++++---------------
 1 file changed, 58 insertions(+), 79 deletions(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index 4dda77417300..dc75c33bd950 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -674,49 +674,45 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 	config.regmap = as3722->regmap;
 
 	for (id = 0; id < AS3722_REGULATOR_ID_MAX; id++) {
+		struct regulator_desc *desc;
+
+		desc = &as3722_regs->desc[id];
 		reg_config = &as3722_regs->reg_config_data[id];
 
-		as3722_regs->desc[id].name = as3722_reg_lookup[id].name;
-		as3722_regs->desc[id].supply_name = as3722_reg_lookup[id].sname;
-		as3722_regs->desc[id].id = as3722_reg_lookup[id].regulator_id;
-		as3722_regs->desc[id].n_voltages =
-					as3722_reg_lookup[id].n_voltages;
-		as3722_regs->desc[id].type = REGULATOR_VOLTAGE;
-		as3722_regs->desc[id].owner = THIS_MODULE;
-		as3722_regs->desc[id].enable_reg =
-					as3722_reg_lookup[id].enable_reg;
-		as3722_regs->desc[id].enable_mask =
-					as3722_reg_lookup[id].enable_mask;
-		as3722_regs->desc[id].vsel_reg = as3722_reg_lookup[id].vsel_reg;
-		as3722_regs->desc[id].vsel_mask =
-					as3722_reg_lookup[id].vsel_mask;
+		desc->name = as3722_reg_lookup[id].name;
+		desc->supply_name = as3722_reg_lookup[id].sname;
+		desc->id = as3722_reg_lookup[id].regulator_id;
+		desc->n_voltages = as3722_reg_lookup[id].n_voltages;
+		desc->type = REGULATOR_VOLTAGE;
+		desc->owner = THIS_MODULE;
+		desc->enable_reg = as3722_reg_lookup[id].enable_reg;
+		desc->enable_mask = as3722_reg_lookup[id].enable_mask;
+		desc->vsel_reg = as3722_reg_lookup[id].vsel_reg;
+		desc->vsel_mask = as3722_reg_lookup[id].vsel_mask;
 		switch (id) {
 		case AS3722_REGULATOR_ID_LDO0:
 			if (reg_config->ext_control)
 				ops = &as3722_ldo0_extcntrl_ops;
 			else
 				ops = &as3722_ldo0_ops;
-			as3722_regs->desc[id].min_uV = 825000;
-			as3722_regs->desc[id].uV_step = 25000;
-			as3722_regs->desc[id].linear_min_sel = 1;
-			as3722_regs->desc[id].enable_time = 500;
-			as3722_regs->desc[id].curr_table = as3722_ldo_current;
-			as3722_regs->desc[id].n_current_limits =
-				ARRAY_SIZE(as3722_ldo_current);
-			as3722_regs->desc[id].csel_reg =
-				as3722_reg_lookup[id].vsel_reg;
-			as3722_regs->desc[id].csel_mask =
-				AS3722_LDO_ILIMIT_MASK;
+			desc->min_uV = 825000;
+			desc->uV_step = 25000;
+			desc->linear_min_sel = 1;
+			desc->enable_time = 500;
+			desc->curr_table = as3722_ldo_current;
+			desc->n_current_limits = ARRAY_SIZE(as3722_ldo_current);
+			desc->csel_reg = as3722_reg_lookup[id].vsel_reg;
+			desc->csel_mask = AS3722_LDO_ILIMIT_MASK;
 			break;
 		case AS3722_REGULATOR_ID_LDO3:
 			if (reg_config->ext_control)
 				ops = &as3722_ldo3_extcntrl_ops;
 			else
 				ops = &as3722_ldo3_ops;
-			as3722_regs->desc[id].min_uV = 620000;
-			as3722_regs->desc[id].uV_step = 20000;
-			as3722_regs->desc[id].linear_min_sel = 1;
-			as3722_regs->desc[id].enable_time = 500;
+			desc->min_uV = 620000;
+			desc->uV_step = 20000;
+			desc->linear_min_sel = 1;
+			desc->enable_time = 500;
 			if (reg_config->enable_tracking) {
 				ret = as3722_ldo3_set_tracking_mode(as3722_regs,
 					id, AS3722_LDO3_MODE_PMOS_TRACKING);
@@ -733,25 +729,17 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 				ops = &as3722_ldo6_extcntrl_ops;
 			else
 				ops = &as3722_ldo6_ops;
-			as3722_regs->desc[id].enable_time = 500;
-			as3722_regs->desc[id].bypass_reg =
-						AS3722_LDO6_VOLTAGE_REG;
-			as3722_regs->desc[id].bypass_mask =
-						AS3722_LDO_VSEL_MASK;
-			as3722_regs->desc[id].bypass_val_on =
-						AS3722_LDO6_VSEL_BYPASS;
-			as3722_regs->desc[id].bypass_val_off =
-						AS3722_LDO6_VSEL_BYPASS;
-			as3722_regs->desc[id].linear_ranges = as3722_ldo_ranges;
-			as3722_regs->desc[id].n_linear_ranges =
-						ARRAY_SIZE(as3722_ldo_ranges);
-			as3722_regs->desc[id].curr_table = as3722_ldo_current;
-			as3722_regs->desc[id].n_current_limits =
-				ARRAY_SIZE(as3722_ldo_current);
-			as3722_regs->desc[id].csel_reg =
-				as3722_reg_lookup[id].vsel_reg;
-			as3722_regs->desc[id].csel_mask =
-				AS3722_LDO_ILIMIT_MASK;
+			desc->enable_time = 500;
+			desc->bypass_reg = AS3722_LDO6_VOLTAGE_REG;
+			desc->bypass_mask = AS3722_LDO_VSEL_MASK;
+			desc->bypass_val_on = AS3722_LDO6_VSEL_BYPASS;
+			desc->bypass_val_off = AS3722_LDO6_VSEL_BYPASS;
+			desc->linear_ranges = as3722_ldo_ranges;
+			desc->n_linear_ranges = ARRAY_SIZE(as3722_ldo_ranges);
+			desc->curr_table = as3722_ldo_current;
+			desc->n_current_limits = ARRAY_SIZE(as3722_ldo_current);
+			desc->csel_reg = as3722_reg_lookup[id].vsel_reg;
+			desc->csel_mask = AS3722_LDO_ILIMIT_MASK;
 			break;
 		case AS3722_REGULATOR_ID_SD0:
 		case AS3722_REGULATOR_ID_SD1:
@@ -770,26 +758,23 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 					AS3722_SD0_VSEL_MAX + 1;
 				as3722_regs->desc[id].min_uV = 610000;
 			}
-			as3722_regs->desc[id].uV_step = 10000;
-			as3722_regs->desc[id].linear_min_sel = 1;
-			as3722_regs->desc[id].enable_time = 600;
-			as3722_regs->desc[id].curr_table = as3722_sd016_current;
-			as3722_regs->desc[id].n_current_limits =
+			desc->uV_step = 10000;
+			desc->linear_min_sel = 1;
+			desc->enable_time = 600;
+			desc->curr_table = as3722_sd016_current;
+			desc->n_current_limits =
 				ARRAY_SIZE(as3722_sd016_current);
 			if (id == AS3722_REGULATOR_ID_SD0) {
-				as3722_regs->desc[id].csel_reg =
-					AS3722_OVCURRENT_REG;
-				as3722_regs->desc[id].csel_mask =
+				desc->csel_reg = AS3722_OVCURRENT_REG;
+				desc->csel_mask =
 					AS3722_OVCURRENT_SD0_TRIP_MASK;
 			} else if (id == AS3722_REGULATOR_ID_SD1) {
-				as3722_regs->desc[id].csel_reg =
-					AS3722_OVCURRENT_REG;
-				as3722_regs->desc[id].csel_mask =
+				desc->csel_reg = AS3722_OVCURRENT_REG;
+				desc->csel_mask =
 					AS3722_OVCURRENT_SD1_TRIP_MASK;
 			} else if (id == AS3722_REGULATOR_ID_SD6) {
-				as3722_regs->desc[id].csel_reg =
-					AS3722_OVCURRENT_DEB_REG;
-				as3722_regs->desc[id].csel_mask =
+				desc->csel_reg = AS3722_OVCURRENT_DEB_REG;
+				desc->csel_mask =
 					AS3722_OVCURRENT_SD6_TRIP_MASK;
 			}
 			break;
@@ -801,9 +786,8 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 				ops = &as3722_sd2345_extcntrl_ops;
 			else
 				ops = &as3722_sd2345_ops;
-			as3722_regs->desc[id].linear_ranges =
-						as3722_sd2345_ranges;
-			as3722_regs->desc[id].n_linear_ranges =
+			desc->linear_ranges = as3722_sd2345_ranges;
+			desc->n_linear_ranges =
 					ARRAY_SIZE(as3722_sd2345_ranges);
 			break;
 		default:
@@ -811,24 +795,19 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 				ops = &as3722_ldo_extcntrl_ops;
 			else
 				ops = &as3722_ldo_ops;
-			as3722_regs->desc[id].enable_time = 500;
-			as3722_regs->desc[id].linear_ranges = as3722_ldo_ranges;
-			as3722_regs->desc[id].n_linear_ranges =
-						ARRAY_SIZE(as3722_ldo_ranges);
-			as3722_regs->desc[id].curr_table = as3722_ldo_current;
-			as3722_regs->desc[id].n_current_limits =
-						ARRAY_SIZE(as3722_ldo_current);
-			as3722_regs->desc[id].csel_reg =
-						as3722_reg_lookup[id].vsel_reg;
-			as3722_regs->desc[id].csel_mask =
-						AS3722_LDO_ILIMIT_MASK;
+			desc->enable_time = 500;
+			desc->linear_ranges = as3722_ldo_ranges;
+			desc->n_linear_ranges = ARRAY_SIZE(as3722_ldo_ranges);
+			desc->curr_table = as3722_ldo_current;
+			desc->n_current_limits = ARRAY_SIZE(as3722_ldo_current);
+			desc->csel_reg = as3722_reg_lookup[id].vsel_reg;
+			desc->csel_mask = AS3722_LDO_ILIMIT_MASK;
 			break;
 		}
-		as3722_regs->desc[id].ops = ops;
+		desc->ops = ops;
 		config.init_data = reg_config->reg_init;
 		config.of_node = as3722_regulator_matches[id].of_node;
-		rdev = devm_regulator_register(&pdev->dev,
-					&as3722_regs->desc[id], &config);
+		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
 			ret = PTR_ERR(rdev);
 			dev_err(&pdev->dev, "regulator %d register failed %d\n",
-- 
2.20.1

