Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBEDC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BFE2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554432211;
	bh=Jl5lGVK+uhIYVz3U3YKckXQPBdIt32st9nF9gHFk/xQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hw5Lh3R+ZrlNZRtLw3Eb5UcQNeUE+/SZlxX2P18vbHCphuTDcY8cFTVb57c6VR84z
	 86PZX79aVOTFA37bWXyRZrZstvGiHv25+52LbVaX5blq3cDinR6Np568dJO36L/QoQ
	 oROtGQsw59N4eHPIf8HRW8gDBWsGg4rtQXZy4ltk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfDECna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:43:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbfDECn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lBopEilTxgctRW26nCeRGTnnGK0+xm9eI+n+7Fyp29I=; b=o6+/x9/upJSv
        tz/cykctgMh5eVb0lbUBucJA72fB9HgrKskJB4KvcIgKnj2vy+63DFXyfWc7ktvSZEYpPuXZ3KoCw
        E9SO8Cnqqm1NUirWJI42N5vHRUD/QTUEoRpl6M/PUhNsGJBwGRcplPNyfDAaSa8OMhj3liqo1Dwdx
        PqDqs=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCEp7-0005Eo-L8; Fri, 05 Apr 2019 02:43:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C6730441D3B; Fri,  5 Apr 2019 09:43:18 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: axg-fifo: add g12a support" to the asoc tree
In-Reply-To:  <20190404111733.28705-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405024318.C6730441D3B@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 09:43:18 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-fifo: add g12a support

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

From 7c02509a8a9981fb2c16b75904423e7ab2f9f43a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:17:29 +0200
Subject: [PATCH] ASoC: meson: axg-fifo: add g12a support

The g12a fifos gained the ability to set the initial address of the
pointer within the buffer, instead of defaulting to the buffer start
address.

It is not very useful to us (yet) but we need to put a copy the buffer
start address in the related register for the fifo to work properly on the
g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-fifo.c | 34 +++++++++++++++++++++++++++++++---
 sound/soc/meson/axg-fifo.h |  2 ++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 75e5e480fda2..01c1c7db2510 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -19,7 +19,7 @@
  * This file implements the platform operations common to the playback and
  * capture frontend DAI. The logic behind this two types of fifo is very
  * similar but some difference exist.
- * These differences the respective DAI drivers
+ * These differences are handled in the respective DAI drivers
  */
 
 static struct snd_pcm_hardware axg_fifo_hw = {
@@ -133,6 +133,23 @@ static int axg_fifo_pcm_hw_params(struct snd_pcm_substream *ss,
 	return 0;
 }
 
+static int g12a_fifo_pcm_hw_params(struct snd_pcm_substream *ss,
+				   struct snd_pcm_hw_params *params)
+{
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+	struct snd_pcm_runtime *runtime = ss->runtime;
+	int ret;
+
+	ret = axg_fifo_pcm_hw_params(ss, params);
+	if (ret)
+		return ret;
+
+	/* Set the initial memory address of the DMA */
+	regmap_write(fifo->map, FIFO_INIT_ADDR, runtime->dma_addr);
+
+	return 0;
+}
+
 static int axg_fifo_pcm_hw_free(struct snd_pcm_substream *ss)
 {
 	struct axg_fifo *fifo = axg_fifo_data(ss);
@@ -262,6 +279,17 @@ const struct snd_pcm_ops axg_fifo_pcm_ops = {
 };
 EXPORT_SYMBOL_GPL(axg_fifo_pcm_ops);
 
+const struct snd_pcm_ops g12a_fifo_pcm_ops = {
+	.open =		axg_fifo_pcm_open,
+	.close =        axg_fifo_pcm_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	g12a_fifo_pcm_hw_params,
+	.hw_free =      axg_fifo_pcm_hw_free,
+	.pointer =	axg_fifo_pcm_pointer,
+	.trigger =	axg_fifo_pcm_trigger,
+};
+EXPORT_SYMBOL_GPL(g12a_fifo_pcm_ops);
+
 int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type)
 {
 	struct snd_card *card = rtd->card->snd_card;
@@ -278,7 +306,7 @@ static const struct regmap_config axg_fifo_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= FIFO_STATUS2,
+	.max_register	= FIFO_INIT_ADDR,
 };
 
 int axg_fifo_probe(struct platform_device *pdev)
@@ -339,6 +367,6 @@ int axg_fifo_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(axg_fifo_probe);
 
-MODULE_DESCRIPTION("Amlogic AXG fifo driver");
+MODULE_DESCRIPTION("Amlogic AXG/G12A fifo driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index d9f516cfbeda..5caf81241dfe 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -60,6 +60,7 @@ struct snd_soc_pcm_runtime;
 #define FIFO_STATUS1			0x14
 #define  STATUS1_INT_STS(x)		((x) << 0)
 #define FIFO_STATUS2			0x18
+#define FIFO_INIT_ADDR			0x24
 
 struct axg_fifo {
 	struct regmap *map;
@@ -74,6 +75,7 @@ struct axg_fifo_match_data {
 };
 
 extern const struct snd_pcm_ops axg_fifo_pcm_ops;
+extern const struct snd_pcm_ops g12a_fifo_pcm_ops;
 
 int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type);
 int axg_fifo_probe(struct platform_device *pdev);
-- 
2.20.1

