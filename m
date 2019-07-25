Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E416C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214582084C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564076632;
	bh=lfjWhSrmZWWzjsByTxj51j9uGijPRSl2jDHCgNkbg9Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=m5q7AS7BDppEXfOTQRiZpWKqAMXp2hFOo8vPH99hzuDiZ5I5F40a0dCVHTnwgLW9t
	 A4aEBMD5apbV9ZekoxZSwhByE8LpSAJjyJvvoaoUnkxnbpXxAmJe1XaiAsUUqaKPKO
	 2Fe8cpZ2m9M06epbY7GXRjk7dM6T3IVn3DVOkW7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbfGYRnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:43:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36590 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfGYRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3hutWYgyTBe2VUCgMXkh7pO498CqD2Amxaael5ohZis=; b=tlZl7MQqLsJ/
        lQTNVWyixo4iVFlVzdZW4OfTzD2PA02QNv/6Bx9lhYkrcNB4/VMSIBRvBfEnO8a1tkFLVnQOBETm/
        MrNfZjEouLs2e6PdYfYrTPKyw46hhEcxBwdYrpLQrFFZm4ikZyE/2Uty+isnTxsH6AbfgZBChg3cj
        Cdu7U=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqhmG-0003NH-QJ; Thu, 25 Jul 2019 17:43:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8B8752742B5F; Thu, 25 Jul 2019 18:43:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec2codec: deal with params when necessary" to the asoc tree
In-Reply-To: <20190725165949.29699-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190725174339.8B8752742B5F@ypsilon.sirena.org.uk>
Date:   Thu, 25 Jul 2019 18:43:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codec2codec: deal with params when necessary

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

From 3dcfb397dad2ad55bf50de3c5d5a57090d35a18a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 25 Jul 2019 18:59:46 +0200
Subject: [PATCH] ASoC: codec2codec: deal with params when necessary

When there is an event on codec to codec dai_link, we only need to deal
with params if the event is SND_SOC_DAPM_PRE_PMU, when .hw_params() is
called. For the other events, it is useless.

Also, dealing with the codec to codec params just before calling
.hw_params() callbacks give change to either party on the link to alter
params content in .startup(), which might be useful in some cases

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190725165949.29699-4-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 159 +++++++++++++++++++++++++------------------
 1 file changed, 92 insertions(+), 67 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7db4abd9a0a5..6dcaf9ff6eb5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3764,25 +3764,59 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
-static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
-				  struct snd_kcontrol *kcontrol, int event)
+static int
+snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
+			       struct snd_pcm_substream *substream)
 {
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dai *source, *sink;
-	struct snd_soc_pcm_runtime *rtd = w->priv;
-	const struct snd_soc_pcm_stream *config;
-	struct snd_pcm_substream substream;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_hw_params *params = NULL;
-	struct snd_pcm_runtime *runtime = NULL;
+	const struct snd_soc_pcm_stream *config = NULL;
 	unsigned int fmt;
-	int ret = 0;
+	int ret;
 
-	config = rtd->dai_link->params + rtd->params_select;
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
 
-	if (WARN_ON(!config) ||
-	    WARN_ON(list_empty(&w->edges[SND_SOC_DAPM_DIR_OUT]) ||
-		    list_empty(&w->edges[SND_SOC_DAPM_DIR_IN])))
-		return -EINVAL;
+	substream->stream = SNDRV_PCM_STREAM_CAPTURE;
+	snd_soc_dapm_widget_for_each_source_path(w, path) {
+		source = path->source->priv;
+
+		ret = snd_soc_dai_startup(source, substream);
+		if (ret < 0) {
+			dev_err(source->dev,
+				"ASoC: startup() failed: %d\n", ret);
+			goto out;
+		}
+		source->active++;
+	}
+
+	substream->stream = SNDRV_PCM_STREAM_PLAYBACK;
+	snd_soc_dapm_widget_for_each_sink_path(w, path) {
+		sink = path->sink->priv;
+
+		ret = snd_soc_dai_startup(sink, substream);
+		if (ret < 0) {
+			dev_err(sink->dev,
+				"ASoC: startup() failed: %d\n", ret);
+			goto out;
+		}
+		sink->active++;
+	}
+
+	/*
+	 * Note: getting the config after .startup() gives a chance to
+	 * either party on the link to alter the configuration if
+	 * necessary
+	 */
+	config = rtd->dai_link->params + rtd->params_select;
+	if (WARN_ON(!config)) {
+		dev_err(w->dapm->dev, "ASoC: link config missing\n");
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Be a little careful as we don't want to overflow the mask array */
 	if (config->formats) {
@@ -3790,27 +3824,62 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	} else {
 		dev_warn(w->dapm->dev, "ASoC: Invalid format %llx specified\n",
 			 config->formats);
-		fmt = 0;
-	}
 
-	/* Currently very limited parameter selection */
-	params = kzalloc(sizeof(*params), GFP_KERNEL);
-	if (!params) {
-		ret = -ENOMEM;
+		ret = -EINVAL;
 		goto out;
 	}
-	snd_mask_set(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT), fmt);
 
+	snd_mask_set(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT), fmt);
 	hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->min =
 		config->rate_min;
 	hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->max =
 		config->rate_max;
