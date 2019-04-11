Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42149C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093A0218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554981598;
	bh=Cc9wfQTTfyCPZt/PP2Wm970F8mZ+FKdufMoOZ38RF+c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=he8QuzERyzXu3Aj/s3tLT0L8mDw/zpzEh2MyPi/LNJUDK7haQYvqvG24rJxk6DoKp
	 6nlrs2sqQIyX4Z5IYLauu7YC11YABrHFR8ugW4Aoopjhy31yqlJ+n4DEfNhlX3zKua
	 Z7gKFP0JDVNLZ0XQJcYQujRyFhu0DXU8GGYrtkgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDKLTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:19:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKLTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VQpn4USn8u7TZTWM5EV+y5A0X4ff3M9PN1w0p92epsg=; b=r7+v0jaxz8C9
        e4KExn0+ciqN2Xz+R82XbDNtPz8NQUJsIEus62YyOBnjooZIr3WTDUkFya+K4FD4A5hGq/eJp4CZc
        TvWpxFoTx+0uCmZ0cXh9/pDObAI6+uY3pzBDzhVIIH2xvDbdNgKKhd5KdeK0djcC/27sZkUvJ37Xe
        elD98=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEXkE-00006l-9J; Thu, 11 Apr 2019 11:19:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 224F41126DD3; Thu, 11 Apr 2019 12:19:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Applied "regulator: mcp16502: Remove setup_regulators function" to the regulator tree
In-Reply-To: <20190411015923.7157-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190411111949.224F41126DD3@debutante.sirena.org.uk>
Date:   Thu, 11 Apr 2019 12:19:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mcp16502: Remove setup_regulators function

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

From 784c24c3e45cc665226e8529d79f319af7cfd09c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Apr 2019 09:59:23 +0800
Subject: [PATCH] regulator: mcp16502: Remove setup_regulators function

It seems a little bit odd current code pass struct regulator_config rather
than a pointer to setup_regulators. The setup_regulators is so simple and
only has one caller, so remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mcp16502.c | 37 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 9292ab8736c7..e5a02711cb46 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -427,36 +427,15 @@ static const struct regmap_config mcp16502_regmap_config = {
 	.wr_table	= &mcp16502_yes_reg_table,
 };
 
-/*
- * set_up_regulators() - initialize all regulators
- */
-static int setup_regulators(struct mcp16502 *mcp, struct device *dev,
-			    struct regulator_config config)
-{
-	struct regulator_dev *rdev;
-	int i;
-
-	for (i = 0; i < NUM_REGULATORS; i++) {
-		rdev = devm_regulator_register(dev, &mcp16502_desc[i], &config);
-		if (IS_ERR(rdev)) {
-			dev_err(dev,
-				"failed to register %s regulator %ld\n",
-				mcp16502_desc[i].name, PTR_ERR(rdev));
-			return PTR_ERR(rdev);
-		}
-	}
-
-	return 0;
-}
-
 static int mcp16502_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	struct device *dev;
 	struct mcp16502 *mcp;
 	struct regmap *rmap;
-	int ret = 0;
+	int i, ret;
 
 	dev = &client->dev;
 	config.dev = dev;
@@ -482,9 +461,15 @@ static int mcp16502_probe(struct i2c_client *client,
 		return PTR_ERR(mcp->lpm);
 	}
 
-	ret = setup_regulators(mcp, dev, config);
-	if (ret != 0)
-		return ret;
+	for (i = 0; i < NUM_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev, &mcp16502_desc[i], &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev,
+				"failed to register %s regulator %ld\n",
+				mcp16502_desc[i].name, PTR_ERR(rdev));
+			return PTR_ERR(rdev);
+		}
+	}
 
 	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_ACTIVE);
 
-- 
2.20.1

