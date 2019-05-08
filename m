Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F8C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1600C214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557306108;
	bh=3lVs43UEkhF7T1qGGgMvzS45dl7693bNEg3z2tjnyhM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Stp0KtXeLIDiUfodOBZO48G7ZkzyUGii7W86GxVYJd0TCGg9uEt1bAHN7LMc0VQ9I
	 1H34+aLOIph43vhLjYjZsRpBtN4IVrjc7wZnRI+s6+0TntX8E1Bm+Lw985axITjp44
	 FF+mZMvNJiy4Grlu1Q73RvAyeFgxGdVGdf+sM6eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEHJBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:01:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44826 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEHJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jLxFpJS05ZYrxx0fuMS+5wjxjXR7kCedppzu/OUwilA=; b=r/8bGS+ZlFTm
        MOHumLydScMrBTCMl4/2Xl45tKOy5iwxXqAleiJaCn7X5SlmDg/ws4nSfe/PjHIEmxaQLDQ5G/+oL
        lbpqTZK2KYzVIH4QMi6rYHWvdW19MOLgXOJpAM8maRC28YE3XYG1nVtzC/nYbrv5+6H+80R6nCJ5I
        cJuMw=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOISG-0007dR-MH; Wed, 08 May 2019 09:01:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6916C440034; Wed,  8 May 2019 10:01:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Applied "ASoC: hdmi-codec: remove reference to the dai drivers in the private data" to the asoc tree
In-Reply-To: <20190506095815.24578-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190508090128.6916C440034@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:01:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: hdmi-codec: remove reference to the dai drivers in the private data

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

From 1de005d47d90343666c5cc50a50929e05e52baac Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 6 May 2019 11:58:14 +0200
Subject: [PATCH] ASoC: hdmi-codec: remove reference to the dai drivers in the
 private data

Keeping the a pointer to the dai drivers is not necessary. It is not used
by the hdmi_codec after the probe.

Even if it was used, the 'struct snd_soc_dai_driver' can accessed through
the 'struct snd_soc_dai' so keeping the pointer in the private data
structure is not useful.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 4d32f93f6be6..9408e6bc4d3e 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -278,7 +278,6 @@ static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
-	struct snd_soc_dai_driver *daidrv;
 	struct hdmi_codec_daifmt daifmt[2];
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
@@ -715,6 +714,7 @@ static const struct snd_soc_component_driver hdmi_driver = {
 static int hdmi_codec_probe(struct platform_device *pdev)
 {
 	struct hdmi_codec_pdata *hcd = pdev->dev.platform_data;
+	struct snd_soc_dai_driver *daidrv;
 	struct device *dev = &pdev->dev;
 	struct hdmi_codec_priv *hcp;
 	int dai_count, i = 0;
@@ -737,27 +737,25 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
-	hcp->daidrv = devm_kcalloc(dev, dai_count, sizeof(*hcp->daidrv),
-				   GFP_KERNEL);
-	if (!hcp->daidrv)
+	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
+	if (!daidrv)
 		return -ENOMEM;
 
 	if (hcd->i2s) {
-		hcp->daidrv[i] = hdmi_i2s_dai;
-		hcp->daidrv[i].playback.channels_max =
-			hcd->max_i2s_channels;
+		daidrv[i] = hdmi_i2s_dai;
+		daidrv[i].playback.channels_max = hcd->max_i2s_channels;
 		i++;
 	}
 
 	if (hcd->spdif) {
-		hcp->daidrv[i] = hdmi_spdif_dai;
+		daidrv[i] = hdmi_spdif_dai;
 		hcp->daifmt[DAI_ID_SPDIF].fmt = HDMI_SPDIF;
 	}
 
 	dev_set_drvdata(dev, hcp);
 
-	ret = devm_snd_soc_register_component(dev, &hdmi_driver, hcp->daidrv,
-				     dai_count);
+	ret = devm_snd_soc_register_component(dev, &hdmi_driver, daidrv,
+					      dai_count);
 	if (ret) {
 		dev_err(dev, "%s: snd_soc_register_component() failed (%d)\n",
 			__func__, ret);
-- 
2.20.1

