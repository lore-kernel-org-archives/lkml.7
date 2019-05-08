Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E3AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719F5216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557306111;
	bh=dVYV3DbDCfMelU7f+xf44Tp8pBMtQf4mKgysG4ZvsRM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LHvSqCJgVLG5duocGl1JXFe4tqkV+ztepjyq9qZtZWgTARmYn9mxRbahJZnuH4dk8
	 13nG1Ke3zVWYFsIhUOvYFX5wbQtENN6SbUPe+cs94zwWRJfGNB3dMikZTTlaHJuj4M
	 yXBoJjtaUuGaFwLuNoBMzrbD85vykbp0CORkd9Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEHJBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:01:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44960 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEHJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OZSKu6gy0jL8wesxVTcC/2QJcoQ2eYauP88jNhYxHUE=; b=tJ8mI5REkGI+
        RTNiLmDkj1AaXt3vNEanI7bDDjogg3RflGYBLLmsEawPdykHdQhb5rLioGPI7UcDsZPfI5sABbZ3f
        5dBVjVhpHNfEv6h/XJr9UMjZ9MsHM2HAwuZNk3SlPItDBc/LsJnrZDDQbTOdWwju4CaG7Xgp5O9MP
        mQ/78=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOISH-0007dW-3w; Wed, 08 May 2019 09:01:39 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 85A0D440036; Wed,  8 May 2019 10:01:29 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Applied "ASoC: hdmi-codec: remove function name debug traces" to the asoc tree
In-Reply-To: <20190506095815.24578-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190508090129.85A0D440036@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:01:29 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: hdmi-codec: remove function name debug traces

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

From 900e5daf7034cf65ce4072b86f297c42f9042433 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 6 May 2019 11:58:12 +0200
Subject: [PATCH] ASoC: hdmi-codec: remove function name debug traces

Remove the debug traces only showing the function name on entry.
The same can be obtained using ftrace.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 39caf19abb0b..eb31d7eddcbf 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -416,8 +416,6 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret = hdmi_codec_new_stream(substream, dai);
 	if (ret)
 		return ret;
@@ -457,8 +455,6 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	WARN_ON(hcp->current_stream != substream);
 
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
@@ -527,8 +523,6 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	struct hdmi_codec_daifmt cf = { 0 };
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (dai->id == DAI_ID_SPDIF)
 		return 0;
 
@@ -597,8 +591,6 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (hcp->hcd.ops->digital_mute)
 		return hcp->hcd.ops->digital_mute(dai->dev->parent,
 						  hcp->hcd.data, mute);
@@ -656,8 +648,6 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	};
 	int ret;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				      NULL, drv->playback.channels_max, 0,
 				      &hcp->chmap_info);
@@ -754,8 +744,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	int dai_count, i = 0;
 	int ret;
 
-	dev_dbg(dev, "%s()\n", __func__);
-
 	if (!hcd) {
 		dev_err(dev, "%s: No platform data\n", __func__);
 		return -EINVAL;
-- 
2.20.1

