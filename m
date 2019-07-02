Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8BDC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31862146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562072705;
	bh=T1Kwn7CcZS5HbyIIQVaIHbrvClK1dLcV7lXVF4fRbz4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UC0ZC1Gse4KGmtT7bmkOsc0QkqsHAuuS3ECtxiXlT8Hn5GQLN2ac7XXtPKJx35QpU
	 hRIUmJA0raP3qdYHL+Lla5GT4FyKuXYzMNA77BCtFwk8uiUs/CyvGy8HDYmk6aXsG1
	 2lX9WyPrvLx3vlvOGoKlDjtjqmzr9TPb7AnVKj/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGBNFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:05:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfGBNFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=F04tVE/uH/qRXJLC7CQfRhTRh00eEbuM9Ceb3EulQu4=; b=vuTUc0fLJ4Ie
        Kirr/Md+2YiI56rIZ2ERMo4aA/e+A3/1YJpEm4rNlWvlOMEH3PI+athaNTilFWsgqu5xeLImE63qD
        gPhjEOiwtRYWg6wXHLCV9IbyexojLs28VfkEBPw08+eiXhFl6OFQrPslyos710c5sbWq6GS31sAfr
        Fe238=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiISm-0002O2-O7; Tue, 02 Jul 2019 13:04:48 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 36CAD440049; Tue,  2 Jul 2019 14:04:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     alexandre.torgue@st.com, broonie@kernel.org,
        devicetree@vger.kernel.org, fabrice.gasnier@st.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        robh+dt@kernel.org
Subject: Applied "regulator: add support for the stm32-booster" to the regulator tree
In-Reply-To: <1561968865-22037-3-git-send-email-fabrice.gasnier@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190702130448.36CAD440049@finisterre.sirena.org.uk>
Date:   Tue,  2 Jul 2019 14:04:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: add support for the stm32-booster

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

From 4e210fbeee8e2f0eb04761c624fcccc8401eba4c Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Date: Mon, 1 Jul 2019 10:14:23 +0200
Subject: [PATCH] regulator: add support for the stm32-booster

Add support for the 3.3V booster regulator embedded in stm32h7 and stm32mp1
devices, that can be used to supply ADC analog input switches.

This regulator is supplied by vdda. It's controlled by using SYSCFG:
- STM32H7 has a unique register to set/clear the booster enable bit
- STM32MP1 has separate set and clear registers to configure it.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig         |  11 +++
 drivers/regulator/Makefile        |   1 +
 drivers/regulator/stm32-booster.c | 132 ++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/regulator/stm32-booster.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 0e7d425ba9b1..1e590ecf1a9d 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -839,6 +839,17 @@ config REGULATOR_SLG51000
 	  The SLG51000 is seven compact and customizable low dropout
 	  regulators.
 
+config REGULATOR_STM32_BOOSTER
+	tristate "STMicroelectronics STM32 BOOSTER"
+	depends on ARCH_STM32 || COMPILE_TEST
+	help
+	  This driver supports internal booster (3V3) embedded in some
+	  STMicroelectronics STM32 chips. It can be used to supply ADC analog
+	  input switches when vdda supply is below 2.7V.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called stm32-booster.
+
 config REGULATOR_STM32_VREFBUF
 	tristate "STMicroelectronics STM32 VREFBUF"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index c15b0b613766..eef73b5a35a4 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
 obj-$(CONFIG_REGULATOR_SLG51000) += slg51000-regulator.o
+obj-$(CONFIG_REGULATOR_STM32_BOOSTER) += stm32-booster.o
 obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
 obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
