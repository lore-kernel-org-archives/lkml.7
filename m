Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48470C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11575218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562257980;
	bh=1VSPrCG5g+SemXBbZN2ZTL/fb0YLG30gRoIbYrAEUN0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sO5gFqzfkUZff/wZBSWlEUee6o1NCRxrwxLMkLmRzdtO141hF+1ukd3KifBuWgMKm
	 AS3eN6oXrOyKsYz9NCFogkuRKQHomkNcoUObWfTnuetNttiFtHUb6ffJfenrUPFbz4
	 C+EyGCDKVXQJYO0FzoMq08/g4E5MMOOrWYLsNv/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfGDQc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:32:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56582 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfGDQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1AIFQaA/yGya6PgQ4uo+dPDqJJntVtbtF2QXpwMlyKI=; b=LmPDO7LwQOJE
        INd866FxaGz7Lpe+YKfQBO/smqq+XHtYHkcos3TIKdo81n9gjrT0Y9SXsu/fVPLixJggtfRmCVq/J
        5d0qZU7RVrgTtAizsQezpJ9UXJcrnOHSWML3e8UEEUXYn267gq+oZzUNZbMOdlKbqjrd4qnNF3YP/
        SPcv0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hj4fH-0001Hb-S2; Thu, 04 Jul 2019 16:32:55 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EDDB027430B0; Thu,  4 Jul 2019 17:32:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max77650: use vsel_step" to the regulator tree
In-Reply-To: <20190703161035.31808-3-brgl@bgdev.pl>
X-Patchwork-Hint: ignore
Message-Id: <20190704163254.EDDB027430B0@ypsilon.sirena.org.uk>
Date:   Thu,  4 Jul 2019 17:32:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: use vsel_step

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 3c7577d442a76c2015dd765497395fb394b78051 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 3 Jul 2019 18:10:35 +0200
Subject: [PATCH] regulator: max77650: use vsel_step

Use the new vsel_step field in the regulator description to instruct
the regulator API on the required voltage ramping. Switch to using the
generic regmap helpers for voltage setting and remove the old set_voltage
callback that handcoded the selector stepping.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Link: https://lore.kernel.org/r/20190703161035.31808-3-brgl@bgdev.pl
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 73 ++++----------------------
 1 file changed, 9 insertions(+), 64 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index b79fe93c8edb..e57fc9197d62 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -108,67 +108,6 @@ static int max77650_regulator_disable(struct regulator_dev *rdev)
 				  MAX77650_REGULATOR_DISABLED);
 }
 
-static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
-					      unsigned int sel)
-{
-	struct max77650_regulator_desc *rdesc = rdev_get_drvdata(rdev);
-	int rv = 0, curr, diff;
-	bool ascending;
-
-	/*
-	 * If the regulator is disabled, we can program the desired
-	 * voltage right away.
-	 */
-	if (!max77650_regulator_is_enabled(rdev)) {
-		if (rdesc == &max77651_SBB1_desc)
-			return regulator_set_voltage_sel_pickable_regmap(rdev,
-									 sel);
-		else
-			return regulator_set_voltage_sel_regmap(rdev, sel);
-	}
-
-	/*
-	 * Otherwise we need to manually ramp the output voltage up/down
-	 * one step at a time.
-	 */
-
-	if (rdesc == &max77651_SBB1_desc)
-		curr = regulator_get_voltage_sel_pickable_regmap(rdev);
-	else
-		curr = regulator_get_voltage_sel_regmap(rdev);
-
-	if (curr < 0)
-		return curr;
-
-	diff = curr - sel;
-	if (diff == 0)
-		return 0; /* Already there. */
-	else if (diff > 0)
-		ascending = false;
-	else
-		ascending = true;
-
-	/*
-	 * Make sure we'll get to the right voltage and break the loop even if
-	 * the selector equals 0.
-	 */
-	for (ascending ? curr++ : curr--;; ascending ? curr++ : curr--) {
-		if (rdesc == &max77651_SBB1_desc)
-			rv = regulator_set_voltage_sel_pickable_regmap(rdev,
-								       curr);
-		else
-			rv = regulator_set_voltage_sel_regmap(rdev, curr);
-
-		if (rv)
-			return rv;
-
-		if (curr == sel)
-			break;
-	}
-
-	return 0;
-}
-
 static const struct regulator_ops max77650_regulator_LDO_ops = {
 	.is_enabled		= max77650_regulator_is_enabled,
 	.enable			= max77650_regulator_enable,
@@ -176,7 +115,7 @@ static const struct regulator_ops max77650_regulator_LDO_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
@@ -187,7 +126,7 @@ static const struct regulator_ops max77650_regulator_SBB_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
@@ -200,7 +139,7 @@ static const struct regulator_ops max77651_SBB1_regulator_ops = {
 	.disable		= max77650_regulator_disable,
 	.list_voltage		= regulator_list_voltage_pickable_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_pickable_regmap,
-	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
+	.set_voltage_sel	= regulator_set_voltage_sel_pickable_regmap,
 	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
@@ -217,6 +156,7 @@ static struct max77650_regulator_desc max77650_LDO_desc = {
 		.min_uV			= 1350000,
 		.uV_step		= 12500,
 		.n_voltages		= 128,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_LDO_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_LDO_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
@@ -242,6 +182,7 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 		.min_uV			= 800000,
 		.uV_step		= 25000,
 		.n_voltages		= 64,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB0_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
@@ -271,6 +212,7 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 		.min_uV			= 800000,
 		.uV_step		= 12500,
 		.n_voltages		= 64,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB1_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
@@ -301,6 +243,7 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.linear_ranges		= max77651_sbb1_volt_ranges,
 		.n_linear_ranges	= ARRAY_SIZE(max77651_sbb1_volt_ranges),
 		.n_voltages		= 58,
+		.vsel_step		= 1,
 		.vsel_range_mask	= MAX77651_REGULATOR_V_SBB1_RANGE_MASK,
 		.vsel_range_reg		= MAX77650_REG_CNFG_SBB1_A,
 		.vsel_mask		= MAX77651_REGULATOR_V_SBB1_MASK,
@@ -332,6 +275,7 @@ static struct max77650_regulator_desc max77650_SBB2_desc = {
 		.min_uV			= 800000,
 		.uV_step		= 50000,
 		.n_voltages		= 64,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB2_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
@@ -361,6 +305,7 @@ static struct max77650_regulator_desc max77651_SBB2_desc = {
 		.min_uV			= 2400000,
 		.uV_step		= 50000,
 		.n_voltages		= 64,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB2_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
-- 
2.20.1

