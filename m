Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AACC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CE821726
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564572603;
	bh=01c++b+75vNLHQsGUvDGqoFCVAlOcpbY5iUDwwzZ7+s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=J6cywImWKV7R6cdriilgz0d344AyfKOQYH5dx1IY1uCkixwCXKz566HsmUOqvyKkQ
	 aw9BZjLKEuDDBRkaTaiDXVbw6IDeOFvxqBs6i3LYex7E5h1OYZsxq/r3y6honlLjft
	 ktin7Z7oQvyXLk0k4A8KA723Z9n09BaaMwkilTCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfGaLaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:30:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34320 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaLaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tz9OrYsm/JIIYaZu0FAWVndUQ54ZCNsvNKCY3ncuXbk=; b=N6PA8EFIsUJy
        su8vlR6Ru8/5cQYPmUszlmF4msTGe+rAnP2cILm7o76udCBkZ2DDfifaVzOqI4JU/UuGSqxl1T2tu
        Fd3GuPCgrG22U6TiNyJfeV57tMot4NB7lLYJTqEG8o/VMnpPu0+7AmElzXwzvFi+vy2EwML/skXHM
        vTnwo=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsmni-0001md-Eh; Wed, 31 Jul 2019 11:29:46 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A62C72742CDE; Wed, 31 Jul 2019 12:29:45 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, brian.austin@cirrus.com,
        broonie@kernel.org, kernel-janitors@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: cs4271: Fix a typo in the CS4171_NR_RATIOS" to the asoc tree
In-Reply-To: <20190724060023.31302-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190731112945.A62C72742CDE@ypsilon.sirena.org.uk>
Date:   Wed, 31 Jul 2019 12:29:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs4271: Fix a typo in the CS4171_NR_RATIOS

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

From 0c03e37af47efcb8600f95f399783c082fcf2f93 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 24 Jul 2019 08:00:23 +0200
Subject: [PATCH] ASoC: cs4271: Fix a typo in the CS4171_NR_RATIOS

This should be CS4271_NR_RATIOS.
Fix it and use it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190724060023.31302-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4271.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 1d03a1348162..04b86a51e055 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -334,7 +334,7 @@ static struct cs4271_clk_cfg cs4271_clk_tab[] = {
 	{0, CS4271_MODE1_MODE_4X, 256,  CS4271_MODE1_DIV_2},
 };
 
-#define CS4171_NR_RATIOS ARRAY_SIZE(cs4271_clk_tab)
+#define CS4271_NR_RATIOS ARRAY_SIZE(cs4271_clk_tab)
 
 static int cs4271_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
@@ -383,13 +383,13 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 		val = CS4271_MODE1_MODE_4X;
 
 	ratio = cs4271->mclk / cs4271->rate;
-	for (i = 0; i < CS4171_NR_RATIOS; i++)
+	for (i = 0; i < CS4271_NR_RATIOS; i++)
 		if ((cs4271_clk_tab[i].master == cs4271->master) &&
 		    (cs4271_clk_tab[i].speed_mode == val) &&
 		    (cs4271_clk_tab[i].ratio == ratio))
 			break;
 
-	if (i == CS4171_NR_RATIOS) {
+	if (i == CS4271_NR_RATIOS) {
 		dev_err(component->dev, "Invalid sample rate\n");
 		return -EINVAL;
 	}
-- 
2.20.1

