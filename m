Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6234CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BB620B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571680859;
	bh=cAbhT5T+L9GK+GPpGd3m42XD8kvHmzuwtHvHS3YtBjg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=OTOgRslLNemXMpWOctX2ANPHIIBNaZaBxLYJirSQkIZA/H8SvIQ2eT2wBvm5AxFw+
	 ahO7UfGNqcv6I5DKn1cfFd4BRexR4z61nEmbdi6oFzq9gn7FfuXJlf46ue8zlpxRwh
	 6MdTzjS2FXIMK8VjwPkkMnmZGpyT0vA17pm6lvvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfJUSA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:00:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39016 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfJUSAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xPyRRoetFVp+xgqkSIDKATLWjAboLeoEpl+LnasuBUc=; b=EUgOYGF+Beig
        LtjRDnYCg+5Mfa7q7ooruOuORlo7LS+SnHXol54R3dVvuuZ44lcqy9B1H3r8MPEJldRZI2hmgN05N
        Bj1wjoQsGkTWVd2672CJRkZlrPyq2+WW7Vzs5AD/e6xok1BqG85JmZ3bSf3z3uqntrsglxhwV07gh
        SzE1o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMbz4-0004bb-UV; Mon, 21 Oct 2019 18:00:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3D5772743267; Mon, 21 Oct 2019 19:00:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: msm8916-wcd-analog: Add earpiece" to the asoc tree
In-Reply-To: <20191020153007.206070-2-stephan@gerhold.net>
X-Patchwork-Hint: ignore
Message-Id: <20191021180046.3D5772743267@ypsilon.sirena.org.uk>
Date:   Mon, 21 Oct 2019 19:00:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: msm8916-wcd-analog: Add earpiece

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 7d2f70f248ab0e4251591cf7b36cc43281941f56 Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Sun, 20 Oct 2019 17:30:07 +0200
Subject: [PATCH] ASoC: msm8916-wcd-analog: Add earpiece

PM8916 supports an earpiece as another (small) speaker.
The earpiece is routed through RX MIX1 similarly to
the headphones, except that RDAC2 MUX is set to RX1.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20191020153007.206070-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 54 ++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 667e9f73aba3..4168b0a0aafb 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -228,6 +228,10 @@
 #define CDC_A_RX_EAR_CTL			(0xf19E)
 #define RX_EAR_CTL_SPK_VBAT_LDO_EN_MASK		BIT(0)
 #define RX_EAR_CTL_SPK_VBAT_LDO_EN_ENABLE	BIT(0)
+#define RX_EAR_CTL_PA_EAR_PA_EN_MASK		BIT(6)
+#define RX_EAR_CTL_PA_EAR_PA_EN_ENABLE		BIT(6)
+#define RX_EAR_CTL_PA_SEL_MASK			BIT(7)
+#define RX_EAR_CTL_PA_SEL			BIT(7)
 
 #define CDC_A_SPKR_DAC_CTL		(0xf1B0)
 #define SPKR_DAC_CTL_DAC_RESET_MASK	BIT(4)
@@ -312,6 +316,7 @@ static const char *const hph_text[] = { "ZERO", "Switch", };
 static const struct soc_enum hph_enum = SOC_ENUM_SINGLE_VIRT(
 					ARRAY_SIZE(hph_text), hph_text);
 
+static const struct snd_kcontrol_new ear_mux = SOC_DAPM_ENUM("EAR_S", hph_enum);
 static const struct snd_kcontrol_new hphl_mux = SOC_DAPM_ENUM("HPHL", hph_enum);
 static const struct snd_kcontrol_new hphr_mux = SOC_DAPM_ENUM("HPHR", hph_enum);
 
@@ -685,6 +690,34 @@ static int pm8916_wcd_analog_enable_spk_pa(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int pm8916_wcd_analog_enable_ear_pa(struct snd_soc_dapm_widget *w,
+					    struct snd_kcontrol *kcontrol,
+					    int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(component, CDC_A_RX_EAR_CTL,
+				    RX_EAR_CTL_PA_SEL_MASK, RX_EAR_CTL_PA_SEL);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_component_update_bits(component, CDC_A_RX_EAR_CTL,
+				    RX_EAR_CTL_PA_EAR_PA_EN_MASK,
+				    RX_EAR_CTL_PA_EAR_PA_EN_ENABLE);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_component_update_bits(component, CDC_A_RX_EAR_CTL,
+				    RX_EAR_CTL_PA_EAR_PA_EN_MASK, 0);
+		/* Delay to reduce ear turn off pop */
+		usleep_range(7000, 7100);
+		snd_soc_component_update_bits(component, CDC_A_RX_EAR_CTL,
+				    RX_EAR_CTL_PA_SEL_MASK, 0);
+		break;
+	}
+	return 0;
+}
+
 static const struct reg_default wcd_reg_defaults_2_0[] = {
 	{CDC_A_RX_COM_OCP_CTL, 0xD1},
 	{CDC_A_RX_COM_OCP_COUNT, 0xFF},
@@ -801,12 +834,20 @@ static const struct snd_soc_dapm_route pm8916_wcd_analog_audio_map[] = {
 	{"PDM_TX", NULL, "A_MCLK2"},
 	{"A_MCLK2", NULL, "A_MCLK"},
 
+	/* Earpiece (RX MIX1) */
+	{"EAR", NULL, "EAR_S"},
+	{"EAR_S", "Switch", "EAR PA"},
+	{"EAR PA", NULL, "RX_BIAS"},
+	{"EAR PA", NULL, "HPHL DAC"},
+	{"EAR PA", NULL, "HPHR DAC"},
+	{"EAR PA", NULL, "EAR CP"},
+
 	/* Headset (RX MIX1 and RX MIX2) */
 	{"HEADPHONE", NULL, "HPHL PA"},
 	{"HEADPHONE", NULL, "HPHR PA"},
 
-	{"HPHL PA", NULL, "EAR_HPHL_CLK"},
-	{"HPHR PA", NULL, "EAR_HPHR_CLK"},
+	{"HPHL DAC", NULL, "EAR_HPHL_CLK"},
+	{"HPHR DAC", NULL, "EAR_HPHR_CLK"},
 
 	{"CP", NULL, "NCP_CLK"},
 
@@ -847,11 +888,20 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("AMIC1"),
 	SND_SOC_DAPM_INPUT("AMIC3"),
 	SND_SOC_DAPM_INPUT("AMIC2"),
+	SND_SOC_DAPM_OUTPUT("EAR"),
 	SND_SOC_DAPM_OUTPUT("HEADPHONE"),
 
 	/* RX stuff */
 	SND_SOC_DAPM_SUPPLY("INT_LDO_H", SND_SOC_NOPM, 1, 0, NULL, 0),
 
+	SND_SOC_DAPM_PGA_E("EAR PA", SND_SOC_NOPM,
+			   0, 0, NULL, 0,
+			   pm8916_wcd_analog_enable_ear_pa,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("EAR_S", SND_SOC_NOPM, 0, 0, &ear_mux),
+	SND_SOC_DAPM_SUPPLY("EAR CP", CDC_A_NCP_EN, 4, 0, NULL, 0),
+
 	SND_SOC_DAPM_PGA("HPHL PA", CDC_A_RX_HPH_CNP_EN, 5, 0, NULL, 0),
 	SND_SOC_DAPM_MUX("HPHL", SND_SOC_NOPM, 0, 0, &hphl_mux),
 	SND_SOC_DAPM_MIXER("HPHL DAC", CDC_A_RX_HPH_L_PA_DAC_CTL, 3, 0, NULL,
-- 
2.20.1

