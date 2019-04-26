Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900042089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271856;
	bh=bafbRjcIViyQ1asnJtUap4qmPZGCxeuelFvZ9TQ9xcI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GF9fPg1GxWtuuFzqCFH3LdiH5KilfY78gMINuNwb8PxQb3IkuTmpHjmaGIwhhAwta
	 yIa/sbPZAFhGZa6l+tDKkAbz28fv9EqSQzwvrPx8+C8jdMSwGBLtAEixUo1kbjQiIx
	 91IQ1AZAwXLaCWcJkZ5/GB8+HTIs+mjX9X2/j0K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfDZJoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:44:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45486 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDZJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ybCv+AMB/M4tLd+C+RITBIzDGzDJLvUMLnICpqlzlzM=; b=vAvUf2my+gag
        moL3xZJnXpHKKz8wwSWjAmhhGb2kYbl+Wq2FlIcamSpdfO1CToNYYCDCLg1WT9XxsgWFhBXcESf4E
        2T+hjkFV6E6L820VUmGr4bn1tRJ/BAm4100AtGQBrScRhuCnn2K5YAxM1btHnjY/tBowBIi6HMH+P
        Px6dw=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxL9-0003IR-8o; Fri, 26 Apr 2019 09:40:19 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0C805441D3B; Fri, 26 Apr 2019 10:40:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Applied "regulator: ltc3589: Get rid of struct ltc3589_regulator" to the regulator tree
In-Reply-To: <20190418114500.1098-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190426094018.0C805441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ltc3589: Get rid of struct ltc3589_regulator

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

From 63c7c2962ae715f3e1ed042db9046b36af637611 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 18 Apr 2019 19:44:59 +0800
Subject: [PATCH] regulator: ltc3589: Get rid of struct ltc3589_regulator

After converting to use simplified DT parsing, the struct ltc3589_regulator
only has a desc member. So let's remove struct ltc3589_regulator and use
struct regulator_desc instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3589.c | 69 +++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 35741f476024..077e73715514 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -84,15 +84,11 @@ enum ltc3589_reg {
 	LTC3589_NUM_REGULATORS,
 };
 
-struct ltc3589_regulator {
-	struct regulator_desc desc;
-};
-
 struct ltc3589 {
 	struct regmap *regmap;
 	struct device *dev;
 	enum ltc3589_variant variant;
-	struct ltc3589_regulator regulator_descs[LTC3589_NUM_REGULATORS];
+	struct regulator_desc regulator_descs[LTC3589_NUM_REGULATORS];
 	struct regulator_dev *regulators[LTC3589_NUM_REGULATORS];
 };
 
