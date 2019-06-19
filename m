Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD56C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEDE2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560946339;
	bh=aZNegzWPXQOuPjJxqQTD/Tkk4WzYcPaeLIm1ItQBZiI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zEcEBW6RqkHJgiMjDdbssfeaspthvWlQ+v+t61WDMfa25WEhpKrodZbw9RjNwmYyf
	 vVdwK4VNiZli74C1/lRNYcNqI9wFvH/Brf0arH4mwbwiiOzePQ12wrFyBbPyP52M+x
	 XjBm3KshPOPfI8HJn3umOYSwQFRd2wF6Lm2z6b9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfFSMMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:12:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47242 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=snQJobh8czVKTg/I7XmAMC//h5sCelbeXeW1T7VZK0w=; b=WScSqMZ52UvS
        BQ9xCl04ZX7QA0xAGvny9MR/vXyzfT0LujRBgoY2lJze0+QDi4bOa9pTDtS0FG4qAEIbd7kS59fmv
        8pxOURv3JHyj4GdXNGYC8JJk5jy0UF33HMFb4c5NudCNh9vrLoQrSEZDkvJGnhdfw5jLcGLcyAA2m
        3B1YU=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdZRc-0007Ca-UV; Wed, 19 Jun 2019 12:12:05 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7557344004B; Wed, 19 Jun 2019 13:12:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ben Zhang <benzh@chromium.org>
Cc:     alsa-devel@alsa-project.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt5677: clear interrupts by polarity flip" to the asoc tree
In-Reply-To: <20190618234555.188955-2-fletcherw@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190619121204.7557344004B@finisterre.sirena.org.uk>
Date:   Wed, 19 Jun 2019 13:12:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5677: clear interrupts by polarity flip

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

From 4f7b018b55db0361718161e1471d8b7a16fdfa47 Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Tue, 18 Jun 2019 17:45:54 -0600
Subject: [PATCH] ASoC: rt5677: clear interrupts by polarity flip

The rt5677 jack detection function has a requirement that the polarity
of an interrupt be flipped after it fires in order to clear the
interrupt.

This patch implements an irq_chip with irq_domain directly instead of
using regmap-irq, so that interrupt source line polarities can be
flipped in the irq handler.

The reason that this patch does not add this feature within regmap-irq
is that future patches will add hotword detection support to this irq
handler. Those patches will require adding additional logic that would
not make sense to have in regmap-irq.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 173 ++++++++++++++++++++++++++++++--------
 sound/soc/codecs/rt5677.h |   8 +-
 2 files changed, 145 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 87a92ba0d040..b5ae61ff87af 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -23,6 +23,10 @@
 #include <linux/firmware.h>
 #include <linux/of_device.h>
 #include <linux/property.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -4620,7 +4624,6 @@ static void rt5677_gpio_config(struct rt5677_priv *rt5677, unsigned offset,
 static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct rt5677_priv *rt5677 = gpiochip_get_data(chip);
-	struct regmap_irq_chip_data *data = rt5677->irq_data;
 	int irq;
 
 	if ((rt5677->pdata.jd1_gpio == 1 && offset == RT5677_GPIO1) ||
@@ -4646,7 +4649,7 @@ static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
 		return -ENXIO;
 	}
 
-	return regmap_irq_get_virq(data, irq);
+	return irq_create_mapping(rt5677->domain, irq);
 }
 
 static const struct gpio_chip rt5677_template_chip = {
@@ -5042,30 +5045,130 @@ static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
 		rt5677->pdata.jd3_gpio = val;
 }
 
