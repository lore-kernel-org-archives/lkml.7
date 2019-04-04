Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74537C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3136120882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365795;
	bh=592vIzJAtq6l2KTuKeOq2uzzslF3XXdwsX8V2bh6d1U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LfhbQw1qGTZQ836jFm3lTmZ0uAwIcBy0GbLWc3k4guKYPA28Rs5Iz1dpICD/kxCp/
	 fVdwIciY6um2O2apru4ET4ePwz4yJuFcJFqUEBTDPktK6ypsxxjCi4KM8+Pjf3g4Br
	 Q+zZTc1nHpbw2ySQ91+QH6MjWvPRWAtwlC3X3m3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfDDIQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49924 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDIQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Yspq768DlQfVYwj04VKUX+8/YMnbCfpjvYSLs4e4syc=; b=QLhYaJ2jTvaf
        F9GyNe90Po5Bins1Soo6G3efKWPX0rVXS+1Pkf0i0+reomul27e77qHlvZnF9pYdY254I3ibLsxvJ
        PiWmR26/DhRVfJGoLPxxityVAOuP7JkS60x2dL082S5MLYocQUjpbZiS1Iatmk0NF+cFbgScK4Cs0
        aJclo=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxXq-000516-Sp; Thu, 04 Apr 2019 08:16:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 75DA7441D3C; Thu,  4 Apr 2019 15:16:19 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and precious" to the asoc tree
In-Reply-To:  <1554350228-24440-1-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081619.75DA7441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:19 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and precious

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

From b126fc07328749269021ac53173f9afdd6947248 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:57:08 +0800
Subject: [PATCH] ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and
 precious

This patch marks RXFIFO_DATA as precious to avoid being read
outside a call from the driver, such as regmap debugfs

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 068453596470..6c0f242db5ef 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -417,6 +417,7 @@ static bool rockchip_pdm_rd_reg(struct device *dev, unsigned int reg)
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
 	case PDM_DATA_VALID:
+	case PDM_RXFIFO_DATA:
 	case PDM_VERSION:
 		return true;
 	default:
@@ -431,6 +432,17 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 	case PDM_FIFO_CTRL:
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
+	case PDM_RXFIFO_DATA:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rockchip_pdm_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case PDM_RXFIFO_DATA:
 		return true;
 	default:
 		return false;
@@ -453,6 +465,7 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 	.writeable_reg = rockchip_pdm_wr_reg,
 	.readable_reg = rockchip_pdm_rd_reg,
 	.volatile_reg = rockchip_pdm_volatile_reg,
+	.precious_reg = rockchip_pdm_precious_reg,
 	.cache_type = REGCACHE_FLAT,
 };
 
-- 
2.20.1

