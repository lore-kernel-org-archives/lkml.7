Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EF52081B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568031805;
	bh=j+nJAObCnTMbStMf0Ed0gMHQwTL69m4fItnMMBq3cXw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Ntx3IvAAnm8Gdd2+oG0dh9AFYY1F3mAbIW9XFC7NHowMsdspwKMlKF4363CSZqzqQ
	 tQGBIjDviVRDOmpAQOA+oW2u2tcRu4tjzQUCYgzzBGc26Mrb/gkLjtKHERgTwAunly
	 E+cVoIvv1FcRP6UEDdrm65WsB42eS86gOPq1KpT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404863AbfIIMXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:23:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58958 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfIIMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=g2Kl09/G8KmBIkN8NIh1/fww/rzbJVZdQXmIM8fX1Zw=; b=CHPumrqgM0Cz
        +jJDrrtUXXEPXJELpNV654D9GqzTZYmk9HGir9R5tqphnF4UP3wz/c40MuH2mZ2cBJ/0Q8djh9fpF
        Hu4k+LA46j478UYNTDAU72CqQaWB7N6sk+UN5bhYq+/QVBG1F5kFgvILUL0Gcxx45TumRhqGqhldf
        f7gtU=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7IhS-0002Iv-MM; Mon, 09 Sep 2019 12:23:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 0F1E0D02D4C; Mon,  9 Sep 2019 13:23:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: lp87565: Simplify lp87565_buck_set_ramp_delay" to the regulator tree
In-Reply-To: <20190908035720.17748-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190909122318.0F1E0D02D4C@fitzroy.sirena.org.uk>
Date:   Mon,  9 Sep 2019 13:23:18 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp87565: Simplify lp87565_buck_set_ramp_delay

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

From 6cadd8ae213678be654042ff8655630d84272ec3 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 8 Sep 2019 11:57:20 +0800
Subject: [PATCH] regulator: lp87565: Simplify lp87565_buck_set_ramp_delay

Use rdev->regmap/&rdev->dev instead of lp87565->regmap/lp87565->dev.
In additional, the lp87565->dev actually is the parent mfd device,
so the dev_err message is misleading here with lp87565->dev.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20190908035720.17748-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp87565-regulator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 0c440c5e2832..4ae12ac1f4c6 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -65,7 +65,6 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 				       int ramp_delay)
 {
 	int id = rdev_get_id(rdev);
-	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
 	unsigned int reg;
 	int ret;
 
@@ -86,11 +85,11 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 	else
 		reg = 0;
 
-	ret = regmap_update_bits(lp87565->regmap, regulators[id].ctrl2_reg,
+	ret = regmap_update_bits(rdev->regmap, regulators[id].ctrl2_reg,
 				 LP87565_BUCK_CTRL_2_SLEW_RATE,
 				 reg << __ffs(LP87565_BUCK_CTRL_2_SLEW_RATE));
 	if (ret) {
-		dev_err(lp87565->dev, "SLEW RATE write failed: %d\n", ret);
+		dev_err(&rdev->dev, "SLEW RATE write failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.20.1

