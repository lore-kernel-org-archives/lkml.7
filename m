Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31674C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072BF20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560785069;
	bh=i8m+DCcFUR2TjDgx5xkl44sKEckuD1JWT7TsbQpikuQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XZK89euO9PPfHZU7o0ZvidtTCPTOulV95PRdq1JiJUQxBSWwXhxO7KAUxdT6oh3bY
	 3wxj7oMB+TCF2cUDq3H9Rm7HM6pb7yygl5jcXeL6yZ5qHyM5y0nVcp6YErreqFmASd
	 rPHG5ITvx2WI9GCL8OJOqQ2J9f0TzPUd1BNiboXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfFQPY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:24:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbfFQPYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LWWfVkNgyVFokMWjFV/DxwVfUI19XJ2WqG9OcJTkUBs=; b=ItYKhsb5Aogt
        9gdYTdy8lzRNqkiEXjZEL6iD40+JhIOtnfTNDv98xHIsrOktrptesRbPBZfQ47Z8aTGA2X5lBZGQc
        NLAn9Wpk9Kf8yF0ehyHhy0r5QtJSXNNDS02SR3QQ5gPn4g4l0S+0D9UTpIPWD53BsnzratuYFAXfQ
        uv8ZI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctUW-0001wo-7Y; Mon, 17 Jun 2019 15:24:16 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B68AF440046; Mon, 17 Jun 2019 16:24:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     alsa-devel@alsa-project.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: ti: Fix SDMA users not providing channel names" to the asoc tree
In-Reply-To: <20190602145549.30899-1-jmkrzyszt@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190617152415.B68AF440046@finisterre.sirena.org.uk>
Date:   Mon, 17 Jun 2019 16:24:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: Fix SDMA users not providing channel names

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From 3e802e90ffcce333127d928eaefdfcc34af233e8 Mon Sep 17 00:00:00 2001
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date: Sun, 2 Jun 2019 16:55:49 +0200
Subject: [PATCH] ASoC: ti: Fix SDMA users not providing channel names

McBSP used to work correctly as long as compat DMA probing, removed by
commit 642aafea8889 ("ASoC: ti: remove compat dma probing"), was
available.  New method of DMA probing apparently requires users to
provide channel names when registering with SDMA, while McBSP passes
NULLs.  Fix it.

The same probably applies to McASP (not tested), hence the patch fixes
both.

Fixes: 642aafea8889 ("ASoC: ti: remove compat dma probing")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 2 +-
 sound/soc/ti/omap-mcbsp.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 9fbc759fdefe..f31805920e3e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2237,7 +2237,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		ret = edma_pcm_platform_register(&pdev->dev);
 		break;
 	case PCM_SDMA:
-		ret = sdma_pcm_platform_register(&pdev->dev, NULL, NULL);
+		ret = sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
 		break;
 	default:
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index a395598f1f20..610c5e706fd2 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -1438,7 +1438,7 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return sdma_pcm_platform_register(&pdev->dev, NULL, NULL);
+	return sdma_pcm_platform_register(&pdev->dev, "tx", "rx");
 }
 
 static int asoc_mcbsp_remove(struct platform_device *pdev)
-- 
2.20.1

