Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92860C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4FD20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561741005;
	bh=rJ4OlEBOKs60ZFiLDkKLtkQASpK4DoCg6YkH/Rg4Fwk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IrBS/8JFXUQKgI4EASvrVhjdjb4/Nja0GU1VzJ0cpeDzexWsPiSYlNvlFp43/FEQT
	 IX9CV2xIq0xBA9yxLWlF6mvaCLOm2nRTHo3cXB95icO4JIQdlrcSrZGCZPrMtOcwD0
	 D/CWsDLrKGp+opF3BdpbxbknhFxfiPqDn0UXHiaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfF1Q4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:56:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42648 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfF1Q4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mYuORRk0xZXGAWkQXTq6m8XNKxs2qCDzQm+6I1NqhnA=; b=oizzJDZervGt
        YTWIgsRMqL3Dqr7hn6RVOCvCy7jlmab0rI3PEucGwSVR96Bm7x+yCRvHY95FqAKhfMGa18nrxbs21
        hN9arErAgXa5Yv/BJ8HuwT6mL4Q5UOy7XwWfmivMa2WbDb6UWxn07IgyNud6hkWq1me8kIabUiWum
        5QkL0=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hguAn-0007Br-25; Fri, 28 Jun 2019 16:56:29 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 72AE544004F; Fri, 28 Jun 2019 17:56:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: codecs: ad193x: Group register initialization at probe" to the asoc tree
In-Reply-To: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190628165628.72AE544004F@finisterre.sirena.org.uk>
Date:   Fri, 28 Jun 2019 17:56:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: ad193x: Group register initialization at probe

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

From bc0a5f43d7d6ba5258a65cf00fa692845f128d3c Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Thu, 27 Jun 2019 15:02:07 +0300
Subject: [PATCH] ASoC: codecs: ad193x: Group register initialization at probe

Create a structure with the register initialization values at probe and
use it to initialize all the registers at once.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 05f4514048e2..f3bab8fe3579 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -415,6 +415,38 @@ static struct snd_soc_dai_driver ad193x_no_adc_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
+struct ad193x_reg_default {
+	unsigned int reg;
+	unsigned int val;
+};
+
+/* codec register values to set after reset */
+static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
+{
+	const struct ad193x_reg_default reg_init[] = {
+		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
+		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
+		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
+		{  4, 0x1A },	/* DAC_CTRL2: 48kHz de-emphasis, unmute dac */
+		{  5, 0x00 },	/* DAC_CHNL_MUTE: unmute DAC channels */
+	};
+	const struct ad193x_reg_default reg_adc_init[] = {
+		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
+		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reg_init); i++)
+		regmap_write(ad193x->regmap, reg_init[i].reg, reg_init[i].val);
+
+	if (ad193x_has_adc(ad193x)) {
+		for (i = 0; i < ARRAY_SIZE(reg_adc_init); i++) {
+			regmap_write(ad193x->regmap, reg_adc_init[i].reg,
+				     reg_adc_init[i].val);
+		}
+	}
+}
+
 static int ad193x_component_probe(struct snd_soc_component *component)
 {
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
@@ -422,25 +454,7 @@ static int ad193x_component_probe(struct snd_soc_component *component)
 	int num, ret;
 
 	/* default setting for ad193x */
-
-	/* unmute dac channels */
-	regmap_write(ad193x->regmap, AD193X_DAC_CHNL_MUTE, 0x0);
-	/* de-emphasis: 48kHz, powedown dac */
-	regmap_write(ad193x->regmap, AD193X_DAC_CTRL2, 0x1A);
-	/* dac in tdm mode */
-	regmap_write(ad193x->regmap, AD193X_DAC_CTRL0, 0x40);
-
-	/* adc only */
-	if (ad193x_has_adc(ad193x)) {
-		/* high-pass filter enable */
-		regmap_write(ad193x->regmap, AD193X_ADC_CTRL0, 0x3);
-		/* sata delay=1, adc aux mode */
-		regmap_write(ad193x->regmap, AD193X_ADC_CTRL1, 0x43);
-	}
-
-	/* pll input: mclki/xi */
-	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL0, 0x99); /* mclk=24.576Mhz: 0x9D; mclk=12.288Mhz: 0x99 */
-	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL1, 0x04);
+	ad193x_reg_default_init(ad193x);
 
 	/* adc only */
 	if (ad193x_has_adc(ad193x)) {
-- 
2.20.1

