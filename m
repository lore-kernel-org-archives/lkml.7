Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76558C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B9C2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558470793;
	bh=aqP/8vzF4eNKx094Bhafd5MDrQNIsS6BvqbuuW0wzNY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=OVTJ4bIcusXdiA1nkUTXOBcvuvRhGakYU/unGY3all42zgcz5h7d/tzUqiClGdw+W
	 OIM3McHz5GK/xIa7KGjTPpN//IbSIcbTY6ixWiMoJVZd/Nr4K1qqiHbFEHg6A0xM9H
	 KxXa5J1ZxS+x9lCHnwAlR6HKQFwM0ZMpmk9Sl9mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfEUUdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:33:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38616 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfEUUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WYXLR7ZS6jDTWKfU4LheraNWdGPA7/wxWnPkHZQHF5k=; b=HQtwaysftys3
        IKkP1WzONpOu/70j3HEIS3i9HRBiKl7J0b/OBN+qE6M8SNvr3Cji9uxdl5nH01HjSvmZD8BK3ioid
        WJs8crY6S8+sfZDb6Pz7W4HjnLeMKDDvGCt7q5bXF+l6M52U5Istb/UUgGy1i/SwmbcmFFfBDDnWM
        BizYw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTBRX-000221-Nj; Tue, 21 May 2019 20:33:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CDEFC1126D16; Tue, 21 May 2019 21:32:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, patches@opensource.cirrus.com,
        robh+dt@kernel.org
Subject: Applied "regulator: arizona-ldo1: Add support for Cirrus Logic Madera codecs" to the regulator tree
In-Reply-To: <20190521100439.27383-2-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Message-Id: <20190521203259.CDEFC1126D16@debutante.sirena.org.uk>
Date:   Tue, 21 May 2019 21:32:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona-ldo1: Add support for Cirrus Logic Madera codecs

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

From 1f5f11e7370c6a55da1a37351b0cfb5f86f0cb6d Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Tue, 21 May 2019 11:04:38 +0100
Subject: [PATCH] regulator: arizona-ldo1: Add support for Cirrus Logic Madera
 codecs

This adds a new driver identity "madera-ldo1" and probe function
so that this driver can be used to control the LDO1 regulator on
some Cirrus Logic Madera codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig        |  8 +--
 drivers/regulator/arizona-ldo1.c | 83 +++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5e3a9e6547b0..5827aace014b 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -135,12 +135,12 @@ config REGULATOR_AB8500
 	  signal AB8500 PMIC
 
 config REGULATOR_ARIZONA_LDO1
-	tristate "Wolfson Arizona class devices LDO1"
-	depends on MFD_ARIZONA
+	tristate "Cirrus Madera and Wolfson Arizona class devices LDO1"
+	depends on MFD_ARIZONA || MFD_MADERA
 	depends on SND_SOC
 	help
-	  Support for the LDO1 regulators found on Wolfson Arizona class
-	  devices.
+	  Support for the LDO1 regulators found on Cirrus Logic Madera codecs
+	  and Wolfson Microelectronic Arizona codecs.
 
 config REGULATOR_ARIZONA_MICSUPP
 	tristate "Wolfson Arizona class devices MICSUPP"
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index e4bc7b1e5ccd..1a3d7b720f5e 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -25,6 +25,10 @@
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
 
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
 struct arizona_ldo1 {
 	struct regulator_dev *regulator;
 	struct regmap *regmap;
@@ -158,6 +162,31 @@ static const struct regulator_init_data arizona_ldo1_wm5110 = {
 	.num_consumer_supplies = 1,
 };
 
+static const struct regulator_desc madera_ldo1 = {
+	.name = "LDO1",
+	.supply_name = "LDOVDD",
+	.type = REGULATOR_VOLTAGE,
+	.ops = &arizona_ldo1_ops,
+
+	.vsel_reg = MADERA_LDO1_CONTROL_1,
+	.vsel_mask = MADERA_LDO1_VSEL_MASK,
+	.min_uV = 900000,
+	.uV_step = 25000,
+	.n_voltages = 13,
+	.enable_time = 3000,
+
+	.owner = THIS_MODULE,
+};
+
+static const struct regulator_init_data madera_ldo1_default = {
+	.constraints = {
+		.min_uV = 1200000,
+		.max_uV = 1200000,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = 1,
+};
+
 static int arizona_ldo1_of_get_pdata(struct arizona_ldo1_pdata *pdata,
 				     struct regulator_config *config,
 				     const struct regulator_desc *desc,
@@ -320,6 +349,32 @@ static int arizona_ldo1_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int madera_ldo1_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct arizona_ldo1 *ldo1;
+	bool external_dcvdd;
+	int ret;
+
+	ldo1 = devm_kzalloc(&pdev->dev, sizeof(*ldo1), GFP_KERNEL);
+	if (!ldo1)
+		return -ENOMEM;
+
+	ldo1->regmap = madera->regmap;
+
+	ldo1->init_data = madera_ldo1_default;
+
+	ret = arizona_ldo1_common_init(pdev, ldo1, &madera_ldo1,
+				       &madera->pdata.ldo1,
+				       &external_dcvdd);
+	if (ret)
+		return ret;
+
+	madera->internal_dcvdd = !external_dcvdd;
+
+	return 0;
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
 	.remove = arizona_ldo1_remove,
@@ -328,10 +383,36 @@ static struct platform_driver arizona_ldo1_driver = {
 	},
 };
 
-module_platform_driver(arizona_ldo1_driver);
+static struct platform_driver madera_ldo1_driver = {
+	.probe = madera_ldo1_probe,
+	.remove = arizona_ldo1_remove,
+	.driver		= {
+		.name	= "madera-ldo1",
+	},
+};
+
+static struct platform_driver * const madera_ldo1_drivers[] = {
+	&arizona_ldo1_driver,
+	&madera_ldo1_driver,
+};
+
+static int __init arizona_ldo1_init(void)
+{
+	return platform_register_drivers(madera_ldo1_drivers,
+					 ARRAY_SIZE(madera_ldo1_drivers));
+}
+module_init(arizona_ldo1_init);
+
+static void __exit madera_ldo1_exit(void)
+{
+	platform_unregister_drivers(madera_ldo1_drivers,
+				    ARRAY_SIZE(madera_ldo1_drivers));
+}
+module_exit(madera_ldo1_exit);
 
 /* Module information */
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("Arizona LDO1 driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:arizona-ldo1");
+MODULE_ALIAS("platform:madera-ldo1");
-- 
2.20.1

