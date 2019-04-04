Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E46E21872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365843;
	bh=ZZ+R/IdidXtLCO6b4UP06OEx8Mq+s2tBAQ5mAfMGzmQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vYn5OImLDnrAPzUob678vW+vjP0a1y1+OHsiSXsdMMppjPPLYHDsPLTRGUfmua+NP
	 R7+JdyY+lcg2juC0qD0/N2ys5ySHcJ2HGvUOwlysr0/SJDq9TTXzjulwLtRrYfPwZc
	 uvg6u6Sp/GxW59uA8ihc+oFiifC/+OZaLj+hL9eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfDDIRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:17:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51120 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfDDIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RO826z7CyLwHLF+l+ODfeJpT3/lgg6wKE+zUFM2nmR0=; b=ZtLt7OP+JDqg
        j5TGltHzgmNyAmQ327eqY5Y94laPm4DHaQ3c1adUW7n0YhOj+eumWoQ+BJZUhHszdvkfczvgvY8h1
        oSDsuvYzR3SCJkd4xewlNQ+d78BPzANShDQZ1XLn8lrzrjvo5ZiQk5WGWEd9RwTb3ZwIlB7qzkDs9
        GwxZE=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxYV-00052t-7P; Thu, 04 Apr 2019 08:17:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 07830441D3C; Thu,  4 Apr 2019 15:17:00 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: pdm: change dma burst to 8" to the asoc tree
In-Reply-To:  <1554349691-23450-1-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081700.07830441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:59 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: pdm: change dma burst to 8

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

From 86a7b6ffd90095d81d9fa0d8b48955b7c83b2e2f Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:48:11 +0800
Subject: [PATCH] ASoC: rockchip: pdm: change dma burst to 8

This patch decreases the transfer bursts to avoid the fifo overrun.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 8a2e3bbce3a1..d0b403a0e27b 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -24,7 +24,7 @@
 
 #include "rockchip_pdm.h"
 
-#define PDM_DMA_BURST_SIZE	(16) /* size * width: 16*4 = 64 bytes */
+#define PDM_DMA_BURST_SIZE	(8) /* size * width: 8*4 = 32 bytes */
 
 struct rk_pdm_dev {
 	struct device *dev;
-- 
2.20.1

