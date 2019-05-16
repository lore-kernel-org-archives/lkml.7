Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA0C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2E620862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558029795;
	bh=S8ynVM12dXyvZs2XB/HsTYoq2nNUp785cTeSlggElfk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=K9FxOzUNHG+BKWW/Gn1SuucIvMyyDk6G+YYSbQ7gKN8tZFvgETrXl5M5hYxECOJdu
	 KHcNS03TIuniW77x9njXU3Fgrhx6z5VsNlFtw4CZT0nwBrebcw8BsyCzHV6A2KsQna
	 dEST5qRYRO6Fn2WuppqZrtm1lLICRPqNdoBqpAvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfEPSDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:03:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44716 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEPSDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AAiegTltAZt+Z5wgi7jYPMjhxUiVL7eonbcP8iKiC74=; b=D3Z96axFu7Dy
        /BS52TeN5pF4vLfs8u+klMVykTij0V+GiSyyQ2EhAa58ppf3FLdGsPqsKB/+6MUckUqguFVen/k6B
        NYLWU98xL3YDED9kfYs75Km4WI5wUPknsWCYCig533FN3SNredaMMtFalzMGUpUsmHgo2iTs7pjEp
        cm++U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hRKii-00085y-WD; Thu, 16 May 2019 18:03:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1F99D112929C; Thu, 16 May 2019 19:03:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: Applied "regulator: tps6507x: Fix boot regression due to testing wrong init_data pointer" to the regulator tree
In-Reply-To: <20190516124808.3335-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190516180305.1F99D112929C@debutante.sirena.org.uk>
Date:   Thu, 16 May 2019 19:03:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps6507x: Fix boot regression due to testing wrong init_data pointer

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

From 7d293f56456120efa97c4e18250d86d2a05ad0bd Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 16 May 2019 20:48:08 +0800
Subject: [PATCH] regulator: tps6507x: Fix boot regression due to testing wrong
 init_data pointer

A NULL init_data once incremented will lead to oops, fix it.

Fixes: f979c08f7624 ("regulator: tps6507x: Convert to regulator core's simplified DT parsing code")
Reported-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Tested-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps6507x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index a1b7fab91dd4..d2a8f69b2665 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -403,12 +403,12 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 	/* common for all regulators */
 	tps->mfd = tps6507x_dev;
 
-	for (i = 0; i < TPS6507X_NUM_REGULATOR; i++, info++, init_data++) {
+	for (i = 0; i < TPS6507X_NUM_REGULATOR; i++, info++) {
 		/* Register the regulators */
 		tps->info[i] = info;
-		if (init_data && init_data->driver_data) {
+		if (init_data && init_data[i].driver_data) {
 			struct tps6507x_reg_platform_data *data =
-					init_data->driver_data;
+					init_data[i].driver_data;
 			info->defdcdc_default = data->defdcdc_default;
 		}
 
-- 
2.20.1

