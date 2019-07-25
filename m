Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB852C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8658122BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564076635;
	bh=qVyB1Zul8As9/WHjxhmM2QzMVCPeMyHtNlzZaWpyttU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AEdase1sFM0fbWepCGZW23JQbNYD70qBji9PjCYmTo5MPO40n3GQ39sA4l3xRzAz3
	 T4lxWWBAXAKBdoDTp+arlWwppiYIvbpyuVY+B2xV1KLunLCR+MBwzGZTzpqBd/LkHd
	 Y2V6LKIMeEIR3hKc945cnoxGKYPX6w6PgRyuq86M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbfGYRny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:43:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36628 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbfGYRnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ANMpYSDNY6oEnY6y25VTsTy96X4rP+mF/SNqvsiqdGc=; b=T8D604aqzVVJ
        Duk4kaKnMxAxRnPCj5r5XAKqalKsudgHJe3rBjW8ZdIA+LY6CYgSBE4CdJolyW8qJqlau0KJXR++/
        +VdCXXyqPRgg4UrjpEeNhJ62/GQD0ROtsaFD07lLC2sVFNgBfsBKAeJZG6u7dMK2X83q2Mquxcnrf
        zo+a0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqhmG-0003NG-MR; Thu, 25 Jul 2019 17:43:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BAF9D2742B60; Thu, 25 Jul 2019 18:43:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec2codec: name link using stream direction" to the asoc tree
In-Reply-To: <20190725165949.29699-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190725174339.BAF9D2742B60@ypsilon.sirena.org.uk>
Date:   Thu, 25 Jul 2019 18:43:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codec2codec: name link using stream direction

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 054d65004c6a008dfefbdae4fc1b46a3ad4e94c1 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 25 Jul 2019 18:59:45 +0200
Subject: [PATCH] ASoC: codec2codec: name link using stream direction

At the moment, codec to codec dai link widgets are named after the
cpu dai and the 1st codec valid on the link. This might be confusing
if there is multiple valid codecs on the link for one stream
direction.

Instead, use the dai link name and the stream direction to name the
the dai link widget

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190725165949.29699-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 034b31fd2ecb..7db4abd9a0a5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4056,8 +4056,7 @@ snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
 
 static struct snd_soc_dapm_widget *
 snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
-		     struct snd_soc_dapm_widget *source,
-		     struct snd_soc_dapm_widget *sink)
+		     char *id)
 {
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
@@ -4067,7 +4066,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	int ret;
 
 	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
-				   source->name, sink->name);
+				   rtd->dai_link->name, id);
 	if (!link_name)
 		return ERR_PTR(-ENOMEM);
 
@@ -4247,15 +4246,13 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 	}
 
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-
 		/* connect BE DAI playback if widgets are valid */
 		codec = codec_dai->playback_widget;
 
 		if (playback_cpu && codec) {
 			if (!playback) {
 				playback = snd_soc_dapm_new_dai(card, rtd,
-								playback_cpu,
-								codec);
+								"playback");
 				if (IS_ERR(playback)) {
 					dev_err(rtd->dev,
 						"ASoC: Failed to create DAI %s: %ld\n",
@@ -4284,8 +4281,7 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 		if (codec && capture_cpu) {
 			if (!capture) {
 				capture = snd_soc_dapm_new_dai(card, rtd,
-							       codec,
-							       capture_cpu);
+							       "capture");
 				if (IS_ERR(capture)) {
 					dev_err(rtd->dev,
 						"ASoC: Failed to create DAI %s: %ld\n",
-- 
2.20.1

