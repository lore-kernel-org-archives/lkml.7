Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC981ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF8A21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453401;
	bh=gaERUu+cKPWlbOgduYLKXf6A64/OujSpGW/6owAlaUM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=tJ2Tni9JNGdwHu5mtpDQH9zcG85kZdzCEpE6b0LRXefUNuq95Wt4FkycXP4rtmh3F
	 PwigVxlKzGbGFRiwNXZIbmXORcA+5hkKyJ3jYt048yRxylv8AFCAaC7NEUgiBgz3Pd
	 D/w+UzXVpDhWpFLu5XQdKmrNtCkYGzc7WNjFqvdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfJGNDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49190 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbfJGNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eryxZ1j8gq/X+jqZu0cElGs7mecbogDpCNSvnUCKXIY=; b=TIKAHVPv2FPO
        c5XlivfXZPz53XukIN77SWX3na2DSy+gMMDQPmU5pG/bGhSFWYQVzIoPeSaxM+T8AtxGWDJE+ywEp
        EJblZaoNZmnlIweHbXADA6J815focu66yxiyy3+fJVcrGTQ6AqTx5/q6R8pq+L/CQs8NiCxXlz37Q
        BCsCE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfU-0003RZ-OF; Mon, 07 Oct 2019 13:03:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3B36E2741EF0; Mon,  7 Oct 2019 14:03:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9211: switch to using devm_fwnode_gpiod_get" to the regulator tree
In-Reply-To: <20191004231017.130290-6-dmitry.torokhov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007130316.3B36E2741EF0@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9211: switch to using devm_fwnode_gpiod_get

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

From 61d2fc3cf8f557193c8c362ea75f06fa5a0abcfe Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 4 Oct 2019 16:10:15 -0700
Subject: [PATCH] regulator: da9211: switch to using devm_fwnode_gpiod_get

devm_gpiod_get_from_of_node() is being retired in favor of
devm_fwnode_gpiod_get_index(), that behaves similar to
devm_gpiod_get_index(), but can work with arbitrary firmware node. It
will also be able to support secondary software nodes.

Let's switch this driver over.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Link: https://lore.kernel.org/r/20191004231017.130290-6-dmitry.torokhov@gmail.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9211-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index bf80748f1ccc..523dc1b95826 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -283,12 +283,12 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
 
 		pdata->init_data[n] = da9211_matches[i].init_data;
 		pdata->reg_node[n] = da9211_matches[i].of_node;
-		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
-				  da9211_matches[i].of_node,
-				  "enable-gpios",
-				  0,
-				  GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
-				  "da9211-enable");
+		pdata->gpiod_ren[n] = devm_fwnode_gpiod_get(dev,
+					of_fwnode_handle(pdata->reg_node[n]),
+					"enable",
+					GPIOD_OUT_HIGH |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+					"da9211-enable");
 		if (IS_ERR(pdata->gpiod_ren[n]))
 			pdata->gpiod_ren[n] = NULL;
 		n++;
-- 
2.20.1

