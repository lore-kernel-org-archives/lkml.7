Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ABCC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F77C21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfLROjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:39:46 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:32628 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbfLROjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:39:44 -0500
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 92/69-12145-C2A3AFD5; Wed, 18 Dec 2019 14:39:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsVy8IPnUV0dq1+
  xBgt/ylrc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTXj76JGxoK1IRVz3p9mb2Bs
  9Oxi5OQQEljPKLGvOQ3CrpDYPaOfBcTmFciUmHxqFTOIzSngLnHj6kvGLkYOoBo3iX2TdEHCb
  AIWEpNPPGADsVkEVCXmXm5nBbGFBcIlnjVAlIsIqEice2MOYjILREj8OcUMMVxQ4uTMJ2CLmA
  UkJA6+eMEMcYCBxOkFjWBxCQF7ienvrzKDtEoI6Es0HouFCBtKfJ/1DarEXOL5gQ3MExgFZyG
  ZOgvJ1AWMTKsYLZKKMtMzSnITM3N0DQ0MdA0NjXQNLY10jYws9BKrdBP1Ukt1y1OLS3QN9RLL
  i/WKK3OTc1L08lJLNjECwzil4MCTHYzfPr7VO8QoycGkJMqrlPEzVogvKT+lMiOxOCO+qDQnt
  fgQowwHh5IE7zuLX7FCgkWp6akVaZk5wJiCSUtw8CiJ8O4GSfMWFyTmFmemQ6ROMepy7Dw6bx
  GzEEtefl6qlDivlSVQkQBIUUZpHtwIWHxfYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMew9
  kCk9mXgncpldARzABHcGhCXZESSJCSqqBSWPj7Oq3c5SvzdIPaE8K5/vBOqHzWXV6WvWtrcXn
  3DcncDaLHz/2dxtXi8RB92cqnwtv3q+QYT6/yMBonoF/wb/fk+Ouz6rf7TnpVfv3Fa9TT4e9P
  hA18dunS70Zt+dc3nrGWuvi/MDLpT2K7LYy7q12OzKzjRtWKiut3nLuw8MP/3+FV/9xCzkc65
  +b+mqB49nKNf2z3xbv0RBWSd+gyfk45+UdnqLV9YLl++Q9N0+bcnDZNItDm+sCE4PX/owo4Xq
  34s2ff3ZLPsZyb/r9/kN6k968pClfmqZ579kiukji9eX7Jt038m7VtT1kkkpll/tSb2VvWCN4
  MrE/aKX2sfsy6+d+3O687VLXxdb0be5KLMUZiYZazEXFiQDpSUQiagMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-7.tower-268.messagelabs.com!1576679979!958129!2
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16171 invoked from network); 18 Dec 2019 14:39:40 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-7.tower-268.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 18 Dec 2019 14:39:40 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 18 Dec 2019 14:39:39 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 B87A53FBE5; Wed, 18 Dec 2019 14:39:39 +0000 (GMT)
Message-ID: <cdf6be94f42ffa13fa73f1ae99c1eda438c2eda2.1576678683.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1576678683.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1576678683.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Wed, 18 Dec 2019 14:39:39 +0000
Subject: [PATCH 1/2] mfd: da9063: Fix revision handling to correctly select
 reg tables
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 18/12/2019 10:41:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation performs checking in the i2c_probe()
function of the variant_code but does this immediately after the
containing struct has been initialised as all zero. This means the
check for variant code will always default to using the BB tables
and will never select AD. The variant code is subsequently set
by device_init() and later used by the RTC so really it's a little
fortunate this mismatch works.

