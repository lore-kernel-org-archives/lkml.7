Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A717C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D30421A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930061;
	bh=qO1biwDVhpB4NZ64+zOg1tfN3f5LTNXedsN7iyGYX+Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nzu6hhM1xfg33MV4TNUMt0l7wina6FY/K/iff6O0xZ6LNIawWUgMm+bpYBrXTCi9f
	 pzOLfzWOLxn9GLz+7BZL6WqKKhS7/GdMQqsDOtq4l7NSQyRybKzt/SzS6X8EjzARAI
	 KIXFF4FjxHjGSON3qkN27bhUNKczfdQ2eMlF0vJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfJALlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:41:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbfJALk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Iv9wdKvTB0h+dHZKzI9dA1j0Tf9XKyywHQlK8mDvtjk=; b=Rm1HYTgatKnU
        DPpL4yS+eCBVV1I1h0pIsCWojSnTboCNhulb67RhJ5tQnl/DpUB+I/xGkR52TWvqtu9yjPf01jjJC
        dQ4oppb6IEyuoqWUconqjzpx1hTNZ3tJt2/+UjL1hmO4dVURdWVloe+Xyyv3JQWiQd4QzD5YGgBqp
        W467w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWN-0004Si-5U; Tue, 01 Oct 2019 11:40:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A948D27429C0; Tue,  1 Oct 2019 12:40:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: adau1761: Add PGA Slew time control" to the asoc tree
In-Reply-To: <20190926115012.24049-1-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114046.A948D27429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: adau1761: Add PGA Slew time control

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

From 83078521072e95cf555d356f9e0b39021c46ac76 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 26 Sep 2019 14:50:11 +0300
Subject: [PATCH] ASoC: adau1761: Add PGA Slew time control

The PGA Slew Time control allows to configure the rate with which the PGA
gain control ramps up/down to the target setting.

The PGA slew control is done via the ALC Control 0 register. There are 2
bits on that reg, that control PGA slew time, while the other bits control
parts of the ALC (automatic level control) block.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926115012.24049-1-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1761.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 977f5a63be3f..a9ef735f8b4e 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -28,6 +28,7 @@
 #define ADAU1761_REC_MIXER_RIGHT1	0x400d
 #define ADAU1761_LEFT_DIFF_INPUT_VOL	0x400e
 #define ADAU1761_RIGHT_DIFF_INPUT_VOL	0x400f
+#define ADAU1761_ALC_CTRL0		0x4011
 #define ADAU1761_PLAY_LR_MIXER_LEFT	0x4020
 #define ADAU1761_PLAY_MIXER_LEFT0	0x401c
 #define ADAU1761_PLAY_MIXER_LEFT1	0x401d
@@ -71,6 +72,7 @@ static const struct reg_default adau1761_reg_defaults[] = {
 	{ ADAU1761_REC_MIXER_RIGHT0,		0x00 },
 	{ ADAU1761_REC_MIXER_RIGHT1,		0x00 },
 	{ ADAU1761_LEFT_DIFF_INPUT_VOL,		0x00 },
+	{ ADAU1761_ALC_CTRL0,			0x00 },
 	{ ADAU1761_RIGHT_DIFF_INPUT_VOL,	0x00 },
 	{ ADAU1761_PLAY_LR_MIXER_LEFT,		0x00 },
 	{ ADAU1761_PLAY_MIXER_LEFT0,		0x00 },
@@ -147,6 +149,21 @@ static SOC_VALUE_ENUM_SINGLE_DECL(adau1761_capture_bias_enum,
 		ADAU17X1_REC_POWER_MGMT, 1, 0x3, adau1761_bias_select_text,
 		adau1761_bias_select_values);
 
+static const unsigned int adau1761_pga_slew_time_values[] = {
+	3, 0, 1, 2,
+};
+
+static const char * const adau1761_pga_slew_time_text[] = {
+	"Off",
+	"24 ms",
+	"48 ms",
+	"96 ms",
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(adau1761_pga_slew_time_enum,
+		ADAU1761_ALC_CTRL0, 6, 0x3, adau1761_pga_slew_time_text,
+		adau1761_pga_slew_time_values);
+
 static const struct snd_kcontrol_new adau1761_jack_detect_controls[] = {
 	SOC_SINGLE("Speaker Auto-mute Switch", ADAU1761_DIGMIC_JACKDETECT,
 		4, 1, 0),
@@ -161,6 +178,8 @@ static const struct snd_kcontrol_new adau1761_differential_mode_controls[] = {
 
 	SOC_DOUBLE_R_TLV("PGA Boost Capture Volume", ADAU1761_REC_MIXER_LEFT1,
 		ADAU1761_REC_MIXER_RIGHT1, 3, 2, 0, adau1761_pga_boost_tlv),
+
+	SOC_ENUM("PGA Capture Slew Time", adau1761_pga_slew_time_enum),
 };
 
 static const struct snd_kcontrol_new adau1761_single_mode_controls[] = {
@@ -632,6 +651,7 @@ static bool adau1761_readable_register(struct device *dev, unsigned int reg)
 	case ADAU1761_DEJITTER:
 	case ADAU1761_CLK_ENABLE0:
 	case ADAU1761_CLK_ENABLE1:
+	case ADAU1761_ALC_CTRL0:
 		return true;
 	default:
 		break;
-- 
2.20.1

