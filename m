Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69984C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA4620693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563881368;
	bh=R0G+tEYl12mLaGVfWo+nEJWH5ZK2knSLm7YHhQ4ojBM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=um0dlqiASZONFf51Q1shgyi+4Yz/zqdzVWQJGRzPjQgDvWdL03CZHnJfW3wKdeIrd
	 bOnFng/rxXhAOyzb5IcIJP/MfXiTxXnGBOl9SahA2i0nDBp5yYxownh2EBee7e9VQr
	 qEu4+7kAOPe0l9TDZgndfpJr8IsYu2jK2lorUAd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbfGWL31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:29:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbfGWL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/xcRR8hlXNifn1w7hoVZZ7dxqbnCqlrjhjGc+MdxHNE=; b=R2+F0tWvbCyz
        j8dY6LaPO2gV1YB5csBcASXIsg+Edrkw3Z4+nCRA3673oiXdPxjKp2a1x5hZkunL8t4maK9a+/Uds
        z60doExHA+qTaPRMuyzylMZOCNH3s7SrarDQCr7wMGLG3+0svk2zZabRLI/j6fx+wQkZkQQF+VN12
        G6mV8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpsyw-0003Ly-7F; Tue, 23 Jul 2019 11:29:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BACB72742B60; Tue, 23 Jul 2019 12:29:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maarten ter Huurne <maarten@treewalker.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: Applied "regulator: act8865: Add support for act8600 charger" to the regulator tree
In-Reply-To: <20190723011418.29143-1-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190723112921.BACB72742B60@ypsilon.sirena.org.uk>
Date:   Tue, 23 Jul 2019 12:29:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8865: Add support for act8600 charger

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 2d09a79bf637f91d1bbfcfd4520e3639dd15897c Mon Sep 17 00:00:00 2001
From: Maarten ter Huurne <maarten@treewalker.org>
Date: Mon, 22 Jul 2019 21:14:18 -0400
Subject: [PATCH] regulator: act8865: Add support for act8600 charger

This provides a way to monitor battery charge status via the power
supply subsystem.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20190723011418.29143-1-paul@crapouillou.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8865-regulator.c | 84 +++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index cf72d7c6b8c9..e63285de485d 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/act8865.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/power_supply.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regmap.h>
 
@@ -118,6 +119,11 @@
 #define ACT8600_LDO10_ENA		0x40	/* ON - [6] */
 #define ACT8600_SUDCDC_VSEL_MASK	0xFF	/* SUDCDC VSET - [7:0] */
 
+#define ACT8600_APCH_CHG_ACIN		BIT(7)
+#define ACT8600_APCH_CHG_USB		BIT(6)
+#define ACT8600_APCH_CSTATE0		BIT(5)
+#define ACT8600_APCH_CSTATE1		BIT(4)
+
 /*
  * ACT8865 voltage number
  */
@@ -372,6 +378,75 @@ static void act8865_power_off(void)
 	while (1);
 }
 
+static int act8600_charger_get_status(struct regmap *map)
+{
+	unsigned int val;
+	int ret;
+	u8 state0, state1;
+
+	ret = regmap_read(map, ACT8600_APCH_STAT, &val);
+	if (ret < 0)
+		return ret;
+
+	state0 = val & ACT8600_APCH_CSTATE0;
+	state1 = val & ACT8600_APCH_CSTATE1;
+
+	if (state0 && !state1)
+		return POWER_SUPPLY_STATUS_CHARGING;
+	if (!state0 && state1)
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	if (!state0 && !state1)
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+
+	return POWER_SUPPLY_STATUS_UNKNOWN;
+}
+
+static int act8600_charger_get_property(struct power_supply *psy,
+		enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct regmap *map = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = act8600_charger_get_status(map);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property act8600_charger_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+};
+
+static const struct power_supply_desc act8600_charger_desc = {
+	.name = "act8600-charger",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = act8600_charger_properties,
+	.num_properties = ARRAY_SIZE(act8600_charger_properties),
+	.get_property = act8600_charger_get_property,
+};
+
+static int act8600_charger_probe(struct device *dev, struct regmap *regmap)
+{
+	struct power_supply *charger;
+	struct power_supply_config cfg = {
+		.drv_data = regmap,
+		.of_node = dev->of_node,
+	};
+
+	charger = devm_power_supply_register(dev, &act8600_charger_desc, &cfg);
+
+	return IS_ERR(charger) ? PTR_ERR(charger) : 0;
+}
+
 static int act8865_pmic_probe(struct i2c_client *client,
 			      const struct i2c_device_id *i2c_id)
 {
@@ -483,6 +558,15 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		}
 	}
 
+	if (type == ACT8600) {
+		ret = act8600_charger_probe(dev, act8865->regmap);
+		if (ret < 0) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to probe charger");
+			return ret;
+		}
+	}
+
 	i2c_set_clientdata(client, act8865);
 
 	return 0;
-- 
2.20.1

