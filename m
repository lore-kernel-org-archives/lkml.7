Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5396DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B9218FE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108802;
	bh=tOlYa0ocF52nbJpqYoB5vmW19cgbgyjLLwbxSXGwuis=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=J6SfUZq182lMC1CbAexzJC5DQMQVn8PwhxdnNha8meRrm2I78o/IuLjxGDIsvXLR6
	 fSvipau2jf3MkU6qn5GJECHXL1DDhCC0kFep1NP9IakXvbCDrqEYA1HONoc88ZaDGR
	 aC6Y1Ie0TOf/+eYc7+RQBSILK9IGz08U62kDBE9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfDAIxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:53:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59374 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfDAIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MBFhKP8rDyLhY1H79JCM+A4HDAUVRivmK2vDZm1q4S0=; b=dQLmXDI4IHso
        S9wy6+Kh7yvor1yu6yo3l+X7gzV273jUb7YOOknw3OpWAeRqEdL+xhoIBWYryftvmXUrBM6mJKSR/
        8gf6tdtBwCarzxQspSMOtDfXQsPiWZhGlWDprCuM6dRWHhkHF9z9gseVRCnQOOlgbhp0D5PeSaxZp
        cwIrA=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsgk-0008N5-4b; Mon, 01 Apr 2019 08:53:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 20BE0440083; Mon,  1 Apr 2019 09:52:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: es8316: Add support for inverted jack detect" to the asoc tree
In-Reply-To:  <20190329215045.6254-1-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190401085258.20BE0440083@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:52:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es8316: Add support for inverted jack detect

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

From 0bbcedd6bb41b82b77115fc001441ff34e7c4ea7 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 29 Mar 2019 22:50:43 +0100
Subject: [PATCH] ASoC: es8316: Add support for inverted jack detect

On some devices (Teclast X98+ II tablet, maybe others), the jack
detection has been wired backwards, so when the ES8316 reports
headphones being present it means they are actually not plugged.

Use a quirk around this incorrect behaviour, which can be enabled
through the 'everest,jack-detect-inverted' boolean device property.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 6d4a323f786b..ec2770b3f77d 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -43,6 +43,7 @@ struct es8316_priv {
 	unsigned int sysclk;
 	unsigned int allowed_rates[NR_SUPPORTED_MCLK_LRCK_RATIOS];
 	struct snd_pcm_hw_constraint_list sysclk_constraints;
+	bool jd_inverted;
 };
 
 /*
@@ -577,6 +578,9 @@ static irqreturn_t es8316_irq(int irq, void *data)
 	if (!es8316->jack)
 		goto out;
 
+	if (es8316->jd_inverted)
+		flags ^= ES8316_GPIO_FLAG_HP_NOT_INSERTED;
+
 	dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
 	if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
 		/* Jack removed, or spurious IRQ? */
@@ -592,6 +596,8 @@ static irqreturn_t es8316_irq(int irq, void *data)
 		/* Jack inserted, determine type */
 		es8316_enable_micbias_for_mic_gnd_short_detect(comp);
 		regmap_read(es8316->regmap, ES8316_GPIO_FLAG, &flags);
+		if (es8316->jd_inverted)
+			flags ^= ES8316_GPIO_FLAG_HP_NOT_INSERTED;
 		dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
 		if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
 			/* Jack unplugged underneath us */
@@ -633,6 +639,14 @@ static void es8316_enable_jack_detect(struct snd_soc_component *component,
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 
+	/*
+	 * Init es8316->jd_inverted here and not in the probe, as we cannot
+	 * guarantee that the bytchr-es8316 driver, which might set this
+	 * property, will probe before us.
+	 */
+	es8316->jd_inverted = device_property_read_bool(component->dev,
+							"everest,jack-detect-inverted");
+
 	mutex_lock(&es8316->lock);
 
 	es8316->jack = jack;
-- 
2.20.1

