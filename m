Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFE9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E3F216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563995897;
	bh=cUUy+a+B1QBy1Ylf79j8dA5nYvO7KkGPOUlA6dpTOFk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YFfGcwdoFxNNLvOypeaFRHcfNEaE9JokqmH0jXky6Bw7K9VEjLCz+EDOXSnfAnm8b
	 E7mMuRVeWmyiPszwvaLBIu7OkOdOK5sU6fnTb9mE05MKMPFqSXdPgVzcdG1cSQtUi9
	 6M1ICwm0TQNhbEXtX0TQuYlDvl4rtl6QWwx8wDf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbfGXTSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:18:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34716 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfGXTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tTy5/+/M3pVI1lUjGhlSClg1xxdvNbhQX6OC/ZBOaJs=; b=PWr2AHlizcnQ
        3/MS25b18uecwwYcvHHqvXyrO+t27sRaH8xy3NNUwP+uedjp4vGhAhqdE8TkMt+gma4tgX6bUBcy4
        6SG0DRJOspB5qjFSm6cKV0fINAqVz3rtitad6nqt1gBwslYUhyrpysI9FI38mZIzMi//N75qviJ4c
        vO/ek=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqMlt-0008W1-1t; Wed, 24 Jul 2019 19:17:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8368A27429A0; Wed, 24 Jul 2019 20:17:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        gustavo@embeddedor.com, kernel-janitors@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()' function name" to the asoc tree
In-Reply-To: <20190724052632.30476-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190724191752.8368A27429A0@ypsilon.sirena.org.uk>
Date:   Wed, 24 Jul 2019 20:17:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()' function name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From e8758a5ed2783c417be1f5aab5af9fe4be60956f Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 24 Jul 2019 07:26:32 +0200
Subject: [PATCH] ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()' function
 name

This should be 'wm8955_pll_factors()' instead.
Fix it and use it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190724052632.30476-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8955.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 66a5f1827aa9..9c7e2892c8cb 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -140,7 +140,7 @@ struct pll_factors {
  * to allow rounding later */
 #define FIXED_FLL_SIZE ((1 << 22) * 10)
 
-static int wm8995_pll_factors(struct device *dev,
+static int wm8955_pll_factors(struct device *dev,
 			      int Fref, int Fout, struct pll_factors *pll)
 {
 	u64 Kpart;
@@ -279,7 +279,7 @@ static int wm8955_configure_clocking(struct snd_soc_component *component)
 
 		/* Use the last divider configuration we saw for the
 		 * sample rate. */
-		ret = wm8995_pll_factors(component->dev, wm8955->mclk_rate,
+		ret = wm8955_pll_factors(component->dev, wm8955->mclk_rate,
 					 clock_cfgs[sr].mclk, &pll);
 		if (ret != 0) {
 			dev_err(component->dev,
-- 
2.20.1

