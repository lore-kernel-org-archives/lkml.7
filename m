Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E0BC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95C12133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930150;
	bh=rjp4iifqPBRRvW8ES5IfH1e+FBL6RFvWzC9ey9yNeXw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Yi6l15MMeeXco24pPne48utK3XMa+IkY//6rYFbxgv/F8UEh3a/Urqrgx8LknTKND
	 EVCHf/Wy6NtyLAZfzestbKOrAmaQCran+R7hAowNFjBMbKZ9dOEwTWCjAyirEuzdQJ
	 k6k8HiZg14rCIgIgDPjUow6Gw+O90q2gHqkxHKJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfJALm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:42:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbfJALlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dH/v3FdfsuuzHHtKYk8U5TeddpOlvyfMmEh5ohyVa1E=; b=BP8Wi0LKs6g4
        vgBpmYJ5+zPjTsYg9+T6y5rqEI/+x1lbmmh1C2K+HmukcTvCLAECaGvBoiEm6Vf9nueI1a4Gf3gn8
        Q1b9BREwsfTInkT0SFusMzfW3Ra4sV+fYF4jKb79zdjewzdLO6k9PLEhhoH6HPcmInwr35SNEFfgt
        SWIWY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWY-0004XD-O2; Tue, 01 Oct 2019 11:40:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3B43A27429C0; Tue,  1 Oct 2019 12:40:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9063: Simplify da9063_buck_set_mode for BUCK_MODE_MANUAL case" to the regulator tree
In-Reply-To: <20190926055128.23434-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114058.3B43A27429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: Simplify da9063_buck_set_mode for BUCK_MODE_MANUAL case

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

From e62cb0e0002ceb1a761b4dd7bb6a2bfc77a1ae77 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 26 Sep 2019 13:51:28 +0800
Subject: [PATCH] regulator: da9063: Simplify da9063_buck_set_mode for
 BUCK_MODE_MANUAL case

The sleep flag bit decides the mode for BUCK_MODE_MANUAL case, simplify
the logic as the result is the same.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Link: https://lore.kernel.org/r/20190926055128.23434-2-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 28b1b20f45bd..2aceb3b7afc2 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -225,7 +225,7 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
 	struct regmap_field *field;
-	unsigned int val, mode = 0;
+	unsigned int val;
 	int ret;
 
 	ret = regmap_field_read(regl->mode, &val);
@@ -235,7 +235,6 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
 	switch (val) {
 	default:
 	case BUCK_MODE_MANUAL:
-		mode = REGULATOR_MODE_FAST | REGULATOR_MODE_STANDBY;
 		/* Sleep flag bit decides the mode */
 		break;
 	case BUCK_MODE_SLEEP:
@@ -262,11 +261,9 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
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

