Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5A0ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CC22196E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453431;
	bh=bweT3GigMqDyzNDIc1Asz1nkoTKoEQxJ0YFWqWXnK3o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=q5OsEEopYoEllpkIgh2ZjIvR7DPfsaA4J4ZiNLhQtdMQypD2xttwhD+mpPOOGZHuA
	 gkNjjhSdtO/VHCJALl+zTJ8zlacek2CwoZQe8iLsLR2r6uyclakcCFtBaV3bjl9FbO
	 N4KMmEKFjnsDPQl3slvrXIc/O+KxuwKsfpSqiJNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfJGND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49284 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGNDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qq8ZMRWiz8nkAQzcMQF3gjrXhlaP3cAYvdl4PKw/Bgw=; b=OgjLSj6WMEoj
        SUQ9glLy16FT/oZ5dgcloEQ4VrEAbx3BtvFOG+f9WZlz2DEXQxUK2fKsmn3aoeTaKeSwhT+aQclDP
        k2R4t5wc76GF5StvwGfSFfQzchw9iMtdFLuO7ThYokeP2on3Le/KdT6BAUJvHe9KIeExKmg/RBI7A
        CI+P8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfO-0003Qp-UE; Mon, 07 Oct 2019 13:03:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3401B2743178; Mon,  7 Oct 2019 14:03:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     <alsa-devel@alsa-project.org>, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: jz4740: Use of_device_get_match_data()" to the asoc tree
In-Reply-To: <20191004214334.149976-8-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20191007130310.3401B2743178@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:10 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: jz4740: Use of_device_get_match_data()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 67ad656bdd703157154d0db5bf1b35a5a86073b9 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Fri, 4 Oct 2019 14:43:31 -0700
Subject: [PATCH] ASoC: jz4740: Use of_device_get_match_data()

This probe function is only called if the device is backed by a DT node,
so switch this call to of_device_get_match_data() to reduce code size
and simplify a bit. This also avoids needing to reference a potentially
undefined variable because of_device_get_match_data() doesn't need to
know anything beyond the struct device to find the match table.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <alsa-devel@alsa-project.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20191004214334.149976-8-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 13408de34055..d2dab4d24b87 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -503,9 +503,8 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	if (!i2s)
 		return -ENOMEM;
 
-	match = of_match_device(jz4740_of_matches, &pdev->dev);
-	if (match)
-		i2s->version = (enum jz47xx_i2s_version)match->data;
+	i2s->version =
+		(enum jz47xx_i2s_version)of_device_get_match_data(&pdev->dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2s->base = devm_ioremap_resource(&pdev->dev, mem);
-- 
2.20.1

