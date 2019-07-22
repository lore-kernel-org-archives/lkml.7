Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D45C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FABB20665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798196;
	bh=knUUkoC4NZcZoIjGr30KdP1XfSCl+BHx5rWJuVgb6sg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0RimA29pxbQVM1xh+DwmxNpYCFAGtdXv/SkyL/KWSDXeLw0cSKRlTaTG2Ys0mLcZd
	 5rVw4OtoGic/8B8MFzCvFDPvdulVy8bT/257JGLOVK7dPtu4Py2Ju3OTI4QZpdN5DV
	 mdA2BZZxbzU40o3tt9OeLpvCpdvw8nZGoxuG5z/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfGVMXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:23:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58654 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfGVMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+TMbBa7jX8uUjOd/fKTs9EqZROGbLGEuI+x5vkFsDS0=; b=V/2VuKZT47Kh
        O+jYSXtZR1BrviwdbYuBXd1mQF0VUZH2JP3Z+jT3CZ6gMFbVN8syi62KcsbfETBfGrGFr2jUGdzO6
        kvds68WwxTjwoWLNdiVLThez58ITzVgDJjsxY+OsiRtFpXmV4bbYy8bK5vliEAd2jcPd/tvavX1e3
        ipIcE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKU-0007dq-JT; Mon, 22 Jul 2019 12:22:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1A0462740463; Mon, 22 Jul 2019 13:22:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     alsa-devel@alsa-project.org,
        Collabora Kernel ML <kernel@collabora.com>,
        cychiang@chromium.org, dianders@chromium.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "SoC: rockchip: rockchip_max98090: Enable MICBIAS for headset keypress detection" to the asoc tree
In-Reply-To: <20190719173929.24065-1-enric.balletbo@collabora.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122210.1A0462740463@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:10 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   SoC: rockchip: rockchip_max98090: Enable MICBIAS for headset keypress detection

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

From f86621cd6c6f54edfdd62da347b2bbb8d7fddc8d Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Fri, 19 Jul 2019 19:39:29 +0200
Subject: [PATCH] SoC: rockchip: rockchip_max98090: Enable MICBIAS for headset
 keypress detection

The TS3A227E says that the headset keypress detection needs the MICBIAS
power in order to report the key events to ensure proper operation
The headset keypress detection needs the MICBIAS power in order to report
the key events all the time as long as MIC is present. So MICBIAS pin
is forced on when a MICROPHONE is detected.

On Veyron Minnie I observed that if the MICBIAS power is not present and
the key press detection is activated (just because it is enabled when you
insert a headset), it randomly reports a keypress on insert.
E.g. (KEY_PLAYPAUSE)

 Event: (SW_HEADPHONE_INSERT), value 1
 Event: (SW_MICROPHONE_INSERT), value 1
 Event: -------------- SYN_REPORT ------------
 Event: (KEY_PLAYPAUSE), value 1

Userspace thinks that KEY_PLAYPAUSE is pressed and produces the annoying
effect that the media player starts a play/pause loop.

Note that, although most of the time the key reported is the one
associated with BTN_0, not always this is true. On my tests I also saw
different keys reported

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Link: https://lore.kernel.org/r/20190719173929.24065-1-enric.balletbo@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index c5fc24675a33..782e534d4c0d 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -61,6 +61,37 @@ static const struct snd_kcontrol_new rk_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
+static int rk_jack_event(struct notifier_block *nb, unsigned long event,
+			 void *data)
+{
+	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
+	struct snd_soc_dapm_context *dapm = &jack->card->dapm;
+
+	if (event & SND_JACK_MICROPHONE)
+		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
+	else
+		snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static struct notifier_block rk_jack_nb = {
+	.notifier_call = rk_jack_event,
+};
+
+static int rk_init(struct snd_soc_pcm_runtime *runtime)
+{
+	/*
+	 * The jack has already been created in the rk_98090_headset_init()
+	 * function.
+	 */
+	snd_soc_jack_notifier_register(&headset_jack, &rk_jack_nb);
+
+	return 0;
+}
+
 static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -119,6 +150,7 @@ SND_SOC_DAILINK_DEFS(hifi,
 static struct snd_soc_dai_link rk_dailink = {
 	.name = "max98090",
 	.stream_name = "Audio",
+	.init = rk_init,
 	.ops = &rk_aif1_ops,
 	/* set max98090 as slave */
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-- 
2.20.1

