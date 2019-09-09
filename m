Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36640C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B7821A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568023677;
	bh=XnpdOvNxtEE8X28vFgjJ6m4Qz6m4Tn6qujf1i3oUNNg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=M7yf2XyM5qdsbmRtas7u/BjpPx5gamSRsvo3NhMdmPtdVLNmvIY1qLo30R7+qrHuY
	 gemrWrxV1EM4X3xP7HLBHurLtn7YY0x28c/uYoCxt4ipWvPkJlLOHaeVdHjVSQ0/u0
	 0875o/NK48VfARfRr3ZD91GY8hf8ZAdwWVD4emTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfIIKH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:07:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbfIIKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zt/n4eTpMG9sUtHcd96OLuRnzRxpm+JT0DN15WfWCf4=; b=i7BuxHtRk6Sa
        iRDp2uZEvLGrY0pa8cfnzwjY9VOGIuYSM6mxUla7k84MFaKCaBytxLhCwojfVdvng6476uUOKAycv
        2aUfz5YNtiTgmOz3AOn1wRymCyc5nFXe5mAu5Z2AFMLH+URQsA0GtCuVXWgmpU0rHIUeE+ZyiwieS
        urfRc=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7GZv-0001tm-7Q; Mon, 09 Sep 2019 10:07:23 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A00A9D02D18; Mon,  9 Sep 2019 11:07:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        support.opensource@diasemi.com
Subject: Applied "regulator: slg51000: use devm_gpiod_get_optional() in probe" to the regulator tree
In-Reply-To: <20190904214200.GA66118@dtor-ws>
X-Patchwork-Hint: ignore
Message-Id: <20190909100722.A00A9D02D18@fitzroy.sirena.org.uk>
Date:   Mon,  9 Sep 2019 11:07:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: slg51000: use devm_gpiod_get_optional() in probe

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

From c0b913447b75538c3cf4b8016fd2e06509895020 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 4 Sep 2019 14:42:00 -0700
Subject: [PATCH] regulator: slg51000: use devm_gpiod_get_optional() in probe

The CS GPIO line is clearly optional GPIO (and marked as such in the
binding document) and we should handle it accordingly. The current code
treats all errors as meaning that there is no GPIO defined, which is
wrong, as it does not handle deferrals raised by the underlying code
properly, nor does it recognize non-existing GPIO from any other
initialization error.

As far as I can see the only reason the driver, unlike all others,
is using OF-specific devm_gpiod_get_from_of_node() so that it can
assign a custom label to the selected GPIO line. Given that noone else
needs that, it should not be doing that either.

Let's switch to using more appropriate devm_gpiod_get_optional().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20190904214200.GA66118@dtor-ws
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/slg51000-regulator.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 4d859fef55e6..a0565daecace 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -447,19 +447,20 @@ static int slg51000_i2c_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct slg51000 *chip;
-	struct gpio_desc *cs_gpiod = NULL;
+	struct gpio_desc *cs_gpiod;
 	int error, ret;
 
 	chip = devm_kzalloc(dev, sizeof(struct slg51000), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	cs_gpiod = devm_gpiod_get_from_of_node(dev, dev->of_node,
-					       "dlg,cs-gpios", 0,
-					       GPIOD_OUT_HIGH
-					       | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
-					       "slg51000-cs");
-	if (!IS_ERR(cs_gpiod)) {
+	cs_gpiod = devm_gpiod_get_optional(dev, "dlg,cs",
+					   GPIOD_OUT_HIGH |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	if (IS_ERR(cs_gpiod))
+		return PTR_ERR(cs_gpiod);
+
+	if (cs_gpiod) {
 		dev_info(dev, "Found chip selector property\n");
 		chip->cs_gpiod = cs_gpiod;
 	}
-- 
2.20.1

