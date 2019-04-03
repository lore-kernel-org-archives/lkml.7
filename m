Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957DCC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E512075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266502;
	bh=GNUgDK/D3oGB+kkeZp2XlMa0v2EECO6LxR3v0qPaj/c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZbN9HfyT9QQG926Vw21qS0cdcJmFPI748d6S+zwy9WLgfFCQ9vtBQbebthaZX6/CH
	 s2qXHCKS8SaATVSq+gDUYgNBUkrur474l9XO6XxkT3lErtwoHnWp2kkpMBpwcpcOho
	 CdJsajxaTxyBbfYz07o9yMdeGTKOeXkOq4+Npfio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfDCEll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:41:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39152 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCElk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aCpRfw3mv0kM+b1WQboJiocvGXZQ+ugjyyCGeinbMU4=; b=aPPGV7cVeOZ3
        tn/TCPtzPuD7wQY0SJ7O7mQAgmPcwisCcp21GjiRm5yJ6PDys6tBYs49ns9HlMP0xo9lyddczlI2S
        7xcVW17/AJkKxvVyOTMxpdB+gZXUJlXwG4PqYIPf7LyFddeYCk0h9evIFQaukwEkLvZqg8GuiokX6
        smiCw=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXiJ-0003z2-BH; Wed, 03 Apr 2019 04:41:27 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7744B440082; Wed,  3 Apr 2019 05:41:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: Mediatek: MT8183: TS3A227: fix build error" to the asoc tree
In-Reply-To:  <20190403030501.25140-1-anders.roxell@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190403044124.7744B440082@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:41:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Mediatek: MT8183: TS3A227: fix build error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 2b7bcdad3af9fbd104d5f300dbb90f684c36aa09 Mon Sep 17 00:00:00 2001
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 3 Apr 2019 05:05:01 +0200
Subject: [PATCH] ASoC: Mediatek: MT8183: TS3A227: fix build error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m the
following error pops up:

../sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c: In function ‘mt8183_mt6358_ts3a227_max98357_dev_probe’:
../sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:325:13: error: ‘struct snd_soc_dai_link’ has no member named ‘platform’; did you mean ‘platforms’?
   dai_link->platform = NULL;
             ^~~~~~~~
             platforms

Rework to use 'dai_link->platforms' instead of 'dai_link->platform'.

Fixes: 11c0269017b2 ("ASoC: Mediatek: MT8183: Add machine driver with TS3A227")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 2da56232a9e1..a50c6af5c945 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -322,7 +322,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		 * the "platform" will not null when probe is trying
 		 * again. It's not expected normally.
 		 */
-		dai_link->platform = NULL;
+		dai_link->platforms = NULL;
 
 		if (dai_link->platform_name)
 			continue;
-- 
2.20.1

