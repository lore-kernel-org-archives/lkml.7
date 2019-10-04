Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3064CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D232222CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570211570;
	bh=RJpqncNz1KHw9uMFjYmeiWDKtb/hqm2wH99odyACv3o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JHFA6mA5sl6f3CvCYLkwWZyFN2K5KA10CjaOELwgKQTzD2Y62AR16XmT/I+TxvQWc
	 7M3lFTsqXGmSLR8QUVouLawfhu/R469bxtayYFRX/YzbKKP3lZHDLbHHmIlrRPiF1e
	 Frbs0+qlgRFi7hBqvTBvAZNj/LNUMeD0wqX+EV0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbfJDRws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:52:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51008 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388643AbfJDRws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OHEeUE0SSoaNVUapw+tZEBpcTGS3QVSsO8YGo6q6aDY=; b=XPZ7k3PRN4Qa
        HO2iEQZCIDk4tBsqW2WZu/u514X3Ie/Qnn8UET6cDjh9+OBtAFTfWyeV+sjnquot42vwDy6xCRUgt
        eD+duwUvTBB2diF4e8KZhHFJ6qMxpvYn1e7MHBCxKw+2jovEboSAdHsLxR3KdR4dF9SDL8vAGUfbW
        R0xw0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iGRkx-0003wO-GE; Fri, 04 Oct 2019 17:52:43 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0BD252741EF0; Fri,  4 Oct 2019 18:52:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     "Cc:"@sirena.co.uk, "Cc:"@sirena.co.uk, csong@cs.ucr.edu,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        zhiyunq@cs.ucr.edu
Subject: Applied "regulator: max8907: Fix the usage of uninitialized variable in max8907_regulator_probe()" to the regulator tree
In-Reply-To: <20191003175813.16415-1-yzhai003@ucr.edu>
X-Patchwork-Hint: ignore
Message-Id: <20191004175243.0BD252741EF0@ypsilon.sirena.org.uk>
Date:   Fri,  4 Oct 2019 18:52:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8907: Fix the usage of uninitialized variable in max8907_regulator_probe()

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

From 472b39c3d1bba0616eb0e9a8fa3ad0f56927c7d7 Mon Sep 17 00:00:00 2001
From: Yizhuo <yzhai003@ucr.edu>
Date: Thu, 3 Oct 2019 10:58:13 -0700
Subject: [PATCH] regulator: max8907: Fix the usage of uninitialized variable
 in max8907_regulator_probe()

Inside function max8907_regulator_probe(), variable val could
be uninitialized if regmap_read() fails. However, val is used
later in the if statement to decide the content written to
"pmic", which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Link: https://lore.kernel.org/r/20191003175813.16415-1-yzhai003@ucr.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8907-regulator.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index 76152aaa330b..96dc0eea7659 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -296,7 +296,10 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 	memcpy(pmic->desc, max8907_regulators, sizeof(pmic->desc));
 
 	/* Backwards compatibility with MAX8907B; SD1 uses different voltages */
-	regmap_read(max8907->regmap_gen, MAX8907_REG_II2RR, &val);
+	ret = regmap_read(max8907->regmap_gen, MAX8907_REG_II2RR, &val);
+	if (ret)
+		return ret;
+
 	if ((val & MAX8907_II2RR_VERSION_MASK) ==
 	    MAX8907_II2RR_VERSION_REV_B) {
 		pmic->desc[MAX8907_SD1].min_uV = 637500;
@@ -333,14 +336,20 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 		}
 
 		if (pmic->desc[i].ops == &max8907_ldo_ops) {
-			regmap_read(config.regmap, pmic->desc[i].enable_reg,
+			ret = regmap_read(config.regmap, pmic->desc[i].enable_reg,
 				    &val);
+			if (ret)
+				return ret;
+
 			if ((val & MAX8907_MASK_LDO_SEQ) !=
 			    MAX8907_MASK_LDO_SEQ)
 				pmic->desc[i].ops = &max8907_ldo_hwctl_ops;
 		} else if (pmic->desc[i].ops == &max8907_out5v_ops) {
-			regmap_read(config.regmap, pmic->desc[i].enable_reg,
+			ret = regmap_read(config.regmap, pmic->desc[i].enable_reg,
 				    &val);
+			if (ret)
+				return ret;
+
 			if ((val & (MAX8907_MASK_OUT5V_VINEN |
 						MAX8907_MASK_OUT5V_ENSRC)) !=
 			    MAX8907_MASK_OUT5V_ENSRC)
-- 
2.20.1

