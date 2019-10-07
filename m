Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C3C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF1E21721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453404;
	bh=J+1/oUNp7vzLACk10160rGq19o1p2bmZJ4DmD+f3j/s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2jqvMSQGId/ebH2PX9jGIv9w5PLG9dZu2gX6+Bdg8i1zP0YLKxhlfRhlSFUy8Jwv/
	 Kpl+Ba3vlCzOYF3XJYRX1NpRhzH07I32jE38NZR1Vs1G7LAq2YJDoaHpuu/SHozje1
	 VW4Y0eDWWW6EstbLc4mSrmPd9IXlLm3/7HJLVa74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfJGNDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49206 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfJGNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hb5spqsla5zrA1tWY7uZXe7wvdEuq0jH8VWwfhg2haA=; b=L+u15nNru0U4
        vfGiSosCK2otlLMFfPnVxC5lVR3gfBtpfOZn7/XJR2lAk2Kyvo/jvVu7mPRM7Z01I1rmOl9J2d8Xu
        F7fnDqSYfJNpxztPxC8fK+GBn96ZYfxyKb5hPhw1JWEqRbTA3tvVwyEu7QtD8s+KAb2iVY7tA1tIk
        A+uSU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfV-0003Rr-Ek; Mon, 07 Oct 2019 13:03:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id F0E3C2741EF0; Mon,  7 Oct 2019 14:03:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: slg51000: switch to using fwnode_gpiod_get_index" to the regulator tree
In-Reply-To: <20191004231017.130290-3-dmitry.torokhov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007130316.F0E3C2741EF0@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: slg51000: switch to using fwnode_gpiod_get_index

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

From de2cd1a552673f370f8ea39a0241f764fbcf39e5 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 4 Oct 2019 16:10:12 -0700
Subject: [PATCH] regulator: slg51000: switch to using fwnode_gpiod_get_index

devm_gpiod_get_from_of_node() is being retired in favor of
[devm_]fwnode_gpiod_get_index(), that behaves similar to
devm_gpiod_get_index(), but can work with arbitrary firmware node. It
will also be able to support secondary software nodes.

Let's switch this driver over.

Note that now that we have a good non-devm API for getting GPIO from
arbitrary firmware node, there is no reason to use devm API here as
regulator core takes care of managing lifetime of "enable" GPIO and we
were immediately detaching requested GPIO from devm anyway.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20191004231017.130290-3-dmitry.torokhov@gmail.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/slg51000-regulator.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index a0565daecace..bf1a3508ebc4 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -198,17 +198,14 @@ static int slg51000_of_parse_cb(struct device_node *np,
 				const struct regulator_desc *desc,
 				struct regulator_config *config)
 {
-	struct slg51000 *chip = config->driver_data;
 	struct gpio_desc *ena_gpiod;
-	enum gpiod_flags gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
-						"enable-gpios", 0,
-						gflags, "gpio-en-ldo");
-	if (!IS_ERR(ena_gpiod)) {
+	ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", 0,
+					   GPIOD_OUT_LOW |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+					   "gpio-en-ldo");
+	if (!IS_ERR(ena_gpiod))
 		config->ena_gpiod = ena_gpiod;
-		devm_gpiod_unhinge(chip->dev, config->ena_gpiod);
-	}
 
 	return 0;
 }
-- 
2.20.1

