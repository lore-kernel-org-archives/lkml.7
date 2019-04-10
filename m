Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA038C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A66E2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554899216;
	bh=Akd9XLlO/3SbTlSw3Nknepz3l6TV5SDk2DVA5XUMGLo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rQXte1mZfORbV9sLIpXQuJfPdIlTmf3cuDofc70UgopT4K45LXsJel5jKz1YY+TO3
	 Ov0fuwU59DUEdjKKgvtFzsYyF2e0yjwP46mIJE8X84iEpx+ceRKaPIMsOMXU9dokQn
	 nIWn5svsR5llMCzelbUr6F3JUw8mFLAj60fERJ+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfDJM0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:26:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35510 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731876AbfDJM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KPAj3K1tqt50q6KsRsCBTP5KhLUZeD3NBXz1MU3TLYU=; b=c6r1oTavVrSZ
        g4suiPz4uPnKzuPl7aMi9rCe5tLycyc8wfKHkJp8y4oMqNDpaHmoW5pMRlVkkTmHY9az3fdqlcQ+9
        hLle5jbmT+rOOsWNdiu1UBT6zZwqUzymnrDqct+aYlqlumBJ6zkM8ahwT1oEsxMQyatQHWFskGOh7
        xwJ7E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hECJY-000078-3r; Wed, 10 Apr 2019 12:26:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 906711128ED2; Wed, 10 Apr 2019 13:26:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: anatop: Remove unneeded fields from struct anatop_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190410122651.906711128ED2@debutante.sirena.org.uk>
Date:   Wed, 10 Apr 2019 13:26:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: anatop: Remove unneeded fields from struct anatop_regulator

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

From f34a269229ec0d51f84f557238d1e4dcda8464d2 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 10 Apr 2019 00:10:39 +0800
Subject: [PATCH] regulator: anatop: Remove unneeded fields from struct
 anatop_regulator

These fields are only used in anatop_regulator_probe() so use local
variables instead. The *initdata is not used so can be removed.
The *anatop is renamed to *regmap for better readability.
Use u32 instead of int for the variables used as third argument of
of_property_read_u32().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/anatop-regulator.c | 63 ++++++++++++----------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index d9d8155ed8cb..754739d004e5 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -23,18 +23,10 @@
 #define LDO_FET_FULL_ON			0x1f
 
 struct anatop_regulator {
-	u32 control_reg;
-	struct regmap *anatop;
-	int vol_bit_shift;
-	int vol_bit_width;
 	u32 delay_reg;
 	int delay_bit_shift;
 	int delay_bit_width;
-	int min_bit_val;
-	int min_voltage;
-	int max_voltage;
 	struct regulator_desc rdesc;
-	struct regulator_init_data *initdata;
 	bool bypass;
 	int sel;
 };
