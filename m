Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C3AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D487020833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560785072;
	bh=7PGMc93B9XELF3aw4zKkWOJb/Ayc5gHvvahUQcyWw0Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=we13V0IOUWTizxnYKzNUThYGkZgIcCStFm8yWDweOeD5Plw0rBL6Auf4aDU/8BAUv
	 roVnS7FEXXZYVpjsYt2Cm3FbGeBB4qA7V1jtXWMiaosAIm19mPvQSNP5kCXnkvDNj9
	 vdKvFrozPMqBR71xRT9VoPgn5QOeB7KbbI6UXcAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfFQPYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:24:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51328 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfFQPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wOd9Qi3GjEKts3WISLUYsBotXm/VRmWrNM78cMe3Cjw=; b=N7RxbLBUWdzg
        PeQTW1bRfWlwWuT6qrA66B6HGk8eyu8HgivLsK2yq3RXzouBzUwcdzFMDxtq+rBmObnFRm0oQkclL
        0edfnJ5iGch3mRGWSg+sOGqJvh3gQ1/5mvJtwn/HFG6NVSy6d/PSHKXwLgFYzPK//1vc1eJbumoo9
        fMyXE=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctUX-0001wr-0D; Mon, 17 Jun 2019 15:24:17 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5C81C440046; Mon, 17 Jun 2019 16:24:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     alsa-devel@alsa-project.org, Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt5677: move jack-detect init to i2c probe" to the asoc tree
In-Reply-To: <20190614194854.208436-3-fletcherw@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190617152416.5C81C440046@finisterre.sirena.org.uk>
Date:   Mon, 17 Jun 2019 16:24:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5677: move jack-detect init to i2c probe

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

From 241800642ea3482ab3f80a2a3662e9f2e6a82208 Mon Sep 17 00:00:00 2001
From: Fletcher Woodruff <fletcherw@chromium.org>
Date: Fri, 14 Jun 2019 13:48:52 -0600
Subject: [PATCH] ASoC: rt5677: move jack-detect init to i2c probe

This patch moves the code to select the gpios for jack detection
from rt5677_probe to rt5677_init_irq (called from rt5677_i2c_probe).

It also sets some registers to fix bugs related to jack detection, and
adds some constants and comments to make it easier to understand what
certain register settings are controlling.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 60 ++++++++++++++++++++++-----------------
 sound/soc/codecs/rt5677.h |  6 ++++
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index fe000f30b9ad..87a92ba0d040 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4716,37 +4716,13 @@ static int rt5677_probe(struct snd_soc_component *component)
 
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
-	regmap_write(rt5677->regmap, RT5677_DIG_MISC, 0x0020);
+	regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC,
+			~RT5677_IRQ_DEBOUNCE_SEL_MASK, 0x0020);
 	regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x0c00);
 
 	for (i = 0; i < RT5677_GPIO_NUM; i++)
 		rt5677_gpio_config(rt5677, i, rt5677->pdata.gpio_config[i]);
 
-	if (rt5677->irq_data) {
-		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1, 0x8000,
-			0x8000);
-		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x0018,
-			0x0008);
-
-		if (rt5677->pdata.jd1_gpio)
-			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
-				RT5677_SEL_GPIO_JD1_MASK,
-				rt5677->pdata.jd1_gpio <<
-				RT5677_SEL_GPIO_JD1_SFT);
-
-		if (rt5677->pdata.jd2_gpio)
-			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
-				RT5677_SEL_GPIO_JD2_MASK,
-				rt5677->pdata.jd2_gpio <<
-				RT5677_SEL_GPIO_JD2_SFT);
-
-		if (rt5677->pdata.jd3_gpio)
-			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
-				RT5677_SEL_GPIO_JD3_MASK,
-				rt5677->pdata.jd3_gpio <<
-				RT5677_SEL_GPIO_JD3_SFT);
-	}
-
 	mutex_init(&rt5677->dsp_cmd_lock);
 	mutex_init(&rt5677->dsp_pri_lock);
 
@@ -5096,6 +5072,7 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 {
 	int ret;
 	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
+	unsigned int jd_mask = 0, jd_val = 0;
 
 	if (!rt5677->pdata.jd1_gpio &&
 		!rt5677->pdata.jd2_gpio &&
@@ -5107,6 +5084,37 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 		return -EINVAL;
 	}
 
+	/*
+	 * Select RC as the debounce clock so that GPIO works even when
+	 * MCLK is gated which happens when there is no audio stream
+	 * (SND_SOC_BIAS_OFF).
+	 */
+	regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC,
+			RT5677_IRQ_DEBOUNCE_SEL_MASK,
+			RT5677_IRQ_DEBOUNCE_SEL_RC);
+
+	/* Enable auto power on RC when GPIO states are changed */
+	regmap_update_bits(rt5677->regmap, RT5677_GEN_CTRL1, 0xff, 0xff);
+
+	/* Select and enable jack detection sources per platform data */
+	if (rt5677->pdata.jd1_gpio) {
+		jd_mask	|= RT5677_SEL_GPIO_JD1_MASK;
+		jd_val	|= rt5677->pdata.jd1_gpio << RT5677_SEL_GPIO_JD1_SFT;
+	}
+	if (rt5677->pdata.jd2_gpio) {
+		jd_mask	|= RT5677_SEL_GPIO_JD2_MASK;
+		jd_val	|= rt5677->pdata.jd2_gpio << RT5677_SEL_GPIO_JD2_SFT;
+	}
+	if (rt5677->pdata.jd3_gpio) {
+		jd_mask	|= RT5677_SEL_GPIO_JD3_MASK;
+		jd_val	|= rt5677->pdata.jd3_gpio << RT5677_SEL_GPIO_JD3_SFT;
+	}
+	regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1, jd_mask, jd_val);
+
+	/* Set GPIO1 pin to be IRQ output */
+	regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1,
+			RT5677_GPIO1_PIN_MASK, RT5677_GPIO1_PIN_IRQ);
+
 	ret = regmap_add_irq_chip(rt5677->regmap, i2c->irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT, 0,
 		&rt5677_irq_chip, &rt5677->irq_data);
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 076e5161d8da..c26edd387e34 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1664,6 +1664,12 @@
 #define RT5677_GPIO6_P_NOR			(0x0 << 0)
 #define RT5677_GPIO6_P_INV			(0x1 << 0)
 
+/* General Control (0xfa) */
+#define RT5677_IRQ_DEBOUNCE_SEL_MASK		(0x3 << 3)
+#define RT5677_IRQ_DEBOUNCE_SEL_MCLK		(0x0 << 3)
+#define RT5677_IRQ_DEBOUNCE_SEL_RC		(0x1 << 3)
+#define RT5677_IRQ_DEBOUNCE_SEL_SLIM		(0x2 << 3)
+
 /* Virtual DSP Mixer Control (0xf7 0xf8 0xf9) */
 #define RT5677_DSP_IB_01_H			(0x1 << 15)
 #define RT5677_DSP_IB_01_H_SFT			15
-- 
2.20.1

