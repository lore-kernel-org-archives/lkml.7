Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2F7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EBF217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554432205;
	bh=qVrqt+KkRlFKAVY2JWCXFG3MnK4UtCUH8sRmPEpgRpM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=m/syzq2jfEVdOpKC5aMwuTvADvO5raT5VkHOMtxB+youCSBw6D0ros7oowEvPOdXf
	 JxBrqV+vWx8bAgYirXlCwCBeXdX1OQDnZZsXvmxKgsoPsHnwxBnBl9rEpMEcnTzVjn
	 NsKDye3beqy5kZ0k7K9b0Zv3ZD8Bm9fcjWobcuJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfDECnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:43:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45212 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDECnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UyKj5DlMfcls5nBkL9KbxAAag0y7F3T0VEfF3xYYWbo=; b=Np87D4Fc8e66
        MMajCdr/lNARdBc8DEWLA8tePEmW+uh7VMbKv2sx09cokNDHpbHXqi15dhYU4nhR/3QFN/PM96x7O
        5lXk1cA+nEXTFr0Zr8B4bPVeK3h0J4vCKinUSxbbdmkllA69g2EFgfuAe9y+8jSmO4TPKOsUQOnTW
        wkq7M=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCEoy-0005EI-Ac; Fri, 05 Apr 2019 02:43:12 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E0EA0441D3C; Fri,  5 Apr 2019 09:43:08 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: axg-tdm-formatter: rework quirks settings" to the asoc tree
In-Reply-To:  <20190404111733.28705-6-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405024308.E0EA0441D3C@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 09:43:08 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-tdm-formatter: rework quirks settings

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

From f01bc67f58fde599b48d2dde5d0f48dccd84c4f1 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:17:32 +0200
Subject: [PATCH] ASoC: meson: axg-tdm-formatter: rework quirks settings

