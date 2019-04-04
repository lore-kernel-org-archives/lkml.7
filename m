Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FACEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F48B20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365814;
	bh=1uG7AoEMKoxVL/nCLuM1DyGV7OOGq66PQPO0eCUhIis=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=L3moHCvEwEkHMoM+LZwkAucId6b6nU5+F325b3upaF34R209gZl2AFw0vi8GUOAVp
	 CCU2e7lyW1BNS0Odbt/evFmrdhFKZvJtEamEPQj4MQ5l1/NSMei34W+HaLZC5KybHy
	 giTLvsMO65ud4ZKOAILJtOiWJg2+b6UQQWIRFjbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDDIQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50434 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDDIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PrnYjYHuYvUZMhArmhzlQALpatUZSD7hDW/5dPA6pt8=; b=l3oIR/0FWhjn
        j4u3CIAfLCkFcd++CwEoMR6ndBN7aXm5mslKjiaB1Jrk+H0VVr08qwTGrK1tz8dxW8gCU7INWJKjb
        1iCqEkcPc3b8MZ4sqNNQe048m0hxqpm4FDjTz20NWy7AqLxJpznxRI4tQqqkb6i9Qb14b9W4fCl1f
        sRnG8=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxY5-00051N-8x; Thu, 04 Apr 2019 08:16:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 31E08441D3C; Thu,  4 Apr 2019 15:16:34 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: pdm: adjust waterlevel in frame unit" to the asoc tree
In-Reply-To:  <1554350189-24318-1-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081634.31E08441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:34 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: pdm: adjust waterlevel in frame unit

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

From 430f5da69b9323d5e7faca95bc30e61be4fcbbbf Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:56:29 +0800
Subject: [PATCH] ASoC: rockchip: pdm: adjust waterlevel in frame unit

This patch make the waterlevel more reasonable, because the pdm
controller share the single FIFO(128 entries) with each channel.
adjust waterlevel in frame to meet the vad or dma frames request.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 3e1c5fd5b32b..955cdc2b8fc5 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -255,8 +255,9 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(pdm->regmap, PDM_CTRL0,
 			   PDM_PATH_MSK | PDM_VDW_MSK,
 			   val);
+	/* all channels share the single FIFO */
 	regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
-			   PDM_DMA_RDL(16));
+			   PDM_DMA_RDL(8 * params_channels(params)));
 
 	return 0;
 }
-- 
2.20.1

