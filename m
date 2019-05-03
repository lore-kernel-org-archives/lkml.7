Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488062087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864361;
	bh=Rc2UCDU/MwtylOmchGmWzCO0+URS9A0hhGwiqM2Ay1w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=w2mNYoLS105ENVCMQTfHMrMQ4rXeOTjHezvOznjUsDYNKGHXl1VCCEHCdWUz7w6Rx
	 k4RrYVGs48rBgGrBWfyoWPRKs9me22u0uNzwivlWwYItJ94XKCPW58Jxp6pN8G1SOc
	 WRxCIurWDvGrNUOnHUveGJamfnDR9bHwQbkuKktY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfECGTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:19:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53538 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfECGTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3bsml9YeoZKGo1dmtXGCstB1yb3sdtjA3lXsRc1JIak=; b=Hpu75fiYziIl
        8aSmE6xTqNUgkw6g9tlW3K1wN0cCr03gbnHt7RN2H0NjoPUJtP3QyFqutjwgGnF7HvF9GXh7VK5ap
        1xkfH1+4tsYcOgzBh8xBC0sGNT+nGMq0vyoVASKhbGAxOXcOnvkFOrl++4la03kw/TNGNErBl/5r0
        vZWFc=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRX4-0000Xe-UO; Fri, 03 May 2019 06:18:56 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 31FF8441D41; Fri,  3 May 2019 07:18:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: da7219: Update the support rate list" to the asoc tree
In-Reply-To: <20190502040743.184310-1-yuhsuan@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190503061846.31FF8441D41@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:18:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: Update the support rate list

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

From cd8926e38e8cc53413a2a4ed2f705db7437a55fb Mon Sep 17 00:00:00 2001
From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date: Thu, 2 May 2019 12:07:43 +0800
Subject: [PATCH] ASoC: da7219: Update the support rate list

If we want to set rate to 64000 on da7219, it fails and returns
"snd_pcm_hw_params: Invalid argument".
We should remove 64000 from support rate list because it is not
available.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 121a8190f93e..9f6970eed6f6 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1583,20 +1583,26 @@ static const struct snd_soc_dai_ops da7219_dai_ops = {
 #define DA7219_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
+#define DA7219_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
+		      SNDRV_PCM_RATE_96000)
+
 static struct snd_soc_dai_driver da7219_dai = {
 	.name = "da7219-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = DA7219_DAI_CH_NUM_MAX,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = DA7219_RATES,
 		.formats = DA7219_FORMATS,
 	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = DA7219_DAI_CH_NUM_MAX,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = DA7219_RATES,
 		.formats = DA7219_FORMATS,
 	},
 	.ops = &da7219_dai_ops,
-- 
2.20.1

