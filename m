Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39820C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC73208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559910444;
	bh=j5o5RE55OKn60iXJNqr76kiyEkDBFmJkKDz36CViG9w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xaNGJs2wNqw3yDlIFsFEu7VReNjAMDVvxfsJ55p/WiC1MEUj79MVHomp5KmAuFOer
	 uafuI1GP2e8DFeHZgOrxkXemKX2q7i6fGODOpMPbMR2QsXBV2bCv31fqNnDmswxOD1
	 TDVWnES6fQJBuvggvK1z3Hd3IWzKMFFFjfrKEyg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfFGM1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:27:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfFGM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cMBcdmzaQ0BRNLuRzxs4sqMAhMZqg9dbVR9+wj77Dwo=; b=AoAgmJMT6Dkp
        v7WpwMT9ucrQtjQFDA1uPTEVoskzRLM2jMzTxT9UpDKOJbtvt78qlD1HFXT+M0gzPMhaIpfKduwPW
        /o+Q1Sfl+EIWweoMw+VDQcBYr9KmXIl+cQBbGSOe3GSkMlM7WWg3LbzbocjmcOF+1NUigDjmxK4O3
        SKDJM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZDxg-0002BB-EA; Fri, 07 Jun 2019 12:27:12 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 4D809440046; Fri,  7 Jun 2019 13:27:11 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: msm8916-wcd-digital: Add sidetone support" to the asoc tree
In-Reply-To: <20190606124242.12941-1-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190607122711.4D809440046@finisterre.sirena.org.uk>
Date:   Fri,  7 Jun 2019 13:27:11 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: msm8916-wcd-digital: Add sidetone support

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

From ef8a4757a6dbb2d406d7ba3a10a513f16f49ed2d Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 6 Jun 2019 13:42:42 +0100
Subject: [PATCH] ASoC: msm8916-wcd-digital: Add sidetone support

This patch adds sidetone support via one of the 3 RX Mix paths
using IIR1 and IIR2.
IIR1 can be feed by any Decimators or RX paths, and IIRx can also be
looped back to RX mixers to provide sidetone functionality.
Two IIR filters are used for Side tone equalization and each filter
is 5 stage.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 282 +++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index a63961861e55..1db7e43ec203 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -187,6 +187,43 @@
 #define MSM8916_WCD_DIGITAL_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 				     SNDRV_PCM_FMTBIT_S32_LE)
 
+/* Codec supports 2 IIR filters */
+enum {
+	IIR1 = 0,
+	IIR2,
+	IIR_MAX,
+};
+
+/* Codec supports 5 bands */
+enum {
+	BAND1 = 0,
+	BAND2,
+	BAND3,
+	BAND4,
+	BAND5,
+	BAND_MAX,
+};
+
+#define WCD_IIR_FILTER_SIZE	(sizeof(u32)*BAND_MAX)
+
+#define WCD_IIR_FILTER_CTL(xname, iidx, bidx) \
+{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = wcd_iir_filter_info, \
+	.get = msm8x16_wcd_get_iir_band_audio_mixer, \
+	.put = msm8x16_wcd_put_iir_band_audio_mixer, \
+	.private_value = (unsigned long)&(struct wcd_iir_filter_ctl) { \
+		.iir_idx = iidx, \
+		.band_idx = bidx, \
+		.bytes_ext = {.max = WCD_IIR_FILTER_SIZE, }, \
+	} \
+}
+
+struct wcd_iir_filter_ctl {
+	unsigned int iir_idx;
+	unsigned int band_idx;
+	struct soc_bytes_ext bytes_ext;
+};
+
 struct msm8916_wcd_digital_priv {
 	struct clk *ahbclk, *mclk;
 };
