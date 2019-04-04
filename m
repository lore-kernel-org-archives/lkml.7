Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2008CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF16214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554386321;
	bh=qiTSqO/gM+L9pidfbgcNdBuapGGyPTLqNknNc1RIcaM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=i6sCjWHbvr+joqWUyZozu2uUc+Oncg8x7hg40uS+sKzHAi60H+tLDqu5GtGn5YHg4
	 2oFr3POWZ8jhqfseVDi1VV0OemlvTnbdO4MiXnkMWald5owt485BlNh3SZE7k6CzFj
	 ouADExJrA8Fok/A38agfw3Qmm/zNXV8CuSpcMpyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfDDN6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:58:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60132 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfDDN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GrTSV5jZslXZdtu5m74k9QkD/GoCJoICsUDJGagf9FA=; b=bin5ljpS4K5o
        GaLyRXBQ1OBCWTBxUJekifecX27qgHVMLX1u7ejaORsyuR+wjR51maiJv/SWCMiSY1KDeFZYPGDHa
        opWQ9I3pF71pGlebq3wR6509nnDITeqFETymC6uikachFSPuvWAdO+Sa3RvalkS6Uj43LyaC3OC6+
        /gDoQ=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hC2sp-0006cv-D6; Thu, 04 Apr 2019 13:58:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B9248441D3C; Thu,  4 Apr 2019 20:58:20 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        apatard@mandriva.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs42l51: add power management" to the asoc tree
In-Reply-To:  <1554297817-14154-7-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404135820.B9248441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 20:58:20 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: add power management

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

From 75a714823e89ceeb168092b4c4d0a3f52b415461 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:36 +0200
Subject: [PATCH] ASoC: cs42l51: add power management

Add sleep PM callbacks to support system low power modes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51-i2c.c |   7 +-
 sound/soc/codecs/cs42l51.c     | 122 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l51.h     |   2 +
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 8333dbf18ea2..116221e581ce 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -29,8 +29,6 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c,
 	struct regmap_config config;
 
 	config = cs42l51_regmap;
-	config.val_bits = 8;
-	config.reg_bits = 8;
 
 	return cs42l51_probe(&i2c->dev, devm_regmap_init_i2c(i2c, &config));
 }
@@ -40,10 +38,15 @@ static int cs42l51_i2c_remove(struct i2c_client *i2c)
 	return cs42l51_remove(&i2c->dev);
 }
 
+static const struct dev_pm_ops cs42l51_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l51_suspend, cs42l51_resume)
+};
+
 static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
 		.name = "cs42l51",
 		.of_match_table = cs42l51_of_match,
+		.pm = &cs42l51_pm_ops,
 	},
 	.probe = cs42l51_i2c_probe,
 	.remove = cs42l51_i2c_remove,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 397b68901d1c..b8f43858876a 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -56,6 +56,7 @@ struct cs42l51_private {
 	enum master_slave_mode func;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(cs42l51_supply_names)];
 	struct gpio_desc *reset_gpio;
+	struct regmap *regmap;
 };
 
 #define CS42L51_FORMATS ( \
