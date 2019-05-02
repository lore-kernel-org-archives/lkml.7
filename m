Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6014FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFC121734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763543;
	bh=++UXd1C67SxoGMKilu8E4osYNOacvYE4ndnVT493uxs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Pmq7iEmPYJiAcZTnco4jPt5ua9hm2j7S5wAnnpBpp+QWF1/demEoE4HJv7IrB/p8z
	 nTKkRXKGy9c6/TtYsitmYhvndXglyXzGl20TFSsuq2DQh/7JZFTlc8M1PFvF6lENAC
	 AY7mXRuP8yES97t1+MWLIq6o09gHRG0iaIgm3lM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEBCTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:19:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56386 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfEBCTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oA8tzqPqM1UUXhOEIjynTm5arH7kOmcJGLh2VgChYiI=; b=qDPxsBUrGKyQ
        S+xY+JYIvUXlyRzFFltRYzOxfKVVSx9k5JCpkcZvqQ6PYBZTTAaG9JtzoGVkMg/EVPotwOCZiLJI/
        IgTZXizDzKoXkFpZ1KzjX9UjmqLoEL8PrcXG0u7ivCBTK4SMlSeQDadiUCkCaMxMd0Jus+0wdDund
        f+XXM=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JI-0005uO-0m; Thu, 02 May 2019 02:18:56 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1E126441D3E; Thu,  2 May 2019 03:18:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Applied "regulator: vexpress: Get rid of struct vexpress_regulator" to the regulator tree
In-Reply-To: <20190429113542.476-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021853.1E126441D3E@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:53 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: vexpress: Get rid of struct vexpress_regulator

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

From eeb1b2355a6f06c4995ce282e247afffb946d983 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 29 Apr 2019 19:35:41 +0800
Subject: [PATCH] regulator: vexpress: Get rid of struct vexpress_regulator

The *regdev and *regmap can be replaced by local variables in probe().
Only desc of struct vexpress_regulator is really need, so just use
struct regulator_desc directly and remove struct vexpress_regulator.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/vexpress-regulator.c | 53 +++++++++++---------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index ca4230fe9e77..a15a1319436a 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -23,17 +23,10 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/vexpress.h>
 
-struct vexpress_regulator {
-	struct regulator_desc desc;
-	struct regulator_dev *regdev;
-	struct regmap *regmap;
-};
-
 static int vexpress_regulator_get_voltage(struct regulator_dev *regdev)
 {
-	struct vexpress_regulator *reg = rdev_get_drvdata(regdev);
-	u32 uV;
-	int err = regmap_read(reg->regmap, 0, &uV);
+	unsigned int uV;
+	int err = regmap_read(regdev->regmap, 0, &uV);
 
 	return err ? err : uV;
 }
@@ -41,9 +34,7 @@ static int vexpress_regulator_get_voltage(struct regulator_dev *regdev)
 static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
 		int min_uV, int max_uV, unsigned *selector)
 {
-	struct vexpress_regulator *reg = rdev_get_drvdata(regdev);
-
-	return regmap_write(reg->regmap, 0, min_uV);
+	return regmap_write(regdev->regmap, 0, min_uV);
 }
 
 static const struct regulator_ops vexpress_regulator_ops_ro = {
@@ -57,44 +48,44 @@ static const struct regulator_ops vexpress_regulator_ops = {
 
 static int vexpress_regulator_probe(struct platform_device *pdev)
 {
-	struct vexpress_regulator *reg;
+	struct regulator_desc *desc;
 	struct regulator_init_data *init_data;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
 
-	reg = devm_kzalloc(&pdev->dev, sizeof(*reg), GFP_KERNEL);
-	if (!reg)
+	desc = devm_kzalloc(&pdev->dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
 		return -ENOMEM;
 
-	reg->regmap = devm_regmap_init_vexpress_config(&pdev->dev);
-	if (IS_ERR(reg->regmap))
-		return PTR_ERR(reg->regmap);
+	regmap = devm_regmap_init_vexpress_config(&pdev->dev);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	reg->desc.name = dev_name(&pdev->dev);
-	reg->desc.type = REGULATOR_VOLTAGE;
-	reg->desc.owner = THIS_MODULE;
-	reg->desc.continuous_voltage_range = true;
+	desc->name = dev_name(&pdev->dev);
+	desc->type = REGULATOR_VOLTAGE;
+	desc->owner = THIS_MODULE;
+	desc->continuous_voltage_range = true;
 
 	init_data = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node,
-					       &reg->desc);
+					       desc);
 	if (!init_data)
 		return -EINVAL;
 
 	init_data->constraints.apply_uV = 0;
 	if (init_data->constraints.min_uV && init_data->constraints.max_uV)
-		reg->desc.ops = &vexpress_regulator_ops;
+		desc->ops = &vexpress_regulator_ops;
 	else
-		reg->desc.ops = &vexpress_regulator_ops_ro;
+		desc->ops = &vexpress_regulator_ops_ro;
 
+	config.regmap = regmap;
 	config.dev = &pdev->dev;
 	config.init_data = init_data;
-	config.driver_data = reg;
 	config.of_node = pdev->dev.of_node;
 
-	reg->regdev = devm_regulator_register(&pdev->dev, &reg->desc, &config);
-	if (IS_ERR(reg->regdev))
-		return PTR_ERR(reg->regdev);
-
-	platform_set_drvdata(pdev, reg);
+	rdev = devm_regulator_register(&pdev->dev, desc, &config);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
 
 	return 0;
 }
-- 
2.20.1

