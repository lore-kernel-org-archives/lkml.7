Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7230DC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A0A2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568213995;
	bh=8hPjscA2LsEymf0YlCe+fSgepmm4iyh6RfoTRwAMQ2U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qA7IU7czCz3D5czyJAzu8RwJ9cb2EYVLWD1Hl+W/bjf1S0roz/ysjApfL4O4pG3jm
	 ZxYYQJI+PmvuvLmT2Bg2TSp1RjRwqN4zIYqqP+JlGNuFjUiB/8NvsILfY4MpX6COgQ
	 da+amydq7jaG141CI2oqZWNwDwUqkT2qFCpadZ/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfIKO7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:59:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52578 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfIKO7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+LCtvPkRaLtCqEGPGQaTACYlF+XbHu00PNm28XP+sLI=; b=biDUhq1P7Ytu
        ucR62zwj/jmMvqM1jV2aMMebsORz/iRXwSa/2vrwcQ7DRYMzKQd8muSPZuExUY1rB50WikXHtQMdj
        DIxi7SbQTcFjY1iYr9nfEMY3B3WwDEtFyKvHeB6cxSeURMSVocIl+nX+hXYeVGETqtV79Dbg3ihHO
        oRYuA=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i845z-0001jK-GJ; Wed, 11 Sep 2019 14:59:47 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id CC382D00486; Wed, 11 Sep 2019 15:59:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max77686: fix obtaining "maxim,ena" GPIO" to the regulator tree
In-Reply-To: <20190910170050.GA55530@dtor-ws>
X-Patchwork-Hint: ignore
Message-Id: <20190911145946.CC382D00486@fitzroy.sirena.org.uk>
Date:   Wed, 11 Sep 2019 15:59:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77686: fix obtaining "maxim,ena" GPIO

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

From 2418f749641caa59d5bc01b66ba16ec5414b28dc Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Sep 2019 10:00:50 -0700
Subject: [PATCH] regulator: max77686: fix obtaining "maxim,ena" GPIO

This fixes 96392c3d8ca4, as devm_gpiod_get_from_of_node() does
not do translation "con-id" -> "con-id-gpios" that our bindings expects,
and therefore it was wrong to change connection ID to be simply
"maxim,ena" when moving to using devm_gpiod_get_from_of_node().

Fixes: 96392c3d8ca4 ("regulator: max77686: Pass descriptor instead of GPIO number")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20190910170050.GA55530@dtor-ws
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77686-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index 8020eb57374a..c8e579e99316 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -257,7 +257,7 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
 		config->ena_gpiod = gpiod_get_from_of_node(np,
-				"maxim,ena",
+				"maxim,ena-gpios",
 				0,
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 				"max77686-regulator");
-- 
2.20.1

