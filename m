Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B911C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF04218BB
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564572606;
	bh=QAX9f558ujnbm03RF+HaZQs+4IEmD7mmA/kX5muTztE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=k5ffU9IuAE4bGo7e07Gf+5KyvREFWAm3o0kR44WraMz/0QsVshEqpS9gxJljg9Umu
	 VQ54fbnrrAW6TJGjIxBC6QDcehG2inOnW07ZF1ArMEpwk3CLaniNSbjpqByBJJ0/DZ
	 yXJnlIy5pwqiqX95dMSbLN1SHLC05QXXDWG5RldY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbfGaLaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:30:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34446 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfGaLaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QcGmBVpDOdgqukjU+sGeVWU68WD55hAUZCPdArb9dVo=; b=it7QpXTqCKjT
        EjZ4pPZAezG1Z4SYVc4k4tvPHDuAiPs5gTSOa9r3/JEL8KULqKbFMiXjHu/pQcMGivq9kOje2fdrw
        JEDRLSsdNqcOWn2Td/uZT031g39gliOgRJv5TT3AH10z52mLuJiR9LQzg4r5yLkF4+xc0m9xDqy2u
        5sdVQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsmno-0001pQ-0o; Wed, 31 Jul 2019 11:29:52 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 41B9A2742CC3; Wed, 31 Jul 2019 12:29:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: g12a-tohdmitx: override codec2codec params" to the asoc tree
In-Reply-To: <20190729080139.32068-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190731112951.41B9A2742CC3@ypsilon.sirena.org.uk>
Date:   Wed, 31 Jul 2019 12:29:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: g12a-tohdmitx: override codec2codec params

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

From 2c4956bc1e9062e5e3c5ea7612294f24e6d4fbdd Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Jul 2019 10:01:39 +0200
Subject: [PATCH] ASoC: meson: g12a-tohdmitx: override codec2codec params

So far, forwarding the hw_params of the input to output relied on the
.hw_params() callback of the cpu side of the codec2codec link to be called
first. This is a bit weak.

Instead, override the stream params of the codec2codec to link to set it up
correctly.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190729080139.32068-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/g12a-tohdmitx.c | 34 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
index 707ccb192e4c..9943c807ec5d 100644
--- a/sound/soc/meson/g12a-tohdmitx.c
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -28,7 +28,7 @@
 #define  CTRL0_SPDIF_CLK_SEL		BIT(0)
 
 struct g12a_tohdmitx_input {
-	struct snd_pcm_hw_params params;
+	struct snd_soc_pcm_stream params;
 	unsigned int fmt;
 };
 
@@ -225,26 +225,17 @@ static int g12a_tohdmitx_input_hw_params(struct snd_pcm_substream *substream,
 {
 	struct g12a_tohdmitx_input *data = dai->playback_dma_data;
 
-	/* Save the stream params for the downstream link */
-	memcpy(&data->params, params, sizeof(*params));
+	data->params.rates = snd_pcm_rate_to_rate_bit(params_rate(params));
+	data->params.rate_min = params_rate(params);
+	data->params.rate_max = params_rate(params);
+	data->params.formats = 1 << params_format(params);
+	data->params.channels_min = params_channels(params);
+	data->params.channels_max = params_channels(params);
+	data->params.sig_bits = dai->driver->playback.sig_bits;
 
 	return 0;
 }
 
-static int g12a_tohdmitx_output_hw_params(struct snd_pcm_substream *substream,
-					  struct snd_pcm_hw_params *params,
-					  struct snd_soc_dai *dai)
-{
-	struct g12a_tohdmitx_input *in_data =
-		g12a_tohdmitx_get_input_data(dai->capture_widget);
-
-	if (!in_data)
-		return -ENODEV;
-
-	memcpy(params, &in_data->params, sizeof(*params));
-
-	return 0;
-}
 
 static int g12a_tohdmitx_input_set_fmt(struct snd_soc_dai *dai,
 				       unsigned int fmt)
@@ -266,6 +257,14 @@ static int g12a_tohdmitx_output_startup(struct snd_pcm_substream *substream,
 	if (!in_data)
 		return -ENODEV;
 
+	if (WARN_ON(!rtd->dai_link->params)) {
+		dev_warn(dai->dev, "codec2codec link expected\n");
+		return -EINVAL;
+	}
+
+	/* Replace link params with the input params */
+	rtd->dai_link->params = &in_data->params;
+
 	if (!in_data->fmt)
 		return 0;
 
@@ -278,7 +277,6 @@ static const struct snd_soc_dai_ops g12a_tohdmitx_input_ops = {
 };
 
 static const struct snd_soc_dai_ops g12a_tohdmitx_output_ops = {
-	.hw_params	= g12a_tohdmitx_output_hw_params,
 	.startup	= g12a_tohdmitx_output_startup,
 };
 
-- 
2.20.1

