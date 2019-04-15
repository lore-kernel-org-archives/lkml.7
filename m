Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BFCC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E7820833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318482;
	bh=EvAwrRBmXxWslfhmK+Nb8qeUDs3ZuaJXyBOtGEpzAJ0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aysZf2HZ9IVW33xrwd2CCZV0erAoqrUfopOW4+FJ212ZKt3SZr1+IDl4h/AVLgD6S
	 qD276oRDwT2T/NwC9LSZqVrkdhLHPFPA8N+Z9Z4NuX/TNUs/eOdcRL4OdU2hMlyo3b
	 Yvj9uxLbH0jMX4IGyi1c+/K1VZoAMWAiqBVuX+zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDOIyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:54:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35608 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfDOIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ayDVrXyF3v2Qo9hhBkSTa7wu1CfEq3wTt6RXvc7Oi8Y=; b=G1Tzgwx9t1lE
        qPG4Ajc2RVLF+UWiPwWK11A6FdtCT6pDTM5duxcO+0YG8B4zCewhJeis58I8ZOAYvx0aEXxL4e8Wt
        J7GyXVn7eMA3mk55bnVBLkPrMvRGm1ETR0gCWKVnVbn2dIDUkRMQW9LjM2z30rj84fg4ZDC+YL7nH
        JXhqY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hFxMr-0007j1-UQ; Mon, 15 Apr 2019 08:53:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7D1E61127BB5; Mon, 15 Apr 2019 09:53:32 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500-ext: Remove *rdev from struct ab8500_ext_regulator_info" to the regulator tree
In-Reply-To: <20190412140658.11754-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190415085332.7D1E61127BB5@debutante.sirena.org.uk>
Date:   Mon, 15 Apr 2019 09:53:32 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500-ext: Remove *rdev from struct ab8500_ext_regulator_info

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

From 80a9c22a9da953146eacb5b8eb2b16691d4d9925 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 22:06:57 +0800
Subject: [PATCH] regulator: ab8500-ext: Remove *rdev from struct
 ab8500_ext_regulator_info

Current code is using devm_regulator_register() so we don't need to save
*rdev for clean up, use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500-ext.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 2ca00045eb99..89ddbabca2af 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -479,7 +479,6 @@ static struct ab8500_regulator_platform_data ab8500_regulator_plat_data = {
  * struct ab8500_ext_regulator_info - ab8500 regulator information
  * @dev: device pointer
  * @desc: regulator description
- * @rdev: regulator device
  * @cfg: regulator configuration (extension of regulator FW configuration)
  * @update_bank: bank to control on/off
  * @update_reg: register to control on/off
@@ -495,7 +494,6 @@ static struct ab8500_regulator_platform_data ab8500_regulator_plat_data = {
 struct ab8500_ext_regulator_info {
 	struct device *dev;
 	struct regulator_desc desc;
-	struct regulator_dev *rdev;
 	struct ab8500_ext_regulator_cfg *cfg;
 	u8 update_bank;
 	u8 update_reg;
@@ -530,7 +528,7 @@ static int ab8500_ext_regulator_enable(struct regulator_dev *rdev)
 		info->update_bank, info->update_reg,
 		info->update_mask, regval);
 	if (ret < 0) {
-		dev_err(rdev_get_dev(info->rdev),
+		dev_err(rdev_get_dev(rdev),
 			"couldn't set enable bits for regulator\n");
 		return ret;
 	}
@@ -566,7 +564,7 @@ static int ab8500_ext_regulator_disable(struct regulator_dev *rdev)
 		info->update_bank, info->update_reg,
 		info->update_mask, regval);
 	if (ret < 0) {
-		dev_err(rdev_get_dev(info->rdev),
+		dev_err(rdev_get_dev(rdev),
 			"couldn't set disable bits for regulator\n");
 		return ret;
 	}
@@ -797,6 +795,7 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 	struct ab8500_regulator_platform_data *pdata = &ab8500_regulator_plat_data;
 	struct device_node *np = pdev->dev.of_node;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	int i, err;
 
 	if (np) {
@@ -850,17 +849,15 @@ static int ab8500_ext_regulator_probe(struct platform_device *pdev)
 			&pdata->ext_regulator[i];
 
 		/* register regulator with framework */
-		info->rdev = devm_regulator_register(&pdev->dev, &info->desc,
-						     &config);
-		if (IS_ERR(info->rdev)) {
-			err = PTR_ERR(info->rdev);
+		rdev = devm_regulator_register(&pdev->dev, &info->desc,
+					       &config);
+		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to register regulator %s\n",
 					info->desc.name);
-			return err;
+			return PTR_ERR(rdev);
 		}
 
-		dev_dbg(rdev_get_dev(info->rdev),
-			"%s-probed\n", info->desc.name);
+		dev_dbg(&pdev->dev, "%s-probed\n", info->desc.name);
 	}
 
 	return 0;
-- 
2.20.1

