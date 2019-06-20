Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53D4C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996D82064A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561037559;
	bh=Nqv1X9Emwhlgoo2BKrg3tS7FQ6/0mNJFHavc5RE60ew=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dM/ybpTjPCATHWmEB6+/ZGgy8bfFs/mW+uQ0uU83AfrRW/D2SQ2OMok3gb+1T8fOy
	 UxXMJOBHNztZwGi5VoE443m1iXSmpC0u890u+HD1TNrn5O51Ad/CcLnNbL/vr5CNQ8
	 gfgcxi5qU1/FmdKRNjwMeKUtgtzj48wB0YT/AQew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfFTNci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:32:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59216 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbfFTNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Xmh5kmupsYkZefSvmh0+GLUxUu6Ox/qAde76AztFzu4=; b=Sekp60hrd2xU
        NaNS8uehgVfNNmU7fz0afMhE/ijpwcij5kGZqeYgJ8jKgq7tnqLmGhVpAUyVrTZiMCO24bpzmvdwI
        cw9IrkK86Vph290bcxyVQNkq1/3kTy+kHwglnRKCFsJ/ASBE4WFx/acJniTFIeGMi7iqLQdzvYmpI
        WOcOQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdxAw-0000jB-TU; Thu, 20 Jun 2019 13:32:27 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 587E544004B; Thu, 20 Jun 2019 14:32:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: dfsdm: add 16 bits audio record support" to the asoc tree
In-Reply-To: <1560944402-8115-1-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190620133226.587E544004B@finisterre.sirena.org.uk>
Date:   Thu, 20 Jun 2019 14:32:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: dfsdm: add 16 bits audio record support

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

From 1e7f6e1c69f0ff35c90878f9b44adcff77995eb9 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 19 Jun 2019 13:40:02 +0200
Subject: [PATCH] ASoC: stm32: dfsdm: add 16 bits audio record support

Add support of audio 16 bits format record to STM32
DFSDM driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 49 ++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index cc517e007039..3c9a9deec9af 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -45,7 +45,7 @@ struct stm32_adfsdm_priv {
 static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_PAUSE,
-	.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 
 	.rate_min = 8000,
 	.rate_max = 32000,
@@ -141,7 +141,8 @@ static const struct snd_soc_dai_driver stm32_adfsdm_dai = {
 	.capture = {
 		    .channels_min = 1,
 		    .channels_max = 1,
-		    .formats = SNDRV_PCM_FMTBIT_S32_LE,
+		    .formats = SNDRV_PCM_FMTBIT_S16_LE |
+			       SNDRV_PCM_FMTBIT_S32_LE,
 		    .rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 			      SNDRV_PCM_RATE_32000),
 		    },
@@ -152,30 +153,58 @@ static const struct snd_soc_component_driver stm32_adfsdm_dai_component = {
 	.name = "stm32_dfsdm_audio",
 };
 
+static void memcpy_32to16(void *dest, const void *src, size_t n)
+{
+	unsigned int i = 0;
+	u16 *d = (u16 *)dest, *s = (u16 *)src;
+
+	s++;
+	for (i = n; i > 0; i--) {
+		*d++ = *s++;
+		s++;
+	}
+}
+
 static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 {
 	struct stm32_adfsdm_priv *priv = private;
 	struct snd_soc_pcm_runtime *rtd = priv->substream->private_data;
 	u8 *pcm_buff = priv->pcm_buff;
 	u8 *src_buff = (u8 *)data;
-	unsigned int buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
-	unsigned int period_size = snd_pcm_lib_period_bytes(priv->substream);
 	unsigned int old_pos = priv->pos;
-	unsigned int cur_size = size;
+	size_t buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
+	size_t period_size = snd_pcm_lib_period_bytes(priv->substream);
+	size_t cur_size, src_size = size;
+	snd_pcm_format_t format = priv->substream->runtime->format;
+
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		src_size >>= 1;
+	cur_size = src_size;
 
 	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
-		__func__, &pcm_buff[priv->pos], priv->pos, size);
+		__func__, &pcm_buff[priv->pos], priv->pos, src_size);
 
-	if ((priv->pos + size) > buff_size) {
-		memcpy(&pcm_buff[priv->pos], src_buff, buff_size - priv->pos);
+	if ((priv->pos + src_size) > buff_size) {
+		if (format == SNDRV_PCM_FORMAT_S16_LE)
+			memcpy_32to16(&pcm_buff[priv->pos], src_buff,
+				      buff_size - priv->pos);
+		else
+			memcpy(&pcm_buff[priv->pos], src_buff,
+			       buff_size - priv->pos);
 		cur_size -= buff_size - priv->pos;
 		priv->pos = 0;
 	}
 
-	memcpy(&pcm_buff[priv->pos], &src_buff[size - cur_size], cur_size);
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		memcpy_32to16(&pcm_buff[priv->pos],
+			      &src_buff[src_size - cur_size], cur_size);
+	else
+		memcpy(&pcm_buff[priv->pos], &src_buff[src_size - cur_size],
+		       cur_size);
+
 	priv->pos = (priv->pos + cur_size) % buff_size;
 
-	if (cur_size != size || (old_pos && (old_pos % period_size < size)))
+	if (cur_size != src_size || (old_pos && (old_pos % period_size < size)))
 		snd_pcm_period_elapsed(priv->substream);
 
 	return 0;
-- 
2.20.1

