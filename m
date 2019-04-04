Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E0DC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3566B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365879;
	bh=kze1nExJoV3YAptLwV5kmAKaYL6XXYl9R40oJTP69NM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MwVkPdGkWqHxSc4i7XTG09H3chkNrQnENi6PITjaW1lC7lx+Ilw5g4LnA3p2712X6
	 tigdEQKNrSZiud0UVosY1zCtSYP0Y12s0kk8u1nP1iIHxIeJvnHMFkiga1O686Wwis
	 FB7vVU3tEEuR9zswG5Y2DdkPM7oBiJnSqlQsjYEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfDDIR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:17:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50368 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfDDIQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9qag3E4fzRzs4zLG5cQVCbgfBLqlEfYL53CaSB42yu4=; b=UabTWDj/CH9v
        6NfjL4KrDtSZ8p+Rjx6rto+gp8bVlgQPO1GJF5nTvBr6OFJS006DAC5At3oBAKTg/cdJCZi+W78T1
        PxWXgad/NlBgdEOvXnRJlM8/LTDB2brSfrG3ZaOPlm+hJo1Gyy8sPE4Os7Y1zOZxndIUd1urAqWO+
        PHY6Y=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxY1-00051J-Vx; Thu, 04 Apr 2019 08:16:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 23BC1441D3D; Thu,  4 Apr 2019 15:16:31 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: pdm: Correct PDM_CTRL0 reg value" to the asoc tree
In-Reply-To:  <1554350277-24561-1-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081631.23BC1441D3D@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:31 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: pdm: Correct PDM_CTRL0 reg value

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

From 54cd97cfe02e9bb93db53e7cbfa9b672bf4a5ac8 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:57:57 +0800
Subject: [PATCH] ASoC: rockchip: pdm: Correct PDM_CTRL0 reg value

This patch fix the wrong reg value for rk322x/rk322xh,
cuz there is no STORE JUSTIFIED MODE on it.

on rk322x/rk322xh, the same bit means PDM_MODE/RESERVED,
if the bit is set to RESERVED, the controller will not work.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 955cdc2b8fc5..068453596470 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -210,7 +210,9 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
 			   PDM_HPF_LE | PDM_HPF_RE, PDM_HPF_LE | PDM_HPF_RE);
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_CLK_EN, PDM_CLK_EN);
-	regmap_update_bits(pdm->regmap, PDM_CTRL0, PDM_MODE_MSK, PDM_MODE_LJ);
+	if (pdm->version != RK_PDM_RK3229)
+		regmap_update_bits(pdm->regmap, PDM_CTRL0,
+				   PDM_MODE_MSK, PDM_MODE_LJ);
 
 	val = 0;
 	switch (params_format(params)) {
@@ -455,7 +457,8 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 };
 
 static const struct of_device_id rockchip_pdm_match[] = {
-	{ .compatible = "rockchip,pdm", },
+	{ .compatible = "rockchip,pdm",
+	  .data = (void *)RK_PDM_RK3229 },
 	{ .compatible = "rockchip,px30-pdm",
 	  .data = (void *)RK_PDM_RK3308 },
 	{ .compatible = "rockchip,rk1808-pdm",
-- 
2.20.1

