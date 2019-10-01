Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B123AECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F765222C7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930068;
	bh=KpTC1ixdLBiJqz5fvsnf8pCm5e1oKxW152A2QXmtozY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oNRpc9V8kJt8WCIpNe/Jv7Cqtj4ygiz4/mIkdDy4/oLoEOf66GF1s+SZj8lmYP0EY
	 /rtHc0LDLPnla3q6SgdkNVW68q4tNDH9zFI+a0ZbL0AmneXoPALrzVGmusavanmqRZ
	 Maipj6Sb04lcjv+p6XgCAFIoATz+mg0Z9rgUv64w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfJALlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:41:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfJALlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=J7yyok7EgwSLFPHzLp/yUCoO3tHmw6Vh5y9GcDVlxFk=; b=FVkhLUQVyayW
        Kkzu0jN74+INu8rGDPFImqpfPBxjiEtFXRy3dL/VZp7SWaFbIqdRNhKKK10+ivcLX6pqBRVngW/Uo
        vn0+IO1HnPdIzGNU5Tr8UivXQBicSbAD6ctllvMZE1XLYzVXHzLpW1rc3NSx3UuCbVGkIgRZzGv7G
        Q1o8o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWL-0004SR-Ty; Tue, 01 Oct 2019 11:40:46 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5F1C72742A30; Tue,  1 Oct 2019 12:40:45 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, nicoleotsuka@gmail.com,
        Nicolin Chen <nicoleotsuka@gmail.com>, perex@perex.cz,
        robh+dt@kernel.org, timur@kernel.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_asrc: Fix error with S24_3LE format bitstream in i.MX8" to the asoc tree
In-Reply-To: <b6a4de2bbf960ef291ee902afe4388bd0fc1d347.1569493933.git.shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114045.5F1C72742A30@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_asrc: Fix error with S24_3LE format bitstream in i.MX8

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

From 703df4413ff6cf1812922522daa7c0610f087910 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 27 Sep 2019 09:46:12 +0800
Subject: [PATCH] ASoC: fsl_asrc: Fix error with S24_3LE format bitstream in
 i.MX8

There is error "aplay: pcm_write:2023: write error: Input/output error"
on i.MX8QM/i.MX8QXP platform for S24_3LE format.

In i.MX8QM/i.MX8QXP, the DMA is EDMA, which don't support 24bit
sample, but we didn't add any constraint, that cause issues.

So we need to query the caps of dma, then update the hw parameters
according to the caps.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/b6a4de2bbf960ef291ee902afe4388bd0fc1d347.1569493933.git.shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c     |  4 +--
 sound/soc/fsl/fsl_asrc.h     |  3 ++
 sound/soc/fsl/fsl_asrc_dma.c | 64 ++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 584badf956d2..0bf91a6f54b9 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -115,7 +115,7 @@ static void fsl_asrc_sel_proc(int inrate, int outrate,
  * within range [ANCA, ANCA+ANCB-1], depends on the channels of pair A
  * while pair A and pair C are comparatively independent.
  */
-static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
+int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 {
 	enum asrc_pair_index index = ASRC_INVALID_PAIR;
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
@@ -158,7 +158,7 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
  *
  * It clears the resource from asrc_priv and releases the occupied channels.
  */
-static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
+void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
 {
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
 	enum asrc_pair_index index = pair->index;
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 38af485bdd22..2b57e8c53728 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -462,4 +462,7 @@ struct fsl_asrc {
 #define DRV_NAME "fsl-asrc-dai"
 extern struct snd_soc_component_driver fsl_asrc_component;
 struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir);
+int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair);
+void fsl_asrc_release_pair(struct fsl_asrc_pair *pair);
+
 #endif /* _FSL_ASRC_H */
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 01052a0808b0..2a60fc6142b1 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -16,13 +16,11 @@
 
 #define FSL_ASRC_DMABUF_SIZE	(256 * 1024)
 
-static const struct snd_pcm_hardware snd_imx_hardware = {
+static struct snd_pcm_hardware snd_imx_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP |
-		SNDRV_PCM_INFO_MMAP_VALID |
-		SNDRV_PCM_INFO_PAUSE |
-		SNDRV_PCM_INFO_RESUME,
+		SNDRV_PCM_INFO_MMAP_VALID,
 	.buffer_bytes_max = FSL_ASRC_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 65535, /* Limited by SDMA engine */
@@ -270,12 +268,25 @@ static int fsl_asrc_dma_hw_free(struct snd_pcm_substream *substream)
 
 static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
 {
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct device *dev = component->dev;
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
 	struct fsl_asrc_pair *pair;
+	struct dma_chan *tmp_chan = NULL;
+	u8 dir = tx ? OUT : IN;
+	bool release_pair = true;
+	int ret = 0;
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(dev, "failed to set pcm hw params periods\n");
+		return ret;
+	}
 
 	pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
 	if (!pair)
@@ -285,11 +296,50 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
 
 	runtime->private_data = pair;
 
-	snd_pcm_hw_constraint_integer(substream->runtime,
-				      SNDRV_PCM_HW_PARAM_PERIODS);
+	/* Request a dummy pair, which will be released later.
+	 * Request pair function needs channel num as input, for this
+	 * dummy pair, we just request "1" channel temporarily.
+	 */
+	ret = fsl_asrc_request_pair(1, pair);
+	if (ret < 0) {
+		dev_err(dev, "failed to request asrc pair\n");
+		goto req_pair_err;
+	}
+
+	/* Request a dummy dma channel, which will be released later. */
+	tmp_chan = fsl_asrc_get_dma_channel(pair, dir);
+	if (!tmp_chan) {
+		dev_err(dev, "failed to get dma channel\n");
+		ret = -EINVAL;
+		goto dma_chan_err;
+	}
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	/* Refine the snd_imx_hardware according to caps of DMA. */
+	ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
+							dma_data,
+							&snd_imx_hardware,
+							tmp_chan);
+	if (ret < 0) {
+		dev_err(dev, "failed to refine runtime hwparams\n");
+		goto out;
+	}
+
+	release_pair = false;
 	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
 
-	return 0;
+out:
+	dma_release_channel(tmp_chan);
+
+dma_chan_err:
+	fsl_asrc_release_pair(pair);
+
+req_pair_err:
+	if (release_pair)
+		kfree(pair);
+
+	return ret;
 }
 
 static int fsl_asrc_dma_shutdown(struct snd_pcm_substream *substream)
-- 
2.20.1

