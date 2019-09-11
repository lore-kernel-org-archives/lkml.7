Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4245FC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114542089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568213992;
	bh=FgP9qNk2W9ug9kkS2vJdQQo9Yc4zKBbrX+sJ6T5+HSM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YPdQjHmcYLppoG3gGZsnP+JtE2OFbevHSGdOxmdXkoPx4kIusnz7xaI+/6VTkdRr9
	 titqySs8BrDdDeP5VcJZs4UyviYnGH9OxXKr3bHLz4yzGSh2j+/CMxa6J99JnWhbnv
	 cDXAqjBELcri/mZyLo9mgZcfXphkGUY0RX9I4dds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfIKO7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:59:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfIKO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=G+6Uom3Bv65G61lK/1b3yVshdCbjKqe0iDzvqpIwYuQ=; b=baYyBlvPsTTL
        sWJnDUu9NrQvB3XlkRtdP8+//niLhl8B7fPWlR5+V0r1jmpAvsHc+Ko1Fpe1AvRH6yxYCNvnXUuOc
        rCt3KhMgyvEwbAkTSFc+2W7dYSD9ASToFpO900B0Wb3n333crfMm/boiw/7zJYarJZM66LoHit8o6
        aWMUM=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i845z-0001jJ-EY; Wed, 11 Sep 2019 14:59:47 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B90ECD0046D; Wed, 11 Sep 2019 15:59:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9211: fix obtaining "enable" GPIO" to the regulator tree
In-Reply-To: <20190910170246.GA56792@dtor-ws>
X-Patchwork-Hint: ignore
Message-Id: <20190911145946.B90ECD0046D@fitzroy.sirena.org.uk>
Date:   Wed, 11 Sep 2019 15:59:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9211: fix obtaining "enable" GPIO

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

From 5eda8e95b7922cb9dd1343f7beece3cd78565216 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Sep 2019 10:02:46 -0700
Subject: [PATCH] regulator: da9211: fix obtaining "enable" GPIO

This fixes 11da04af0d3b, as devm_gpiod_get_from_of_node() does
not do translation "con-id" -> "con-id-gpios" that our bindings expects,
and therefore it was wrong to change connection ID to be simply "enable"
when moving to using devm_gpiod_get_from_of_node().

Fixes: 11da04af0d3b ("regulator: da9211: Pass descriptors instead of GPIO numbers")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20190910170246.GA56792@dtor-ws
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9211-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 0309823d2c72..bf80748f1ccc 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -285,7 +285,7 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
 		pdata->reg_node[n] = da9211_matches[i].of_node;
 		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
 				  da9211_matches[i].of_node,
-				  "enable",
+				  "enable-gpios",
 				  0,
 				  GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 				  "da9211-enable");
-- 
2.20.1