diff --git a/drivers/regulator/stm32-booster.c b/drivers/regulator/stm32-booster.c
new file mode 100644
index 000000000000..2a897666c650
--- /dev/null
+++ b/drivers/regulator/stm32-booster.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) STMicroelectronics 2019
+// Author(s): Fabrice Gasnier <fabrice.gasnier@st.com>.
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+/* STM32H7 SYSCFG register */
+#define STM32H7_SYSCFG_PMCR		0x04
+#define STM32H7_SYSCFG_BOOSTE_MASK	BIT(8)
+
+/* STM32MP1 SYSCFG has set and clear registers */
+#define STM32MP1_SYSCFG_PMCSETR		0x04
+#define STM32MP1_SYSCFG_PMCCLRR		0x44
+#define STM32MP1_SYSCFG_EN_BOOSTER_MASK	BIT(8)
+
+static const struct regulator_ops stm32h7_booster_ops = {
+	.list_voltage	= regulator_list_voltage_linear,
+	.enable		= regulator_enable_regmap,
+	.disable	= regulator_disable_regmap,
+	.is_enabled	= regulator_is_enabled_regmap,
+};
+
+static const struct regulator_desc stm32h7_booster_desc = {
+	.name = "booster",
+	.supply_name = "vdda",
+	.n_voltages = 1,
+	.type = REGULATOR_VOLTAGE,
+	.min_uV = 3300000,
+	.fixed_uV = 3300000,
+	.ramp_delay = 66000, /* up to 50us to stabilize */
+	.ops = &stm32h7_booster_ops,
+	.enable_reg = STM32H7_SYSCFG_PMCR,
+	.enable_mask = STM32H7_SYSCFG_BOOSTE_MASK,
+	.owner = THIS_MODULE,
+};
+
+static int stm32mp1_booster_enable(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, STM32MP1_SYSCFG_PMCSETR,
+			    STM32MP1_SYSCFG_EN_BOOSTER_MASK);
+}
+
+static int stm32mp1_booster_disable(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, STM32MP1_SYSCFG_PMCCLRR,
+			    STM32MP1_SYSCFG_EN_BOOSTER_MASK);
+}
+
+static const struct regulator_ops stm32mp1_booster_ops = {
+	.list_voltage	= regulator_list_voltage_linear,
+	.enable		= stm32mp1_booster_enable,
+	.disable	= stm32mp1_booster_disable,
+	.is_enabled	= regulator_is_enabled_regmap,
+};
+
+static const struct regulator_desc stm32mp1_booster_desc = {
+	.name = "booster",
+	.supply_name = "vdda",
+	.n_voltages = 1,
+	.type = REGULATOR_VOLTAGE,
+	.min_uV = 3300000,
+	.fixed_uV = 3300000,
+	.ramp_delay = 66000,
+	.ops = &stm32mp1_booster_ops,
+	.enable_reg = STM32MP1_SYSCFG_PMCSETR,
+	.enable_mask = STM32MP1_SYSCFG_EN_BOOSTER_MASK,
+	.owner = THIS_MODULE,
+};
+
+static int stm32_booster_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	struct regulator_config config = { };
+	const struct regulator_desc *desc;
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	desc = (const struct regulator_desc *)
+		of_match_device(dev->driver->of_match_table, dev)->data;
+
+	config.regmap = regmap;
+	config.dev = dev;
+	config.of_node = np;
+	config.init_data = of_get_regulator_init_data(dev, np, desc);
+
+	rdev = devm_regulator_register(dev, desc, &config);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		dev_err(dev, "register failed with error %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id stm32_booster_of_match[] = {
+	{
+		.compatible = "st,stm32h7-booster",
+		.data = (void *)&stm32h7_booster_desc
+	}, {
+		.compatible = "st,stm32mp1-booster",
+		.data = (void *)&stm32mp1_booster_desc
+	}, {
+	},
+};
+MODULE_DEVICE_TABLE(of, stm32_booster_of_match);
+
+static struct platform_driver stm32_booster_driver = {
+	.probe = stm32_booster_probe,
+	.driver = {
+		.name  = "stm32-booster",
+		.of_match_table = of_match_ptr(stm32_booster_of_match),
+	},
+};
+module_platform_driver(stm32_booster_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 booster regulator driver");
+MODULE_ALIAS("platform:stm32-booster");
-- 
2.20.1

