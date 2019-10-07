Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659AECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB792070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453448;
	bh=X2jBdKWQxoZ1BCVmswnUYdAcJr+g9oL75u86slM+b3s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CwpWfZhBVCy0sqd12GUwJqPIPnHhKRygV8+fK6oKcRFw/VEcx6DirFU7sIM4d5uQR
	 5LlBolw4rG+OTYlbUapQknfddEF7UhpehiNwlb5kfO2EpEmfzFiKlWwiV8oUnicuqJ
	 1UKJKUE7ndF2o0joZuue4rBpJMSoETHeuPNE5F0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfJGNDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfJGNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BLfhGvOms8vrkoruRjB0fNgC2H90ROBBYao9KV7E39s=; b=izXfN5kET+39
        B3vd6YrUvFCVPf57meyeqCOopMIau0uGmBR1p9YtyghTJsK789mePStcS9OdSfdRMZ4subWHqzUNK
        sFs6qUl5ZltlJyF5Pn5RQi+c+FNJsvv+3AVyyFO/pe7k9xksKMkY5qIz2G3g39eKhjiHDSXEDSEEw
        2kW7c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfV-0003Rk-6B; Mon, 07 Oct 2019 13:03:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B1A012741D8E; Mon,  7 Oct 2019 14:03:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65090: switch to using devm_fwnode_gpiod_get" to the regulator tree
In-Reply-To: <20191004231017.130290-4-dmitry.torokhov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007130316.B1A012741D8E@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65090: switch to using devm_fwnode_gpiod_get

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 51d98ff8616a3c46233bdd1b714b8f19537bc9a8 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 4 Oct 2019 16:10:13 -0700
Subject: [PATCH] regulator: tps65090: switch to using devm_fwnode_gpiod_get

devm_gpiod_get_from_of_node() is being retired in favor of
devm_fwnode_gpiod_get_index(), that behaves similar to
devm_gpiod_get_index(), but can work with arbitrary firmware node. It
will also be able to support secondary software nodes.

Let's switch this driver over.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20191004231017.130290-4-dmitry.torokhov@gmail.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65090-regulator.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 10ea4b5a0f55..f0b660e9f15f 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -346,16 +346,20 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 	for (idx = 0; idx < ARRAY_SIZE(tps65090_matches); idx++) {
 		struct regulator_init_data *ri_data;
 		struct tps65090_regulator_plat_data *rpdata;
+		struct device_node *np;
 
 		rpdata = &reg_pdata[idx];
 		ri_data = tps65090_matches[idx].init_data;
-		if (!ri_data || !tps65090_matches[idx].of_node)
+		if (!ri_data)
+			continue;
+
+		np = tps65090_matches[idx].of_node;
+		if (!np)
 			continue;
 
 		rpdata->reg_init_data = ri_data;
-		rpdata->enable_ext_control = of_property_read_bool(
-					tps65090_matches[idx].of_node,
-					"ti,enable-ext-control");
+		rpdata->enable_ext_control = of_property_read_bool(np,
+						"ti,enable-ext-control");
 		if (rpdata->enable_ext_control) {
 			enum gpiod_flags gflags;
 
@@ -366,11 +370,12 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 				gflags = GPIOD_OUT_LOW;
 			gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-			rpdata->gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
-								    tps65090_matches[idx].of_node,
-								    "dcdc-ext-control-gpios", 0,
-								    gflags,
-								    "tps65090");
+			rpdata->gpiod = devm_fwnode_gpiod_get(
+							&pdev->dev,
+							of_fwnode_handle(np),
+							"dcdc-ext-control",
+							gflags,
+							"tps65090");
 			if (PTR_ERR(rpdata->gpiod) == -ENOENT) {
 				dev_err(&pdev->dev,
 					"could not find DCDC external control GPIO\n");
@@ -379,8 +384,7 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 				return ERR_CAST(rpdata->gpiod);
 		}
 
-		if (of_property_read_u32(tps65090_matches[idx].of_node,
-					 "ti,overcurrent-wait",
+		if (of_property_read_u32(np, "ti,overcurrent-wait",
 					 &rpdata->overcurrent_wait) == 0)
 			rpdata->overcurrent_wait_valid = true;
 
-- 
2.20.1