@@ -298,6 +335,161 @@ static SOC_ENUM_SINGLE_DECL(rx2_dcb_cutoff_enum, LPASS_CDC_RX2_B4_CTL, 0,
 static SOC_ENUM_SINGLE_DECL(rx3_dcb_cutoff_enum, LPASS_CDC_RX3_B4_CTL, 0,
 			    dc_blocker_cutoff_text);
 
+static int msm8x16_wcd_codec_set_iir_gain(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+			snd_soc_dapm_to_component(w->dapm);
+	int value = 0, reg = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (w->shift == 0)
+			reg = LPASS_CDC_IIR1_GAIN_B1_CTL;
+		else if (w->shift == 1)
+			reg = LPASS_CDC_IIR2_GAIN_B1_CTL;
+		value = snd_soc_component_read32(component, reg);
+		snd_soc_component_write(component, reg, value);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static uint32_t get_iir_band_coeff(struct snd_soc_component *component,
+				   int iir_idx, int band_idx,
+				   int coeff_idx)
+{
+	uint32_t value = 0;
+
+	/* Address does not automatically update if reading */
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t)) & 0x7F);
+
+	value |= snd_soc_component_read32(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx));
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t) + 1) & 0x7F);
+
+	value |= (snd_soc_component_read32(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx)) << 8);
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t) + 2) & 0x7F);
+
+	value |= (snd_soc_component_read32(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx)) << 16);
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t) + 3) & 0x7F);
+
+	/* Mask bits top 2 bits since they are reserved */
+	value |= ((snd_soc_component_read32(component,
+		 (LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx)) & 0x3f) << 24);
+	return value;
+
+}
+
+static int msm8x16_wcd_get_iir_band_audio_mixer(
+					struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct wcd_iir_filter_ctl *ctl =
+			(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	int iir_idx = ctl->iir_idx;
+	int band_idx = ctl->band_idx;
+	u32 coeff[BAND_MAX];
+
+	coeff[0] = get_iir_band_coeff(component, iir_idx, band_idx, 0);
+	coeff[1] = get_iir_band_coeff(component, iir_idx, band_idx, 1);
+	coeff[2] = get_iir_band_coeff(component, iir_idx, band_idx, 2);
+	coeff[3] = get_iir_band_coeff(component, iir_idx, band_idx, 3);
+	coeff[4] = get_iir_band_coeff(component, iir_idx, band_idx, 4);
+
+	memcpy(ucontrol->value.bytes.data, &coeff[0], params->max);
+
+	return 0;
+}
+
+static void set_iir_band_coeff(struct snd_soc_component *component,
+				int iir_idx, int band_idx,
+				uint32_t value)
+{
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx),
+		(value & 0xFF));
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx),
+		(value >> 8) & 0xFF);
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx),
+		(value >> 16) & 0xFF);
+
+	/* Mask top 2 bits, 7-8 are reserved */
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx),
+		(value >> 24) & 0x3F);
+}
+
+static int msm8x16_wcd_put_iir_band_audio_mixer(
+					struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct wcd_iir_filter_ctl *ctl =
+			(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	int iir_idx = ctl->iir_idx;
+	int band_idx = ctl->band_idx;
+	u32 coeff[BAND_MAX];
+
+	memcpy(&coeff[0], ucontrol->value.bytes.data, params->max);
+
+	/* Mask top bit it is reserved */
+	/* Updates addr automatically for each B2 write */
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		(band_idx * BAND_MAX * sizeof(uint32_t)) & 0x7F);
+
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[0]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[1]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[2]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[3]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[4]);
+
+	return 0;
+}
+
+static int wcd_iir_filter_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *ucontrol)
+{
+	struct wcd_iir_filter_ctl *ctl =
+		(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+
+	ucontrol->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	ucontrol->count = params->max;
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new msm8916_wcd_digital_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("RX1 Digital Volume", LPASS_CDC_RX1_VOL_CTL_B2_CTL,
 			  -128, 127, digital_gain),
@@ -322,6 +514,44 @@ static const struct snd_kcontrol_new msm8916_wcd_digital_snd_controls[] = {
 	SOC_SINGLE("RX1 Mute Switch", LPASS_CDC_RX1_B6_CTL, 0, 1, 0),
 	SOC_SINGLE("RX2 Mute Switch", LPASS_CDC_RX2_B6_CTL, 0, 1, 0),
 	SOC_SINGLE("RX3 Mute Switch", LPASS_CDC_RX3_B6_CTL, 0, 1, 0),
+
+	SOC_SINGLE("IIR1 Band1 Switch", LPASS_CDC_IIR1_CTL, 0, 1, 0),
+	SOC_SINGLE("IIR1 Band2 Switch", LPASS_CDC_IIR1_CTL, 1, 1, 0),
+	SOC_SINGLE("IIR1 Band3 Switch", LPASS_CDC_IIR1_CTL, 2, 1, 0),
+	SOC_SINGLE("IIR1 Band4 Switch", LPASS_CDC_IIR1_CTL, 3, 1, 0),
+	SOC_SINGLE("IIR1 Band5 Switch", LPASS_CDC_IIR1_CTL, 4, 1, 0),
+	SOC_SINGLE("IIR2 Band1 Switch", LPASS_CDC_IIR2_CTL, 0, 1, 0),
+	SOC_SINGLE("IIR2 Band2 Switch", LPASS_CDC_IIR2_CTL, 1, 1, 0),
+	SOC_SINGLE("IIR2 Band3 Switch", LPASS_CDC_IIR2_CTL, 2, 1, 0),
+	SOC_SINGLE("IIR2 Band4 Switch", LPASS_CDC_IIR2_CTL, 3, 1, 0),
+	SOC_SINGLE("IIR2 Band5 Switch", LPASS_CDC_IIR2_CTL, 4, 1, 0),
+	WCD_IIR_FILTER_CTL("IIR1 Band1", IIR1, BAND1),
+	WCD_IIR_FILTER_CTL("IIR1 Band2", IIR1, BAND2),
+	WCD_IIR_FILTER_CTL("IIR1 Band3", IIR1, BAND3),
+	WCD_IIR_FILTER_CTL("IIR1 Band4", IIR1, BAND4),
+	WCD_IIR_FILTER_CTL("IIR1 Band5", IIR1, BAND5),
+	WCD_IIR_FILTER_CTL("IIR2 Band1", IIR2, BAND1),
+	WCD_IIR_FILTER_CTL("IIR2 Band2", IIR2, BAND2),
+	WCD_IIR_FILTER_CTL("IIR2 Band3", IIR2, BAND3),
+	WCD_IIR_FILTER_CTL("IIR2 Band4", IIR2, BAND4),
+	WCD_IIR_FILTER_CTL("IIR2 Band5", IIR2, BAND5),
+	SOC_SINGLE_SX_TLV("IIR1 INP1 Volume", LPASS_CDC_IIR1_GAIN_B1_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR1 INP2 Volume", LPASS_CDC_IIR1_GAIN_B2_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR1 INP3 Volume", LPASS_CDC_IIR1_GAIN_B3_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR1 INP4 Volume", LPASS_CDC_IIR1_GAIN_B4_CTL,
+			0,  -84,	40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR2 INP1 Volume", LPASS_CDC_IIR2_GAIN_B1_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR2 INP2 Volume", LPASS_CDC_IIR2_GAIN_B2_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR2 INP3 Volume", LPASS_CDC_IIR2_GAIN_B3_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR2 INP4 Volume", LPASS_CDC_IIR2_GAIN_B4_CTL,
+			0,  -84, 40, digital_gain),
+
 };
 
 static int msm8916_wcd_digital_enable_interpolator(
@@ -448,6 +678,24 @@ static int msm8916_wcd_digital_enable_dmic(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const char * const iir_inp1_text[] = {
+	"ZERO", "DEC1", "DEC2", "RX1", "RX2", "RX3"
+};
+
+static const struct soc_enum iir1_inp1_mux_enum =
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_EQ1_B1_CTL,
+		0, 6, iir_inp1_text);
+
+static const struct soc_enum iir2_inp1_mux_enum =
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_EQ2_B1_CTL,
+		0, 6, iir_inp1_text);
+
+static const struct snd_kcontrol_new iir1_inp1_mux =
+	SOC_DAPM_ENUM("IIR1 INP1 Mux", iir1_inp1_mux_enum);
+
+static const struct snd_kcontrol_new iir2_inp1_mux =
+	SOC_DAPM_ENUM("IIR2 INP1 Mux", iir2_inp1_mux_enum);
+
 static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 	/*RX stuff */
 	SND_SOC_DAPM_AIF_IN("I2S RX1", NULL, 0, SND_SOC_NOPM, 0, 0),
@@ -534,6 +782,15 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Digital Mic1", NULL),
 	SND_SOC_DAPM_MIC("Digital Mic2", NULL),
 
+	/* Sidetone */
+	SND_SOC_DAPM_MUX("IIR1 INP1 MUX", SND_SOC_NOPM, 0, 0, &iir1_inp1_mux),
+	SND_SOC_DAPM_PGA_E("IIR1", LPASS_CDC_CLK_SD_CTL, 0, 0, NULL, 0,
+		msm8x16_wcd_codec_set_iir_gain, SND_SOC_DAPM_POST_PMU),
+
+	SND_SOC_DAPM_MUX("IIR2 INP1 MUX", SND_SOC_NOPM, 0, 0, &iir2_inp1_mux),
+	SND_SOC_DAPM_PGA_E("IIR2", LPASS_CDC_CLK_SD_CTL, 1, 0, NULL, 0,
+		msm8x16_wcd_codec_set_iir_gain, SND_SOC_DAPM_POST_PMU),
+
 };
 
 static int msm8916_wcd_digital_get_clks(struct platform_device *pdev,
@@ -708,10 +965,14 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"RX1 MIX1 INP1", "RX1", "I2S RX1"},
 	{"RX1 MIX1 INP1", "RX2", "I2S RX2"},
 	{"RX1 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX1 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX1 MIX1 INP1", "IIR2", "IIR2"},
 
 	{"RX1 MIX1 INP2", "RX1", "I2S RX1"},
 	{"RX1 MIX1 INP2", "RX2", "I2S RX2"},
 	{"RX1 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX1 MIX1 INP2", "IIR1", "IIR1"},
+	{"RX1 MIX1 INP2", "IIR2", "IIR2"},
 
 	{"RX1 MIX1 INP3", "RX1", "I2S RX1"},
 	{"RX1 MIX1 INP3", "RX2", "I2S RX2"},
@@ -728,10 +989,14 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"RX2 MIX1 INP1", "RX1", "I2S RX1"},
 	{"RX2 MIX1 INP1", "RX2", "I2S RX2"},
 	{"RX2 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX2 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX2 MIX1 INP1", "IIR2", "IIR2"},
 
 	{"RX2 MIX1 INP2", "RX1", "I2S RX1"},
 	{"RX2 MIX1 INP2", "RX2", "I2S RX2"},
 	{"RX2 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX2 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX2 MIX1 INP1", "IIR2", "IIR2"},
 
 	{"RX2 MIX1 INP3", "RX1", "I2S RX1"},
 	{"RX2 MIX1 INP3", "RX2", "I2S RX2"},
