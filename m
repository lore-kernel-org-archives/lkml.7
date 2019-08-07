Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B31C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EF021E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565184663;
	bh=nxrTq08eV0QgbjIKI+azAC+TZQk+a3y7TNPBv3VHYUc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JAqxvZg5AFVsr4J0Fb1x3jxEK3caUe28CN4JUhC5XaSrI4E+VYRcr2OX/oR0Qc9wj
	 cWE2BGbibczw4Fhhj53mR1BHhoP6QeH2/DZiQEVjGIbCnMYOZMTZIuhxV3fCTEzfm2
	 Cmrlr/xdpLe7R88q/RffsohNUCH/M7d6V3JlTDTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfHGNbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:31:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35260 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbfHGNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2EbYTAqI4zLOFVUYBUHF/BE1UcTYirfxLUj8k3Q4Nh8=; b=rwRWB8D+EP/r
        y2l2Zf6wdcIIFVMHu5VxN3NvzqClPMRV9k8tlI75E6a/+E6KdhGWSVLRHi8wFfR3UNcGD9PtNf/mX
        649w19tiNe6iuBQ2IbRGAQfi0et1MFjpj99a+uxVnIqRR/Y/c5XhRhLk4QwPb4jpvlR7niSkKK5CU
        vRi78=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvM1f-0007fA-LY; Wed, 07 Aug 2019 13:30:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 05EA42742B9E; Wed,  7 Aug 2019 14:30:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, angus@akkea.ca, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, l.stach@pengutronix.de,
        Mark Brown <broonie@kernel.org>, mihai.serban@gmail.com,
        nicoleotsuka@gmail.com, Nicolin Chen <nicoleotsuka@gmail.com>,
        robh@kernel.org, shengjiu.wang@nxp.com, timur@kernel.org,
        tiwai@suse.com
Subject: Applied "ASoC: fsl_sai: Update Tx/Rx channel enable mask" to the asoc tree
In-Reply-To: <20190806151214.6783-3-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190807133047.05EA42742B9E@ypsilon.sirena.org.uk>
Date:   Wed,  7 Aug 2019 14:30:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_sai: Update Tx/Rx channel enable mask

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

From b84f50b0fcb497a62068926fca793d2d213c7dbd Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 6 Aug 2019 18:12:11 +0300
Subject: [PATCH] ASoC: fsl_sai: Update Tx/Rx channel enable mask

Tx channel enable (TCE) / Rx channel enable (RCE) bits
enable corresponding data channel for Tx/Rx operation.

Because SAI supports up the 8 channels TCE/RCE occupy
up the 8 bits inside TCR3/RCR3 registers we need to extend
the mask to reflect this.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20190806151214.6783-3-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 6 ++++--
 sound/soc/fsl/fsl_sai.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index e4221f2a5ee3..f2698c94c9fe 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -599,7 +599,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	int ret;
 
-	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
+	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
+			   FSL_SAI_CR3_TRCE_MASK,
 			   FSL_SAI_CR3_TRCE);
 
 	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
@@ -614,7 +615,8 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 
-	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
+			   FSL_SAI_CR3_TRCE_MASK, 0);
 }
 
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 4bb478041d67..20c5b9b1e8bc 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -110,6 +110,7 @@
 
 /* SAI Transmit and Receive Configuration 3 Register */
 #define FSL_SAI_CR3_TRCE	BIT(16)
+#define FSL_SAI_CR3_TRCE_MASK	GENMASK(23, 16)
 #define FSL_SAI_CR3_WDFL(x)	(x)
 #define FSL_SAI_CR3_WDFL_MASK	0x1f
 
-- 
2.20.1

