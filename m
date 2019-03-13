Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1081CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D225620693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491687;
	bh=eoiJ8Y7WJpVfiM+Ls9DjOU5lrfujq1mV76rlmLsUG3w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hveS+fJ4f6yM7wvGNH3qlDFhkOJm8hQIHF1dwAFQz6pnR2L8sR4wV2Ayx+ANXz+jb
	 Z2UDTZdbLUfyTuvOF3qi1vpfVKpFBHJ7auesphWlU/zY7HbULrjhPZaez4NKQOzNvN
	 VBW+viaHkcFOiGyhRRaIMOn+qdJB7+drU0nI3/N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCMPjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49946 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfCMPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=X5sGB91oFBFVYIHkyXSiAn+ENZMIm0hBqBhWrcKAEqM=; b=bw2qxkLR1+TF
        r7QGBmPkYzcuugzIXvojcmdACC1EY8ym8Bxel5nprJ8mAtCMfVNv/ukNoZzREzFLvc5KeihQmechx
        wQdpBJIneS34hny3UufsqRL9xJm2aKW41TWu7e72hA/mYtTdVpcdC/J8zNKjBmfNXVDOkyVaUANwm
        JF9YY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45xz-0003R0-8J; Wed, 13 Mar 2019 15:38:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AE33D1128B97; Wed, 13 Mar 2019 15:38:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: i2s: change trigger traces" to the asoc tree
In-Reply-To:  <1552317990-24219-2-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190313153850.AE33D1128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:38:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: change trigger traces

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

From 52e7306ca2db565edc1503a74477f3547bc9e408 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 11 Mar 2019 16:26:28 +0100
Subject: [PATCH] ASoC: stm32: i2s: change trigger traces

Update traces to log capture/playback stream start/stop.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 47c334de6b09..783b33497435 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -593,7 +593,8 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		/* Enable i2s */
-		dev_dbg(cpu_dai->dev, "start I2S\n");
+		dev_dbg(cpu_dai->dev, "start I2S %s\n",
+			playback_flg ? "playback" : "capture");
 
 		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
 		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
@@ -638,6 +639,9 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dev_dbg(cpu_dai->dev, "stop I2S %s\n",
+			playback_flg ? "playback" : "capture");
+
 		if (playback_flg)
 			regmap_update_bits(i2s->regmap, STM32_I2S_IER_REG,
 					   I2S_IER_UDRIE,
@@ -654,8 +658,6 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			break;
 		}
 
-		dev_dbg(cpu_dai->dev, "stop I2S\n");
-
 		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,
 					 I2S_CR1_SPE, 0);
 		if (ret < 0) {
-- 
2.20.1

