Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B93EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B20C21872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365818;
	bh=hE8gLv/nVMRsSoiQrMEs7sNNnq6JbwRQzI23o9k+ZBc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=tHf9+K+uOKlGtU3HEw654Qjguli/VAY9o+OV9TaKS7jfPrKlr/vw0vY3NraFzkOPI
	 FqtyvrmaIUfdITrYOGarKpHjjM58CI2Br/fO2C4Na4JRq12+fBxNVElIsCbh6C7brj
	 CtkqfG6prtxWS+budX7+tt3mNLna7U6FKKwRomG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDDIQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50638 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDDIQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mLKwJqcitI1+Bw2m8VEZVon+yftBzc7r6BAV80yQCwc=; b=eqnUq0ccdmhL
        Wh/zEpKY4/zWAGV9q5tHJqiiREJ52g7YjEksODtkXjWDfXYrk3N07a7dohXWx0InMOFflplGirx9j
        lf0tUDkbw5SLQbK06PUjt1pDfuS8viEMQna1AkV76AvKFxaTQPnene1jdknoO8+G09HQkB8epyNYy
        +MSCs=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxYB-00051k-RB; Thu, 04 Apr 2019 08:16:44 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D7D3E441D3C; Thu,  4 Apr 2019 15:16:40 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: pdm: add compatible for rk1808" to the asoc tree
In-Reply-To:  <1554350070-24078-1-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081640.D7D3E441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:40 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: pdm: add compatible for rk1808

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

From 717d97879b346d56fc47a6e3fe0ad44fea9949b2 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:54:30 +0800
Subject: [PATCH] ASoC: rockchip: pdm: add compatible for rk1808

This patch adds support for rk1808, the pdm controller
is the same as rk3308.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 4f93a7454e85..3e1c5fd5b32b 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -457,6 +457,8 @@ static const struct of_device_id rockchip_pdm_match[] = {
 	{ .compatible = "rockchip,pdm", },
 	{ .compatible = "rockchip,px30-pdm",
 	  .data = (void *)RK_PDM_RK3308 },
+	{ .compatible = "rockchip,rk1808-pdm",
+	  .data = (void *)RK_PDM_RK3308 },
 	{ .compatible = "rockchip,rk3308-pdm",
 	  .data = (void *)RK_PDM_RK3308 },
 	{},
-- 
2.20.1

