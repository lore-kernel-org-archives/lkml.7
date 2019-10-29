Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBF5CA9EC5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790A5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572353844;
	bh=/A/IykStI6SJ5QJMe87nweQh/Dvgw95vsOTLTwcpYhc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=T2f2zDCanNQ+c52Yl5zum6P8NRcBpfVoYMFbIR1CbvcEI9dcA6nEi/uxXrSQ/pe6H
	 0ODQzNXCoop53ifcCYk714f9n9wlgRX4nc2ShNaDottGTvTKkCLDlxgBCSXrbQmPr1
	 KmfRH71n5wjqTs69SIafhg/govWUZOWTxV1wahfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbfJ2M5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:57:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56898 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387901AbfJ2M5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CBQLq/65CvGse5vZ5IhccpSwngNnItVee/+ILoQUur0=; b=NEe6XtxYcThn
        bTmvcMIN1MnRHLAE6mcDNDsazPISqwuyVYdrzzrgGR+HvCwcXVZV2vxjLKF4FSZ0mFTHoV+xfLv4s
        c/BOBFzrvWrbQvplTiRlCb4rfhIHMdrFXPtMS9+zJkSmWGuM3vVUGcGMw7kyuoEqZK35b97YdL9qC
        upl4c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iPR3T-0002DG-Pu; Tue, 29 Oct 2019 12:56:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5564627428D8; Tue, 29 Oct 2019 12:56:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     alsa-devel@alsa-project.org, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dgreid@chromium.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Takashi Iwai <tiwai@suse.com>, tzungbi@chromium.org
Subject: Applied "ASoC: rockchip_max98090: Optionally support HDMI use case" to the asoc tree
In-Reply-To: <20191028071930.145899-4-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20191029125659.5564627428D8@ypsilon.sirena.org.uk>
Date:   Tue, 29 Oct 2019 12:56:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip_max98090: Optionally support HDMI use case

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

From 05b754f5f41c1ea5366c37c8f0ee04c4b4899ff9 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Mon, 28 Oct 2019 15:19:27 +0800
Subject: [PATCH] ASoC: rockchip_max98090: Optionally support HDMI use case

Support three different use cases with rockchip_max98090 driver.

The three use cases:
- max98090 only: Current usage, where HDMI link is missing.
- HDMI only: Needed use case for veyron_mickey board.
- max98090 + HDMI: Ideal use case for veyron_jerry, veyron_minnie..etc.

The presence of max98090 is determined by the presence of
rockchip,audio-codec device property.

The presence of HDMI is determined by the presence of
rockchip,hdmi-codec device property.

Create different sound card based on the configuration.
Note that we keep max98090 only usage for backward compatibility.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Link: https://lore.kernel.org/r/20191028071930.145899-4-cychiang@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 291 +++++++++++++++++++------
 1 file changed, 226 insertions(+), 65 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 0097df1fae66..50ef9b8e7ce4 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
@@ -36,28 +37,73 @@ static struct snd_soc_jack_pin headset_jack_pins[] = {
 
 };
 
-static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Int Mic", NULL),
-	SND_SOC_DAPM_SPK("Speaker", NULL),
+#define RK_MAX98090_WIDGETS \
+	SND_SOC_DAPM_HP("Headphone", NULL), \
+	SND_SOC_DAPM_MIC("Headset Mic", NULL), \
+	SND_SOC_DAPM_MIC("Int Mic", NULL), \
+	SND_SOC_DAPM_SPK("Speaker", NULL)
+
+#define RK_HDMI_WIDGETS \
+	SND_SOC_DAPM_LINE("HDMI", NULL)
+
+static const struct snd_soc_dapm_widget rk_max98090_dapm_widgets[] = {
+	RK_MAX98090_WIDGETS,
+};
+
+static const struct snd_soc_dapm_widget rk_hdmi_dapm_widgets[] = {
+	RK_HDMI_WIDGETS,
+};
+
+static const struct snd_soc_dapm_widget rk_max98090_hdmi_dapm_widgets[] = {
+	RK_MAX98090_WIDGETS,
+	RK_HDMI_WIDGETS,
+};
+
+#define RK_MAX98090_AUDIO_MAP \
+	{"IN34", NULL, "Headset Mic"}, \
+	{"Headset Mic", NULL, "MICBIAS"}, \
+	{"DMICL", NULL, "Int Mic"}, \
+	{"Headphone", NULL, "HPL"}, \
+	{"Headphone", NULL, "HPR"}, \
+	{"Speaker", NULL, "SPKL"}, \
+	{"Speaker", NULL, "SPKR"}
+
+#define RK_HDMI_AUDIO_MAP \
+	{"HDMI", NULL, "TX"}
+
+static const struct snd_soc_dapm_route rk_max98090_audio_map[] = {
+	RK_MAX98090_AUDIO_MAP,
+};
+
+static const struct snd_soc_dapm_route rk_hdmi_audio_map[] = {
+	RK_HDMI_AUDIO_MAP,
 };
 
