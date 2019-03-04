Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B61C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D3F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658017;
	bh=0Twwcx/6eyKgP8Sqg8wKP1sOAAWvOG4NVVIOoNxF1s8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jUIz7GLL98fYJNT+9LwKZJi7ubP7uulFznAjX5hTubSOANimWTRHYFa30j/vJ/lUP
	 p96gkP+y7kttT0/m8cr+Nholmb7rvF2tVb+8wBpB0Dimfn+SKkFbFEqOf72o4mC12z
	 +2Q58DL3OiTaH+OBZH31vENVe9mUWA3g9cctUDgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCDAG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54486 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCDAGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BCfHAD1KOrXK7FfGVpuUU2ntyQNLE7/Chr2NxddgILY=; b=ejzfwMNb1trG
        +pPch6HJbEUf00cUCf0/zuW9hx+SLnFtbZkKsduIT3Id7kym2hLlfBEIEZwmWqhSgqtmxOoqKLtE/
        UUzQf3pp6ppxp1Z6uXJyzzIeLjjWvD43AFbvoZdrgnByk3cnOJpiAhU9xIwgGY9vDf7tGAEFajrnm
        UZv2Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b87-0007QT-A4; Mon, 04 Mar 2019 00:06:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AE42B440082; Mon,  4 Mar 2019 00:06:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9055: Convert to use regulator_set/get_current_limit_regmap" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000650.AE42B440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9055: Convert to use regulator_set/get_current_limit_regmap

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 941666e29831010c7375ac9e7622f64b128153fe Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:14 +0800
Subject: [PATCH] regulator: da9055: Convert to use
 regulator_set/get_current_limit_regmap

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9055-regulator.c | 45 ++++++----------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 417cafe2aba0..3c6fac793658 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -48,7 +48,9 @@
 #define DA9055_ID_LDO6		7
 
 /* DA9055 BUCK current limit */
-static const int da9055_current_limits[] = { 500000, 600000, 700000, 800000 };
+static const unsigned int da9055_current_limits[] = {
+	500000, 600000, 700000, 800000
+};
 
 struct da9055_conf_reg {
 	int reg;
@@ -169,39 +171,6 @@ static int da9055_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
 				 val << volt.sl_shift);
 }
 
-static int da9055_buck_get_current_limit(struct regulator_dev *rdev)
-{
-	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
-	struct da9055_regulator_info *info = regulator->info;
-	int ret;
-
-	ret = da9055_reg_read(regulator->da9055, DA9055_REG_BUCK_LIM);
-	if (ret < 0)
-		return ret;
-
-	ret &= info->mode.mask;
-	return da9055_current_limits[ret >> info->mode.shift];
-}
-
-static int da9055_buck_set_current_limit(struct regulator_dev *rdev, int min_uA,
-					 int max_uA)
-{
-	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
-	struct da9055_regulator_info *info = regulator->info;
-	int i;
-
-	for (i = ARRAY_SIZE(da9055_current_limits) - 1; i >= 0; i--) {
-		if ((min_uA <= da9055_current_limits[i]) &&
-		    (da9055_current_limits[i] <= max_uA))
-			return da9055_reg_update(regulator->da9055,
-						 DA9055_REG_BUCK_LIM,
-						 info->mode.mask,
-						 i << info->mode.shift);
-	}
-
-	return -EINVAL;
-}
-
 static int da9055_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
@@ -329,8 +298,8 @@ static const struct regulator_ops da9055_buck_ops = {
 	.get_mode = da9055_buck_get_mode,
 	.set_mode = da9055_buck_set_mode,
 
-	.get_current_limit = da9055_buck_get_current_limit,
-	.set_current_limit = da9055_buck_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 
 	.get_voltage_sel = da9055_regulator_get_voltage_sel,
 	.set_voltage_sel = da9055_regulator_set_voltage_sel,
@@ -407,6 +376,10 @@ static const struct regulator_ops da9055_ldo_ops = {
 		.uV_step = (step) * 1000,\
 		.linear_min_sel = (voffset),\
 		.owner = THIS_MODULE,\
+		.curr_table = da9055_current_limits,\
+		.n_current_limits = ARRAY_SIZE(da9055_current_limits),\
+		.csel_reg = DA9055_REG_BUCK_LIM,\
+		.csel_mask = (mbits),\
 	},\
 	.conf = {\
 		.reg = DA9055_REG_BCORE_CONT + DA9055_ID_##_id, \
-- 
2.20.1

