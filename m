Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E62C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A7220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfCDUcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:32:39 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:37819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCDUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:32:38 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MofLl-1hKKoo0TY9-00p0vk; Mon, 04 Mar 2019 21:31:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 2/3] ASoC: ti: remove compat dma probing
Date:   Mon,  4 Mar 2019 21:30:51 +0100
Message-Id: <20190304203114.1894822-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304203114.1894822-1-arnd@arndb.de>
References: <20190304203114.1894822-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:23zV7yiwQbGvoR6NSOw+FcqidDd3dA6fErRuKWTjmyD7MdmC+nw
 XwIU2b9OhxTFai7Wzym7Ww+fjFwr3EQzIMc7oDopmtD5TtPhxri+q3tZjaL7TadR2OXFOA3
 UpWqjGInXBBsWPR+vfFM5BmKUT1pCWCV3WetpsNNKM2Un2aojuWibWescy2dp5tfhvVLNJL
 bpkx+3U+AuU9p9/wZlt6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NWqV2wJR8PE=:0+AF6lWNa0GjvFa6H71OYu
 gtLjM0pjCayaUSg/tF7w3giEbH4JU/YfXsmEKoJA61xIT/qRCXA9jca7zuwRa/KIe1MOJczBQ
 Fm5xVUJblS9fCOKbyHqZPSUw0I0MvDF3MEN6fI6x85/aUVZ0csqZNJHvC1uCd133PF4w4P0i0
 M89LqJfULpebVOXTam7701GBYHxCVA0hGLqNFLRucWI2+uD+WJTDfyH7L2gwJffhed+7pnHVf
 dlNJajKHq1EKswxTUvij4uNWZqo4M92A9qOufmgX409PGszONYPEuMR1m2XfxWfNSZa+AbcX3
 ekumBnSMbSM7uhqZjeO8tSOo/UfGf2gqJizx6OGYOJQ2s+Zvm6I+yHuX+Wl7KbjrZcu7wWey6
 Gli7mM7GrKwokRs2Fu0jgnkbv9pqjfxfFsGUllRaHvKiStgWYzGwEl06KGLv72TMZ1h4k7JWM
 JSmyZSCpokIThna0VmV+J9fQAEiW9pcqfg8OIt4u6iiF23tUmpf0gti2wIliZapiva8tw4WNL
 zMH1QR46CtAv5o/pot7hK4ddJwc7ajjxgb8PeF/XlGb+YksT6upSogjixF9H/vXjekGpKHzDI
 7fveZBjSI1ZKzGnt+8WbuVHLVDg04YO5Plpbjc9a7ikNv1iGk5MBGZ6v5plCpXD4vIHqaRA5/
 nnNp0xo7zYYGjBya0VNuAIau7XthX7OmPxod2C2/7ipuJF3S3r3PjjBu7+n1nPkVgVmHgHsjs
 iH0mN0fyILGQtn0TbWOJQA8SHW4zWZYejb1I4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After running into a link error:

sound/soc/ti/edma-pcm.o:(.rodata+0x18): undefined reference to `edma_filter_fn'

I checked all users of this, and they have new-style 'dma_slave_map' tables,
so none of them should still need it. Removing the associated lines
simplifies the code and avoids the build-time dependency on the
respective dmaengine drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ti/edma-pcm.c | 4 +---
 sound/soc/ti/sdma-pcm.c | 8 +++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ti/edma-pcm.c b/sound/soc/ti/edma-pcm.c
index 59e588abe54b..5b9e341309f0 100644
--- a/sound/soc/ti/edma-pcm.c
+++ b/sound/soc/ti/edma-pcm.c
@@ -43,14 +43,12 @@ static const struct snd_pcm_hardware edma_pcm_hardware = {
 static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
 	.pcm_hardware = &edma_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = edma_filter_fn,
 	.prealloc_buffer_size = 128 * 1024,
 };
 
 int edma_pcm_platform_register(struct device *dev)
 {
-	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config,
-					SND_DMAENGINE_PCM_FLAG_COMPAT);
+	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config, 0);
 }
 EXPORT_SYMBOL_GPL(edma_pcm_platform_register);
 
diff --git a/sound/soc/ti/sdma-pcm.c b/sound/soc/ti/sdma-pcm.c
index 21a9c2499d48..3e83a3920dc7 100644
--- a/sound/soc/ti/sdma-pcm.c
+++ b/sound/soc/ti/sdma-pcm.c
@@ -31,7 +31,6 @@ static const struct snd_pcm_hardware sdma_pcm_hardware = {
 static const struct snd_dmaengine_pcm_config sdma_dmaengine_pcm_config = {
 	.pcm_hardware = &sdma_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = omap_dma_filter_fn,
 	.prealloc_buffer_size = 128 * 1024,
 };
 
@@ -39,13 +38,12 @@ int sdma_pcm_platform_register(struct device *dev,
 			       char *txdmachan, char *rxdmachan)
 {
 	struct snd_dmaengine_pcm_config *config;
-	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
+	unsigned int flags = 0;
 
 	/* Standard names for the directions: 'tx' and 'rx' */
 	if (!txdmachan && !rxdmachan)
 		return devm_snd_dmaengine_pcm_register(dev,
-						&sdma_dmaengine_pcm_config,
-						flags);
+						&sdma_dmaengine_pcm_config, 0);
 
 	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
 	if (!config)
@@ -65,7 +63,7 @@ int sdma_pcm_platform_register(struct device *dev,
 	config->chan_names[0] = txdmachan;
 	config->chan_names[1] = rxdmachan;
 
-	return devm_snd_dmaengine_pcm_register(dev, config, flags);
+	return devm_snd_dmaengine_pcm_register(dev, config, 0);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
 
-- 
2.20.0

