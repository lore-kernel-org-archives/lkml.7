Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19496C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2AE2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864653;
	bh=RC1DNti1NMiEre8qjNGRqYDMkXZG/x2c2KWL9kQ7siI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Nykm6N0e5t0FyAZlqCZKsCNB49qfsQLIT7FwWkMI9p8sfHLYhtjvfv9w+k//mgtcN
	 Bqw/Wykaqh+o3g7H6AG6XyEPBnkn+Ly0XtdPp1kvec+KflzSJf0mjpm6xrSt6S9dIG
	 dJ6DkBdRty+iLmhCS4RoYnZoYt6L9mxqxKXzubaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfECGYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:24:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33808 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfECGXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Gkp2AltP4W1gkJLI9fh3u2b0qzsdnHwlasfeXfRpDcw=; b=jYjeS82pd8Mp
        F5A9px8eGs40NFiTwq0OmPffyo1Sr2ddjiGy4xleOeHZClwIyP7RSgSELlqcjojAeSvMOiXehqtA6
        gGvLvSQzjx79aHUMK83zxk6l3GOspmHjD3hlpe+xIq0RacRZICZxat+7u2hgZwYUYSAAzsoLjjMwm
        oXhHQ=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRbh-0000lU-Iv; Fri, 03 May 2019 06:23:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D06EA441D56; Fri,  3 May 2019 07:23:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Pascal Paillet <p.paillet@st.com>
Subject: Applied "regulator: stm32-pwr: Remove unneeded *desc from struct stm32_pwr_reg" to the regulator tree
In-Reply-To: <20190430111346.23427-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503062337.D06EA441D56@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:23:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stm32-pwr: Remove unneeded *desc from struct stm32_pwr_reg

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

From 7bcbdbe01fa82712f8fece2a07ea30758b76403d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 30 Apr 2019 19:13:45 +0800
Subject: [PATCH] regulator: stm32-pwr: Remove unneeded *desc from struct
 stm32_pwr_reg

Just use rdev->desc instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stm32-pwr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 7b39a41530d4..8bd15e4d2cea 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -40,7 +40,6 @@ static u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
 
 struct stm32_pwr_reg {
 	void __iomem *base;
-	const struct regulator_desc *desc;
 	u32 ready_mask;
 };
 
@@ -61,7 +60,7 @@ static int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
 
 	val = readl_relaxed(priv->base + REG_PWR_CR3);
 
-	return (val & priv->desc->enable_mask);
+	return (val & rdev->desc->enable_mask);
 }
 
 static int stm32_pwr_reg_enable(struct regulator_dev *rdev)
@@ -71,7 +70,7 @@ static int stm32_pwr_reg_enable(struct regulator_dev *rdev)
 	u32 val;
 
 	val = readl_relaxed(priv->base + REG_PWR_CR3);
-	val |= priv->desc->enable_mask;
+	val |= rdev->desc->enable_mask;
 	writel_relaxed(val, priv->base + REG_PWR_CR3);
 
 	/* use an arbitrary timeout of 20ms */
@@ -90,7 +89,7 @@ static int stm32_pwr_reg_disable(struct regulator_dev *rdev)
 	u32 val;
 
 	val = readl_relaxed(priv->base + REG_PWR_CR3);
-	val &= ~priv->desc->enable_mask;
+	val &= ~rdev->desc->enable_mask;
 	writel_relaxed(val, priv->base + REG_PWR_CR3);
 
 	/* use an arbitrary timeout of 20ms */
@@ -153,7 +152,6 @@ static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 		if (!priv)
 			return -ENOMEM;
 		priv->base = base;
-		priv->desc = &stm32_pwr_desc[i];
 		priv->ready_mask = ready_mask_table[i];
 		config.driver_data = priv;
 
-- 
2.20.1