-static const struct snd_soc_dapm_route rk_audio_map[] = {
-	{"IN34", NULL, "Headset Mic"},
-	{"Headset Mic", NULL, "MICBIAS"},
-	{"DMICL", NULL, "Int Mic"},
-	{"Headphone", NULL, "HPL"},
-	{"Headphone", NULL, "HPR"},
-	{"Speaker", NULL, "SPKL"},
-	{"Speaker", NULL, "SPKR"},
+static const struct snd_soc_dapm_route rk_max98090_hdmi_audio_map[] = {
+	RK_MAX98090_AUDIO_MAP,
+	RK_HDMI_AUDIO_MAP,
+};
+
+#define RK_MAX98090_CONTROLS \
+	SOC_DAPM_PIN_SWITCH("Headphone"), \
+	SOC_DAPM_PIN_SWITCH("Headset Mic"), \
+	SOC_DAPM_PIN_SWITCH("Int Mic"), \
+	SOC_DAPM_PIN_SWITCH("Speaker")
+
+#define RK_HDMI_CONTROLS \
+	SOC_DAPM_PIN_SWITCH("HDMI")
+
+static const struct snd_kcontrol_new rk_max98090_controls[] = {
+	RK_MAX98090_CONTROLS,
 };
 
-static const struct snd_kcontrol_new rk_mc_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Headphone"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Int Mic"),
-	SOC_DAPM_PIN_SWITCH("Speaker"),
+static const struct snd_kcontrol_new rk_hdmi_controls[] = {
+	RK_HDMI_CONTROLS,
+};
+
+static const struct snd_kcontrol_new rk_max98090_hdmi_controls[] = {
+	RK_MAX98090_CONTROLS,
+	RK_HDMI_CONTROLS,
 };
 
 static int rk_jack_event(struct notifier_block *nb, unsigned long event,
@@ -122,15 +168,20 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
 				     SND_SOC_CLOCK_OUT);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+	if (ret) {
+		dev_err(cpu_dai->dev, "Can't set cpu dai clock %d\n", ret);
 		return ret;
 	}
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 				     SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+
+	/* HDMI codec dai does not need to set sysclk. */
+	if (!strcmp(rtd->dai_link->name, "HDMI"))
+		return 0;
+
+	if (ret) {
+		dev_err(codec_dai->dev, "Can't set codec dai clock %d\n", ret);
 		return ret;
 	}
 
@@ -152,20 +203,67 @@ static const struct snd_soc_ops rk_aif1_ops = {
 	.startup = rk_aif1_startup,
 };
 