@@ -575,7 +576,106 @@ static const struct snd_soc_component_driver soc_component_device_cs42l51 = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static bool cs42l51_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS42L51_POWER_CTL1:
+	case CS42L51_MIC_POWER_CTL:
+	case CS42L51_INTF_CTL:
+	case CS42L51_MIC_CTL:
+	case CS42L51_ADC_CTL:
+	case CS42L51_ADC_INPUT:
+	case CS42L51_DAC_OUT_CTL:
+	case CS42L51_DAC_CTL:
+	case CS42L51_ALC_PGA_CTL:
+	case CS42L51_ALC_PGB_CTL:
+	case CS42L51_ADCA_ATT:
+	case CS42L51_ADCB_ATT:
+	case CS42L51_ADCA_VOL:
+	case CS42L51_ADCB_VOL:
+	case CS42L51_PCMA_VOL:
+	case CS42L51_PCMB_VOL:
+	case CS42L51_BEEP_FREQ:
+	case CS42L51_BEEP_VOL:
+	case CS42L51_BEEP_CONF:
+	case CS42L51_TONE_CTL:
+	case CS42L51_AOUTA_VOL:
+	case CS42L51_AOUTB_VOL:
+	case CS42L51_PCM_MIXER:
+	case CS42L51_LIMIT_THRES_DIS:
+	case CS42L51_LIMIT_REL:
+	case CS42L51_LIMIT_ATT:
+	case CS42L51_ALC_EN:
+	case CS42L51_ALC_REL:
+	case CS42L51_ALC_THRES:
+	case CS42L51_NOISE_CONF:
+	case CS42L51_CHARGE_FREQ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs42l51_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS42L51_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs42l51_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS42L51_CHIP_REV_ID:
+	case CS42L51_POWER_CTL1:
+	case CS42L51_MIC_POWER_CTL:
+	case CS42L51_INTF_CTL:
+	case CS42L51_MIC_CTL:
+	case CS42L51_ADC_CTL:
+	case CS42L51_ADC_INPUT:
+	case CS42L51_DAC_OUT_CTL:
+	case CS42L51_DAC_CTL:
+	case CS42L51_ALC_PGA_CTL:
+	case CS42L51_ALC_PGB_CTL:
+	case CS42L51_ADCA_ATT:
+	case CS42L51_ADCB_ATT:
+	case CS42L51_ADCA_VOL:
+	case CS42L51_ADCB_VOL:
+	case CS42L51_PCMA_VOL:
+	case CS42L51_PCMB_VOL:
+	case CS42L51_BEEP_FREQ:
+	case CS42L51_BEEP_VOL:
+	case CS42L51_BEEP_CONF:
+	case CS42L51_TONE_CTL:
+	case CS42L51_AOUTA_VOL:
+	case CS42L51_AOUTB_VOL:
+	case CS42L51_PCM_MIXER:
+	case CS42L51_LIMIT_THRES_DIS:
+	case CS42L51_LIMIT_REL:
+	case CS42L51_LIMIT_ATT:
+	case CS42L51_ALC_EN:
+	case CS42L51_ALC_REL:
+	case CS42L51_ALC_THRES:
+	case CS42L51_NOISE_CONF:
+	case CS42L51_STATUS:
+	case CS42L51_CHARGE_FREQ:
+		return true;
+	default:
+		return false;
+	}
+}
+
 const struct regmap_config cs42l51_regmap = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.use_single_write = true,
+	.readable_reg = cs42l51_readable_reg,
+	.volatile_reg = cs42l51_volatile_reg,
+	.writeable_reg = cs42l51_writeable_reg,
 	.max_register = CS42L51_CHARGE_FREQ,
 	.cache_type = REGCACHE_RBTREE,
 };
@@ -596,6 +696,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, cs42l51);
+	cs42l51->regmap = regmap;
 
 	cs42l51->mclk_handle = devm_clk_get(dev, "MCLK");
 	if (IS_ERR(cs42l51->mclk_handle)) {
@@ -673,6 +774,27 @@ int cs42l51_remove(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cs42l51_remove);
 
+int __maybe_unused cs42l51_suspend(struct device *dev)
+{
+	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
+
+	regcache_cache_only(cs42l51->regmap, true);
+	regcache_mark_dirty(cs42l51->regmap);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs42l51_suspend);
+
+int __maybe_unused cs42l51_resume(struct device *dev)
+{
+	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
+
+	regcache_cache_only(cs42l51->regmap, false);
+
+	return regcache_sync(cs42l51->regmap);
+}
+EXPORT_SYMBOL_GPL(cs42l51_resume);
+
 const struct of_device_id cs42l51_of_match[] = {
 	{ .compatible = "cirrus,cs42l51", },
 	{ }
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index aef0ede82c7b..79dee01137c8 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -23,6 +23,8 @@ struct device;
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
 int cs42l51_remove(struct device *dev);
+int __maybe_unused cs42l51_suspend(struct device *dev);
+int __maybe_unused cs42l51_resume(struct device *dev);
 extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
-- 
2.20.1

