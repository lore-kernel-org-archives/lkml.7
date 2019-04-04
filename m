Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9729AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6835D2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365830;
	bh=33okhUCKPwBfTCcUXMy62hCbG6p+BCweEYWB1s0ZoOw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YHXjM0viinby7Mi5HizpnX0mpTSDs2Xal6WLPnuT7GU6Dnb01jPy5ABr5BkwPHHHF
	 VrFnJE2KlQ7YyzT0M1HkAtOHxPpAv7FA7z4suTuKdEL0d1onyw9r7fRHBwiVvSkcp1
	 91MRgVWzk7ND7MRY7mu9q8DGYkr23xWyWxQWomBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfDDIRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:17:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfDDIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=y07oRNI29gzFVOrU96FFCl/Ash0/icVsvDce4ew2BAA=; b=EvcWsssQiA/c
        7RY6+FXB04MEChrPW9zZ/PjS60nRrzyVXfzVP1QeKUyCm9xNRmbBCo/cfhwzsd6HUOhP5I/BLoe6s
        /YUK5F1bo2fJLCGy4YvR6laeS6TI2zv5m+0Eug5Cgawb3DH9A86N/NwKs6QCPPnlb/NMU7pg+oOj3
        K09DQ=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxYL-00052K-Hx; Thu, 04 Apr 2019 08:16:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7748C441D3D; Thu,  4 Apr 2019 15:16:50 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: pdm: optimize clear logic" to the asoc tree
In-Reply-To:  <1554298856-59028-5-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081650.7748C441D3D@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:50 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: pdm: optimize clear logic

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

From 252163a66a06859f468ef1e00fa5a1f377b16eed Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Wed, 3 Apr 2019 21:40:48 +0800
Subject: [PATCH] ASoC: rockchip: pdm: optimize clear logic

There is no need to reset controller every time, do this
once in pdm_probe.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 984d99889a65..eb5216dd7dbc 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -183,9 +183,6 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 				   val);
 		regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
 				   PDM_DMA_RDL(16));
-		regmap_update_bits(pdm->regmap, PDM_SYSCONFIG,
-				   PDM_RX_MASK | PDM_RX_CLR_MASK,
-				   PDM_RX_STOP | PDM_RX_CLR_WR);
 	}
 
 	return 0;
@@ -353,6 +350,7 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case PDM_SYSCONFIG:
+	case PDM_FIFO_CTRL:
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
 		return true;
@@ -436,6 +434,7 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
+	rockchip_pdm_rxctrl(pdm, 0);
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register pcm: %d\n", ret);
-- 
2.20.1

