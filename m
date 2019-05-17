Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB87C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2302089E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558089321;
	bh=maHsfARJNSPH4diqBz+T/CqJLWfXNbmCQuCjFACq2Zw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mDS7mWU3ZIvsZfA3REhXWjzwxfLR3vjozeP7SfOOOPC3jIKODTYO0UR2W++x9gbiM
	 kDTnbHgF0oAQrymcR6JScPQYT5aBMgvX51HF9g0EC5dWgNM254SUGUDNNsqgwqb6MB
	 q85CCZedVVTu67NM2u/ddj/WjspYa6/g1VQ5upVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfEQKfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:35:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44356 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfEQKfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3yIQ0AOdHWQzC6rb+WwEefXqE5Fe2rpIMJ7AF7EUJtw=; b=xzM81uaIt0Li
        BcSEi6QrUIpncpFHkiGp6XrwzooGpWZW+3wtdbV/+Kc6ViPDNMiO93nn+obBkuP5J/X6I3YOhsCx8
        E6hxSA2B4Pfxbiy5/QkNZQCq6CyeCCZTjY0xT9ogofS5EwFg6L3y/d91nCwiwchk3vjaRSZ0DW0B1
        OXddA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hRaCI-0001gY-F7; Fri, 17 May 2019 10:34:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D58891126D64; Fri, 17 May 2019 11:34:38 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        sravanhome@gmail.com, tiwai@suse.com
Subject: Applied "ASoC: tlv320aic3x: Add support for high power analog output" to the asoc tree
In-Reply-To:  <20190511151149.28823-1-sravanhome@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190517103438.D58891126D64@debutante.sirena.org.uk>
Date:   Fri, 17 May 2019 11:34:38 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320aic3x: Add support for high power analog output

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

From bfa8130f50a63563eae10ef933fe01b50b3e87a0 Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Sat, 11 May 2019 17:11:49 +0200
Subject: [PATCH] ASoC: tlv320aic3x: Add support for high power analog output

Add support to output level control for the analog high power output
drivers HPOUT and HPCOM.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic3x.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 516d17cb2182..599e4ed3850b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
  */
 static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
 
+/* Output volumes. From 0 to 9 dB in 1 dB steps */
+static const DECLARE_TLV_DB_SCALE(out_tlv, 0, 100, 0);
+
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Output */
 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
@@ -386,11 +389,17 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 			 DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
 			 0, 118, 1, output_stage_tlv),
 
-	/* Output pin mute controls */
+	/* Output pin controls */
+	SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, 4,
+			 9, 0, out_tlv),
 	SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3,
 		     0x01, 0),
+	SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, 4,
+			 9, 0, out_tlv),
 	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
+	SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL,
+			 4, 9, 0, out_tlv),
 	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
 
@@ -472,6 +481,9 @@ static const struct snd_kcontrol_new aic3x_mono_controls[] = {
 			 0, 118, 1, output_stage_tlv),
 
 	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
+	SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0,
+			out_tlv),
+
 };
 
 /*
-- 
2.20.1

