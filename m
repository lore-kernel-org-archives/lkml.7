Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8AEC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA7921A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568023679;
	bh=FuNr+wCnPVF+u29lSFTsihKdutUNsbIAoO7WbcW5dJU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xWmgr8neygYFARmZqwEplpGM9sBLB6vcp8kDEIX8mxMRIRwfitJcoCjL+c+Yo7chq
	 TKHEURgiYmVQHPyQ924DSooz+40q3ZOQ4zmk+D3yVDQ4lZcWu2b5KTPMOexLFYFGzr
	 Vs8z7chig58deoPx6CPMFxbv8/9uKa0oKKu8P7cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbfIIKHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:07:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56116 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfIIKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qvEqsVB11jXmmerUvV31z20Vlpx17lLYw1fsBAjdagI=; b=pXNo7qq2UWBq
        spzRhEcGVj6jjCwtX6iq9ax3WlEaALupG2KGNADYj377FRXB5YK4B4iPhuIcB7TK+5I3QetDm0iRm
        ZVttrfHQEuFTtXHUzTXds1OPS6QUk+fk4ykoDpRgEFTR2APfm+NXYLjMvX5IUAhAJJZqEDQhZQQ0B
        KE+Z4=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7GZq-0001s5-0D; Mon, 09 Sep 2019 10:07:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 559AED02D83; Mon,  9 Sep 2019 11:07:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     alsa-devel@alsa-project.org, Daniel Drake <drake@endlessm.com>,
        David Yang <yangxiaohua@everest-semi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8316: support fixed and variable both clock rates" to the asoc tree
In-Reply-To: <20190907163653.9382-2-katsuhiro@katsuster.net>
X-Patchwork-Hint: ignore
Message-Id: <20190909100717.559AED02D83@fitzroy.sirena.org.uk>
Date:   Mon,  9 Sep 2019 11:07:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es8316: support fixed and variable both clock rates

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

From ebe02a5b9ef05e3b812af3d628cdf6206d9ba610 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Sun, 8 Sep 2019 01:36:53 +0900
Subject: [PATCH] ASoC: es8316: support fixed and variable both clock rates

This patch supports some type of machine drivers that set 0 to mclk
when sound device goes to idle state. After applied this patch,
sysclk == 0 means there is no constraint of sound rate and other
values will set constraints which is derived by sysclk setting.

Original code refuses sysclk == 0 setting. But some boards and SoC
(such as RockPro64 and RockChip I2S) has connected SoC MCLK out to
ES8316 MCLK in. In this case, SoC side I2S will choose suitable
frequency of MCLK such as fs * mclk-fs when user starts playing or
capturing.

Bad scenario as follows (mclk-fs = 256):
  - Initialize sysclk by correct value (Ex. 12.288MHz)
    - ES8316 set constraints of PCM rate by sysclk
      48kHz (1/256), 32kHz (1/384), 30.720kHz (1/400),
      24kHz (1/512), 16kHz (1/768), 12kHz (1/1024)
  - Play 48kHz sound, it's acceptable
  - Sysclk is not changed

  - Play 32kHz sound, it's acceptable
  - Set sysclk by 8.192MHz (= fs * mclk-fs = 32k * 256)
    - ES8316 set constraints of PCM rate by sysclk
      32kHz (1/256), 21.33kHz (1/384), 20.48kHz (1/400),
      16kHz (1/512), 10.66kHz (1/768), 8kHz (1/1024)

  - Play 48kHz again, but it's NOT acceptable because constraints
    list does not allow 48kHz

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Link: https://lore.kernel.org/r/20190907163653.9382-2-katsuhiro@katsuster.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index e9fa4981ccef..9150e7068467 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -367,8 +367,12 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 	es8316->sysclk = freq;
 
-	if (freq == 0)
+	if (freq == 0) {
+		es8316->sysclk_constraints.list = NULL;
+		es8316->sysclk_constraints.count = 0;
+
 		return 0;
+	}
 
 	ret = clk_set_rate(es8316->mclk, freq);
 	if (ret)
@@ -447,17 +451,10 @@ static int es8316_pcm_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 
-	if (es8316->sysclk == 0) {
-		dev_err(component->dev, "No sysclk provided\n");
-		return -EINVAL;
-	}
-
-	/* The set of sample rates that can be supported depends on the
-	 * MCLK supplied to the CODEC.
-	 */
-	snd_pcm_hw_constraint_list(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_RATE,
-				   &es8316->sysclk_constraints);
+	if (es8316->sysclk_constraints.list)
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   &es8316->sysclk_constraints);
 
 	return 0;
 }
@@ -469,11 +466,19 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 	u8 wordlen = 0;
+	int i;
 
-	if (!es8316->sysclk) {
-		dev_err(component->dev, "No MCLK configured\n");
-		return -EINVAL;
+	/* Validate supported sample rates that are autodetected from MCLK */
+	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
+		const unsigned int ratio = supported_mclk_lrck_ratios[i];
+
+		if (es8316->sysclk % ratio != 0)
+			continue;
+		if (es8316->sysclk / ratio == params_rate(params))
+			break;
 	}
+	if (i == NR_SUPPORTED_MCLK_LRCK_RATIOS)
+		return -EINVAL;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-- 
2.20.1

