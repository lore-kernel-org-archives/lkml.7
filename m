Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE1C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F082133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930165;
	bh=NiDeweyQkKZ1+LLV45mA9BkC3mtsZTOGXP3GZKh3PyY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=INkUrCzkkp2EyOXPrlVJX3N63tg7p/bWNPEmCchRBL2ESP8qUoP3Bdpw+p/5IIBKY
	 P/6nIscUTi371Fkzge/n30MApfWu8Z5TsZRMv+DBmjn6ww6NwzRU8xqm9ZBmntH/Gx
	 Pyn23L4cpo8I5YBShxc+gqpD1BnmWTXPJZHWhPHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfJALk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:40:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40500 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387446AbfJALk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V5RHpSxNWzakocPlU9cRm3U97yA8CaJ3phtqtgfY7I4=; b=MHUKoAUBl2Zt
        WiiduYioNcPPpDycy8PHlqg4lvEycqcA8pHeZj9pVUtl1WaiGWduVIW+KJzKrWt2NEWuD0tWzKPhF
        k6A/sYap8yppd7+ffU7CQuxceXyRK1aQzQKgYT9Rc8LbkBK9WHIyC7fC/Vvnf7q6NsiAwC7/mGKRg
        ib3mQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWM-0004Sf-UZ; Tue, 01 Oct 2019 11:40:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6C1012742A30; Tue,  1 Oct 2019 12:40:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: adau1761: Add ALC controls" to the asoc tree
In-Reply-To: <20190926115012.24049-2-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114046.6C1012742A30@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: adau1761: Add ALC controls

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

From 5422737192d907c6fd181479c25690e7f371e9dd Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 26 Sep 2019 14:50:12 +0300
Subject: [PATCH] ASoC: adau1761: Add ALC controls

The adau1761 has a automatic level control block that can adjust the gain
for the differential input PGA. This patch adds ALSA controls for enabling
and changing the parameter settings for the ALC.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926115012.24049-2-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1761.c | 109 ++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index a9ef735f8b4e..5ca9b744b7d8 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -29,6 +29,9 @@
 #define ADAU1761_LEFT_DIFF_INPUT_VOL	0x400e
 #define ADAU1761_RIGHT_DIFF_INPUT_VOL	0x400f
 #define ADAU1761_ALC_CTRL0		0x4011
+#define ADAU1761_ALC_CTRL1		0x4012
+#define ADAU1761_ALC_CTRL2		0x4013
+#define ADAU1761_ALC_CTRL3		0x4014
 #define ADAU1761_PLAY_LR_MIXER_LEFT	0x4020
 #define ADAU1761_PLAY_MIXER_LEFT0	0x401c
 #define ADAU1761_PLAY_MIXER_LEFT1	0x401d
