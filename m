Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2C3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157F5218F0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563995886;
	bh=FTIbky2RQh4n4trZB8J028hZOG5yvaFCDH0KTl+rYHY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dGegXyFRbHjuIxEYSmwqLhJby0FNfOyIKWOVq2ePJFtvm6xCgQyBH83P1qncrNnNZ
	 cH+/xxEZGRuW309H199wQSu/B2LnDL55Fzct2rLoAIrXj0rU0gtGgdaa5zBzvhA0ti
	 SmWFMCxdWGrMls3lT02S1WAZOjdH8S2dbLENLWCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfGXTSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:18:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34506 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGXTSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZvaDn2iuFkpUufm9sy0OMnQSAaQSZxJ0Gwy+hLn2UIE=; b=NTGKnuySZtkt
        TysE1tGDvJ9HsFDVURtjonr+J14vGj798LDLiEhReft0rrOA4ngBq2Tx9I37QU0PmnsLUlws2TFru
        oo2u4uDpkrhnI8ASc/9DuQUzW+PR3Ux09G6PTKB2/e9iR/247p02T7sKaV5cXyHhM9GgTssgCcJnZ
        DYf6o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqMlz-000054-FX; Wed, 24 Jul 2019 19:17:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EA01D2742B5D; Wed, 24 Jul 2019 20:17:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: lp87565: Fix probe failure for "ti,lp87565"" to the regulator tree
In-Reply-To: <20190711113517.26077-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190724191758.EA01D2742B5D@ypsilon.sirena.org.uk>
Date:   Wed, 24 Jul 2019 20:17:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp87565: Fix probe failure for "ti,lp87565"

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From a853c0a0b013af3fee0f028cff3c44e275ce9abd Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Jul 2019 19:35:17 +0800
Subject: [PATCH] regulator: lp87565: Fix probe failure for "ti,lp87565"

The "ti,lp87565" compatible string is still in of_lp87565_match_table,
but current code will return -EINVAL because lp87565->dev_type is unknown.
This was working in earlier kernel versions, so fix it.

Fixes: 7ee63bd74750 ("regulator: lp87565: Add 4-phase lp87561 regulator support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20190711113517.26077-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp87565-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 5d067f7c2116..0c440c5e2832 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -163,7 +163,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	struct lp87565 *lp87565 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	int i, min_idx = LP87565_BUCK_0, max_idx = LP87565_BUCK_3;
+	int i, min_idx, max_idx;
 
 	platform_set_drvdata(pdev, lp87565);
 
@@ -182,9 +182,9 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 		max_idx = LP87565_BUCK_3210;
 		break;
 	default:
-		dev_err(lp87565->dev, "Invalid lp config %d\n",
-			lp87565->dev_type);
-		return -EINVAL;
+		min_idx = LP87565_BUCK_0;
+		max_idx = LP87565_BUCK_3;
+		break;
 	}
 
 	for (i = min_idx; i <= max_idx; i++) {
-- 
2.20.1