@@ -748,10 +1013,27 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"RX3 MIX1 INP1", "RX1", "I2S RX1"},
 	{"RX3 MIX1 INP1", "RX2", "I2S RX2"},
 	{"RX3 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX3 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX3 MIX1 INP1", "IIR2", "IIR2"},
 
 	{"RX3 MIX1 INP2", "RX1", "I2S RX1"},
 	{"RX3 MIX1 INP2", "RX2", "I2S RX2"},
 	{"RX3 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX3 MIX1 INP2", "IIR1", "IIR1"},
+	{"RX3 MIX1 INP2", "IIR2", "IIR2"},
+
+	{"RX1 MIX2 INP1", "IIR1", "IIR1"},
+	{"RX2 MIX2 INP1", "IIR1", "IIR1"},
+	{"RX1 MIX2 INP1", "IIR2", "IIR2"},
+	{"RX2 MIX2 INP1", "IIR2", "IIR2"},
+
+	{"IIR1", NULL, "IIR1 INP1 MUX"},
+	{"IIR1 INP1 MUX", "DEC1", "DEC1 MUX"},
+	{"IIR1 INP1 MUX", "DEC2", "DEC2 MUX"},
+
+	{"IIR2", NULL, "IIR2 INP1 MUX"},
+	{"IIR2 INP1 MUX", "DEC1", "DEC1 MUX"},
+	{"IIR2 INP1 MUX", "DEC2", "DEC2 MUX"},
 
 	{"RX3 MIX1 INP3", "RX1", "I2S RX1"},
 	{"RX3 MIX1 INP3", "RX2", "I2S RX2"},
-- 
2.20.1