-static struct regmap_irq rt5677_irqs[] = {
+struct rt5677_irq_desc {
+	unsigned int enable_mask;
+	unsigned int status_mask;
+	unsigned int polarity_mask;
+};
+
+static const struct rt5677_irq_desc rt5677_irq_descs[] = {
 	[RT5677_IRQ_JD1] = {
-		.reg_offset = 0,
-		.mask = RT5677_EN_IRQ_GPIO_JD1,
+		.enable_mask = RT5677_EN_IRQ_GPIO_JD1,
+		.status_mask = RT5677_STA_GPIO_JD1,
+		.polarity_mask = RT5677_INV_GPIO_JD1,
 	},
 	[RT5677_IRQ_JD2] = {
-		.reg_offset = 0,
-		.mask = RT5677_EN_IRQ_GPIO_JD2,
+		.enable_mask = RT5677_EN_IRQ_GPIO_JD2,
+		.status_mask = RT5677_STA_GPIO_JD2,
+		.polarity_mask = RT5677_INV_GPIO_JD2,
 	},
 	[RT5677_IRQ_JD3] = {
-		.reg_offset = 0,
-		.mask = RT5677_EN_IRQ_GPIO_JD3,
+		.enable_mask = RT5677_EN_IRQ_GPIO_JD3,
+		.status_mask = RT5677_STA_GPIO_JD3,
+		.polarity_mask = RT5677_INV_GPIO_JD3,
 	},
 };
 
-static struct regmap_irq_chip rt5677_irq_chip = {
-	.name = RT5677_DRV_NAME,
-	.irqs = rt5677_irqs,
-	.num_irqs = ARRAY_SIZE(rt5677_irqs),
+static irqreturn_t rt5677_irq(int unused, void *data)
+{
+	struct rt5677_priv *rt5677 = data;
+	int ret = 0, i, reg_irq, virq;
+	bool irq_fired = false;
+
+	mutex_lock(&rt5677->irq_lock);
+	/* Read interrupt status */
+	ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
+	if (ret) {
+		dev_err(rt5677->dev, "failed reading IRQ status: %d\n", ret);
+		goto exit;
+	}
+
+	for (i = 0; i < RT5677_IRQ_NUM; i++) {
+		if (reg_irq & rt5677_irq_descs[i].status_mask) {
+			irq_fired = true;
+			virq = irq_find_mapping(rt5677->domain, i);
+			if (virq)
+				handle_nested_irq(virq);
+
+			/* Clear the interrupt by flipping the polarity of the
+			 * interrupt source line that fired
+			 */
+			reg_irq ^= rt5677_irq_descs[i].polarity_mask;
+		}
+	}
+
+	if (!irq_fired)
+		goto exit;
+
+	ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
+	if (ret) {
+		dev_err(rt5677->dev, "failed updating IRQ status: %d\n", ret);
+		goto exit;
+	}
+exit:
+	mutex_unlock(&rt5677->irq_lock);
+	if (irq_fired)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
+static void rt5677_irq_bus_lock(struct irq_data *data)
+{
+	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&rt5677->irq_lock);
+}
+
+static void rt5677_irq_bus_sync_unlock(struct irq_data *data)
+{
+	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
+
+	// Set the enable/disable bits for the jack detect IRQs.
+	regmap_update_bits(rt5677->regmap, RT5677_IRQ_CTRL1,
+			RT5677_EN_IRQ_GPIO_JD1 | RT5677_EN_IRQ_GPIO_JD2 |
+			RT5677_EN_IRQ_GPIO_JD3, rt5677->irq_en);
+	mutex_unlock(&rt5677->irq_lock);
+}
+
+static void rt5677_irq_enable(struct irq_data *data)
+{
+	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
+
+	rt5677->irq_en |= rt5677_irq_descs[data->hwirq].enable_mask;
+}
 
-	.num_regs = 1,
-	.status_base = RT5677_IRQ_CTRL1,
-	.mask_base = RT5677_IRQ_CTRL1,
-	.mask_invert = 1,
+static void rt5677_irq_disable(struct irq_data *data)
+{
+	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
+
+	rt5677->irq_en &= ~rt5677_irq_descs[data->hwirq].enable_mask;
+}
+
+static struct irq_chip rt5677_irq_chip = {
+	.name			= "rt5677_irq_chip",
+	.irq_bus_lock		= rt5677_irq_bus_lock,
+	.irq_bus_sync_unlock	= rt5677_irq_bus_sync_unlock,
+	.irq_disable		= rt5677_irq_disable,
+	.irq_enable		= rt5677_irq_enable,
+};
+
+static int rt5677_irq_map(struct irq_domain *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	struct rt5677_priv *rt5677 = h->host_data;
+
+	irq_set_chip_data(virq, rt5677);
+	irq_set_chip(virq, &rt5677_irq_chip);
+	irq_set_nested_thread(virq, 1);
+	irq_set_noprobe(virq);
+	return 0;
+}
+
+
+static const struct irq_domain_ops rt5677_domain_ops = {
+	.map	= rt5677_irq_map,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static int rt5677_init_irq(struct i2c_client *i2c)
@@ -5084,6 +5187,8 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 		return -EINVAL;
 	}
 
+	mutex_init(&rt5677->irq_lock);
+
 	/*
 	 * Select RC as the debounce clock so that GPIO works even when
 	 * MCLK is gated which happens when there is no audio stream
@@ -5092,7 +5197,6 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 	regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC,
 			RT5677_IRQ_DEBOUNCE_SEL_MASK,
 			RT5677_IRQ_DEBOUNCE_SEL_RC);
-
 	/* Enable auto power on RC when GPIO states are changed */
 	regmap_update_bits(rt5677->regmap, RT5677_GEN_CTRL1, 0xff, 0xff);
 
@@ -5115,24 +5219,21 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 	regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1,
 			RT5677_GPIO1_PIN_MASK, RT5677_GPIO1_PIN_IRQ);
 
-	ret = regmap_add_irq_chip(rt5677->regmap, i2c->irq,
-		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT, 0,
-		&rt5677_irq_chip, &rt5677->irq_data);
-
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to register IRQ chip: %d\n", ret);
-		return ret;
+	/* Ready to listen for interrupts */
+	rt5677->domain = irq_domain_add_linear(i2c->dev.of_node,
+			RT5677_IRQ_NUM, &rt5677_domain_ops, rt5677);
+	if (!rt5677->domain) {
+		dev_err(&i2c->dev, "Failed to create IRQ domain\n");
+		return -ENOMEM;
 	}
 
-	return 0;
-}
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, rt5677_irq,
+			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			"rt5677", rt5677);
+	if (ret)
+		dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
-static void rt5677_free_irq(struct i2c_client *i2c)
-{
-	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
-
-	if (rt5677->irq_data)
-		regmap_del_irq_chip(i2c->irq, rt5677->irq_data);
+	return ret;
 }
 
 static int rt5677_i2c_probe(struct i2c_client *i2c)
