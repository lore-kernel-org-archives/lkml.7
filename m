Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD93C218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180848;
	bh=56XsAtnmm34qQoi0weOgcp2pHxI/qVkr/ysU4OzUOiQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xVA1xufpTusc6QOGxBhqIcPTQuGlcXMwCwsXvhwh8KR8RxAuo2DS7pFfx7CFlwZwR
	 JT6j6tBsXuFdrjgnrYzLjAEkM414zjnTtuUItBFTeE1KBtnrQqC7A1MrENLaW+TDuE
	 I9nPEnW6dVv15oXykF7uXFgNMLD1E8GLvXinTcWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfCUPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:07:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47900 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfCUPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DZaM2L6ue4YxSVtip8mTUGww7ZiwYqf9V3We3S5ZOpM=; b=jwJlWR1uuIK4
        9DykhkHUGP70OeebNTTJoOBg9AAB573SR26HEwweL4OaJjk2QczJiXbnAdJLGBBvc74hfOP4wmecZ
        4WvUxSmcN5KJqPi1/i8ZhGwc19STenpjTaKWkZfa/W8dR/eDH8K06sUx/BHAzL2Xp4xWOf7JKfkwc
        Pbgf8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zHg-0005cV-CI; Thu, 21 Mar 2019 15:07:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C32D211288EC; Thu, 21 Mar 2019 15:07:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: da7219: Expose BCLK and WCLK control through CCF" to the asoc tree
In-Reply-To:  <d946088965125f22687c575c9564fb4041f4d4a5.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
X-Patchwork-Hint: ignore
Message-Id: <20190321150707.C32D211288EC@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:07:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: Expose BCLK and WCLK control through CCF

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

From d90ba6c8b53e541913a181638c353cf7a0856256 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 19 Mar 2019 17:49:31 +0000
Subject: [PATCH] ASoC: da7219: Expose BCLK and WCLK control through CCF

For the purposes of platforms which use the codec as DAI clock
master for the CPU and other codec devices, there is the need to
not only expose the clock gating of BCLK and WCLK but also the
ability to set those rates without going through the ASoC APIs.

To make this possible, the previous CCF implementation in the
driver has been extended to separate BCLK and WCLK out. WCLK is
the parent clock to BCLK, and is also the clock gate for both.
BCLK in HW is a factor/multiplier of WCLK so derives from whatever
SR is chosen for WCLK, hence the need to make it a child of WCLK
for the purposes of CCF. Enabling/disabling either BCLK or WCLK
will result in clocks being ungated/gated accordingly. To simplify
matters, these clocks can only be configured if the codec is set
as master, otherwise CCF control is disallowed.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/da7219.h    |   8 +-
 sound/soc/codecs/da7219.c | 523 +++++++++++++++++++++++++++++---------
 sound/soc/codecs/da7219.h |   6 +-
 3 files changed, 407 insertions(+), 130 deletions(-)

diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 1bfcb16f2d10..4a36954c86c5 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -33,10 +33,16 @@ enum da7219_mic_amp_in_sel {
 
 struct da7219_aad_pdata;
 
+enum da7219_dai_clks {
+	DA7219_DAI_WCLK_IDX = 0,
+	DA7219_DAI_BCLK_IDX,
+	DA7219_DAI_NUM_CLKS,
+};
+
 struct da7219_pdata {
 	bool wakeup_source;
 
-	const char *dai_clks_name;
+	const char *dai_clk_names[DA7219_DAI_NUM_CLKS];
 
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 121a8190f93e..5f5fa3416af3 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -797,6 +797,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	struct clk *bclk = da7219->dai_clks[DA7219_DAI_BCLK_IDX];
 	u8 pll_ctrl, pll_status;
 	int i = 0, ret;
 	bool srm_lock = false;
@@ -805,11 +806,11 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMU:
 		if (da7219->master) {
 			/* Enable DAI clks for master mode */
-			if (da7219->dai_clks) {
-				ret = clk_prepare_enable(da7219->dai_clks);
+			if (bclk) {
+				ret = clk_prepare_enable(bclk);
 				if (ret) {
 					dev_err(component->dev,
-						"Failed to enable dai_clks\n");
+						"Failed to enable DAI clks\n");
 					return ret;
 				}
 			} else {
@@ -852,8 +853,8 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 
 		/* Disable DAI clks if in master mode */
 		if (da7219->master) {
-			if (da7219->dai_clks)
-				clk_disable_unprepare(da7219->dai_clks);
+			if (bclk)
+				clk_disable_unprepare(bclk);
 			else
 				snd_soc_component_update_bits(component,
 							      DA7219_DAI_CLK_MODE,
@@ -1385,17 +1386,50 @@ static int da7219_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
+static int da7219_set_bclks_per_wclk(struct snd_soc_component *component,
+				     unsigned long factor)
+{
+	u8 bclks_per_wclk;
+
+	switch (factor) {
+	case 32:
+		bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
+		break;
+	case 64:
+		bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
+		break;
+	case 128:
+		bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_128;
+		break;
+	case 256:
+		bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_256;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+				      DA7219_DAI_BCLKS_PER_WCLK_MASK,
+				      bclks_per_wclk);
+
+	return 0;
+}
+
 static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				   unsigned int tx_mask, unsigned int rx_mask,
 				   int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	struct clk *wclk = da7219->dai_clks[DA7219_DAI_WCLK_IDX];
+	struct clk *bclk = da7219->dai_clks[DA7219_DAI_BCLK_IDX];
 	unsigned int ch_mask;
-	u8 dai_bclks_per_wclk, slot_offset;
+	unsigned long sr, bclk_rate;
+	u8 slot_offset;
 	u16 offset;
 	__le16 dai_offset;
 	u32 frame_size;
+	int ret;
 
 	/* No channels enabled so disable TDM */
 	if (!tx_mask) {
@@ -1432,28 +1466,26 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	 */
 	if (da7219->master) {
 		frame_size = slots * slot_width;
-		switch (frame_size) {
-		case 32:
-			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
-			break;
-		case 64:
-			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
-			break;
-		case 128:
-			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_128;
-			break;
-		case 256:
-			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_256;
-			break;
-		default:
-			dev_err(component->dev, "Invalid frame size %d\n",
-				frame_size);
-			return -EINVAL;
-		}
 
-		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-				DA7219_DAI_BCLKS_PER_WCLK_MASK,
-				dai_bclks_per_wclk);
+		if (bclk) {
+			sr = clk_get_rate(wclk);
+			bclk_rate = sr * frame_size;
+			ret = clk_set_rate(bclk, bclk_rate);
+			if (ret) {
+				dev_err(component->dev,
+					"Failed to set TDM BCLK rate %lu: %d\n",
+					bclk_rate, ret);
+				return ret;
+			}
+		} else {
+			ret = da7219_set_bclks_per_wclk(component, frame_size);
+			if (ret) {
+				dev_err(component->dev,
+					"Failed to set TDM BCLKs per WCLK %d: %d\n",
+					frame_size, ret);
+				return ret;
+			}
+		}
 	}
 
 	dai_offset = cpu_to_le16(offset);
@@ -1471,44 +1503,12 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int da7219_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params,
-			    struct snd_soc_dai *dai)
+static int da7219_set_sr(struct snd_soc_component *component,
+			 unsigned long rate)
 {
-	struct snd_soc_component *component = dai->component;
-	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
-	u8 dai_ctrl = 0, dai_bclks_per_wclk = 0, fs;
-	unsigned int channels;
-	int word_len = params_width(params);
-	int frame_size;
-
-	switch (word_len) {
-	case 16:
-		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S16_LE;
-		break;
-	case 20:
-		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S20_LE;
-		break;
-	case 24:
-		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S24_LE;
-		break;
-	case 32:
-		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S32_LE;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	channels = params_channels(params);
-	if ((channels < 1) || (channels > DA7219_DAI_CH_NUM_MAX)) {
-		dev_err(component->dev,
-			"Invalid number of channels, only 1 to %d supported\n",
-			DA7219_DAI_CH_NUM_MAX);
-		return -EINVAL;
-	}
-	dai_ctrl |= channels << DA7219_DAI_CH_NUM_SHIFT;
+	u8 fs;
 
-	switch (params_rate(params)) {
+	switch (rate) {
 	case 8000:
 		fs = DA7219_SR_8000;
 		break;
@@ -1546,28 +1546,103 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	snd_soc_component_write(component, DA7219_SR, fs);
+
+	return 0;
+}
+
+static int da7219_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	struct clk *wclk = da7219->dai_clks[DA7219_DAI_WCLK_IDX];
+	struct clk *bclk = da7219->dai_clks[DA7219_DAI_BCLK_IDX];
+	u8 dai_ctrl = 0;
+	unsigned int channels;
+	unsigned long sr, bclk_rate;
+	int word_len = params_width(params);
+	int frame_size, ret;
+
+	switch (word_len) {
+	case 16:
+		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S16_LE;
+		break;
+	case 20:
+		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S20_LE;
+		break;
+	case 24:
+		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S24_LE;
+		break;
+	case 32:
+		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S32_LE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	channels = params_channels(params);
+	if ((channels < 1) || (channels > DA7219_DAI_CH_NUM_MAX)) {
+		dev_err(component->dev,
+			"Invalid number of channels, only 1 to %d supported\n",
+			DA7219_DAI_CH_NUM_MAX);
+		return -EINVAL;
+	}
+	dai_ctrl |= channels << DA7219_DAI_CH_NUM_SHIFT;
+
+	sr = params_rate(params);
+	if (da7219->master && wclk) {
+		ret = clk_set_rate(wclk, sr);
+		if (ret) {
+			dev_err(component->dev,
+				"Failed to set WCLK SR %lu: %d\n", sr, ret);
+			return ret;
+		}
+	} else {
+		ret = da7219_set_sr(component, sr);
+		if (ret) {
+			dev_err(component->dev,
+				"Failed to set SR %lu: %d\n", sr, ret);
+			return ret;
+		}
+	}
+
 	/*
 	 * If we're master, then we have a limited set of BCLK rates we
 	 * support. For slave mode this isn't the case and the codec can detect
 	 * the BCLK rate automatically.
 	 */
 	if (da7219->master && !da7219->tdm_en) {
-		frame_size = word_len * 2;
-		if (frame_size <= 32)
-			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
+		if ((word_len * DA7219_DAI_CH_NUM_MAX) <= 32)
+			frame_size = 32;
 		else
-			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
-
-		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-					      DA7219_DAI_BCLKS_PER_WCLK_MASK,
-					      dai_bclks_per_wclk);
+			frame_size = 64;
+
+		if (bclk) {
+			bclk_rate = frame_size * sr;
+			ret = clk_set_rate(bclk, bclk_rate);
+			if (ret) {
+				dev_err(component->dev,
+					"Failed to set BCLK rate %lu: %d\n",
+					bclk_rate, ret);
+				return ret;
+			}
+		} else {
+			ret = da7219_set_bclks_per_wclk(component, frame_size);
+			if (ret) {
+				dev_err(component->dev,
+					"Failed to set BCLKs per WCLK %d: %d\n",
+					frame_size, ret);
+				return ret;
+			}
+		}
 	}
 
 	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
 			    DA7219_DAI_WORD_LENGTH_MASK |
 			    DA7219_DAI_CH_NUM_MASK,
 			    dai_ctrl);
-	snd_soc_component_write(component, DA7219_SR, fs);
 
 	return 0;
 }
@@ -1672,11 +1747,14 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *compone
 
 	pdata->wakeup_source = device_property_read_bool(dev, "wakeup-source");
 
-	pdata->dai_clks_name = "da7219-dai-clks";
-	if (device_property_read_string(dev, "clock-output-names",
-					&pdata->dai_clks_name))
-		dev_warn(dev, "Using default clk name: %s\n",
-			 pdata->dai_clks_name);
+	pdata->dai_clk_names[DA7219_DAI_WCLK_IDX] = "da7219-dai-wclk";
+	pdata->dai_clk_names[DA7219_DAI_BCLK_IDX] = "da7219-dai-bclk";
+	if (device_property_read_string_array(dev, "clock-output-names",
+					      pdata->dai_clk_names,
+					      DA7219_DAI_NUM_CLKS) < 0)
+		dev_warn(dev, "Using default DAI clk names: %s, %s\n",
+			 pdata->dai_clk_names[DA7219_DAI_WCLK_IDX],
+			 pdata->dai_clk_names[DA7219_DAI_BCLK_IDX]);
 
 	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
 		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
@@ -1793,12 +1871,16 @@ static int da7219_handle_supplies(struct snd_soc_component *component)
 }
 
 #ifdef CONFIG_COMMON_CLK
-static int da7219_dai_clks_prepare(struct clk_hw *hw)
+static int da7219_wclk_prepare(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
-		container_of(hw, struct da7219_priv, dai_clks_hw);
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = da7219->component;
 
+	if (!da7219->master)
+		return -EINVAL;
+
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK,
 				      DA7219_DAI_CLK_EN_MASK);
@@ -1806,36 +1888,48 @@ static int da7219_dai_clks_prepare(struct clk_hw *hw)
 	return 0;
 }
 
-static void da7219_dai_clks_unprepare(struct clk_hw *hw)
+static void da7219_wclk_unprepare(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
-		container_of(hw, struct da7219_priv, dai_clks_hw);
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = da7219->component;
 
+	if (!da7219->master)
+		return;
+
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK, 0);
 }
 
-static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
+static int da7219_wclk_is_prepared(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
-		container_of(hw, struct da7219_priv, dai_clks_hw);
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = da7219->component;
 	u8 clk_reg;
 
+	if (!da7219->master)
+		return -EINVAL;
+
 	clk_reg = snd_soc_component_read32(component, DA7219_DAI_CLK_MODE);
 
 	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);
 }
 
-static unsigned long da7219_dai_clks_recalc_rate(struct clk_hw *hw,
-						 unsigned long parent_rate)
+static unsigned long da7219_wclk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
 {
 	struct da7219_priv *da7219 =
-		container_of(hw, struct da7219_priv, dai_clks_hw);
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = da7219->component;
 	u8 fs = snd_soc_component_read32(component, DA7219_SR);
 
+	if (!da7219->master)
+		return 0;
+
 	switch (fs & DA7219_SR_MASK) {
 	case DA7219_SR_8000:
 		return 8000;
@@ -1864,11 +1958,151 @@ static unsigned long da7219_dai_clks_recalc_rate(struct clk_hw *hw,
 	}
 }
 
-static const struct clk_ops da7219_dai_clks_ops = {
-	.prepare = da7219_dai_clks_prepare,
-	.unprepare = da7219_dai_clks_unprepare,
-	.is_prepared = da7219_dai_clks_is_prepared,
-	.recalc_rate = da7219_dai_clks_recalc_rate,
+static long da7219_wclk_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_WCLK_IDX]);
+
+	if (!da7219->master)
+		return -EINVAL;
+
+	if (rate < 11025)
+		return 8000;
+	else if (rate < 12000)
+		return 11025;
+	else if (rate < 16000)
+		return 12000;
+	else if (rate < 22050)
+		return 16000;
+	else if (rate < 24000)
+		return 22050;
+	else if (rate < 32000)
+		return 24000;
+	else if (rate < 44100)
+		return 32000;
+	else if (rate < 48000)
+		return 44100;
+	else if (rate < 88200)
+		return 48000;
+	else if (rate < 96000)
+		return 88200;
+	else
+		return 96000;
+}
+
+static int da7219_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_WCLK_IDX]);
+	struct snd_soc_component *component = da7219->component;
+
+	if (!da7219->master)
+		return -EINVAL;
+
+	return da7219_set_sr(component, rate);
+}
+
+static unsigned long da7219_bclk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_BCLK_IDX]);
+	struct snd_soc_component *component = da7219->component;
+	u8 bclks_per_wclk = snd_soc_component_read32(component,
+						     DA7219_DAI_CLK_MODE);
+
+	if (!da7219->master)
+		return 0;
+
+	switch (bclks_per_wclk & DA7219_DAI_BCLKS_PER_WCLK_MASK) {
+	case DA7219_DAI_BCLKS_PER_WCLK_32:
+		return parent_rate * 32;
+	case DA7219_DAI_BCLKS_PER_WCLK_64:
+		return parent_rate * 64;
+	case DA7219_DAI_BCLKS_PER_WCLK_128:
+		return parent_rate * 128;
+	case DA7219_DAI_BCLKS_PER_WCLK_256:
+		return parent_rate * 256;
+	default:
+		return 0;
+	}
+}
+
+static unsigned long da7219_bclk_get_factor(unsigned long rate,
+					    unsigned long parent_rate)
+{
+	unsigned long factor;
+
+	factor = rate / parent_rate;
+	if (factor < 64)
+		return 32;
+	else if (factor < 128)
+		return 64;
+	else if (factor < 256)
+		return 128;
+	else
+		return 256;
+}
+
+static long da7219_bclk_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_BCLK_IDX]);
+	unsigned long factor;
+
+	if (!*parent_rate || !da7219->master)
+		return -EINVAL;
+
+	/*
+	 * We don't allow changing the parent rate as some BCLK rates can be
+	 * derived from multiple parent WCLK rates (BCLK rates are set as a
+	 * multiplier of WCLK in HW). We just do some rounding down based on the
+	 * parent WCLK rate set and find the appropriate multiplier of BCLK to
+	 * get the rounded down BCLK value.
+	 */
+	factor = da7219_bclk_get_factor(rate, *parent_rate);
+
+	return *parent_rate * factor;
+}
+
+static int da7219_bclk_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv,
+			     dai_clks_hw[DA7219_DAI_BCLK_IDX]);
+	struct snd_soc_component *component = da7219->component;
+	unsigned long factor;
+
+	if (!da7219->master)
+		return -EINVAL;
+
+	factor = da7219_bclk_get_factor(rate, parent_rate);
+
+	return da7219_set_bclks_per_wclk(component, factor);
+}
+
+static const struct clk_ops da7219_dai_clk_ops[DA7219_DAI_NUM_CLKS] = {
+	[DA7219_DAI_WCLK_IDX] = {
+		.prepare = da7219_wclk_prepare,
+		.unprepare = da7219_wclk_unprepare,
+		.is_prepared = da7219_wclk_is_prepared,
+		.recalc_rate = da7219_wclk_recalc_rate,
+		.round_rate = da7219_wclk_round_rate,
+		.set_rate = da7219_wclk_set_rate,
+	},
+	[DA7219_DAI_BCLK_IDX] = {
+		.recalc_rate = da7219_bclk_recalc_rate,
+		.round_rate = da7219_bclk_round_rate,
+		.set_rate = da7219_bclk_set_rate,
+	},
 };
 
 static int da7219_register_dai_clks(struct snd_soc_component *component)
