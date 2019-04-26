Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678BCC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2382D2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271841;
	bh=Uc/4OTVXzbZxEitS7K9frJ0WgKQlF0AMrPLg2A9EVWs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ufeLboKbJF+pwV1/DsrZ4+02/Lr7z4e3JNKTZXrAea/Ru5yynTlL1x3x3WLFrNbcW
	 wtTKEHQDYc2TN70+noA1fjpq57UpZrO4kzSXpHJvrzBJeLKUlBFlxmg4fYD/RoW+Jb
	 ZnLMwLZhhiSb9sibq7EtzT3Eq95xfcayybot+YVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDZJkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:40:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfDZJkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Bjttw/kysjZ0hTg3mOjp0dGdGPAyxOMwgkY7EXYG3Ls=; b=KkhNYP2Mqcz6
        pgabG8IWMBr7X0UieHcSuwhFi450hCYazvNcSLgHjjSpdZWcbbCpdIBz6ebL/LZr/y/P8ykKbZFTf
        i0akn3TcReqAuJB0x1wPt1l34MqimmzruteOfPAFDXzeHqXs7uirz3IQcFLush5kLFLgfNAD/XRW7
        1m28E=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxL9-0003IV-Hj; Fri, 26 Apr 2019 09:40:19 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7BCDB441D3C; Fri, 26 Apr 2019 10:40:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Applied "regulator: ltc3589: Convert to use simplified DT parsing" to the regulator tree
In-Reply-To: <20190418114500.1098-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190426094018.7BCDB441D3C@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:18 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ltc3589: Convert to use simplified DT parsing

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

From ce62ba3afd10cee12fb8f2f81853ae1e91e21387 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 18 Apr 2019 19:44:58 +0800
Subject: [PATCH] regulator: ltc3589: Convert to use simplified DT parsing

