Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBEEC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CA520679
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577232550;
	bh=LrCrjx9Jxlwg2IpcZJI8G2Ns3kvwyP56z3bFktDdaUY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=J+rxQQVoz1Na5iaxxa3+l0ton0hWi+AY34rTHeuo8qJnkI749vEWJSQzqZXCrwiOH
	 FIZpEk5dYu5ezqevprYsXd7MvLnig49nYNJeEcOgoii9NRaOtLod8kUnn2i+XOa/IS
	 lyBxb6vYiQX+fPOSjnJr1OIijDXlLOb9q1vhLPK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLYAJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:09:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfLYAJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=p26wgisYxxYMSvvPgu9UbmNcMRVE/Th6vTcPV+OsQJw=; b=uc+NypEqzyEH
        a/y3n70VYmrfyw0xoV9fXTRRzr8AdE5JrJgqd/SMmC9nbPVxPJBTE17J3JvfDvBsNMgaBJFMjzT2n
        zRfNWiGYAizT4dCr9lYUqH1hZGNkXG1lnK5jTs3K2oLfBPasmIdvpqC1aJDZrey9KmzG2k9ZuM1s6
        NjyZM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuET-0007KY-Rf; Wed, 25 Dec 2019 00:08:57 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5140BD01963; Wed, 25 Dec 2019 00:08:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Angus Ainslie (Purism) <angus@akkea.ca>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, kernel@puri.sm,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robh@kernel.org
Subject: Applied "ASoC: gtm601: add Broadmobi bm818 sound profile" to the asoc tree
In-Reply-To: <20191223154712.18581-2-angus@akkea.ca>
Message-Id: <applied-20191223154712.18581-2-angus@akkea.ca>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:08:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: gtm601: add Broadmobi bm818 sound profile

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 057a317a8d94136b76a3cc6f7be53ee2b85dc115 Mon Sep 17 00:00:00 2001
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Mon, 23 Dec 2019 07:47:11 -0800
Subject: [PATCH] ASoC: gtm601: add Broadmobi bm818 sound profile

The Broadmobi bm818 uses stereo sound at 48Khz sample rate

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Link: https://lore.kernel.org/r/20191223154712.18581-2-angus@akkea.ca
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/gtm601.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index d454294c8d06..7f05ebcb88d1 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/device.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
@@ -47,6 +47,24 @@ static struct snd_soc_dai_driver gtm601_dai = {
 	},
 };
 
+static struct snd_soc_dai_driver bm818_dai = {
+	.name = "bm818",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
 static const struct snd_soc_component_driver soc_component_dev_gtm601 = {
 	.dapm_widgets		= gtm601_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(gtm601_dapm_widgets),
@@ -60,13 +78,19 @@ static const struct snd_soc_component_driver soc_component_dev_gtm601 = {
 
 static int gtm601_platform_probe(struct platform_device *pdev)
 {
+	const struct snd_soc_dai_driver *dai_driver;
+
+	dai_driver = of_device_get_match_data(&pdev->dev);
+
 	return devm_snd_soc_register_component(&pdev->dev,
-			&soc_component_dev_gtm601, &gtm601_dai, 1);
+			&soc_component_dev_gtm601,
+			(struct snd_soc_dai_driver *)dai_driver, 1);
 }
 
 #if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
-	{ .compatible = "option,gtm601", },
+	{ .compatible = "option,gtm601", .data = (void *)&gtm601_dai },
+	{ .compatible = "broadmobi,bm818", .data = (void *)&bm818_dai },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
-- 
2.20.1

