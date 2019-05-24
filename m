Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E4C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869F721871
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558699972;
	bh=QUID8il93BT5YYEJvSxD9CdqWmogcOK+zuFTAfzJMkY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2lTm0GF++46Si9Rcl/NUaqjB+dO1zeu1K/FIb+pIL4z/OPxuvZ1bwz8hRLuLYbPs4
	 R3Zg56hhOH/oRsLOgD8O4bVYxSqR2Uz6gPqnmJSBE3+8zbBj4S4bAXFM8BAH6Aau/n
	 1yuwn+AreKQ08ZrZ/nuVZDYow2siIErarM5iykS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391487AbfEXMMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:12:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43310 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391449AbfEXMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1jfbm+ilo7jODaRxd8Scvr0X0nhcAhiF59hj2x7IHRk=; b=ShjilB1EhGZQ
        Sd50u6x0iF3W13fvmbZze9Hnc5JpyFGWcRvuPq4HHsmTqGKgmgaVbPWIGPwvnhcXw82ADLoX9QQS1
        tjbrRiXwN71Yym0BWnPOuYASF8ZcMQZhGCQBUvbH+rize5FixWquy4SpF5n3Tj8bui+BiIt5ot/Sc
        Dkr00=;
Received: from [176.12.107.140] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hU943-0003DW-EW; Fri, 24 May 2019 12:12:47 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 804B1440046; Fri, 24 May 2019 13:12:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Eric Jeong <eric.jeong.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: slg51000: Remove unneeded regl_pdata from struct slg51000" to the regulator tree
In-Reply-To: <20190524100247.7267-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190524121246.804B1440046@finisterre.sirena.org.uk>
Date:   Fri, 24 May 2019 13:12:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: slg51000: Remove unneeded regl_pdata from struct slg51000

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

From 12c574d84c8e492320a4e75b2c1157f8b61e4092 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 24 May 2019 18:02:47 +0800
Subject: [PATCH] regulator: slg51000: Remove unneeded regl_pdata from struct
 slg51000

Just use a local variable *ena_gpiod in slg51000_of_parse_cb instead.
With this change, the struct slg51000_pdata can be removed.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/slg51000-regulator.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index a06a18f220e0..04b732991d69 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -35,14 +35,9 @@ enum slg51000_regulators {
 	SLG51000_MAX_REGULATORS,
 };
 
-struct slg51000_pdata {
-	struct gpio_desc *ena_gpiod;
-};
-
 struct slg51000 {
 	struct device *dev;
 	struct regmap *regmap;
-	struct slg51000_pdata regl_pdata[SLG51000_MAX_REGULATORS];
 	struct regulator_desc *rdesc[SLG51000_MAX_REGULATORS];
 	struct regulator_dev *rdev[SLG51000_MAX_REGULATORS];
 	struct gpio_desc *cs_gpiod;
@@ -204,14 +199,14 @@ static int slg51000_of_parse_cb(struct device_node *np,
 				struct regulator_config *config)
 {
 	struct slg51000 *chip = config->driver_data;
-	struct slg51000_pdata *rpdata = &chip->regl_pdata[desc->id];
+	struct gpio_desc *ena_gpiod;
 	enum gpiod_flags gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	rpdata->ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
-							"enable-gpios", 0,
-							gflags, "gpio-en-ldo");
-	if (rpdata->ena_gpiod) {
-		config->ena_gpiod = rpdata->ena_gpiod;
+	ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
+						"enable-gpios", 0,
+						gflags, "gpio-en-ldo");
+	if (ena_gpiod) {
+		config->ena_gpiod = ena_gpiod;
 		devm_gpiod_unhinge(chip->dev, config->ena_gpiod);
 	}
 
-- 
2.20.1

