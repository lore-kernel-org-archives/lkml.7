Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C6BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3404217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565296440;
	bh=a8TRy6hXAdZBhIN2BLeFWvN68f+JdPjGFdAx+e/AhPg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RWpdBty8JqBG9DmBAxJRj5BdH+C/6iCvgeV0BgWR9sL6cRCC1c0NXRjlvw3NgwbWp
	 6w+ZBlnsrCYANOoDSNlotiVfoJULPVxqdV5xj1GYI5/UF7BO9RtNj1eEA1ZeqOPLsj
	 M2uQNzQmmCSeANtQ0UDDBagD80GrVxnTd3KmEJUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfHHUd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:33:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59050 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389974AbfHHUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3voCnN8Of2ynwHx3MJQutd/Kh6zmjomsglAokxWqF50=; b=kBASezOYADPm
        QYgTaKLM+so3/xAdMW2ssjpVM3exxEVTIEbGJZC6PIti3jaAJ1SLT6bEXMe2CxsGrBgeZ4opj6IDx
        UC2Mb1op+Uuw7FGCqhv90naiG3X7Wa8TgCTxNwY+NrhNj1g0aF1WTMBMRdXnDDgE4VQ2kRsW4pyw2
        IQCF4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvp6c-00042n-4T; Thu, 08 Aug 2019 20:33:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8CD7D2742B42; Thu,  8 Aug 2019 21:33:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Eric Jeong <eric.jeong.opensource@diasemi.com>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: slg51000: Fix a couple NULL vs IS_ERR() checks" to the regulator tree
In-Reply-To: <20190808103335.GD30506@mwanda>
X-Patchwork-Hint: ignore
Message-Id: <20190808203349.8CD7D2742B42@ypsilon.sirena.org.uk>
Date:   Thu,  8 Aug 2019 21:33:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: slg51000: Fix a couple NULL vs IS_ERR() checks

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

From 7352e72a513fd2757b2fda695a349d86faa4c94e Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 8 Aug 2019 13:33:35 +0300
Subject: [PATCH] regulator: slg51000: Fix a couple NULL vs IS_ERR() checks

The devm_gpiod_get_from_of_node() function never returns NULL, it
returns error pointers on error.

Fixes: a867bde3dd03 ("regulator: slg51000: add slg51000 regulator driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20190808103335.GD30506@mwanda
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/slg51000-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 04b732991d69..4d859fef55e6 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -205,7 +205,7 @@ static int slg51000_of_parse_cb(struct device_node *np,
 	ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
 						"enable-gpios", 0,
 						gflags, "gpio-en-ldo");
-	if (ena_gpiod) {
+	if (!IS_ERR(ena_gpiod)) {
 		config->ena_gpiod = ena_gpiod;
 		devm_gpiod_unhinge(chip->dev, config->ena_gpiod);
 	}
@@ -459,7 +459,7 @@ static int slg51000_i2c_probe(struct i2c_client *client,
 					       GPIOD_OUT_HIGH
 					       | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 					       "slg51000-cs");
-	if (cs_gpiod) {
+	if (!IS_ERR(cs_gpiod)) {
 		dev_info(dev, "Found chip selector property\n");
 		chip->cs_gpiod = cs_gpiod;
 	}
-- 
2.20.1

