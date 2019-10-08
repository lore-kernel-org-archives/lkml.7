Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE28C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4573C21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570531977;
	bh=LejxuiKyL/Kfi8thcDJDj005hQbgz/Ty00Y6oVVPZ6o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fzoxPK/a3jh8vDZ01yTd91AN5fKFf2Zwv87zb8ZEzJQe9VSi0tACYeX9y/BxY/GQU
	 sjvdZyXTuybp13jKHdVMv5CNavY2zUU1CdqDw4OeGC4wve42ifR/W+oDASUxH2q4O9
	 bixMNfbs6eTve/Nj4rWnVNsWIKgVvcn4JYISj9YE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfJHKw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:52:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47658 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbfJHKwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YFJEsHwZa6QwTk57YvfVQd1arCEbyVMTfXhaXNmU/+s=; b=SbbCwzOcw04p
        KM3okTg3ODuQ76hAnJ7AUQBB7J7Y+PrcP/39DQCEY6vXXSvGGS3waGsR5/g7UKDB9KzJc2LlJZg66
        l69AsnyXjkTYKajjx30KdQuSGzLs+VHz/Ot4B5ZZUmfpRr+pxuNkLuj0xUEtexoYOOS+1naUqi/RW
        eoUk4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHn6n-00083V-4Z; Tue, 08 Oct 2019 10:52:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 533392742998; Tue,  8 Oct 2019 11:52:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Tony Xie <tony.xie@rock-chips.com>
Subject: Applied "regulator: rk808: Remove rk817_set_suspend_voltage function" to the regulator tree
In-Reply-To: <20191008010628.8513-3-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20191008105248.533392742998@ypsilon.sirena.org.uk>
Date:   Tue,  8 Oct 2019 11:52:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rk808: Remove rk817_set_suspend_voltage function

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

From 9306a733f8eac86400b9149db6d047dc371e46a2 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 8 Oct 2019 09:06:28 +0800
Subject: [PATCH] regulator: rk808: Remove rk817_set_suspend_voltage function

The implement is exactly the same as rk808_set_suspend_voltage, so just
use rk808_set_suspend_voltage instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20191008010628.8513-3-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index d0d1b868b0cd..5b4003226484 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -411,21 +411,6 @@ static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 				  sel);
 }
 
-static int rk817_set_suspend_voltage(struct regulator_dev *rdev, int uv)
-{
-	unsigned int reg;
-	int sel = regulator_map_voltage_linear(rdev, uv, uv);
-	/* only ldo1~ldo9 */
-	if (sel < 0)
-		return -EINVAL;
-
-	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
-
-	return regmap_update_bits(rdev->regmap, reg,
-				  rdev->desc->vsel_mask,
-				  sel);
-}
-
 static int rk808_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
@@ -708,7 +693,7 @@ static const struct regulator_ops rk817_reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
-	.set_suspend_voltage	= rk817_set_suspend_voltage,
+	.set_suspend_voltage	= rk808_set_suspend_voltage,
 	.set_suspend_enable	= rk817_set_suspend_enable,
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
-- 
2.20.1