-
 	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->min
 		= config->channels_min;
 	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max
 		= config->channels_max;
 
+	substream->stream = SNDRV_PCM_STREAM_CAPTURE;
+	snd_soc_dapm_widget_for_each_source_path(w, path) {
+		source = path->source->priv;
+
+		ret = snd_soc_dai_hw_params(source, substream, params);
+		if (ret < 0)
+			goto out;
+
+		dapm_update_dai_unlocked(substream, params, source);
+	}
+
+	substream->stream = SNDRV_PCM_STREAM_PLAYBACK;
+	snd_soc_dapm_widget_for_each_sink_path(w, path) {
+		sink = path->sink->priv;
+
+		ret = snd_soc_dai_hw_params(sink, substream, params);
+		if (ret < 0)
+			goto out;
+
+		dapm_update_dai_unlocked(substream, params, sink);
+	}
+
+out:
+	kfree(params);
+	return 0;
+}
+
+static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_dapm_path *path;
+	struct snd_soc_dai *source, *sink;
+	struct snd_soc_pcm_runtime *rtd = w->priv;
+	struct snd_pcm_substream substream;
+	struct snd_pcm_runtime *runtime = NULL;
+	int ret = 0;
+
+	if (WARN_ON(list_empty(&w->edges[SND_SOC_DAPM_DIR_OUT]) ||
+		    list_empty(&w->edges[SND_SOC_DAPM_DIR_IN])))
+		return -EINVAL;
+
 	memset(&substream, 0, sizeof(substream));
 
 	/* Allocate a dummy snd_pcm_runtime for startup() and other ops() */
@@ -3824,53 +3893,10 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
-		snd_soc_dapm_widget_for_each_source_path(w, path) {
-			source = path->source->priv;
-
-			ret = snd_soc_dai_startup(source, &substream);
-			if (ret < 0) {
-				dev_err(source->dev,
-					"ASoC: startup() failed: %d\n", ret);
-				goto out;
-			}
-			source->active++;
-		}
-
-		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
-		snd_soc_dapm_widget_for_each_sink_path(w, path) {
-			sink = path->sink->priv;
-
-			ret = snd_soc_dai_startup(sink, &substream);
-			if (ret < 0) {
-				dev_err(sink->dev,
-					"ASoC: startup() failed: %d\n", ret);
-				goto out;
-			}
-			sink->active++;
-		}
-
-		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
-		snd_soc_dapm_widget_for_each_source_path(w, path) {
-			source = path->source->priv;
-
-			ret = snd_soc_dai_hw_params(source, &substream, params);
-			if (ret < 0)
-				goto out;
-
-			dapm_update_dai_unlocked(&substream, params, source);
-		}
-
-		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
-		snd_soc_dapm_widget_for_each_sink_path(w, path) {
-			sink = path->sink->priv;
-
-			ret = snd_soc_dai_hw_params(sink, &substream, params);
-			if (ret < 0)
-				goto out;
+		ret = snd_soc_dai_link_event_pre_pmu(w, &substream);
+		if (ret < 0)
+			goto out;
 
-			dapm_update_dai_unlocked(&substream, params, sink);
-		}
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
@@ -3932,7 +3958,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 
 out:
 	kfree(runtime);
-	kfree(params);
 	return ret;
 }
 
-- 
2.20.1

