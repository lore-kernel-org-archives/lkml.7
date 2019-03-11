Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE96A20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325024;
	bh=uU12uTsRPOGiYuB6QZAJ0LCrLtd9PFc1YKEa7hVAjeM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=e23al0udRiyRAWUjCM4v6NxydhHTBTwaYvD22JPSYI7GBz6odhTKarqvKoFdfpEsj
	 wBjKEYUs1fSoukRqPnvOie0Fhe+Mm9e+kws18p1XaiI+7jbKWEcA7sNcp09FXDp55+
	 ae7r5BxXXX8z8FFXz2DN6As+psu4cprLZ1sqa7Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfCKRXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:23:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49816 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfCKRXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hcxY13NOHnSFaaLSuZXOLFWv8u3iM3oCfS2F5I5URkg=; b=vwY8zfB+3r7T
        I9+F32vJ9EooWLjNwTxJjlIbe5zq34fzltikH75TIuApXgAuJBeJ8ZNCBqTGtpD74ScXW9fKJTeUe
        fc3I7Gn+LIzD6Z5FFnT4Z7bo65zBPDcIdjnQck8AHxpzgW2F12Ra7Z0O+aTGKstNHUS8Xbb41dzyo
        IV/s8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3Ody-0005Kj-Te; Mon, 11 Mar 2019 17:23:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 508771128896; Mon, 11 Mar 2019 17:23:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: axi-i2s: let both capture and playback be optional" to the asoc tree
In-Reply-To:  <20190307214456.16445-1-luca@lucaceresoli.net>
X-Patchwork-Hint: ignore
Message-Id: <20190311172318.508771128896@debutante.sirena.org.uk>
Date:   Mon, 11 Mar 2019 17:23:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: axi-i2s: let both capture and playback be optional

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

From 7bf7d0554890c53478ec04d3d4bfced0c881f6c8 Mon Sep 17 00:00:00 2001
From: Luca Ceresoli <luca@lucaceresoli.net>
Date: Thu, 7 Mar 2019 22:44:55 +0100
Subject: [PATCH] ASoC: axi-i2s: let both capture and playback be optional

Both the capture and playback channels are optional in the axi_i2s IP
block. Reflect this in the driver by enabling only the channel(s) that
have a DMA.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/adi/axi-i2s.c | 68 +++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
index 4c23381727a1..273c543e8ff3 100644
--- a/sound/soc/adi/axi-i2s.c
+++ b/sound/soc/adi/axi-i2s.c
@@ -43,6 +43,9 @@ struct axi_i2s {
 	struct clk *clk;
 	struct clk *clk_ref;
 
+	bool   has_capture;
+	bool   has_playback;
+
 	struct snd_soc_dai_driver dai_driver;
 
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
@@ -136,8 +139,10 @@ static int axi_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
-	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
-		&i2s->capture_dma_data);
+	snd_soc_dai_init_dma_data(
+		dai,
+		i2s->has_playback ? &i2s->playback_dma_data : NULL,
+		i2s->has_capture  ? &i2s->capture_dma_data  : NULL);
 
 	return 0;
 }
@@ -151,18 +156,6 @@ static const struct snd_soc_dai_ops axi_i2s_dai_ops = {
 
 static struct snd_soc_dai_driver axi_i2s_dai = {
 	.probe = axi_i2s_dai_probe,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE,
-	},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE,
-	},
 	.ops = &axi_i2s_dai_ops,
 	.symmetric_rates = 1,
 };
@@ -178,6 +171,19 @@ static const struct regmap_config axi_i2s_regmap_config = {
 	.max_register = AXI_I2S_REG_STATUS,
 };
 
+static void axi_i2s_parse_of(struct axi_i2s *i2s, const struct device_node *np)
+{
+	struct property *dma_names;
+	const char *dma_name;
+
+	of_property_for_each_string(np, "dma-names", dma_names, dma_name) {
+		if (strcmp(dma_name, "rx") == 0)
+			i2s->has_capture = true;
+		if (strcmp(dma_name, "tx") == 0)
+			i2s->has_playback = true;
+	}
+}
+
 static int axi_i2s_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -191,6 +197,8 @@ static int axi_i2s_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2s);
 
+	axi_i2s_parse_of(i2s, pdev->dev.of_node);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
@@ -213,13 +221,29 @@ static int axi_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	i2s->playback_dma_data.addr = res->start + AXI_I2S_REG_TX_FIFO;
-	i2s->playback_dma_data.addr_width = 4;
-	i2s->playback_dma_data.maxburst = 1;
+	if (i2s->has_playback) {
+		axi_i2s_dai.playback.channels_min = 2;
+		axi_i2s_dai.playback.channels_max = 2;
+		axi_i2s_dai.playback.rates = SNDRV_PCM_RATE_KNOT;
+		axi_i2s_dai.playback.formats =
+			SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE;
+
+		i2s->playback_dma_data.addr = res->start + AXI_I2S_REG_TX_FIFO;
+		i2s->playback_dma_data.addr_width = 4;
+		i2s->playback_dma_data.maxburst = 1;
+	}
+
+	if (i2s->has_capture) {
+		axi_i2s_dai.capture.channels_min = 2;
+		axi_i2s_dai.capture.channels_max = 2;
+		axi_i2s_dai.capture.rates = SNDRV_PCM_RATE_KNOT;
+		axi_i2s_dai.capture.formats =
+			SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE;
 
-	i2s->capture_dma_data.addr = res->start + AXI_I2S_REG_RX_FIFO;
-	i2s->capture_dma_data.addr_width = 4;
-	i2s->capture_dma_data.maxburst = 1;
+		i2s->capture_dma_data.addr = res->start + AXI_I2S_REG_RX_FIFO;
+		i2s->capture_dma_data.addr_width = 4;
+		i2s->capture_dma_data.maxburst = 1;
+	}
 
 	i2s->ratnum.num = clk_get_rate(i2s->clk_ref) / 2 / AXI_I2S_BITS_PER_FRAME;
 	i2s->ratnum.den_step = 1;
@@ -240,6 +264,10 @@ static int axi_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
+	dev_info(&pdev->dev, "probed, capture %s, playback %s\n",
+		 i2s->has_capture ? "enabled" : "disabled",
+		 i2s->has_playback ? "enabled" : "disabled");
+
 	return 0;
 
 err_clk_disable:
-- 
2.20.1

