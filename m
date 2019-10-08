Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E7521721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570558194;
	bh=ROAVXmZ1zboSWjlEfvdW4buzP9CBjiQUyqFGG5ko3tA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fLvA7OyLmwQzuWpmafB4hlK/cOWF9Dd++VyrM/vcmAi7pGJlOoEp8j2HA4mfb0yHX
	 PnAa/wB79yUt4whlCf+maCn8bWsMCDito0nqnA2RPSzwm6V+SCPLn8zBiD/XyUlcXN
	 Tc27eBeMSYsHdwcFf2Q12O7hkwul7yiaIYA3DZZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfJHSJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:09:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfJHSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+Dvvoc3YuVgVEFz79dHTriNBh+K4146BDY8Dg6c/esE=; b=BVyeHBbYCsaf
        59qkMt908qhsOcGnl5ps7S3yOr6Vh6nDwIHI4KFC5H7y0gNmUipOkCVqGiHIeEer5SL0peLeEvUeK
        Ywda2M6MDed4n9fDx4SjZc5cA9HIO6uN/QAg/MIQr/0K1So2K+6HbtCZLDuNyUw3P9y3B/i0Gsba9
        Bri6s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHtvh-0000os-Kr; Tue, 08 Oct 2019 18:09:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1F66F2740D4A; Tue,  8 Oct 2019 19:09:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9062: Simplify da9062_buck_set_mode for BUCK_MODE_MANUAL case" to the regulator tree
In-Reply-To: <20191007115009.25672-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20191008180949.1F66F2740D4A@ypsilon.sirena.org.uk>
Date:   Tue,  8 Oct 2019 19:09:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: Simplify da9062_buck_set_mode for BUCK_MODE_MANUAL case

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

From be446f183ae35a8c76687ea8203fdd86f3f9678e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 7 Oct 2019 19:50:09 +0800
Subject: [PATCH] regulator: da9062: Simplify da9062_buck_set_mode for
 BUCK_MODE_MANUAL case

The sleep flag bit decides the mode for BUCK_MODE_MANUAL case, simplify
the logic as the result is the same.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Link: https://lore.kernel.org/r/20191007115009.25672-2-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 9bb895006455..4b24518f75b5 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -136,7 +136,7 @@ static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	unsigned int val, mode = 0;
+	unsigned int val;
 	int ret;
 
 	ret = regmap_field_read(regl->mode, &val);
@@ -146,7 +146,6 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 	switch (val) {
 	default:
 	case BUCK_MODE_MANUAL:
-		mode = REGULATOR_MODE_FAST | REGULATOR_MODE_STANDBY;
 		/* Sleep flag bit decides the mode */
 		break;
 	case BUCK_MODE_SLEEP:
@@ -162,11 +161,9 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 		return 0;
 
 	if (val)
-		mode &= REGULATOR_MODE_STANDBY;
+		return REGULATOR_MODE_STANDBY;
 	else
-		mode &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_FAST;
-
-	return mode;
+		return REGULATOR_MODE_FAST;
 }
 
 /*
-- 
2.20.1

