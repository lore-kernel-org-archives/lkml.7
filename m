Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05590C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF37E21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103008;
	bh=yPjnqRl80YyL7+Kxp/L2bm8pusrcG0BCTvW3IuSreZw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Ce4hYQNQoHDGCGoju9yDix4OLOlbwwbGyDcJX3V3e/fb5/hCVc0+wr9gL9vPxp7ga
	 fBNH37sTz7k23CHkZVt/kXgLl9bRE5KBLKnyh98CUjI0NQsbOv77rmCp1+1aezy6hn
	 d/fNj4G1WBEBMpT34NN8Jafd/Qn0wNhGi03fwph0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCTRaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCTRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oalBAalad9BFR9xpLekBS/inXxQm0qYEyaU8tivC5Dw=; b=ZA6ssFbrrb1m
        ZtNFHAjNUQuc3lYRTdfhCEfnX11ARSoqHDOAm7TTilNSkE4Jq7Aplhd+7/S45QZS3qY78p5jPc279
        A9MtD2c1328Fj7t+eFKurj97L6jiRv3MEbBNu9kMWL5EIagC8Kj/oM0s1Hq4nBIiVnXMJmSEaZk5P
        EoE+A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f1t-000185-2C; Wed, 20 Mar 2019 17:29:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9818A1126E4C; Wed, 20 Mar 2019 17:29:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: dfsdm: manage multiple prepare" to the asoc tree
In-Reply-To:  <1551711165-28684-2-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190320172923.9818A1126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: dfsdm: manage multiple prepare

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

From 19441e35a43b616ea6afad91ed0d9e77268d8f6a Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 4 Mar 2019 15:52:43 +0100
Subject: [PATCH] ASoC: stm32: dfsdm: manage multiple prepare

The DFSDM must be stopped when a new setting is applied.
restart systematically DFSDM on multiple prepare calls,
to apply changes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 47901983a6ff..d77f0421e4f0 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -37,6 +38,8 @@ struct stm32_adfsdm_priv {
 	/* PCM buffer */
 	unsigned char *pcm_buff;
 	unsigned int pos;
+
+	struct mutex lock; /* protect against race condition on iio state */
 };
 
 static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
@@ -62,10 +65,12 @@ static void stm32_adfsdm_shutdown(struct snd_pcm_substream *substream,
 {
 	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
 
+	mutex_lock(&priv->lock);
 	if (priv->iio_active) {
 		iio_channel_stop_all_cb(priv->iio_cb);
 		priv->iio_active = false;
 	}
+	mutex_unlock(&priv->lock);
 }
 
 static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
@@ -74,13 +79,19 @@ static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
 	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	mutex_lock(&priv->lock);
+	if (priv->iio_active) {
+		iio_channel_stop_all_cb(priv->iio_cb);
+		priv->iio_active = false;
+	}
+
 	ret = iio_write_channel_attribute(priv->iio_ch,
 					  substream->runtime->rate, 0,
 					  IIO_CHAN_INFO_SAMP_FREQ);
 	if (ret < 0) {
 		dev_err(dai->dev, "%s: Failed to set %d sampling rate\n",
 			__func__, substream->runtime->rate);
-		return ret;
+		goto out;
 	}
 
 	if (!priv->iio_active) {
@@ -92,6 +103,9 @@ static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
 				__func__, ret);
 	}
 
+out:
+	mutex_unlock(&priv->lock);
+
 	return ret;
 }
 
@@ -299,6 +313,7 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	priv->dai_drv = stm32_adfsdm_dai;
+	mutex_init(&priv->lock);
 
 	dev_set_drvdata(&pdev->dev, priv);
 
-- 
2.20.1

