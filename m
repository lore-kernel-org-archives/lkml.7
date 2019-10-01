Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1472C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B563D2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930153;
	bh=cKqzYNtfZEJ1yLIg8l/siBoXlooKQPR5rXPEATMNNMA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0SJeA8PT0YVhJEqd0TMVy8IBpzAemwzsbIL+TPN4H0QU1+SUTHe7QNL2/qLh5nOTR
	 x4dMXaIuW9O/Q6Fr11h5hQFVz6g0Xwnv1BCYhdkc1mazVhNvqZnDeph0GABjQlmDwV
	 u+H063TNZo50RwHSQ+PPCtMDCIqOW0ifPJHnnmLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbfJALm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:42:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40746 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbfJALlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RaehcVWI7CqFqJ3sZaDsrRQlx6JMqoPgEGwPcYTozzY=; b=V/Sz9RRPzg5A
        xKBq6NbmMeQKbD6lx5Z/CCT3ASOmtBGiUFBNdAYUpLomqjwo3x6XaI/rEhcAbzvKYfk1epb4eJPQc
        m//MQwL54TC1ov35IidCpvuvoD4LlIAYj1N0BDtmXn3ndrXGzAj8IuHcsiBG6UOYW2V5gmYLGURCy
        wK7gY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWM-0004ST-5i; Tue, 01 Oct 2019 11:40:46 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A06972742A31; Tue,  1 Oct 2019 12:40:45 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, nicoleotsuka@gmail.com, perex@perex.cz,
        robh+dt@kernel.org, timur@kernel.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com
Subject: Applied "ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams" to the asoc tree
In-Reply-To: <d728f65194e9978cbec4132b522d4fed420d704a.1569493933.git.shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114045.A06972742A31@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams

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

From e957204e732bc2916a241dc61dd7dd14e9a98350 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 27 Sep 2019 09:46:11 +0800
Subject: [PATCH] ASoC: pcm_dmaengine: Extract
 snd_dmaengine_pcm_refine_runtime_hwparams

When set the runtime hardware parameters, we may need to query
the capability of DMA to complete the parameters.

This patch is to Extract this operation from
dmaengine_pcm_set_runtime_hwparams function to a separate function
snd_dmaengine_pcm_refine_runtime_hwparams, that other components
which need this feature can call this function.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/d728f65194e9978cbec4132b522d4fed420d704a.1569493933.git.shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/dmaengine_pcm.h         |  5 ++
 sound/core/pcm_dmaengine.c            | 83 +++++++++++++++++++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c | 61 ++------------------
 3 files changed, 94 insertions(+), 55 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index c679f6116580..b65220685920 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -83,6 +83,11 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	const struct snd_dmaengine_dai_dma_data *dma_data,
 	struct dma_slave_config *config);
 
+int snd_dmaengine_pcm_refine_runtime_hwparams(
+	struct snd_pcm_substream *substream,
+	struct snd_dmaengine_dai_dma_data *dma_data,
+	struct snd_pcm_hardware *hw,
+	struct dma_chan *chan);
 
 /*
  * Try to request the DMA channel using compat_request_channel or
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 89a05926ac73..5749a8a49784 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -369,4 +369,87 @@ int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close_release_chan);
 
+/**
+ * snd_dmaengine_pcm_refine_runtime_hwparams - Refine runtime hw params
+ * @substream: PCM substream
+ * @dma_data: DAI DMA data
+ * @hw: PCM hw params
+ * @chan: DMA channel to use for data transfers
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function will query DMA capability, then refine the pcm hardware
+ * parameters.
+ */
+int snd_dmaengine_pcm_refine_runtime_hwparams(
+	struct snd_pcm_substream *substream,
+	struct snd_dmaengine_dai_dma_data *dma_data,
+	struct snd_pcm_hardware *hw,
+	struct dma_chan *chan)
+{
+	struct dma_slave_caps dma_caps;
+	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	snd_pcm_format_t i;
+	int ret = 0;
+
+	if (!hw || !chan || !dma_data)
+		return -EINVAL;
+
+	ret = dma_get_slave_caps(chan, &dma_caps);
+	if (ret == 0) {
+		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
+			hw->info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
+		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
+			hw->info |= SNDRV_PCM_INFO_BATCH;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			addr_widths = dma_caps.dst_addr_widths;
+		else
+			addr_widths = dma_caps.src_addr_widths;
+	}
+
+	/*
+	 * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
+	 * hw.formats set to 0, meaning no restrictions are in place.
+	 * In this case it's the responsibility of the DAI driver to
+	 * provide the supported format information.
+	 */
+	if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
+		/*
+		 * Prepare formats mask for valid/allowed sample types. If the
+		 * dma does not have support for the given physical word size,
+		 * it needs to be masked out so user space can not use the
+		 * format which produces corrupted audio.
+		 * In case the dma driver does not implement the slave_caps the
+		 * default assumption is that it supports 1, 2 and 4 bytes
+		 * widths.
+		 */
+		for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+			int bits = snd_pcm_format_physical_width(i);
+
+			/*
+			 * Enable only samples with DMA supported physical
+			 * widths
+			 */
+			switch (bits) {
+			case 8:
+			case 16:
+			case 24:
+			case 32:
+			case 64:
+				if (addr_widths & (1 << (bits / 8)))
+					hw->formats |= pcm_format_to_bits(i);
+				break;
+			default:
+				/* Unsupported types */
+				break;
+			}
+		}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_refine_runtime_hwparams);
+
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 5552c66ca642..f2c98a9cbf75 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -118,12 +118,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	struct device *dma_dev = dmaengine_dma_dev(pcm, substream);
 	struct dma_chan *chan = pcm->chan[substream->stream];
 	struct snd_dmaengine_dai_dma_data *dma_data;
-	struct dma_slave_caps dma_caps;
 	struct snd_pcm_hardware hw;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	snd_pcm_format_t i;
 	int ret;
 
 	if (pcm->config && pcm->config->pcm_hardware)
@@ -145,56 +140,12 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		hw.info |= SNDRV_PCM_INFO_BATCH;
 
-	ret = dma_get_slave_caps(chan, &dma_caps);
-	if (ret == 0) {
-		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
-			hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
-		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
-			hw.info |= SNDRV_PCM_INFO_BATCH;
-
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
-		else
-			addr_widths = dma_caps.src_addr_widths;
-	}
-
-	/*
-	 * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
-	 * hw.formats set to 0, meaning no restrictions are in place.
-	 * In this case it's the responsibility of the DAI driver to
-	 * provide the supported format information.
-	 */
-	if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
-		/*
-		 * Prepare formats mask for valid/allowed sample types. If the
-		 * dma does not have support for the given physical word size,
-		 * it needs to be masked out so user space can not use the
-		 * format which produces corrupted audio.
-		 * In case the dma driver does not implement the slave_caps the
-		 * default assumption is that it supports 1, 2 and 4 bytes
-		 * widths.
-		 */
-		for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-			int bits = snd_pcm_format_physical_width(i);
-
-			/*
-			 * Enable only samples with DMA supported physical
-			 * widths
-			 */
-			switch (bits) {
-			case 8:
-			case 16:
-			case 24:
-			case 32:
-			case 64:
-				if (addr_widths & (1 << (bits / 8)))
-					hw.formats |= pcm_format_to_bits(i);
-				break;
-			default:
-				/* Unsupported types */
-				break;
-			}
-		}
+	ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
+							dma_data,
+							&hw,
+							chan);
+	if (ret)
+		return ret;
 
 	return snd_soc_set_runtime_hwparams(substream, &hw);
 }
-- 
2.20.1