@@ -1876,47 +2110,81 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 	struct device *dev = component->dev;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	struct da7219_pdata *pdata = da7219->pdata;
-	struct clk_init_data init = {};
-	struct clk *dai_clks;
-	struct clk_lookup *dai_clks_lookup;
 	const char *parent_name;
+	int i, ret;
 
-	if (da7219->mclk) {
-		parent_name = __clk_get_name(da7219->mclk);
-		init.parent_names = &parent_name;
-		init.num_parents = 1;
-	} else {
-		init.parent_names = NULL;
-		init.num_parents = 0;
-	}
+	for (i = 0; i < DA7219_DAI_NUM_CLKS; ++i) {
+		struct clk_init_data init = {};
+		struct clk *dai_clk;
+		struct clk_lookup *dai_clk_lookup;
+		struct clk_hw *dai_clk_hw = &da7219->dai_clks_hw[i];
 
-	init.name = pdata->dai_clks_name;
-	init.ops = &da7219_dai_clks_ops;
-	init.flags = CLK_GET_RATE_NOCACHE;
-	da7219->dai_clks_hw.init = &init;
+		switch (i) {
+		case DA7219_DAI_WCLK_IDX:
+			/*
+			 * If we can, make MCLK the parent of WCLK to ensure
+			 * it's enabled as required.
+			 */
+			if (da7219->mclk) {
+				parent_name = __clk_get_name(da7219->mclk);
+				init.parent_names = &parent_name;
+				init.num_parents = 1;
+			} else {
+				init.parent_names = NULL;
+				init.num_parents = 0;
+			}
+			break;
+		case DA7219_DAI_BCLK_IDX:
+			/* Make WCLK the parent of BCLK */
+			parent_name = __clk_get_name(da7219->dai_clks[DA7219_DAI_WCLK_IDX]);
+			init.parent_names = &parent_name;
+			init.num_parents = 1;
+			break;
+		default:
+			dev_err(dev, "Invalid clock index\n");
+			ret = -EINVAL;
+			goto err;
+		}
 
-	dai_clks = devm_clk_register(dev, &da7219->dai_clks_hw);
-	if (IS_ERR(dai_clks)) {
-		dev_warn(dev, "Failed to register DAI clocks: %ld\n",
-			 PTR_ERR(dai_clks));
-		return PTR_ERR(dai_clks);
-	}
-	da7219->dai_clks = dai_clks;
+		init.name = pdata->dai_clk_names[i];
+		init.ops = &da7219_dai_clk_ops[i];
+		init.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_GATE;
+		dai_clk_hw->init = &init;
+
+		dai_clk = devm_clk_register(dev, dai_clk_hw);
+		if (IS_ERR(dai_clk)) {
+			dev_warn(dev, "Failed to register %s: %ld\n",
+				 init.name, PTR_ERR(dai_clk));
+			ret = PTR_ERR(dai_clk);
+			goto err;
+		}
+		da7219->dai_clks[i] = dai_clk;
 
-	/* If we're using DT, then register as provider accordingly */
-	if (dev->of_node) {
-		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
-					    &da7219->dai_clks_hw);
-	} else {
-		dai_clks_lookup = clkdev_create(dai_clks, pdata->dai_clks_name,
-						"%s", dev_name(dev));
-		if (!dai_clks_lookup)
-			return -ENOMEM;
-		else
-			da7219->dai_clks_lookup = dai_clks_lookup;
+		/* If we're using DT, then register as provider accordingly */
+		if (dev->of_node) {
+			devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+						    dai_clk_hw);
+		} else {
+			dai_clk_lookup = clkdev_create(dai_clk, init.name,
+						       "%s", dev_name(dev));
+			if (!dai_clk_lookup) {
+				ret = -ENOMEM;
+				goto err;
+			} else {
+				da7219->dai_clks_lookup[i] = dai_clk_lookup;
+			}
+		}
 	}
 
 	return 0;
