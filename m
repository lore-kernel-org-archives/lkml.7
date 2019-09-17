Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2410EC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2BE2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568736181;
	bh=3X5ZjeOO1C1bcq2z1BMPTXQaL4HE6PHHkVBpaCMCei4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FfTzZPBPZ9kPwOk+k7LhGLqAitwS8N6YICCQ02LoZfzBrpBPi0TfJ6MPvD7TmAPek
	 9tohVDaHdZUUXK+gMWnK6+j0Rkd9OwgduaMiWXDEsT26WoTi84wMgjMb1i4eibTX17
	 OOHCuYHab58CbUS7GAQlE5ZamiHI0OLGAsOc2pyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfIQQDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:03:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56508 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfIQQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vaCvTr8Faen7PvXlxXOwvkyQjeDJvGKNYb4c/ee5Xm8=; b=Mz17ytn/Ahg6
        Y/QaIOxdq3D2Nbni7N3IVAxkvZEguVp+G4zD/hI84aVgabyrm9tJToQNYLjyGW2TRQZJwuaHPRIXM
        TXoWQHoDMfQJGxHzZpo6jC3IoBkY1JOR5u/gGx1zxxSnabRHWlYVLGVoWC+bMn8ibL2SwQi8STfEC
        l+osY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAFwH-0008O9-9x; Tue, 17 Sep 2019 16:02:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B319D27428FE; Tue, 17 Sep 2019 17:02:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Mihai Serban <mihai.serban@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>, festevam@gmail.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        Nicolin Chen <nicoleotsuka@gmail.com>, perex@perex.cz,
        timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_sai: Fix noise when using EDMA" to the asoc tree
In-Reply-To: <20190913192807.8423-2-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190917160248.B319D27428FE@ypsilon.sirena.org.uk>
Date:   Tue, 17 Sep 2019 17:02:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_sai: Fix noise when using EDMA

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

From e75f4940e8ad0dd76527302a10c06b58bf7eb590 Mon Sep 17 00:00:00 2001
From: Mihai Serban <mihai.serban@nxp.com>
Date: Fri, 13 Sep 2019 22:28:05 +0300
Subject: [PATCH] ASoC: fsl_sai: Fix noise when using EDMA

EDMA requires the period size to be multiple of maxburst. Otherwise the
remaining bytes are not transferred and thus noise is produced.

We can handle this issue by adding a constraint on
SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.

Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20190913192807.8423-2-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ef0b74693093..b517e4bc1b87 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -628,6 +628,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 			   FSL_SAI_CR3_TRCE_MASK,
 			   FSL_SAI_CR3_TRCE);
 
+	/*
+	 * EDMA controller needs period size to be a multiple of
+	 * tx/rx maxburst
+	 */
+	if (sai->soc_data->use_edma)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   tx ? sai->dma_params_tx.maxburst :
+					   sai->dma_params_rx.maxburst);
+
 	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
 
@@ -1026,30 +1036,35 @@ static int fsl_sai_remove(struct platform_device *pdev)
 
 static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
 	.use_imx_pcm = false,
+	.use_edma = false,
 	.fifo_depth = 32,
 	.reg_offset = 0,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.use_imx_pcm = true,
+	.use_edma = false,
 	.fifo_depth = 32,
 	.reg_offset = 0,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
 	.use_imx_pcm = true,
+	.use_edma = false,
 	.fifo_depth = 16,
 	.reg_offset = 8,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.use_imx_pcm = true,
+	.use_edma = false,
 	.fifo_depth = 128,
 	.reg_offset = 8,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
 	.use_imx_pcm = true,
+	.use_edma = true,
 	.fifo_depth = 64,
 	.reg_offset = 0,
 };
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index b12cb578f6d0..76b15deea80c 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -157,6 +157,7 @@
 
 struct fsl_sai_soc_data {
 	bool use_imx_pcm;
+	bool use_edma;
 	unsigned int fifo_depth;
 	unsigned int reg_offset;
 };
-- 
2.20.1