This update creates an initial temporary regmap instantiation to
simply read the chip and variant/revision information (common to
all revisions) so that it can subsequently correctly choose the
proper regmap tables for real initialisation.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/mfd/da9063-core.c            |  31 -------
 drivers/mfd/da9063-i2c.c             | 167 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/registers.h |  15 ++--
 3 files changed, 160 insertions(+), 53 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index b125f90d..a353d52 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -160,7 +160,6 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
 
 int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 {
-	int model, variant_id, variant_code;
 	int ret;
 
 	ret = da9063_clear_fault_log(da9063);
@@ -171,36 +170,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 	da9063->irq_base = -1;
 	da9063->chip_irq = irq;
 
-	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_ID, &model);
-	if (ret < 0) {
-		dev_err(da9063->dev, "Cannot read chip model id.\n");
-		return -EIO;
-	}
-	if (model != PMIC_CHIP_ID_DA9063) {
-		dev_err(da9063->dev, "Invalid chip model id: 0x%02x\n", model);
-		return -ENODEV;
-	}
-
-	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_VARIANT, &variant_id);
-	if (ret < 0) {
-		dev_err(da9063->dev, "Cannot read chip variant id.\n");
-		return -EIO;
-	}
-
-	variant_code = variant_id >> DA9063_CHIP_VARIANT_SHIFT;
-
-	dev_info(da9063->dev,
-		 "Device detected (chip-ID: 0x%02X, var-ID: 0x%02X)\n",
-		 model, variant_id);
-
-	if (variant_code < PMIC_DA9063_BB && variant_code != PMIC_DA9063_AD) {
-		dev_err(da9063->dev,
-			"Cannot support variant code: 0x%02X\n", variant_code);
-		return -ENODEV;
-	}
-
-	da9063->variant_code = variant_code;
-
 	ret = da9063_irq_init(da9063);
 	if (ret) {
 		dev_err(da9063->dev, "Cannot initialize interrupts.\n");
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 455de74..c7f3057 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -22,12 +22,107 @@
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 
+/*
+ * Temporary regmap config for just accessing chip and variant info before we
+ * know which device is present. The info read from the device using this config
+ * is then used to select the correct regmap tables.
+ */
+
+static const struct regmap_range da9063_tmp_readable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
+};
+
+static const struct regmap_range da9063_tmp_writeable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+};
+
+static const struct regmap_access_table da9063_tmp_readable_table = {
+	.yes_ranges = da9063_tmp_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063_tmp_readable_ranges),
+};
+
+static const struct regmap_access_table da9063_tmp_writeable_table = {
+	.yes_ranges = da9063_tmp_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063_tmp_writeable_ranges),
+};
+
+static const struct regmap_range_cfg da9063_tmp_range_cfg[] = {
+	{
+		.range_min = DA9063_REG_PAGE_CON,
+		.range_max = DA9063_REG_VARIANT_ID,
+		.selector_reg = DA9063_REG_PAGE_CON,
+		.selector_mask = 1 << DA9063_I2C_PAGE_SEL_SHIFT,
+		.selector_shift = DA9063_I2C_PAGE_SEL_SHIFT,
+		.window_start = 0,
+		.window_len = 256,
+	}
+};
+
+static struct regmap_config da9063_tmp_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.ranges = da9063_tmp_range_cfg,
+	.num_ranges = ARRAY_SIZE(da9063_tmp_range_cfg),
+	.max_register = DA9063_REG_VARIANT_ID,
+	.cache_type = REGCACHE_NONE,
+	.rd_table = &da9063_tmp_readable_table,
+	.wr_table = &da9063_tmp_writeable_table,
+};
+
+static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
+{
+	int ret;
+	int device_id, variant_id;
+	struct regmap *tmp_regmap;
+
+	tmp_regmap = regmap_init_i2c(i2c, &da9063_tmp_regmap_config);
+	if (IS_ERR(tmp_regmap)) {
+		dev_err(da9063->dev,
+			"Failed to allocate temporary register map\n");
+		return PTR_ERR(tmp_regmap);
+	}
+
+	ret = regmap_read(tmp_regmap, DA9063_REG_DEVICE_ID, &device_id);
+	if (ret < 0) {
+		dev_err(da9063->dev, "Cannot read chip device id.\n");
+		return -EIO;
+	}
+
+	if (device_id != PMIC_CHIP_ID_DA9063) {
+		dev_err(da9063->dev,
+			"Invalid chip device id: 0x%02x\n", device_id);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(tmp_regmap, DA9063_REG_VARIANT_ID, &variant_id);
+	if (ret < 0) {
+		dev_err(da9063->dev, "Cannot read chip variant id.\n");
+		return -EIO;
+	}
+
+	dev_info(da9063->dev,
+		 "Device detected (chip-ID: 0x%02X, var-ID: 0x%02X)\n",
+		 device_id, variant_id);
+
+	da9063->variant_code = (variant_id & DA9063_VARIANT_ID_MRC_MASK)
+			       >> DA9063_VARIANT_ID_MRC_SHIFT;
+
+	regmap_exit(tmp_regmap);
+
+	return 0;
+}
+
+/*
+ * Variant specific regmap configs
+ */
+
 static const struct regmap_range da9063_ad_readable_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_AD_REG_SECOND_D),
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_AD_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063_ad_writeable_ranges[] = {
@@ -72,7 +167,7 @@
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063_bb_writeable_ranges[] = {
@@ -117,7 +212,7 @@
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063l_bb_writeable_ranges[] = {
@@ -159,7 +254,7 @@
 static const struct regmap_range_cfg da9063_range_cfg[] = {
 	{
 		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_CHIP_VARIANT,
+		.range_max = DA9063_REG_CONFIG_ID,
 		.selector_reg = DA9063_REG_PAGE_CON,
 		.selector_mask = 1 << DA9063_I2C_PAGE_SEL_SHIFT,
 		.selector_shift = DA9063_I2C_PAGE_SEL_SHIFT,
@@ -173,7 +268,7 @@
 	.val_bits = 8,
 	.ranges = da9063_range_cfg,
 	.num_ranges = ARRAY_SIZE(da9063_range_cfg),
-	.max_register = DA9063_REG_CHIP_VARIANT,
+	.max_register = DA9063_REG_CONFIG_ID,
 
 	.cache_type = REGCACHE_RBTREE,
 };
@@ -199,18 +294,56 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	da9063->chip_irq = i2c->irq;
 	da9063->type = id->driver_data;
 
-	if (da9063->variant_code == PMIC_DA9063_AD) {
-		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
-		da9063_regmap_config.wr_table = &da9063_ad_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063_ad_volatile_table;
-	} else if (da9063->type == PMIC_TYPE_DA9063L) {
-		da9063_regmap_config.rd_table = &da9063l_bb_readable_table;
-		da9063_regmap_config.wr_table = &da9063l_bb_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063l_bb_volatile_table;
-	} else {
-		da9063_regmap_config.rd_table = &da9063_bb_readable_table;
-		da9063_regmap_config.wr_table = &da9063_bb_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063_bb_volatile_table;
+	ret = da9063_get_device_type(i2c, da9063);
+	if (ret < 0)
+		return ret;
+
+	switch (da9063->type) {
+	case PMIC_TYPE_DA9063:
+		switch (da9063->variant_code) {
+		case PMIC_DA9063_AD:
+			da9063_regmap_config.rd_table =
+				&da9063_ad_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063_ad_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063_ad_volatile_table;
+			break;
+		case PMIC_DA9063_BB:
+		case PMIC_DA9063_CA:
+			da9063_regmap_config.rd_table =
+				&da9063_bb_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063_bb_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063_bb_volatile_table;
+			break;
+		default:
+			dev_err(da9063->dev,
+				"Chip variant not supported for DA9063\n");
+			return -ENODEV;
+		}
+		break;
+	case PMIC_TYPE_DA9063L:
+		switch (da9063->variant_code) {
+		case PMIC_DA9063_BB:
+		case PMIC_DA9063_CA:
+			da9063_regmap_config.rd_table =
+				&da9063l_bb_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063l_bb_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063l_bb_volatile_table;
+			break;
+		default:
+			dev_err(da9063->dev,
+				"Chip variant not supported for DA9063L\n");
+			return -ENODEV;
+		}
+		break;
+	default:
+		dev_err(da9063->dev, "Chip type not supported\n");
+		return -ENODEV;
 	}
 
 	da9063->regmap = devm_regmap_init_i2c(i2c, &da9063_regmap_config);
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index ba706b0..1dbabf1 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -292,8 +292,10 @@
 #define	DA9063_BB_REG_GP_ID_19		0x134
 
 /* Chip ID and variant */
-#define	DA9063_REG_CHIP_ID		0x181
-#define	DA9063_REG_CHIP_VARIANT		0x182
+#define	DA9063_REG_DEVICE_ID		0x181
+#define	DA9063_REG_VARIANT_ID		0x182
+#define	DA9063_REG_CUSTOMER_ID		0x183
+#define	DA9063_REG_CONFIG_ID		0x184
 
 /*
  * PMIC registers bits
@@ -929,9 +931,6 @@
 #define	DA9063_RTC_CLOCK			0x40
 #define	DA9063_OUT_32K_EN			0x80
 
-/* DA9063_REG_CHIP_VARIANT */
-#define	DA9063_CHIP_VARIANT_SHIFT		4
-
 /* DA9063_REG_BUCK_ILIM_A (addr=0x9A) */
 #define DA9063_BIO_ILIM_MASK			0x0F
 #define DA9063_BMEM_ILIM_MASK			0xF0
@@ -1065,4 +1064,10 @@
 #define		DA9063_MON_A10_IDX_LDO9		0x04
 #define		DA9063_MON_A10_IDX_LDO10	0x05
 
+/* DA9063_REG_VARIANT_ID (addr=0x182) */
+#define	DA9063_VARIANT_ID_VRC_SHIFT		0
+#define DA9063_VARIANT_ID_VRC_MASK		0x0F
+#define	DA9063_VARIANT_ID_MRC_SHIFT		4
+#define DA9063_VARIANT_ID_MRC_MASK		0xF0
+
 #endif /* _DA9063_REG_H */
-- 
1.9.1