@@ -209,7 +205,7 @@ static int ltc3589_of_parse_cb(struct device_node *np,
 			       struct regulator_config *config)
 {
 	struct ltc3589 *ltc3589 = config->driver_data;
-	struct ltc3589_regulator *rdesc = &ltc3589->regulator_descs[desc->id];
+	struct regulator_desc *rdesc = &ltc3589->regulator_descs[desc->id];
 	u32 r[2];
 	int ret;
 
@@ -227,36 +223,34 @@ static int ltc3589_of_parse_cb(struct device_node *np,
 	if (!r[0] || !r[1])
 		return 0;
 
-	rdesc->desc.min_uV = ltc3589_scale(desc->min_uV, r[0], r[1]);
-	rdesc->desc.uV_step = ltc3589_scale(desc->uV_step, r[0], r[1]);
-	rdesc->desc.fixed_uV = ltc3589_scale(desc->fixed_uV, r[0], r[1]);
+	rdesc->min_uV = ltc3589_scale(desc->min_uV, r[0], r[1]);
+	rdesc->uV_step = ltc3589_scale(desc->uV_step, r[0], r[1]);
+	rdesc->fixed_uV = ltc3589_scale(desc->fixed_uV, r[0], r[1]);
 
 	return 0;
 }
 
 #define LTC3589_REG(_name, _of_name, _ops, en_bit, dtv1_reg, dtv_mask, go_bit)\
 	[LTC3589_ ## _name] = {						\
-		.desc = {						\
-			.name = #_name,					\
-			.of_match = of_match_ptr(#_of_name),		\
-			.regulators_node = of_match_ptr("regulators"),	\
-			.of_parse_cb = ltc3589_of_parse_cb,		\
-			.n_voltages = (dtv_mask) + 1,			\
-			.min_uV = (go_bit) ? 362500 : 0,		\
-			.uV_step = (go_bit) ? 12500 : 0,		\
-			.ramp_delay = (go_bit) ? 1750 : 0,		\
-			.fixed_uV = (dtv_mask) ? 0 : 800000,		\
-			.ops = &ltc3589_ ## _ops ## _regulator_ops,	\
-			.type = REGULATOR_VOLTAGE,			\
-			.id = LTC3589_ ## _name,			\
-			.owner = THIS_MODULE,				\
-			.vsel_reg = (dtv1_reg),			\
-			.vsel_mask = (dtv_mask),			\
-			.apply_reg = (go_bit) ? LTC3589_VCCR : 0,	\
-			.apply_bit = (go_bit),				\
-			.enable_reg = (en_bit) ? LTC3589_OVEN : 0,	\
-			.enable_mask = (en_bit),			\
-		},							\
+		.name = #_name,						\
+		.of_match = of_match_ptr(#_of_name),			\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.of_parse_cb = ltc3589_of_parse_cb,			\
+		.n_voltages = (dtv_mask) + 1,				\
+		.min_uV = (go_bit) ? 362500 : 0,			\
+		.uV_step = (go_bit) ? 12500 : 0,			\
+		.ramp_delay = (go_bit) ? 1750 : 0,			\
+		.fixed_uV = (dtv_mask) ? 0 : 800000,			\
+		.ops = &ltc3589_ ## _ops ## _regulator_ops,		\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = LTC3589_ ## _name,				\
+		.owner = THIS_MODULE,					\
+		.vsel_reg = (dtv1_reg),					\
+		.vsel_mask = (dtv_mask),				\
+		.apply_reg = (go_bit) ? LTC3589_VCCR : 0,		\
+		.apply_bit = (go_bit),					\
+		.enable_reg = (en_bit) ? LTC3589_OVEN : 0,		\
+		.enable_mask = (en_bit),				\
 	}
 
 #define LTC3589_LINEAR_REG(_name, _of_name, _dtv1)			\
@@ -267,7 +261,7 @@ static int ltc3589_of_parse_cb(struct device_node *np,
 #define LTC3589_FIXED_REG(_name, _of_name)				\
 	LTC3589_REG(_name, _of_name, fixed, LTC3589_OVEN_ ## _name, 0, 0, 0)
 
-static struct ltc3589_regulator ltc3589_regulators[LTC3589_NUM_REGULATORS] = {
+static const struct regulator_desc ltc3589_regulators[] = {
 	LTC3589_LINEAR_REG(SW1, sw1, B1DTV1),
 	LTC3589_LINEAR_REG(SW2, sw2, B2DTV1),
 	LTC3589_LINEAR_REG(SW3, sw3, B3DTV1),
@@ -403,7 +397,7 @@ static int ltc3589_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	struct ltc3589_regulator *descs;
+	struct regulator_desc *descs;
 	struct ltc3589 *ltc3589;
 	int i, ret;
 
@@ -422,11 +416,11 @@ static int ltc3589_probe(struct i2c_client *client,
 	descs = ltc3589->regulator_descs;
 	memcpy(descs, ltc3589_regulators, sizeof(ltc3589_regulators));
 	if (ltc3589->variant == LTC3589) {
-		descs[LTC3589_LDO3].desc.fixed_uV = 1800000;
-		descs[LTC3589_LDO4].desc.volt_table = ltc3589_ldo4;
+		descs[LTC3589_LDO3].fixed_uV = 1800000;
+		descs[LTC3589_LDO4].volt_table = ltc3589_ldo4;
 	} else {
-		descs[LTC3589_LDO3].desc.fixed_uV = 2800000;
-		descs[LTC3589_LDO4].desc.volt_table = ltc3589_12_ldo4;
+		descs[LTC3589_LDO3].fixed_uV = 2800000;
+		descs[LTC3589_LDO4].volt_table = ltc3589_12_ldo4;
 	}
 
 	ltc3589->regmap = devm_regmap_init_i2c(client, &ltc3589_regmap_config);
@@ -437,8 +431,7 @@ static int ltc3589_probe(struct i2c_client *client,
 	}
 
 	for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
-		struct ltc3589_regulator *rdesc = &ltc3589->regulator_descs[i];
-		struct regulator_desc *desc = &rdesc->desc;
+		struct regulator_desc *desc = &ltc3589->regulator_descs[i];
 		struct regulator_config config = { };
 
 		config.dev = dev;
-- 
2.20.1