Use regulator core's simplified DT parsing code to simplify the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3589.c | 194 +++++++++++-------------------------
 1 file changed, 58 insertions(+), 136 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 75089b037b72..35741f476024 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -86,10 +86,6 @@ enum ltc3589_reg {
 
 struct ltc3589_regulator {
 	struct regulator_desc desc;
-
-	/* External feedback voltage divider */
-	unsigned int r1;
-	unsigned int r2;
 };
 
 struct ltc3589 {
@@ -196,11 +192,55 @@ static const struct regulator_ops ltc3589_table_regulator_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
+static inline unsigned int ltc3589_scale(unsigned int uV, u32 r1, u32 r2)
+{
+	uint64_t tmp;
+
+	if (uV == 0)
+		return 0;
+
+	tmp = (uint64_t)uV * r1;
+	do_div(tmp, r2);
+	return uV + (unsigned int)tmp;
+}
+
+static int ltc3589_of_parse_cb(struct device_node *np,
+			       const struct regulator_desc *desc,
+			       struct regulator_config *config)
+{
+	struct ltc3589 *ltc3589 = config->driver_data;
+	struct ltc3589_regulator *rdesc = &ltc3589->regulator_descs[desc->id];
+	u32 r[2];
+	int ret;
+
+	/* Parse feedback voltage dividers. LDO3 and LDO4 don't have them */
+	if (desc->id >= LTC3589_LDO3)
+		return 0;
+
+	ret = of_property_read_u32_array(np, "lltc,fb-voltage-divider", r, 2);
+	if (ret) {
+		dev_err(ltc3589->dev, "Failed to parse voltage divider: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (!r[0] || !r[1])
+		return 0;
+
+	rdesc->desc.min_uV = ltc3589_scale(desc->min_uV, r[0], r[1]);
+	rdesc->desc.uV_step = ltc3589_scale(desc->uV_step, r[0], r[1]);
+	rdesc->desc.fixed_uV = ltc3589_scale(desc->fixed_uV, r[0], r[1]);
+
+	return 0;
+}
 
-#define LTC3589_REG(_name, _ops, en_bit, dtv1_reg, dtv_mask, go_bit)	\
+#define LTC3589_REG(_name, _of_name, _ops, en_bit, dtv1_reg, dtv_mask, go_bit)\
 	[LTC3589_ ## _name] = {						\
 		.desc = {						\
 			.name = #_name,					\
+			.of_match = of_match_ptr(#_of_name),		\
+			.regulators_node = of_match_ptr("regulators"),	\
+			.of_parse_cb = ltc3589_of_parse_cb,		\
 			.n_voltages = (dtv_mask) + 1,			\
 			.min_uV = (go_bit) ? 362500 : 0,		\
 			.uV_step = (go_bit) ? 12500 : 0,		\
@@ -219,109 +259,26 @@ static const struct regulator_ops ltc3589_table_regulator_ops = {
 		},							\
 	}
 
-#define LTC3589_LINEAR_REG(_name, _dtv1)				\
-	LTC3589_REG(_name, linear, LTC3589_OVEN_ ## _name,		\
+#define LTC3589_LINEAR_REG(_name, _of_name, _dtv1)			\
+	LTC3589_REG(_name, _of_name, linear, LTC3589_OVEN_ ## _name,	\
 		    LTC3589_ ## _dtv1, 0x1f,				\
 		    LTC3589_VCCR_ ## _name ## _GO)
 
-#define LTC3589_FIXED_REG(_name) \
-	LTC3589_REG(_name, fixed, LTC3589_OVEN_ ## _name, 0, 0, 0)
+#define LTC3589_FIXED_REG(_name, _of_name)				\
+	LTC3589_REG(_name, _of_name, fixed, LTC3589_OVEN_ ## _name, 0, 0, 0)
 
 static struct ltc3589_regulator ltc3589_regulators[LTC3589_NUM_REGULATORS] = {
-	LTC3589_LINEAR_REG(SW1, B1DTV1),
-	LTC3589_LINEAR_REG(SW2, B2DTV1),
-	LTC3589_LINEAR_REG(SW3, B3DTV1),
-	LTC3589_FIXED_REG(BB_OUT),
-	LTC3589_REG(LDO1, fixed_standby, 0, 0, 0, 0),
-	LTC3589_LINEAR_REG(LDO2, L2DTV1),
-	LTC3589_FIXED_REG(LDO3),
-	LTC3589_REG(LDO4, table, LTC3589_OVEN_LDO4, LTC3589_L2DTV2, 0x60, 0),
+	LTC3589_LINEAR_REG(SW1, sw1, B1DTV1),
+	LTC3589_LINEAR_REG(SW2, sw2, B2DTV1),
+	LTC3589_LINEAR_REG(SW3, sw3, B3DTV1),
+	LTC3589_FIXED_REG(BB_OUT, bb-out),
+	LTC3589_REG(LDO1, ldo1, fixed_standby, 0, 0, 0, 0),
+	LTC3589_LINEAR_REG(LDO2, ldo2, L2DTV1),
+	LTC3589_FIXED_REG(LDO3, ldo3),
+	LTC3589_REG(LDO4, ldo4, table, LTC3589_OVEN_LDO4, LTC3589_L2DTV2,
+		    0x60, 0),
 };
 
-#ifdef CONFIG_OF
-static struct of_regulator_match ltc3589_matches[LTC3589_NUM_REGULATORS] = {
-	{ .name = "sw1",    },
-	{ .name = "sw2",    },
-	{ .name = "sw3",    },
-	{ .name = "bb-out", },
-	{ .name = "ldo1",   }, /* standby */
-	{ .name = "ldo2",   },
-	{ .name = "ldo3",   },
-	{ .name = "ldo4",   },
-};
-
-static int ltc3589_parse_regulators_dt(struct ltc3589 *ltc3589)
-{
-	struct device *dev = ltc3589->dev;
-	struct device_node *node;
-	int i, ret;
-
-	node = of_get_child_by_name(dev->of_node, "regulators");
-	if (!node) {
-		dev_err(dev, "regulators node not found\n");
-		return -EINVAL;
-	}
-
-	ret = of_regulator_match(dev, node, ltc3589_matches,
-				 ARRAY_SIZE(ltc3589_matches));
-	of_node_put(node);
-	if (ret < 0) {
-		dev_err(dev, "Error parsing regulator init data: %d\n", ret);
-		return ret;
-	}
-	if (ret != LTC3589_NUM_REGULATORS) {
-		dev_err(dev, "Only %d regulators described in device tree\n",
-			ret);
-		return -EINVAL;
-	}
-
-	/* Parse feedback voltage dividers. LDO3 and LDO4 don't have them */
-	for (i = 0; i < LTC3589_LDO3; i++) {
-		struct ltc3589_regulator *desc = &ltc3589->regulator_descs[i];
-		struct device_node *np = ltc3589_matches[i].of_node;
-		u32 vdiv[2];
-
-		ret = of_property_read_u32_array(np, "lltc,fb-voltage-divider",
-						 vdiv, 2);
-		if (ret) {
-			dev_err(dev, "Failed to parse voltage divider: %d\n",
-				ret);
-			return ret;
-		}
-
-		desc->r1 = vdiv[0];
-		desc->r2 = vdiv[1];
-	}
-
-	return 0;
-}
-
-static inline struct regulator_init_data *match_init_data(int index)
-{
-	return ltc3589_matches[index].init_data;
-}
-
-static inline struct device_node *match_of_node(int index)
-{
-	return ltc3589_matches[index].of_node;
-}
-#else
-static inline int ltc3589_parse_regulators_dt(struct ltc3589 *ltc3589)
-{
-	return 0;
-}
-
-static inline struct regulator_init_data *match_init_data(int index)
-{
-	return NULL;
-}
-
-static inline struct device_node *match_of_node(int index)
-{
-	return NULL;
-}
-#endif
-
 static bool ltc3589_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -409,7 +366,6 @@ static const struct regmap_config ltc3589_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-
 static irqreturn_t ltc3589_isr(int irq, void *dev_id)
 {
 	struct ltc3589 *ltc3589 = dev_id;
@@ -443,28 +399,6 @@ static irqreturn_t ltc3589_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static inline unsigned int ltc3589_scale(unsigned int uV, u32 r1, u32 r2)
-{
-	uint64_t tmp;
-	if (uV == 0)
-		return 0;
-	tmp = (uint64_t)uV * r1;
-	do_div(tmp, r2);
-	return uV + (unsigned int)tmp;
-}
-
-static void ltc3589_apply_fb_voltage_divider(struct ltc3589_regulator *rdesc)
-{
-	struct regulator_desc *desc = &rdesc->desc;
-
-	if (!rdesc->r1 || !rdesc->r2)
-		return;
-
-	desc->min_uV = ltc3589_scale(desc->min_uV, rdesc->r1, rdesc->r2);
-	desc->uV_step = ltc3589_scale(desc->uV_step, rdesc->r1, rdesc->r2);
-	desc->fixed_uV = ltc3589_scale(desc->fixed_uV, rdesc->r1, rdesc->r2);
-}
-
 static int ltc3589_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -502,25 +436,13 @@ static int ltc3589_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = ltc3589_parse_regulators_dt(ltc3589);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
 		struct ltc3589_regulator *rdesc = &ltc3589->regulator_descs[i];
 		struct regulator_desc *desc = &rdesc->desc;
-		struct regulator_init_data *init_data;
 		struct regulator_config config = { };
 
-		init_data = match_init_data(i);
-
-		if (i < LTC3589_LDO3)
-			ltc3589_apply_fb_voltage_divider(rdesc);
-
 		config.dev = dev;
-		config.init_data = init_data;
 		config.driver_data = ltc3589;
-		config.of_node = match_of_node(i);
 
 		ltc3589->regulators[i] = devm_regulator_register(dev, desc,
 								 &config);
-- 
2.20.1

