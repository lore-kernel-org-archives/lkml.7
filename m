Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0DB20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578822;
	bh=mWA7rUN9T2nlDpUtwH6+6IGF6uxA4by4cJwcRvvT8i0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gLoggTEibmpjLQzZe9ZHQIFulE1k07GG2Tks60Yeevrbk/mnNvY0GNwm4wS2HQf8R
	 8NzzO4tER0Pl+TbMHK+tADWHqRUkxQW2D5Nc3CifoHsTWYHHjP7M0HKapuh704FtUT
	 hLnVNqUCURHTCQRpOVRBc8OB+TjAU1Xh6GAfz/PI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCNPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:53:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfCNPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xxoBDDb+U0bogJTA9ja4zKPg2TPimc+rGT8YeYDcVlw=; b=AJ7ja+6y135p
        FHC6IRWT9ilsD4Ft9Eya8NOAIFqUZ6X7j34JRWcWX5JPhvWE8N3RW7EugQwgIKarLE03uAr9eOWc5
        MyOSpt4gY4ZhmhhK7kAGVmhx4O1QC2iMx70lq2Dik+CR3cjr8EqwkiHtEPs69uShZOpjR7cJXQL3v
        +eKMs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sfk-0002fk-Ne; Thu, 14 Mar 2019 15:53:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3913B1126E64; Thu, 14 Mar 2019 15:53:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ti: fix davinci_mcasp_probe dependencies" to the asoc tree
In-Reply-To:  <20190304203114.1894822-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190314155332.3913B1126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:53:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: fix davinci_mcasp_probe dependencies

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

From 7d7b25d05ef1c5a1a9320190e1eeb55534847558 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Mar 2019 21:30:50 +0100
Subject: [PATCH] ASoC: ti: fix davinci_mcasp_probe dependencies

The SND_SOC_DAVINCI_MCASP driver can use either edma or sdma as
a back-end, and it takes the presence of the respective dma engine
drivers in the configuration as an indication to which ones should be
built. However, this is flawed in multiple ways:

- With CONFIG_TI_EDMA=m and CONFIG_SND_SOC_DAVINCI_MCASP=y,
  is enabled as =m, and we get a link error:
  sound/soc/ti/davinci-mcasp.o: In function `davinci_mcasp_probe':
  davinci-mcasp.c:(.text+0x930): undefined reference to `edma_pcm_platform_register'

- When CONFIG_SND_SOC_DAVINCI_MCASP=m has already been selected by
  another driver, the same link error appears even if CONFIG_TI_EDMA
  is disabled

There are possibly other issues here, but it seems that the only reasonable
solution is to always build both SND_SOC_TI_EDMA_PCM and
SND_SOC_TI_SDMA_PCM as a dependency here. Both are fairly small and
do not have any other compile-time dependencies, so the cost is
very small, and makes the configuration stage much more consistent.

Fixes: f2055e145f29 ("ASoC: ti: Merge davinci and omap directories")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 4bf3c15d4e51..ee7c202c69b7 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -21,8 +21,8 @@ config SND_SOC_DAVINCI_ASP
 
 config SND_SOC_DAVINCI_MCASP
 	tristate "Multichannel Audio Serial Port (McASP) support"
-	select SND_SOC_TI_EDMA_PCM if TI_EDMA
-	select SND_SOC_TI_SDMA_PCM if DMA_OMAP
+	select SND_SOC_TI_EDMA_PCM
+	select SND_SOC_TI_SDMA_PCM
 	help
 	  Say Y or M here if you want to have support for McASP IP found in
 	  various Texas Instruments SoCs like:
-- 
2.20.1