@@ -55,7 +47,7 @@ static int anatop_regmap_set_voltage_time_sel(struct regulator_dev *reg,
 		 * to calculate how many steps LDO need to
 		 * ramp up, and how much delay needed. (us)
 		 */
-		regmap_read(anatop_reg->anatop, anatop_reg->delay_reg, &val);
+		regmap_read(reg->regmap, anatop_reg->delay_reg, &val);
 		val = (val >> anatop_reg->delay_bit_shift) &
 			((1 << anatop_reg->delay_bit_width) - 1);
 		ret = (new_sel - old_sel) * (LDO_RAMP_UP_UNIT_IN_CYCLES <<
@@ -170,6 +162,13 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	struct anatop_regulator *sreg;
 	struct regulator_init_data *initdata;
 	struct regulator_config config = { };
+	struct regmap *regmap;
+	u32 control_reg;
+	u32 vol_bit_shift;
+	u32 vol_bit_width;
+	u32 min_bit_val;
+	u32 min_voltage;
+	u32 max_voltage;
 	int ret = 0;
 	u32 val;
 
@@ -192,48 +191,41 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	initdata->supply_regulator = "vin";
-	sreg->initdata = initdata;
 
 	anatop_np = of_get_parent(np);
 	if (!anatop_np)
 		return -ENODEV;
-	sreg->anatop = syscon_node_to_regmap(anatop_np);
+	regmap = syscon_node_to_regmap(anatop_np);
 	of_node_put(anatop_np);
-	if (IS_ERR(sreg->anatop))
-		return PTR_ERR(sreg->anatop);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	ret = of_property_read_u32(np, "anatop-reg-offset",
-				   &sreg->control_reg);
+	ret = of_property_read_u32(np, "anatop-reg-offset", &control_reg);
 	if (ret) {
 		dev_err(dev, "no anatop-reg-offset property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-vol-bit-width",
-				   &sreg->vol_bit_width);
+	ret = of_property_read_u32(np, "anatop-vol-bit-width", &vol_bit_width);
 	if (ret) {
 		dev_err(dev, "no anatop-vol-bit-width property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-vol-bit-shift",
-				   &sreg->vol_bit_shift);
+	ret = of_property_read_u32(np, "anatop-vol-bit-shift", &vol_bit_shift);
 	if (ret) {
 		dev_err(dev, "no anatop-vol-bit-shift property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-min-bit-val",
-				   &sreg->min_bit_val);
+	ret = of_property_read_u32(np, "anatop-min-bit-val", &min_bit_val);
 	if (ret) {
 		dev_err(dev, "no anatop-min-bit-val property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-min-voltage",
-				   &sreg->min_voltage);
+	ret = of_property_read_u32(np, "anatop-min-voltage", &min_voltage);
 	if (ret) {
 		dev_err(dev, "no anatop-min-voltage property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-max-voltage",
-				   &sreg->max_voltage);
+	ret = of_property_read_u32(np, "anatop-max-voltage", &max_voltage);
 	if (ret) {
 		dev_err(dev, "no anatop-max-voltage property set\n");
 		return ret;
@@ -247,24 +239,23 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	of_property_read_u32(np, "anatop-delay-bit-shift",
 			     &sreg->delay_bit_shift);
 
-	rdesc->n_voltages = (sreg->max_voltage - sreg->min_voltage) / 25000 + 1
-			    + sreg->min_bit_val;
-	rdesc->min_uV = sreg->min_voltage;
+	rdesc->n_voltages = (max_voltage - min_voltage) / 25000 + 1
+			    + min_bit_val;
+	rdesc->min_uV = min_voltage;
 	rdesc->uV_step = 25000;
-	rdesc->linear_min_sel = sreg->min_bit_val;
-	rdesc->vsel_reg = sreg->control_reg;
-	rdesc->vsel_mask = ((1 << sreg->vol_bit_width) - 1) <<
-			   sreg->vol_bit_shift;
+	rdesc->linear_min_sel = min_bit_val;
+	rdesc->vsel_reg = control_reg;
+	rdesc->vsel_mask = ((1 << vol_bit_width) - 1) << vol_bit_shift;
 	rdesc->min_dropout_uV = 125000;
 
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
 	config.driver_data = sreg;
 	config.of_node = pdev->dev.of_node;
-	config.regmap = sreg->anatop;
+	config.regmap = regmap;
 
 	/* Only core regulators have the ramp up delay configuration. */
-	if (sreg->control_reg && sreg->delay_bit_width) {
+	if (control_reg && sreg->delay_bit_width) {
 		rdesc->ops = &anatop_core_rops;
 
 		ret = regmap_read(config.regmap, rdesc->vsel_reg, &val);
@@ -273,7 +264,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		sreg->sel = (val & rdesc->vsel_mask) >> sreg->vol_bit_shift;
+		sreg->sel = (val & rdesc->vsel_mask) >> vol_bit_shift;
 		if (sreg->sel == LDO_FET_FULL_ON) {
 			sreg->sel = 0;
 			sreg->bypass = true;
@@ -306,7 +297,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 			anatop_rops.disable = regulator_disable_regmap;
 			anatop_rops.is_enabled = regulator_is_enabled_regmap;
 
-			rdesc->enable_reg = sreg->control_reg;
+			rdesc->enable_reg = control_reg;
 			rdesc->enable_mask = BIT(enable_bit);
 		}
 	}
-- 
2.20.1