@@ -5146,6 +5247,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 	if (rt5677 == NULL)
 		return -ENOMEM;
 
+	rt5677->dev = &i2c->dev;
 	i2c_set_clientdata(i2c, rt5677);
 
 	if (i2c->dev.of_node) {
@@ -5259,7 +5361,9 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 			RT5677_MICBIAS1_CTRL_VDD_3_3V);
 
 	rt5677_init_gpio(i2c);
-	rt5677_init_irq(i2c);
+	ret = rt5677_init_irq(i2c);
+	if (ret)
+		dev_err(&i2c->dev, "Failed to initialize irq: %d\n", ret);
 
 	return devm_snd_soc_register_component(&i2c->dev,
 				      &soc_component_dev_rt5677,
@@ -5268,7 +5372,6 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 
 static int rt5677_i2c_remove(struct i2c_client *i2c)
 {
-	rt5677_free_irq(i2c);
 	rt5677_free_gpio(i2c);
 
 	return 0;
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index c26edd387e34..45633d8b6a19 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1749,6 +1749,7 @@ enum {
 	RT5677_IRQ_JD1,
 	RT5677_IRQ_JD2,
 	RT5677_IRQ_JD3,
+	RT5677_IRQ_NUM,
 };
 
 enum rt5677_type {
@@ -1827,6 +1828,7 @@ struct rt5677_platform_data {
 
 struct rt5677_priv {
 	struct snd_soc_component *component;
+	struct device *dev;
 	struct rt5677_platform_data pdata;
 	struct regmap *regmap, *regmap_physical;
 	const struct firmware *fw1, *fw2;
@@ -1847,9 +1849,13 @@ struct rt5677_priv {
 	struct gpio_chip gpio_chip;
 #endif
 	bool dsp_vad_en;
-	struct regmap_irq_chip_data *irq_data;
 	bool is_dsp_mode;
 	bool is_vref_slow;
+
+	/* Interrupt handling */
+	struct irq_domain *domain;
+	struct mutex irq_lock;
+	unsigned int irq_en;
 };
 
 int rt5677_sel_asrc_clk_src(struct snd_soc_component *component,
-- 
2.20.1

