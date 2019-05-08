Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E811C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605D42053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557306543;
	bh=45EUAz7LSnYPBwJi9jq2QB1vDTzbdeCiSsc2Vb9Dasw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2D/7FVW1SfAiKgv+yQLmWhn39/buahEFgLQxF4g4BypkXN1DkbBPKmiuXmWj4nSBr
	 IduL+Iku1aOOXsT2eBfl4A/XxX0oWar7d1qqoTBZeHFBuprbCE+T62+1jINg1+5ijE
	 4XeGqWgvw04i2rSBL9iF1xXT3ho+SsNnXOEALXlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfEHJJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:09:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfEHJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ew5lks+8277Mog8P1Gt7DcSGyf7hxco+Ye7kTeDt0lE=; b=NhOJ7qNacgh0
        vreN7Xi6ypj1OUxLe+hzmIvaaaE1mzbyzjExNVm5njVaLifflhBua+KX0OsJbEDb61gnl1iuQynDH
        gzt/093+Lw83qm4i0Cwv96Fu/rpKmNJDh6g+Th1FeoFy4M7c2uA4ykpnN2Js3iBelonOQrE4x54lj
        UPKkU=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIZK-0007gD-7w; Wed, 08 May 2019 09:08:55 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id F16F6440010; Wed,  8 May 2019 10:08:45 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max77650: Convert MAX77651 SBB1 to pickable linear range" to the regulator tree
In-Reply-To: <20190325135557.3423-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190508090845.F16F6440010@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:08:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: Convert MAX77651 SBB1 to pickable linear range

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

From 3df4235ac41c2b8c3c5cd9c7798bc4a3105c0bc4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 25 Mar 2019 21:55:57 +0800
Subject: [PATCH] regulator: max77650: Convert MAX77651 SBB1 to pickable linear
 range

The pickable linear range is suitable for The MAX77651 SBB1.
According to MAX77651 TV_SBB1 Code Table:
Use BIT[1:0] as range selectors.
Use BIT[5:2] as selectors for each linear range.

The MAX77651 SBB1 supports up to selector 57, selector 58 ~ 63 are RSVD,
thus set n_voltage to 58.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 134 +++++++++----------------
 1 file changed, 45 insertions(+), 89 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 5c4f86c98510..ecf8cf7aad20 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -20,6 +20,8 @@
 
 #define MAX77650_REGULATOR_V_LDO_MASK		GENMASK(6, 0)
 #define MAX77650_REGULATOR_V_SBB_MASK		GENMASK(5, 0)
+#define MAX77651_REGULATOR_V_SBB1_MASK		GENMASK(5, 2)
+#define MAX77651_REGULATOR_V_SBB1_RANGE_MASK	GENMASK(1, 0)
 
 #define MAX77650_REGULATOR_AD_MASK		BIT(3)
 #define MAX77650_REGULATOR_AD_DISABLED		0x00
@@ -27,6 +29,8 @@
 
 #define MAX77650_REGULATOR_CURR_LIM_MASK	GENMASK(7, 6)
 
