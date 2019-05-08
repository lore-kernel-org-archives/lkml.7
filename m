Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2512CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B4B214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557306117;
	bh=TsjMumr5oicf66p+jj690QjmZzpdwbOD1GBOQAVblp0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PBRf9My2WZxHOGWao/COIrSO0pG/70dVr0lApyO97k3QUnlsVqDjGvMnvSF4w9LoX
	 1bYHnVlcVq2g+21Z+zYDdhyBXAJLt0+P/HhyHHVtAvNSta9lTJ/WYE+tWHVOdOgVV+
	 DP5inKGmXfT3fOXZKUzKnth4x6y99ukfn08PxTkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfEHJBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:01:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45102 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfEHJBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3foX1zSexcdw1h20N2CRNYxzqyizoRUKVKuHebbDRjs=; b=NWfk1/acOYOZ
        pIdhn6VeUkyEZc5NYPylKzP+4+ecyftkJTtEhcSc+cOWOOBr2+KI/V2OMd9+LfycVWfnjaB7++5QK
        +wwRAQ1Rdcqd5LLPfgg+FgGl5gQ/OpisQPbtm9i+BQGAOizlHvbV3YWwzkMaVVbkcsm69t20YBhcq
        aY8v4=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOISN-0007dX-P0; Wed, 08 May 2019 09:01:49 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 00B9A440035; Wed,  8 May 2019 10:01:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Applied "ASoC: hdmi-codec: remove reference to the current substream" to the asoc tree
In-Reply-To: <20190506095815.24578-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190508090129.00B9A440035@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:01:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: hdmi-codec: remove reference to the current substream

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 3fcf94ef4d418668fa66e33ce9aabb05689b55f6 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 6 May 2019 11:58:13 +0200
Subject: [PATCH] ASoC: hdmi-codec: remove reference to the current substream

If the hdmi-codec is on a codec-to-codec link, the substream pointer
it receives is completely made up by snd_soc_dai_link_event().
The pointer will be different between startup() and shutdown().

The hdmi-codec complains when this happens even if it is not really a
problem. The current_substream pointer is not used for anything useful
apart from getting the exclusive ownership of the device.

Remove current_substream pointer and replace the exclusive locking
mechanism with a simple variable and some atomic operations.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 58 ++++++++++-------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index eb31d7eddcbf..4d32f93f6be6 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -280,11 +280,10 @@ struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
 	struct snd_soc_dai_driver *daidrv;
 	struct hdmi_codec_daifmt daifmt[2];
-	struct mutex current_stream_lock;
-	struct snd_pcm_substream *current_stream;
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
+	unsigned long busy;
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -392,42 +391,22 @@ static int hdmi_codec_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	int ret = 0;
-
-	mutex_lock(&hcp->current_stream_lock);
-	if (!hcp->current_stream) {
-		hcp->current_stream = substream;
-	} else if (hcp->current_stream != substream) {
-		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
-		ret = -EINVAL;
-	}
-	mutex_unlock(&hcp->current_stream_lock);
-
-	return ret;
-}
-
 static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	ret = hdmi_codec_new_stream(substream, dai);
-	if (ret)
-		return ret;
+	ret = test_and_set_bit(0, &hcp->busy);
+	if (ret) {
+		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
+		return -EINVAL;
+	}
 
 	if (hcp->hcd.ops->audio_startup) {
 		ret = hcp->hcd.ops->audio_startup(dai->dev->parent, hcp->hcd.data);
-		if (ret) {
-			mutex_lock(&hcp->current_stream_lock);
-			hcp->current_stream = NULL;
-			mutex_unlock(&hcp->current_stream_lock);
-			return ret;
-		}
+		if (ret)
+			goto err;
 	}
 
 	if (hcp->hcd.ops->get_eld) {
@@ -437,17 +416,18 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 		if (!ret) {
 			ret = snd_pcm_hw_constraint_eld(substream->runtime,
 							hcp->eld);
-			if (ret) {
-				mutex_lock(&hcp->current_stream_lock);
-				hcp->current_stream = NULL;
-				mutex_unlock(&hcp->current_stream_lock);
-				return ret;
-			}
+			if (ret)
+				goto err;
 		}
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
 	}
 	return 0;
+
+err:
+	/* Release the exclusive lock on error */
+	clear_bit(0, &hcp->busy);
+	return ret;
 }
 
 static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
@@ -455,14 +435,10 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	WARN_ON(hcp->current_stream != substream);
-
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 	hcp->hcd.ops->audio_shutdown(dai->dev->parent, hcp->hcd.data);
 
-	mutex_lock(&hcp->current_stream_lock);
-	hcp->current_stream = NULL;
-	mutex_unlock(&hcp->current_stream_lock);
+	clear_bit(0, &hcp->busy);
 }
 
 static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
@@ -761,8 +737,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
-	mutex_init(&hcp->current_stream_lock);
-
 	hcp->daidrv = devm_kcalloc(dev, dai_count, sizeof(*hcp->daidrv),
 				   GFP_KERNEL);
 	if (!hcp->daidrv)
-- 
2.20.1

