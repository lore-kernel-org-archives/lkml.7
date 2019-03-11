Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8868C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B922063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325032;
	bh=iKPbDtV2ehekjU9FuKSCg2EQ6eqNnVdLo/DiPYX5xOU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QxwUSuDc/i7TGVAxZHssdjKUR7lDRMEppfdP8mS9fD4DE6lqHf+SXllZX29/ubESY
	 Xr0p/thTA39S7mcEe5N4GlCJj66dKrBoxewoIjpBhBtSJB97yTv1z5Rx8/m3SD0r8I
	 Y8h8hYY6ZfX4ywChgObVePqjA75EKytAVcQq1nyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfCKRXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:23:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50096 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Lnj13rR0ecnnQ8FeiqxHVUJkOqCrxg3GN407eFSZnH4=; b=qC9uv5AqsMKf
        QPy995zpFNj58mxXls8/KnsF/qqE0zRET+X1B1EGTneQGwcTWq6ob+0nCvDBaDjqCN3j8CKQkXfSI
        wa4rsXIub8EqUaW2POjcKbcnV4vCGbGt5v0oLBaFjGsQVLuTEaL9/aoD57cMIjz2CFdz0u6n9vbyB
        An26E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3OeM-0005MF-OC; Mon, 11 Mar 2019 17:23:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 47D561128896; Mon, 11 Mar 2019 17:23:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ti: remove compat dma probing" to the asoc tree
In-Reply-To:  <20190307151646.1016966-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190311172342.47D561128896@debutante.sirena.org.uk>
Date:   Mon, 11 Mar 2019 17:23:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: remove compat dma probing

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

From 642aafea8889b712fe8e57aaa706d6c05d295059 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Mar 2019 16:16:08 +0100
Subject: [PATCH] ASoC: ti: remove compat dma probing

After running into a link error:

sound/soc/ti/edma-pcm.o:(.rodata+0x18): undefined reference to `edma_filter_fn'

I checked all users of this, and they have new-style 'dma_slave_map' tables,
so none of them should still need it. Removing the associated lines
simplifies the code and avoids the build-time dependency on the
respective dmaengine drivers.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/edma-pcm.c | 5 +----
 sound/soc/ti/sdma-pcm.c | 9 +++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/ti/edma-pcm.c b/sound/soc/ti/edma-pcm.c
index 59e588abe54b..fdffb801b185 100644
--- a/sound/soc/ti/edma-pcm.c
+++ b/sound/soc/ti/edma-pcm.c
@@ -23,7 +23,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <linux/edma.h>
 
 #include "edma-pcm.h"
 
@@ -43,14 +42,12 @@ static const struct snd_pcm_hardware edma_pcm_hardware = {
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
index 21a9c2499d48..a236350beb10 100644
--- a/sound/soc/ti/sdma-pcm.c
+++ b/sound/soc/ti/sdma-pcm.c
@@ -11,7 +11,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
-#include <linux/omap-dmaengine.h>
 
 #include "sdma-pcm.h"
 
@@ -31,7 +30,6 @@ static const struct snd_pcm_hardware sdma_pcm_hardware = {
 static const struct snd_dmaengine_pcm_config sdma_dmaengine_pcm_config = {
 	.pcm_hardware = &sdma_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = omap_dma_filter_fn,
 	.prealloc_buffer_size = 128 * 1024,
 };
 
@@ -39,13 +37,12 @@ int sdma_pcm_platform_register(struct device *dev,
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
@@ -65,7 +62,7 @@ int sdma_pcm_platform_register(struct device *dev,
 	config->chan_names[0] = txdmachan;
 	config->chan_names[1] = rxdmachan;
 
-	return devm_snd_dmaengine_pcm_register(dev, config, flags);
+	return devm_snd_dmaengine_pcm_register(dev, config, 0);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
 
-- 
2.20.1

