Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8247C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E3320874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318477;
	bh=xkcJtL77TL2JvYpdAU8n97hjdFadr1SbXtDexJJWf1Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=P7JV5Q2RaPpzXMX6ayepsDHxqXcVo41Sli07VKoGJC+YNe9oMIEIOmtzu/jUTXL72
	 US+MS6gKtKUgRk49aDv8RO68R1GnY50CFwAvTcfINhOFfxd8DQgER414ojgnq5uPfx
	 S2L/YGqBK/rKB1LJRH2f67KIwrctXAu8jHTcXpVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfDOIxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:53:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35562 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfDOIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JGl15Y/sd6EKl1xqS6YCNLf1jq7Twxu/clxkwRkywAc=; b=uzb2RGI+fsm7
        XQLntkAsAJexyfa7y0e9txMd+4ZDRlvRCn1Ar25OvKO7cYFf+oYc1+FZ082LzGvHAn4AhV6/lg09a
        5lmBLgmXoO4+CbL8V8GpN/zHw3gV4N72c6/qCae+E5o4PxRHbWSa17cg+d+hY316RnHEHRB7OLSUg
        xk/cg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hFxMq-0007j0-S2; Mon, 15 Apr 2019 08:53:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2A1221127B60; Mon, 15 Apr 2019 09:53:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Cyril Chemparathy <cyril@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps6524x: Remove *rdev[N_REGULATORS] from struct tps6524x" to the regulator tree
In-Reply-To: <20190413073002.764-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190415085331.2A1221127B60@debutante.sirena.org.uk>
Date:   Mon, 15 Apr 2019 09:53:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps6524x: Remove *rdev[N_REGULATORS] from struct tps6524x

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

From 7a8b0e66df5ad04d0acf31d43b37be46504b9fbc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 13 Apr 2019 15:30:02 +0800
Subject: [PATCH] regulator: tps6524x: Remove *rdev[N_REGULATORS] from struct
 tps6524x

Current code is using devm_regulator_register() so we don't need to store
*rdev for clean up, use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps6524x-regulator.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index c09223c34dbf..740aeccdfb1f 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -137,7 +137,6 @@ struct tps6524x {
 	struct spi_device	*spi;
 	struct mutex		lock;
 	struct regulator_desc	desc[N_REGULATORS];
-	struct regulator_dev	*rdev[N_REGULATORS];
 };
 
 static int __read_reg(struct tps6524x *hw, int reg)
@@ -584,6 +583,7 @@ static int pmic_probe(struct spi_device *spi)
 	const struct supply_info *info = supply_info;
 	struct regulator_init_data *init_data;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	int i;
 
 	init_data = dev_get_platdata(dev);
@@ -616,10 +616,9 @@ static int pmic_probe(struct spi_device *spi)
 		config.init_data = init_data;
 		config.driver_data = hw;
 
-		hw->rdev[i] = devm_regulator_register(dev, &hw->desc[i],
-						      &config);
-		if (IS_ERR(hw->rdev[i]))
-			return PTR_ERR(hw->rdev[i]);
+		rdev = devm_regulator_register(dev, &hw->desc[i], &config);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
 	}
 
 	return 0;
-- 
2.20.1