+static struct max77650_regulator_desc max77651_SBB1_desc;
+
 enum {
 	MAX77650_REGULATOR_ID_LDO = 0,
 	MAX77650_REGULATOR_ID_SBB0,
@@ -41,43 +45,20 @@ struct max77650_regulator_desc {
 	unsigned int regB;
 };
 
-static const unsigned int max77651_sbb1_regulator_volt_table[] = {
-	2400000, 3200000, 4000000, 4800000,
-	2450000, 3250000, 4050000, 4850000,
-	2500000, 3300000, 4100000, 4900000,
-	2550000, 3350000, 4150000, 4950000,
-	2600000, 3400000, 4200000, 5000000,
-	2650000, 3450000, 4250000, 5050000,
-	2700000, 3500000, 4300000, 5100000,
-	2750000, 3550000, 4350000, 5150000,
-	2800000, 3600000, 4400000, 5200000,
-	2850000, 3650000, 4450000, 5250000,
-	2900000, 3700000, 4500000,       0,
-	2950000, 3750000, 4550000,       0,
-	3000000, 3800000, 4600000,       0,
-	3050000, 3850000, 4650000,       0,
-	3100000, 3900000, 4700000,       0,
-	3150000, 3950000, 4750000,       0,
+static const unsigned int max77651_sbb1_volt_range_sel[] = {
+	0x0, 0x1, 0x2, 0x3
 };
 
-#define MAX77651_REGULATOR_SBB1_SEL_DEC(_val) \
-		(((_val & 0x3c) >> 2) | ((_val & 0x03) << 4))
-#define MAX77651_REGULATOR_SBB1_SEL_ENC(_val) \
-		(((_val & 0x30) >> 4) | ((_val & 0x0f) << 2))
-
-#define MAX77650_REGULATOR_SBB1_SEL_DECR(_val)				\
-	do {								\
-		_val = MAX77651_REGULATOR_SBB1_SEL_DEC(_val);		\
-		_val--;							\
-		_val = MAX77651_REGULATOR_SBB1_SEL_ENC(_val);		\
-	} while (0)
-
-#define MAX77650_REGULATOR_SBB1_SEL_INCR(_val)				\
-	do {								\
-		_val = MAX77651_REGULATOR_SBB1_SEL_DEC(_val);		\
-		_val++;							\
-		_val = MAX77651_REGULATOR_SBB1_SEL_ENC(_val);		\
-	} while (0)
+static const struct regulator_linear_range max77651_sbb1_volt_ranges[] = {
+	/* range index 0 */
+	REGULATOR_LINEAR_RANGE(2400000, 0x00, 0x0f, 50000),
+	/* range index 1 */
+	REGULATOR_LINEAR_RANGE(3200000, 0x00, 0x0f, 50000),
+	/* range index 2 */
+	REGULATOR_LINEAR_RANGE(4000000, 0x00, 0x0f, 50000),
+	/* range index 3 */
+	REGULATOR_LINEAR_RANGE(4800000, 0x00, 0x09, 50000),
+};
 
 static const unsigned int max77650_current_limit_table[] = {
 	1000000, 866000, 707000, 500000,
@@ -130,6 +111,7 @@ static int max77650_regulator_disable(struct regulator_dev *rdev)
 static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					      unsigned int sel)
 {
+	struct max77650_regulator_desc *rdesc = rdev_get_drvdata(rdev);
 	int rv = 0, curr, diff;
 	bool ascending;
 
@@ -137,15 +119,24 @@ static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	 * If the regulator is disabled, we can program the desired
 	 * voltage right away.
 	 */
-	if (!max77650_regulator_is_enabled(rdev))
-		return regulator_set_voltage_sel_regmap(rdev, sel);
+	if (!max77650_regulator_is_enabled(rdev)) {
+		if (rdesc == &max77651_SBB1_desc)
+			return regulator_set_voltage_sel_pickable_regmap(rdev,
+									 sel);
+		else
+			return regulator_set_voltage_sel_regmap(rdev, sel);
+	}
 
 	/*
 	 * Otherwise we need to manually ramp the output voltage up/down
 	 * one step at a time.
 	 */
 
-	curr = regulator_get_voltage_sel_regmap(rdev);
+	if (rdesc == &max77651_SBB1_desc)
+		curr = regulator_get_voltage_sel_pickable_regmap(rdev);
+	else
+		curr = regulator_get_voltage_sel_regmap(rdev);
+
 	if (curr < 0)
 		return curr;
 
@@ -162,57 +153,18 @@ static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	 * the selector equals 0.
 	 */
 	for (ascending ? curr++ : curr--;; ascending ? curr++ : curr--) {
-		rv = regulator_set_voltage_sel_regmap(rdev, curr);
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
-/*
- * Special case: non-linear voltage table for max77651 SBB1 - software
- * must ensure the voltage is ramped in 50mV increments.
- */
-static int max77651_regulator_sbb1_set_voltage_sel(struct regulator_dev *rdev,
-						   unsigned int sel)
-{
-	int rv = 0, curr, vcurr, vdest, vdiff;
-
-	/*
-	 * If the regulator is disabled, we can program the desired
-	 * voltage right away.
-	 */
-	if (!max77650_regulator_is_enabled(rdev))
-		return regulator_set_voltage_sel_regmap(rdev, sel);
-
-	curr = regulator_get_voltage_sel_regmap(rdev);
-	if (curr < 0)
-		return curr;
-
-	if (curr == sel)
-		return 0; /* Already there. */
-
-	vcurr = max77651_sbb1_regulator_volt_table[curr];
-	vdest = max77651_sbb1_regulator_volt_table[sel];
-	vdiff = vcurr - vdest;
-
-	for (;;) {
-		if (vdiff > 0)
-			MAX77650_REGULATOR_SBB1_SEL_DECR(curr);
+		if (rdesc == &max77651_SBB1_desc)
+			rv = regulator_set_voltage_sel_pickable_regmap(rdev,
+								       curr);
 		else
-			MAX77650_REGULATOR_SBB1_SEL_INCR(curr);
+			rv = regulator_set_voltage_sel_regmap(rdev, curr);
 
-		rv = regulator_set_voltage_sel_regmap(rdev, curr);
 		if (rv)
 			return rv;
 
 		if (curr == sel)
 			break;
-	};
+	}
 
 	return 0;
 }
@@ -241,14 +193,14 @@ static const struct regulator_ops max77650_regulator_SBB_ops = {
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
-/* Special case for max77651 SBB1 - non-linear voltage mapping. */
+/* Special case for max77651 SBB1 - pickable linear-range voltage mapping. */
 static const struct regulator_ops max77651_SBB1_regulator_ops = {
 	.is_enabled		= max77650_regulator_is_enabled,
 	.enable			= max77650_regulator_enable,
 	.disable		= max77650_regulator_disable,
-	.list_voltage		= regulator_list_voltage_table,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= max77651_regulator_sbb1_set_voltage_sel,
+	.list_voltage		= regulator_list_voltage_pickable_linear_range,
+	.get_voltage_sel	= regulator_get_voltage_sel_pickable_regmap,
+	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
 	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
@@ -345,9 +297,13 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.supply_name		= "in-sbb1",
 		.id			= MAX77650_REGULATOR_ID_SBB1,
 		.ops			= &max77651_SBB1_regulator_ops,
-		.volt_table		= max77651_sbb1_regulator_volt_table,
-		.n_voltages = ARRAY_SIZE(max77651_sbb1_regulator_volt_table),
-		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
+		.linear_range_selectors	= max77651_sbb1_volt_range_sel,
+		.linear_ranges		= max77651_sbb1_volt_ranges,
+		.n_linear_ranges	= ARRAY_SIZE(max77651_sbb1_volt_ranges),
+		.n_voltages		= 58,
+		.vsel_range_mask	= MAX77651_REGULATOR_V_SBB1_RANGE_MASK,
+		.vsel_range_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.vsel_mask		= MAX77651_REGULATOR_V_SBB1_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB1_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
 		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
-- 
2.20.1

