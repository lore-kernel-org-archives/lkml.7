Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DEFC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3AA20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562347230;
	bh=PpDFMdj8Y/WOcmBMdTmYas5euYO79JSFLwyHTY59LZE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yp7Dt1rFWFT9mslbzuyMnmq0ufpD9dqMZqwAfonSccw8CT7ra/4NTiWkGeUBbWE5d
	 EKACbkZpiXFypwlSBwcwpemJD/J6zzGJmhkJl0YuOuZLiPoBKxbGAIHZZpr4+8LRpJ
	 gWU8g6rrzMxGnJ1z0+OiGX3EkFq9jNvx6CLKNEW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGERU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 13:20:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57074 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfGERU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 13:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2ThStbfjZy7dGop/GZdJqX18mi147KcSga4aEJ1WmBY=; b=QAqVfaywNc2V
        GqFHGj+VWP6HuirLc6CWTUgwCZQhrsH9+SSKkf3XvSSObPbvi+o9ORi4z3PYkmnTFbaIyjFo5bqbW
        HshpLWIFyrqMuDbmlsIPm9FnUh9pRLRgoRM4KMS6keRQ6cHIZ+iOUcSZNP9VIfvqgHZejYR0R6tQA
        pMQ/E=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hjRsF-0004ZP-AR; Fri, 05 Jul 2019 17:19:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9C2F82742B3A; Fri,  5 Jul 2019 18:19:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     alsa-devel@alsa-project.org, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        ~martijnbraam/pmos-upstream@lists.sr.ht,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Takashi Iwai <tiwai@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Applied "ASoC: sunxi: sun50i-codec-analog: Add earpiece" to the asoc tree
In-Reply-To: <20190703184814.27191-1-luca@z3ntu.xyz>
X-Patchwork-Hint: ignore
Message-Id: <20190705171950.9C2F82742B3A@ypsilon.sirena.org.uk>
Date:   Fri,  5 Jul 2019 18:19:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sunxi: sun50i-codec-analog: Add earpiece

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

From 1fe08602d1179e7bfb2e805b22e8f57f4916c51e Mon Sep 17 00:00:00 2001
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 3 Jul 2019 20:48:11 +0200
Subject: [PATCH] ASoC: sunxi: sun50i-codec-analog: Add earpiece

This adds the necessary registers and audio routes to play audio using
the Earpiece, that's supported on the A64.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20190703184814.27191-1-luca@z3ntu.xyz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index d105c90c3706..6d1de565350e 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -49,6 +49,15 @@
 #define SUN50I_ADDA_OR_MIX_CTRL_DACR		1
 #define SUN50I_ADDA_OR_MIX_CTRL_DACL		0
 
+#define SUN50I_ADDA_EARPIECE_CTRL0	0x03
+#define SUN50I_ADDA_EARPIECE_CTRL0_EAR_RAMP_TIME	4
+#define SUN50I_ADDA_EARPIECE_CTRL0_ESPSR		0
+
+#define SUN50I_ADDA_EARPIECE_CTRL1	0x04
+#define SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN	7
+#define SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE	6
+#define SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL	0
+
 #define SUN50I_ADDA_LINEOUT_CTRL0	0x05
 #define SUN50I_ADDA_LINEOUT_CTRL0_LEN		7
 #define SUN50I_ADDA_LINEOUT_CTRL0_REN		6
@@ -172,6 +181,10 @@ static const DECLARE_TLV_DB_RANGE(sun50i_codec_lineout_vol_scale,
 	2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
 );
 
+static const DECLARE_TLV_DB_RANGE(sun50i_codec_earpiece_vol_scale,
+	0, 1, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
+	2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
+);
 
 /* volume / mute controls */
 static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
@@ -225,6 +238,15 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
 		   SUN50I_ADDA_LINEOUT_CTRL0_LEN,
 		   SUN50I_ADDA_LINEOUT_CTRL0_REN, 1, 0),
 
+	SOC_SINGLE_TLV("Earpiece Playback Volume",
+		       SUN50I_ADDA_EARPIECE_CTRL1,
+		       SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL, 0x1f, 0,
+		       sun50i_codec_earpiece_vol_scale),
+
+	SOC_SINGLE("Earpiece Playback Switch",
+		   SUN50I_ADDA_EARPIECE_CTRL1,
+		   SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
+
 };
 
 static const char * const sun50i_codec_hp_src_enum_text[] = {
@@ -257,6 +279,20 @@ static const struct snd_kcontrol_new sun50i_codec_lineout_src[] = {
 		      sun50i_codec_lineout_src_enum),
 };
 
+static const char * const sun50i_codec_earpiece_src_enum_text[] = {
+	"DACR", "DACL", "Right Mixer", "Left Mixer",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun50i_codec_earpiece_src_enum,
+			    SUN50I_ADDA_EARPIECE_CTRL0,
+			    SUN50I_ADDA_EARPIECE_CTRL0_ESPSR,
+			    sun50i_codec_earpiece_src_enum_text);
+
+static const struct snd_kcontrol_new sun50i_codec_earpiece_src[] = {
+	SOC_DAPM_ENUM("Earpiece Source Playback Route",
+		      sun50i_codec_earpiece_src_enum),
+};
+
 static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	/* DAC */
 	SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
@@ -285,6 +321,12 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
 	SND_SOC_DAPM_OUTPUT("LINEOUT"),
 
+	SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
+			 SND_SOC_NOPM, 0, 0, sun50i_codec_earpiece_src),
+	SND_SOC_DAPM_OUT_DRV("Earpiece Amp", SUN50I_ADDA_EARPIECE_CTRL1,
+			     SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("EARPIECE"),
+
 	/* Microphone inputs */
 	SND_SOC_DAPM_INPUT("MIC1"),
 
@@ -388,6 +430,14 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Line Out Source Playback Route", "Mono Differential",
 		"Right Mixer" },
 	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
+
+	/* Earpiece Routes */
+	{ "Earpiece Source Playback Route", "DACL", "Left DAC" },
+	{ "Earpiece Source Playback Route", "DACR", "Right DAC" },
+	{ "Earpiece Source Playback Route", "Left Mixer", "Left Mixer" },
+	{ "Earpiece Source Playback Route", "Right Mixer", "Right Mixer" },
+	{ "Earpiece Amp", NULL, "Earpiece Source Playback Route" },
+	{ "EARPIECE", NULL, "Earpiece Amp" },
 };
 
 static const struct snd_soc_component_driver sun50i_codec_analog_cmpnt_drv = {
-- 
2.20.1

