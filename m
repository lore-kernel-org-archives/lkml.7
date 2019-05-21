Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9626CC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AE421855
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558470798;
	bh=AZZSicw78b5Fggefzg16+EJ0Q3YsoyLnR4rvrLtZAi8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UiUCsYAMXX9BCi4/njRHxI9NvobEOp3QxHhdEMwifgpQKaETPmhx/PQjyU9So129i
	 zzpWZICjchb9hbBekVJG0mOuozhm/fXwb/m4cLGmHbwC0g5zUYQqpD0LPFZ5cBKH3B
	 gcz5L9g1ZlDG/bvllDcABKToPovsrUO5SKYJYdpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfEUUdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:33:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfEUUdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=S5X7czboCisMYseVeOymioFKExO97rxcqzHyV6vKQEM=; b=XrmK8xbVOkbO
        RBzeMljHOj0vrLCu8xnNe88LnagR1nQjM88ZXA2XeBPTK29QRp9HDaui9i8sA+9yEh+Qxfc/Ck35e
        G/7lesp/juCsEg2CoxBR1UkpT8d2k5Ab1MMobEYMpsAD7pzqZ9xJBqDOxHrsE0QiAme56WS6PTHlS
        uuzi4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTBRU-00021a-7E; Tue, 21 May 2019 20:33:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 937C91126D13; Tue, 21 May 2019 21:32:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, patches@opensource.cirrus.com,
        robh+dt@kernel.org
Subject: Applied "regulator: arizona-micsupp: Add support for Cirrus Logic Madera codecs" to the regulator tree
In-Reply-To: <20190521100439.27383-3-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Message-Id: <20190521203259.937C91126D13@debutante.sirena.org.uk>
Date:   Tue, 21 May 2019 21:32:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona-micsupp: Add support for Cirrus Logic Madera codecs

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

From 7bd7916dc8ab5b056f1b53e19021e476120481c0 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Tue, 21 May 2019 11:04:39 +0100
Subject: [PATCH] regulator: arizona-micsupp: Add support for Cirrus Logic
 Madera codecs

This adds a new driver identity "madera-micsupp" and probe function
so that this driver can be used to control the micsupp regulator on
Cirrus Logic Madera codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig           |  7 +--
 drivers/regulator/arizona-micsupp.c | 71 ++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5827aace014b..660f3a1717ba 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -143,11 +143,12 @@ config REGULATOR_ARIZONA_LDO1
 	  and Wolfson Microelectronic Arizona codecs.
 
 config REGULATOR_ARIZONA_MICSUPP
-	tristate "Wolfson Arizona class devices MICSUPP"
-	depends on MFD_ARIZONA
+	tristate "Cirrus Madera and Wolfson Arizona class devices MICSUPP"
+	depends on MFD_ARIZONA || MFD_MADERA
 	depends on SND_SOC
 	help
-	  Support for the MICSUPP regulators found on Wolfson Arizona class
+	  Support for the MICSUPP regulators found on Cirrus Logic Madera codecs
+	  and Wolfson Microelectronic Arizona codecs
 	  devices.
 
 config REGULATOR_AS3711
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index be0d46da51a1..de6802b85e9f 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -25,6 +25,10 @@
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
 
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
 #include <linux/regulator/arizona-micsupp.h>
 
 struct arizona_micsupp {
@@ -200,6 +204,28 @@ static const struct regulator_init_data arizona_micsupp_ext_default = {
 	.num_consumer_supplies = 1,
 };
 
+static const struct regulator_desc madera_micsupp = {
+	.name = "MICVDD",
+	.supply_name = "CPVDD1",
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = 40,
+	.ops = &arizona_micsupp_ops,
+
+	.vsel_reg = MADERA_LDO2_CONTROL_1,
+	.vsel_mask = MADERA_LDO2_VSEL_MASK,
+	.enable_reg = MADERA_MIC_CHARGE_PUMP_1,
+	.enable_mask = MADERA_CPMIC_ENA,
+	.bypass_reg = MADERA_MIC_CHARGE_PUMP_1,
+	.bypass_mask = MADERA_CPMIC_BYPASS,
+
+	.linear_ranges = arizona_micsupp_ext_ranges,
+	.n_linear_ranges = ARRAY_SIZE(arizona_micsupp_ext_ranges),
+
+	.enable_time = 3000,
+
+	.owner = THIS_MODULE,
+};
+
 static int arizona_micsupp_of_get_pdata(struct arizona_micsupp_pdata *pdata,
 					struct regulator_config *config,
 					const struct regulator_desc *desc)
@@ -316,6 +342,24 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 					   &arizona->pdata.micvdd);
 }
 
+static int madera_micsupp_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct arizona_micsupp *micsupp;
+
+	micsupp = devm_kzalloc(&pdev->dev, sizeof(*micsupp), GFP_KERNEL);
+	if (!micsupp)
+		return -ENOMEM;
+
+	micsupp->regmap = madera->regmap;
+	micsupp->dapm = &madera->dapm;
+	micsupp->dev = madera->dev;
+	micsupp->init_data = arizona_micsupp_ext_default;
+
+	return arizona_micsupp_common_init(pdev, micsupp, &madera_micsupp,
+					   &madera->pdata.micvdd);
+}
+
 static struct platform_driver arizona_micsupp_driver = {
 	.probe = arizona_micsupp_probe,
 	.driver		= {
@@ -323,10 +367,35 @@ static struct platform_driver arizona_micsupp_driver = {
 	},
 };
 
-module_platform_driver(arizona_micsupp_driver);
+static struct platform_driver madera_micsupp_driver = {
+	.probe = madera_micsupp_probe,
+	.driver		= {
+		.name	= "madera-micsupp",
+	},
+};
+
+static struct platform_driver * const arizona_micsupp_drivers[] = {
+	&arizona_micsupp_driver,
+	&madera_micsupp_driver,
+};
+
+static int __init arizona_micsupp_init(void)
+{
+	return platform_register_drivers(arizona_micsupp_drivers,
+					 ARRAY_SIZE(arizona_micsupp_drivers));
+}
+module_init(arizona_micsupp_init);
+
+static void __exit arizona_micsupp_exit(void)
+{
+	platform_unregister_drivers(arizona_micsupp_drivers,
+				    ARRAY_SIZE(arizona_micsupp_drivers));
+}
+module_exit(arizona_micsupp_exit);
 
 /* Module information */
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("Arizona microphone supply driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:arizona-micsupp");
+MODULE_ALIAS("platform:madera-micsupp");
-- 
2.20.1

