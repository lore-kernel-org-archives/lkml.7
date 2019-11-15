Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8EBC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B862073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820710;
	bh=3zZf4d/g+sEPBuTboee1XgQcGj37YtmYPhALHMGpUog=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0DrTVbm5aM+1kc/GSvUx6nDTLohx1hj4HhiqBf8ZW/i0oNtq7AksbYaWTNpokUgCD
	 +V14sRKtAkr+Qq7O+PhdbUd8GDhVI1WVqs1OB7AqHeaKpt0STqG17KMp16MIsZEJqB
	 RiaGcPUKyUx3SSCubqnQw/MMcrFrAOK79z8zaL6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKOMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:25:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60864 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfKOMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aRjpcEBmllVgUt/hu01jfE1yDUz542uVDl/im8vUdjE=; b=XOgNaKIVmk7O
        wYz4jH5igA/lhPtND/5YqPmmym6lF4hOEopuWsX+RImWjkmHvBsIC9Tmk/xDZiZDUYO7bgM4IItQT
        oPJpxipkm9EpkNoNedT4NVBzb4AP9Z9UvsQtT4PkHl30DnjLEjOrqzR1ipnVVhp3WZaE9CqmrtfHF
        kxIxI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaeq-0000Jf-Qi; Fri, 15 Nov 2019 12:25:00 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E398427415A7; Fri, 15 Nov 2019 12:24:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, jsarha@ti.com,
        lars@metafoo.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, vkoul@kernel.org
Subject: Applied "ASoC: ti: davinci-mcasp: Use dma_request_chan() directly for channel request" to the asoc tree
In-Reply-To: <20191113095445.3211-3-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122459.E398427415A7@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:24:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: davinci-mcasp: Use dma_request_chan() directly for channel request

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

From f0c97131b946fe77e22eddbd7e7d92fb6459f497 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 13 Nov 2019 11:54:45 +0200
Subject: [PATCH] ASoC: ti: davinci-mcasp: Use dma_request_chan() directly for
 channel request

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191113095445.3211-3-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 7aa3c32e4a49..8e5371801d88 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1867,7 +1867,7 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 		return PCM_EDMA;
 
 	tmp = mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data;
-	chan = dma_request_slave_channel_reason(mcasp->dev, tmp);
+	chan = dma_request_chan(mcasp->dev, tmp);
 	if (IS_ERR(chan)) {
 		if (PTR_ERR(chan) != -EPROBE_DEFER)
 			dev_err(mcasp->dev,
-- 
2.20.1

