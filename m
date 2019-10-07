Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2B6C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA5206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570472021;
	bh=IM3RRaHRAAAZ9GriggCzjNI8gnCjvqbSFAswxUXkCbg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=z2AqrfyMPUzz3itdb0imDMUNGjjdnjPlHjur63BzcwrPM0idhqbVrSfGv+agPenEv
	 ey+DxaSo1nyeVFplkYyjCC+/nxeq3JtYtZm78f/FHbXEKN1LoHfZ2ejK7hlkDPYWH9
	 o3q9AY78S8mzBjiuuNKZhKf5ok+cD+JjfckIKIpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfJGSNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:13:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34400 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YszzIRRq8+HMe+uWy5lgHyDF5uj3GQ+Jn/wpF3eKyO4=; b=GaYXeXG9/kZA
        xoRoklbcb21LauF4f0MDmub9bJdPkJYpgJBMBQpQ/Vkmbh288FFFllOjhsaDZtDi/71KJJK9qjauh
        iFkLS8na+vM6ThtkF/TlQYWmNR/KxtMd0ROzrP7t4v6ZxfoF3LwTl9i37LSqEDt/bCSE3ESIF0waa
        EpZ0w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHXVe-0004GD-1J; Mon, 07 Oct 2019 18:13:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 42DD6274162F; Mon,  7 Oct 2019 19:13:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, navada@ti.com, perex@perex.cz,
        shifu0704@thundersoft.com, tiwai@suse.com
Subject: Applied "ASoC: tas2770: Fix snd_soc_update_bits error handling" to the asoc tree
In-Reply-To: <20191007171157.17813-1-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007181325.42DD6274162F@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 19:13:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas2770: Fix snd_soc_update_bits error handling

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

From edd6d5393206ec9bfc74776f6f20a57f11327e1b Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Mon, 7 Oct 2019 12:11:55 -0500
Subject: [PATCH] ASoC: tas2770: Fix snd_soc_update_bits error handling

According the documentation for snd_soc_update_bits the API
will return a 1 if the update was successful with a value change,
a 0 if the update was successful with no value change or a negative
if the command just failed.

So the value of return in the driver needs to be checked for being less
then 0 or the caller may indicate failure when the value actually
changed.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20191007171157.17813-1-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2770.c | 46 +++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index f3a665b64fd6..ad76f22fcfac 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -83,7 +83,8 @@ static int tas2770_codec_suspend(struct snd_soc_component *component)
 		TAS2770_PWR_CTRL,
 		TAS2770_PWR_CTRL_MASK,
 		TAS2770_PWR_CTRL_SHUTDOWN);
-	if (ret)
+
+	if (ret < 0)
 		return ret;
 
 	return 0;
@@ -97,8 +98,9 @@ static int tas2770_codec_resume(struct snd_soc_component *component)
 		TAS2770_PWR_CTRL,
 		TAS2770_PWR_CTRL_MASK,
 		TAS2770_PWR_CTRL_ACTIVE);
-	if (ret)
-		return -EINVAL;
+
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -150,7 +152,10 @@ static int tas2770_dac_event(struct snd_soc_dapm_widget *w,
 	}
 
 end:
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static const struct snd_kcontrol_new isense_switch =
@@ -200,7 +205,10 @@ static int tas2770_mute(struct snd_soc_dai *dai, int mute)
 			TAS2770_PWR_CTRL_MASK,
 			TAS2770_PWR_CTRL_ACTIVE);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
@@ -253,7 +261,10 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 		tas2770->i_sense_slot);
 
 end:
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
@@ -345,9 +356,11 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 	}
 
 end:
-	if (!ret)
-		tas2770->sampling_rate = samplerate;
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	tas2770->sampling_rate = samplerate;
+	return 0;
 }
 
 static int tas2770_hw_params(struct snd_pcm_substream *substream,
@@ -401,7 +414,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG1,
 		TAS2770_TDM_CFG_REG1_RX_MASK,
 		asi_cfg_1);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -426,7 +439,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG1,
 		TAS2770_TDM_CFG_REG1_MASK,
 	(tdm_rx_start_slot << TAS2770_TDM_CFG_REG1_51_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	tas2770->asi_format = fmt;
@@ -470,12 +483,12 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG3,
 		TAS2770_TDM_CFG_REG3_30_MASK,
 		(left_slot << TAS2770_TDM_CFG_REG3_30_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG3,
 		TAS2770_TDM_CFG_REG3_RXS_MASK,
 	(right_slot << TAS2770_TDM_CFG_REG3_RXS_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	switch (slot_width) {
@@ -509,10 +522,11 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		ret = -EINVAL;
 	}
 
-	if (!ret)
-		tas2770->slot_width = slot_width;
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	tas2770->slot_width = slot_width;
+	return 0;
 }
 
 static struct snd_soc_dai_ops tas2770_dai_ops = {
-- 
2.20.1