+
+err:
+	do {
+		if (da7219->dai_clks_lookup[i])
+			clkdev_drop(da7219->dai_clks_lookup[i]);
+	} while (i-- > 0);
+
+	return ret;
 }
 #else
 static inline int da7219_register_dai_clks(struct snd_soc_component *component)
@@ -2080,12 +2348,15 @@ static int da7219_probe(struct snd_soc_component *component)
 static void da7219_remove(struct snd_soc_component *component)
 {
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	int i;
 
 	da7219_aad_exit(component);
 
 #ifdef CONFIG_COMMON_CLK
-	if (da7219->dai_clks_lookup)
-		clkdev_drop(da7219->dai_clks_lookup);
+	for (i = DA7219_DAI_NUM_CLKS - 1; i >= 0; --i) {
+		if (da7219->dai_clks_lookup[i])
+			clkdev_drop(da7219->dai_clks_lookup[i]);
+	}
 #endif
 
 	/* Supplies */
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 018819c631fb..f3b180bc986f 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -820,10 +820,10 @@ struct da7219_priv {
 	struct mutex pll_lock;
 
 #ifdef CONFIG_COMMON_CLK
-	struct clk_hw dai_clks_hw;
+	struct clk_hw dai_clks_hw[DA7219_DAI_NUM_CLKS];
 #endif
-	struct clk_lookup *dai_clks_lookup;
-	struct clk *dai_clks;
+	struct clk_lookup *dai_clks_lookup[DA7219_DAI_NUM_CLKS];
+	struct clk *dai_clks[DA7219_DAI_NUM_CLKS];
 
 	struct clk *mclk;
 	unsigned int mclk_rate;
-- 
2.20.1

