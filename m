Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C41ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873222070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453454;
	bh=99+/3sDH7FyyAumF9slNub8DkOxbOvjPW0RmwKQ5dxc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=noTRTiaYpcQUEMofS7ABGSvgz19dUNH/NXuV2CffQm731SekcvzTYdVSkdWdaQCe3
	 bfMmjYsWK4bhblCm0BDkLojcNut4gbhUZkDQtSIwgCs780VqXCbzMZdIeCIZmGg1be
	 vwIQV1ekY1N0oLfEbZyfvwI6Zx4rg6daW+khNjpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfJGNEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:04:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfJGNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DU5fckPym4ukfja1ev2Ad3lC+NNCZz8yfpvWiknS2lI=; b=cVKn4po1AWEa
        ChnLB6asEyOWGi5k1Az4gqQeYL+T4mofJsz86JwVTNCeimbbLbLm5rwesgdPY58zM/pCAfLyGlPNk
        KxVvDPPeYcdl30Kh8vMnnvG4UYjfivf6my5Y2DvZyE/tS+KqnzdJc6t04mVQaQ+F8nNiWgOP7bqZH
        WoADw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfU-0003RS-8c; Mon, 07 Oct 2019 13:03:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B0DB8274162F; Mon,  7 Oct 2019 14:03:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max77686: switch to using fwnode_gpiod_get_index" to the regulator tree
In-Reply-To: <20191004231017.130290-8-dmitry.torokhov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007130315.B0DB8274162F@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77686: switch to using fwnode_gpiod_get_index

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

From 0b2ba815fb5cbfab253f175d0b0d0d93d7ab9b5d Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 4 Oct 2019 16:10:17 -0700
Subject: [PATCH] regulator: max77686: switch to using fwnode_gpiod_get_index

gpiod_get_from_of_node() is being retired in favor of
fwnode_gpiod_get_index(), that behaves similar to gpiod_get_index(),
but can work with arbitrary firmware node. It will also be able to
support secondary software nodes.

Let's switch this driver over.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20191004231017.130290-8-dmitry.torokhov@gmail.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77686-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index c8e579e99316..9089ec608fcc 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -256,8 +256,9 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpiod = gpiod_get_from_of_node(np,
-				"maxim,ena-gpios",
+		config->ena_gpiod = fwnode_gpiod_get_index(
+				of_fwnode_handle(np),
+				"maxim,ena",
 				0,
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 				"max77686-regulator");
-- 
2.20.1

