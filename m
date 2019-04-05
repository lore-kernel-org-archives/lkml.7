Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AD2C10F13
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B00C218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554432207;
	bh=ecQ3/QfLeGhLkjz7C3afJZ5i3XA770EpXrw9X8WRUVY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VgsfKF3VCD3IMF1tl/LDrMjnNft4qktvj9ZRS/4XBgUjJNoPEgj+eWB9vF8p9xBb7
	 nK9ERJKuhloU4+jvwmQUyP3zQmn1kMOqwwSLevwN8yi5dz7Nq6ryo7K+WmuTYXLq4y
	 9IvtxR2XObpN9F69Ev3TCWoo/rkk6uZHye4SM2Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfDECnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:43:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDECnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iyswIuIXLt3/9SO6gpWFMWb/+gQjPoJq3Mser0iVGWo=; b=rDjpxvV24yve
        YXNE2nt3nVR1rJJZ0OdBD0pI5hhgcYdIfMPeUz5bltpyJYiUlxd11DEtyb38/cg/T3VWFdBrjogpM
        9eRuiIn0krX052Y8R+9CDzpk6WS6UvCZ0EeAk7hn9V7D8XCAQp6xqaaLK201VG3D1WHY3pUrN57j/
        wL/Zs=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCEp4-0005Eb-GJ; Fri, 05 Apr 2019 02:43:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7F18E441D3C; Fri,  5 Apr 2019 09:43:15 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: axg-toddr: add g12a support" to the asoc tree
In-Reply-To:  <20190404111733.28705-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405024315.7F18E441D3C@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 09:43:15 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-toddr: add g12a support

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

From a3c23a8ad4dc07100d916d75ca30c982288b868d Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:17:30 +0200
Subject: [PATCH] ASoC: meson: axg-toddr: add g12a support

Since the g12a SoC fifo can set the fifo initial start address, we must
make sure to actually reset the write pointer to this address when
starting a capture.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-toddr.c | 53 +++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 0e9ca3882ae5..4f63e434fad4 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -24,6 +24,7 @@
 #define CTRL0_TODDR_MSB_POS(x)		((x) << 8)
 #define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
 #define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
+#define CTRL1_TODDR_FORCE_FINISH	BIT(25)
 
 #define TODDR_MSB_POS	31
 
@@ -33,6 +34,22 @@ static int axg_toddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	return axg_fifo_pcm_new(rtd, SNDRV_PCM_STREAM_CAPTURE);
 }
 
+static int g12a_toddr_dai_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+
+	/* Reset the write pointer to the FIFO_INIT_ADDR */
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, 0);
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, CTRL1_TODDR_FORCE_FINISH);
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, 0);
+
+	return 0;
+}
+
 static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -172,10 +189,46 @@ static const struct axg_fifo_match_data axg_toddr_match_data = {
 	.dai_drv	= &axg_toddr_dai_drv
 };
 
+static const struct snd_soc_dai_ops g12a_toddr_ops = {
+	.prepare	= g12a_toddr_dai_prepare,
+	.hw_params	= axg_toddr_dai_hw_params,
+	.startup	= axg_toddr_dai_startup,
+	.shutdown	= axg_toddr_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver g12a_toddr_dai_drv = {
+	.name = "TODDR",
+	.capture = {
+		.stream_name	= "Capture",
+		.channels_min	= 1,
+		.channels_max	= AXG_FIFO_CH_MAX,
+		.rates		= AXG_FIFO_RATES,
+		.formats	= AXG_FIFO_FORMATS,
+	},
+	.ops		= &g12a_toddr_ops,
+	.pcm_new	= axg_toddr_pcm_new,
+};
+
+static const struct snd_soc_component_driver g12a_toddr_component_drv = {
+	.dapm_widgets		= axg_toddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_toddr_dapm_widgets),
+	.dapm_routes		= axg_toddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_toddr_dapm_routes),
+	.ops			= &g12a_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data g12a_toddr_match_data = {
+	.component_drv	= &g12a_toddr_component_drv,
+	.dai_drv	= &g12a_toddr_dai_drv
+};
+
 static const struct of_device_id axg_toddr_of_match[] = {
 	{
 		.compatible = "amlogic,axg-toddr",
 		.data = &axg_toddr_match_data,
+	}, {
+		.compatible = "amlogic,g12a-toddr",
+		.data = &g12a_toddr_match_data,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_toddr_of_match);
-- 
2.20.1