The g12a tdmout requires a different signal skew offset than the axg.
With this change, the skew offset is added as a parameter of the tdm
formatters to prepare the addition of the g12a support.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-formatter.c |  6 ++++--
 sound/soc/meson/axg-tdm-formatter.h | 11 +++++++++--
 sound/soc/meson/axg-tdmin.c         | 16 +++++++++++-----
 sound/soc/meson/axg-tdmout.c        | 16 +++++++++++-----
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 43e390f9358a..0c6cce5c5773 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
 static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
 {
 	struct axg_tdm_stream *ts = formatter->stream;
-	bool invert = formatter->drv->invert_sclk;
+	bool invert = formatter->drv->quirks->invert_sclk;
 	int ret;
 
 	/* Do nothing if the formatter is already enabled */
@@ -85,7 +85,9 @@ static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
 		return ret;
 
 	/* Setup the stream parameter in the formatter */
-	ret = formatter->drv->ops->prepare(formatter->map, formatter->stream);
+	ret = formatter->drv->ops->prepare(formatter->map,
+					   formatter->drv->quirks,
+					   formatter->stream);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/meson/axg-tdm-formatter.h b/sound/soc/meson/axg-tdm-formatter.h
index cf947caf3cb1..9ef98e955cb2 100644
--- a/sound/soc/meson/axg-tdm-formatter.h
+++ b/sound/soc/meson/axg-tdm-formatter.h
@@ -14,18 +14,25 @@ struct regmap;
 struct snd_soc_dapm_widget;
 struct snd_kcontrol;
 
+struct axg_tdm_formatter_hw {
+	unsigned int skew_offset;
+	bool invert_sclk;
+};
+
 struct axg_tdm_formatter_ops {
 	struct axg_tdm_stream *(*get_stream)(struct snd_soc_dapm_widget *w);
 	void (*enable)(struct regmap *map);
 	void (*disable)(struct regmap *map);
-	int (*prepare)(struct regmap *map, struct axg_tdm_stream *ts);
+	int (*prepare)(struct regmap *map,
+		       const struct axg_tdm_formatter_hw *quirks,
+		       struct axg_tdm_stream *ts);
 };
 
 struct axg_tdm_formatter_driver {
 	const struct snd_soc_component_driver *component_drv;
 	const struct regmap_config *regmap_cfg;
 	const struct axg_tdm_formatter_ops *ops;
-	bool invert_sclk;
+	const struct axg_tdm_formatter_hw *quirks;
 };
 
 int axg_tdm_formatter_set_channel_masks(struct regmap *map,
diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index bbac44c81688..a790f925a4ef 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -107,21 +107,22 @@ static void axg_tdmin_disable(struct regmap *map)
 	regmap_update_bits(map, TDMIN_CTRL, TDMIN_CTRL_ENABLE, 0);
 }
 
-static int axg_tdmin_prepare(struct regmap *map, struct axg_tdm_stream *ts)
+static int axg_tdmin_prepare(struct regmap *map,
+			     const struct axg_tdm_formatter_hw *quirks,
+			     struct axg_tdm_stream *ts)
 {
-	unsigned int val = 0;
+	unsigned int val, skew = quirks->skew_offset;
 
 	/* Set stream skew */
 	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_DSP_A:
-		val |= TDMIN_CTRL_IN_BIT_SKEW(3);
+		skew += 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_DSP_B:
-		val = TDMIN_CTRL_IN_BIT_SKEW(2);
 		break;
 
 	default:
@@ -130,6 +131,8 @@ static int axg_tdmin_prepare(struct regmap *map, struct axg_tdm_stream *ts)
 		return -EINVAL;
 	}
 
+	val = TDMIN_CTRL_IN_BIT_SKEW(skew);
+
 	/* Set stream format mode */
 	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -204,7 +207,10 @@ static const struct axg_tdm_formatter_driver axg_tdmin_drv = {
 	.component_drv	= &axg_tdmin_component_drv,
 	.regmap_cfg	= &axg_tdmin_regmap_cfg,
 	.ops		= &axg_tdmin_ops,
-	.invert_sclk	= false,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk	= false,
+		.skew_offset	= 2,
+	},
 };
 
 static const struct of_device_id axg_tdmin_of_match[] = {
diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
index f73368ee1088..3984818e2a7c 100644
--- a/sound/soc/meson/axg-tdmout.c
+++ b/sound/soc/meson/axg-tdmout.c
@@ -124,21 +124,22 @@ static void axg_tdmout_disable(struct regmap *map)
 	regmap_update_bits(map, TDMOUT_CTRL0, TDMOUT_CTRL0_ENABLE, 0);
 }
 
-static int axg_tdmout_prepare(struct regmap *map, struct axg_tdm_stream *ts)
+static int axg_tdmout_prepare(struct regmap *map,
+			      const struct axg_tdm_formatter_hw *quirks,
+			      struct axg_tdm_stream *ts)
 {
-	unsigned int val = 0;
+	unsigned int val, skew = quirks->skew_offset;
 
 	/* Set the stream skew */
 	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_DSP_A:
-		val |= TDMOUT_CTRL0_INIT_BITNUM(1);
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_DSP_B:
-		val |= TDMOUT_CTRL0_INIT_BITNUM(2);
+		skew += 1;
 		break;
 
 	default:
@@ -147,6 +148,8 @@ static int axg_tdmout_prepare(struct regmap *map, struct axg_tdm_stream *ts)
 		return -EINVAL;
 	}
 
+	val = TDMOUT_CTRL0_INIT_BITNUM(skew);
+
 	/* Set the slot width */
 	val |= TDMOUT_CTRL0_BITNUM(ts->iface->slot_width - 1);
 
@@ -234,7 +237,10 @@ static const struct axg_tdm_formatter_driver axg_tdmout_drv = {
 	.component_drv	= &axg_tdmout_component_drv,
 	.regmap_cfg	= &axg_tdmout_regmap_cfg,
 	.ops		= &axg_tdmout_ops,
-	.invert_sclk	= true,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk = true,
+		.skew_offset = 1,
+	},
 };
 
 static const struct of_device_id axg_tdmout_of_match[] = {
-- 
2.20.1

