Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00606C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC34620863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568213988;
	bh=pxGRZ0uMa/BAChnrMsSHv71/eaMcbgRKw8kXAfF5ag8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YD0BXZ23quvPbvAZwwOl25LjNBwaGVzte06GkI8T+g27XwHsKlSilBSii9xp3fXGY
	 jKMdwvj6I8yPmp0D/U+GebkovCCr8c2TI8ll0GOIC94iwa+CDVVwH0+4/VYVvX19kP
	 OEbL6FGIrJHhDcnGUbCfVcqkjiboBSUur/HJKuxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfIKO7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:59:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52430 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfIKO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ffweYwgveZmJKePFG9U1Khan+EGK6MmWiUDhz/mX4Rw=; b=K2AC9QCD1I0w
        YaLgcXNL3ZutlkxgDXi9jZW17CPrYiLGGkgeQ3vQdrDyRA88ZN2/kDAy+3WPiuYgZJXnFKKBP76iU
        qxc80Hez5+JLfYhYmlvy8xEyvdy1anCRKD3jJ5OjGQcs1ScpOtr0sXYEEHnc8DHPukWd+u6w3/2M2
        yEOKc=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i845u-0001j0-KA; Wed, 11 Sep 2019 14:59:42 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id D9B0CD0046D; Wed, 11 Sep 2019 15:59:41 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        srinivas.kandagatla@linaro.org
Subject: Applied "ASoC: wcd9335: remove redundant use of ret variable" to the asoc tree
In-Reply-To: <20190909174541.GA22718@SD>
X-Patchwork-Hint: ignore
Message-Id: <20190911145941.D9B0CD0046D@fitzroy.sirena.org.uk>
Date:   Wed, 11 Sep 2019 15:59:41 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd9335: remove redundant use of ret variable

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

From d1c9e44a858d706ce0b496f559b25732e6697b0c Mon Sep 17 00:00:00 2001
From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Date: Mon, 9 Sep 2019 23:15:41 +0530
Subject: [PATCH] ASoC: wcd9335: remove redundant use of ret variable

All these functions declares and initializes variable ret with
'0' and without modifying 'ret' variable, it is returned.

This patch removes this redundancy and returns '0' directly.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Link: https://lore.kernel.org/r/20190909174541.GA22718@SD
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 03f8a94bba2f..f318403133e9 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3022,7 +3022,6 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = snd_soc_component_get_drvdata(comp);
 	struct wcd_slim_codec_dai_data *dai = &wcd->dai[w->shift];
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -3034,7 +3033,7 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
@@ -3539,7 +3538,6 @@ static int wcd9335_codec_hphl_dac_event(struct snd_soc_dapm_widget *w,
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
 	u8 dem_inp;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3579,7 +3577,7 @@ static int wcd9335_codec_hphl_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_lineout_dac_event(struct snd_soc_dapm_widget *w,
@@ -3607,7 +3605,6 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3621,7 +3618,7 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static void wcd9335_codec_hph_post_pa_config(struct wcd9335_codec *wcd,
@@ -3692,7 +3689,6 @@ static int wcd9335_codec_hphr_dac_event(struct snd_soc_dapm_widget *w,
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
 	u8 dem_inp;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3731,7 +3727,7 @@ static int wcd9335_codec_hphr_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
@@ -3741,7 +3737,6 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3780,7 +3775,7 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
@@ -3789,7 +3784,6 @@ static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	int vol_reg = 0, mix_vol_reg = 0;
-	int ret = 0;
 
 	if (w->reg == WCD9335_ANA_LO_1_2) {
 		if (w->shift == 7) {
@@ -3837,7 +3831,7 @@ static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static void wcd9335_codec_init_flyback(struct snd_soc_component *component)
@@ -3892,7 +3886,6 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3930,14 +3923,13 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 				       struct snd_kcontrol *kc, int event)
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -3967,7 +3959,7 @@ static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
-- 
2.20.1