-SND_SOC_DAILINK_DEFS(hifi,
-	DAILINK_COMP_ARRAY(COMP_EMPTY()),
-	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
-
-static struct snd_soc_dai_link rk_dailink = {
-	.name = "max98090",
-	.stream_name = "Audio",
-	.init = rk_init,
-	.ops = &rk_aif1_ops,
-	/* set max98090 as slave */
-	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBS_CFS,
-	SND_SOC_DAILINK_REG(hifi),
+SND_SOC_DAILINK_DEFS(analog,
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
+		     DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(hdmi,
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
+		     DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "i2s-hifi")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+enum {
+	DAILINK_MAX98090,
+	DAILINK_HDMI,
+};
+
+/* max98090 dai_link */
+static struct snd_soc_dai_link rk_max98090_dailinks[] = {
+	{
+		.name = "max98090",
+		.stream_name = "Analog",
+		.init = rk_init,
+		.ops = &rk_aif1_ops,
+		/* set max98090 as slave */
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(analog),
+	},
+};
+
+/* HDMI codec dai_link */
+static struct snd_soc_dai_link rk_hdmi_dailinks[] = {
+	{
+		.name = "HDMI",
+		.stream_name = "HDMI",
+		.ops = &rk_aif1_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(hdmi),
+	}
+};
+
+/* max98090 and HDMI codec dai_link */
+static struct snd_soc_dai_link rk_max98090_hdmi_dailinks[] = {
+	[DAILINK_MAX98090] = {
+		.name = "max98090",
+		.stream_name = "Analog",
+		.init = rk_init,
+		.ops = &rk_aif1_ops,
+		/* set max98090 as slave */
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(analog),
+	},
+	[DAILINK_HDMI] = {
+		.name = "HDMI",
+		.stream_name = "HDMI",
+		.ops = &rk_aif1_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(hdmi),
+	}
 };
 
 static int rk_98090_headset_init(struct snd_soc_component *component);
@@ -175,19 +273,47 @@ static struct snd_soc_aux_dev rk_98090_headset_dev = {
 	.init = rk_98090_headset_init,
 };
 
-static struct snd_soc_card snd_soc_card_rk = {
+static struct snd_soc_card rockchip_max98090_card = {
 	.name = "ROCKCHIP-I2S",
 	.owner = THIS_MODULE,
-	.dai_link = &rk_dailink,
-	.num_links = 1,
+	.dai_link = rk_max98090_dailinks,
+	.num_links = ARRAY_SIZE(rk_max98090_dailinks),
 	.aux_dev = &rk_98090_headset_dev,
 	.num_aux_devs = 1,
-	.dapm_widgets = rk_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(rk_dapm_widgets),
-	.dapm_routes = rk_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(rk_audio_map),
-	.controls = rk_mc_controls,
-	.num_controls = ARRAY_SIZE(rk_mc_controls),
+	.dapm_widgets = rk_max98090_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk_max98090_dapm_widgets),
+	.dapm_routes = rk_max98090_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(rk_max98090_audio_map),
+	.controls = rk_max98090_controls,
+	.num_controls = ARRAY_SIZE(rk_max98090_controls),
+};
+
+static struct snd_soc_card rockchip_hdmi_card = {
+	.name = "ROCKCHIP-HDMI",
+	.owner = THIS_MODULE,
+	.dai_link = rk_hdmi_dailinks,
+	.num_links = ARRAY_SIZE(rk_hdmi_dailinks),
+	.dapm_widgets = rk_hdmi_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk_hdmi_dapm_widgets),
+	.dapm_routes = rk_hdmi_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(rk_hdmi_audio_map),
+	.controls = rk_hdmi_controls,
+	.num_controls = ARRAY_SIZE(rk_hdmi_controls),
+};
+
+static struct snd_soc_card rockchip_max98090_hdmi_card = {
+	.name = "ROCKCHIP-MAX98090-HDMI",
+	.owner = THIS_MODULE,
+	.dai_link = rk_max98090_hdmi_dailinks,
+	.num_links = ARRAY_SIZE(rk_max98090_hdmi_dailinks),
+	.aux_dev = &rk_98090_headset_dev,
+	.num_aux_devs = 1,
+	.dapm_widgets = rk_max98090_hdmi_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk_max98090_hdmi_dapm_widgets),
+	.dapm_routes = rk_max98090_hdmi_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(rk_max98090_hdmi_audio_map),
+	.controls = rk_max98090_hdmi_controls,
+	.num_controls = ARRAY_SIZE(rk_max98090_hdmi_controls),
 };
 
 static int rk_98090_headset_init(struct snd_soc_component *component)
@@ -195,7 +321,7 @@ static int rk_98090_headset_init(struct snd_soc_component *component)
 	int ret;
 
 	/* Enable Headset and 4 Buttons Jack detection */
-	ret = snd_soc_card_jack_new(&snd_soc_card_rk, "Headset Jack",
+	ret = snd_soc_card_jack_new(component->card, "Headset Jack",
 				    SND_JACK_HEADSET |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
@@ -210,41 +336,75 @@ static int rk_98090_headset_init(struct snd_soc_component *component)
 	return ret;
 }
 
+static int rk_parse_headset_from_of(struct device *dev, struct device_node *np)
+{
+	rk_98090_headset_dev.dlc.of_node = of_parse_phandle(
+			np, "rockchip,headset-codec", 0);
+	if (!rk_98090_headset_dev.dlc.of_node) {
+		dev_err(dev,
+			"Property 'rockchip,headset-codec' missing/invalid\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int snd_rk_mc_probe(struct platform_device *pdev)
 {
 	int ret = 0;
-	struct snd_soc_card *card = &snd_soc_card_rk;
+	struct snd_soc_card *card;
+	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np_cpu;
+	struct device_node *np_audio, *np_hdmi;
 
-	/* register the soc card */
-	card->dev = &pdev->dev;
+	/* Parse DTS for I2S controller. */
+	np_cpu = of_parse_phandle(np, "rockchip,i2s-controller", 0);
 
-	rk_dailink.codecs->of_node = of_parse_phandle(np,
-			"rockchip,audio-codec", 0);
-	if (!rk_dailink.codecs->of_node) {
+	if (!np_cpu) {
 		dev_err(&pdev->dev,
-			"Property 'rockchip,audio-codec' missing or invalid\n");
+			"Property 'rockchip,i2s-controller missing or invalid\n");
 		return -EINVAL;
 	}
 
-	rk_dailink.cpus->of_node = of_parse_phandle(np,
-			"rockchip,i2s-controller", 0);
-	if (!rk_dailink.cpus->of_node) {
-		dev_err(&pdev->dev,
-			"Property 'rockchip,i2s-controller' missing or invalid\n");
+	/*
+	 * Find the card to use based on the presences of audio codec
+	 * and hdmi codec in device property. Set their of_node accordingly.
+	 */
+	np_audio = of_parse_phandle(np, "rockchip,audio-codec", 0);
+	np_hdmi = of_parse_phandle(np, "rockchip,hdmi-codec", 0);
+	if (np_audio && np_hdmi) {
+		card = &rockchip_max98090_hdmi_card;
+		card->dai_link[DAILINK_MAX98090].codecs->of_node = np_audio;
+		card->dai_link[DAILINK_HDMI].codecs->of_node = np_hdmi;
+		card->dai_link[DAILINK_MAX98090].cpus->of_node = np_cpu;
+		card->dai_link[DAILINK_MAX98090].platforms->of_node = np_cpu;
+		card->dai_link[DAILINK_HDMI].cpus->of_node = np_cpu;
+		card->dai_link[DAILINK_HDMI].platforms->of_node = np_cpu;
+	} else if (np_audio) {
+		card = &rockchip_max98090_card;
+		card->dai_link[0].codecs->of_node = np_audio;
+		card->dai_link[0].cpus->of_node = np_cpu;
+		card->dai_link[0].platforms->of_node = np_cpu;
+	} else if (np_hdmi) {
+		card = &rockchip_hdmi_card;
+		card->dai_link[0].codecs->of_node = np_hdmi;
+		card->dai_link[0].cpus->of_node = np_cpu;
+		card->dai_link[0].platforms->of_node = np_cpu;
+	} else {
+		dev_err(dev, "At least one of codecs should be specified\n");
 		return -EINVAL;
 	}
 
-	rk_dailink.platforms->of_node = rk_dailink.cpus->of_node;
+	card->dev = dev;
 
-	rk_98090_headset_dev.dlc.of_node = of_parse_phandle(np,
-			"rockchip,headset-codec", 0);
-	if (!rk_98090_headset_dev.dlc.of_node) {
-		dev_err(&pdev->dev,
-			"Property 'rockchip,headset-codec' missing/invalid\n");
-		return -EINVAL;
+	/* Parse headset detection codec. */
+	if (np_audio) {
+		ret = rk_parse_headset_from_of(dev, np);
+		if (ret)
+			return ret;
 	}
 
+	/* Parse card name. */
 	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -252,6 +412,7 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* register the soc card */
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.20.1