@@ -73,6 +76,9 @@ static const struct reg_default adau1761_reg_defaults[] = {
 	{ ADAU1761_REC_MIXER_RIGHT1,		0x00 },
 	{ ADAU1761_LEFT_DIFF_INPUT_VOL,		0x00 },
 	{ ADAU1761_ALC_CTRL0,			0x00 },
+	{ ADAU1761_ALC_CTRL1,			0x00 },
+	{ ADAU1761_ALC_CTRL2,			0x00 },
+	{ ADAU1761_ALC_CTRL3,			0x00 },
 	{ ADAU1761_RIGHT_DIFF_INPUT_VOL,	0x00 },
 	{ ADAU1761_PLAY_LR_MIXER_LEFT,		0x00 },
 	{ ADAU1761_PLAY_MIXER_LEFT0,		0x00 },
@@ -123,6 +129,10 @@ static const DECLARE_TLV_DB_SCALE(adau1761_sidetone_tlv, -1800, 300, 1);
 static const DECLARE_TLV_DB_SCALE(adau1761_boost_tlv, -600, 600, 1);
 static const DECLARE_TLV_DB_SCALE(adau1761_pga_boost_tlv, -2000, 2000, 1);
 
+static const DECLARE_TLV_DB_SCALE(adau1761_alc_max_gain_tlv, -1200, 600, 0);
+static const DECLARE_TLV_DB_SCALE(adau1761_alc_target_tlv, -2850, 150, 0);
+static const DECLARE_TLV_DB_SCALE(adau1761_alc_ng_threshold_tlv, -7650, 150, 0);
+
 static const unsigned int adau1761_bias_select_values[] = {
 	0, 2, 3,
 };
@@ -160,9 +170,91 @@ static const char * const adau1761_pga_slew_time_text[] = {
 	"96 ms",
 };
 
+static const char * const adau1761_alc_function_text[] = {
+	"Off",
+	"Right",
+	"Left",
+	"Stereo",
+	"DSP control",
+};
+
+static const char * const adau1761_alc_hold_time_text[] = {
+	"2.67 ms",
+	"5.34 ms",
+	"10.68 ms",
+	"21.36 ms",
+	"42.72 ms",
+	"85.44 ms",
+	"170.88 ms",
+	"341.76 ms",
+	"683.52 ms",
+	"1367 ms",
+	"2734.1 ms",
+	"5468.2 ms",
+	"10936 ms",
+	"21873 ms",
+	"43745 ms",
+	"87491 ms",
+};
+
+static const char * const adau1761_alc_attack_time_text[] = {
+	"6 ms",
+	"12 ms",
+	"24 ms",
+	"48 ms",
+	"96 ms",
+	"192 ms",
+	"384 ms",
+	"768 ms",
+	"1540 ms",
+	"3070 ms",
+	"6140 ms",
+	"12290 ms",
+	"24580 ms",
+	"49150 ms",
+	"98300 ms",
+	"196610 ms",
+};
+
+static const char * const adau1761_alc_decay_time_text[] = {
+	"24 ms",
+	"48 ms",
+	"96 ms",
+	"192 ms",
+	"384 ms",
+	"768 ms",
+	"15400 ms",
+	"30700 ms",
+	"61400 ms",
+	"12290 ms",
+	"24580 ms",
+	"49150 ms",
+	"98300 ms",
+	"196610 ms",
+	"393220 ms",
+	"786430 ms",
+};
+
+static const char * const adau1761_alc_ng_type_text[] = {
+	"Hold",
+	"Mute",
+	"Fade",
+	"Fade + Mute",
+};
+
 static SOC_VALUE_ENUM_SINGLE_DECL(adau1761_pga_slew_time_enum,
 		ADAU1761_ALC_CTRL0, 6, 0x3, adau1761_pga_slew_time_text,
 		adau1761_pga_slew_time_values);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_function_enum,
+		ADAU1761_ALC_CTRL0, 0, adau1761_alc_function_text);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_hold_time_enum,
+		ADAU1761_ALC_CTRL1, 4, adau1761_alc_hold_time_text);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_attack_time_enum,
+		ADAU1761_ALC_CTRL2, 4, adau1761_alc_attack_time_text);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_decay_time_enum,
+		ADAU1761_ALC_CTRL2, 0, adau1761_alc_decay_time_text);
+static SOC_ENUM_SINGLE_DECL(adau1761_alc_ng_type_enum,
+		ADAU1761_ALC_CTRL3, 6, adau1761_alc_ng_type_text);
 
 static const struct snd_kcontrol_new adau1761_jack_detect_controls[] = {
 	SOC_SINGLE("Speaker Auto-mute Switch", ADAU1761_DIGMIC_JACKDETECT,
@@ -180,6 +272,20 @@ static const struct snd_kcontrol_new adau1761_differential_mode_controls[] = {
 		ADAU1761_REC_MIXER_RIGHT1, 3, 2, 0, adau1761_pga_boost_tlv),
 
 	SOC_ENUM("PGA Capture Slew Time", adau1761_pga_slew_time_enum),
+
+	SOC_SINGLE_TLV("ALC Capture Max Gain Volume", ADAU1761_ALC_CTRL0,
+		3, 7, 0, adau1761_alc_max_gain_tlv),
+	SOC_ENUM("ALC Capture Function", adau1761_alc_function_enum),
+	SOC_ENUM("ALC Capture Hold Time", adau1761_alc_hold_time_enum),
+	SOC_SINGLE_TLV("ALC Capture Target Volume", ADAU1761_ALC_CTRL1,
+		0, 15, 0, adau1761_alc_target_tlv),
+	SOC_ENUM("ALC Capture Attack Time", adau1761_alc_decay_time_enum),
+	SOC_ENUM("ALC Capture Decay Time", adau1761_alc_attack_time_enum),
+	SOC_ENUM("ALC Capture Noise Gate Type", adau1761_alc_ng_type_enum),
+	SOC_SINGLE("ALC Capture Noise Gate Switch",
+		ADAU1761_ALC_CTRL3, 5, 1, 0),
+	SOC_SINGLE_TLV("ALC Capture Noise Gate Threshold Volume",
+		ADAU1761_ALC_CTRL3, 0, 31, 0, adau1761_alc_ng_threshold_tlv),
 };
 
 static const struct snd_kcontrol_new adau1761_single_mode_controls[] = {
@@ -652,6 +758,9 @@ static bool adau1761_readable_register(struct device *dev, unsigned int reg)
 	case ADAU1761_CLK_ENABLE0:
 	case ADAU1761_CLK_ENABLE1:
 	case ADAU1761_ALC_CTRL0:
+	case ADAU1761_ALC_CTRL1:
+	case ADAU1761_ALC_CTRL2:
+	case ADAU1761_ALC_CTRL3:
 		return true;
 	default:
 		break;
-- 
2.20.1

