Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC0ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E0420673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571054716;
	bh=/sIj46+9bgVa+vYAWnKUmVGGLWi8i3xpHBLJJTsNvIM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=swwFK+xv3Ghl+IktuwIZ8mQOCNhqDDN1rR3umqoC50xZ4UvZG3rq+lxhGVAONT4ey
	 ELMZFwE+SpaLe5bwrzq2h5uCAtg5LPiytNVvJIDiDUg+W6O0fc8D+ATWZI0Xo3t3pi
	 hsuL66+imqr6v72bJBp7oCjcZcnQq+CtLmsQ/Ozk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfJNMFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:05:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfJNMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HTqny5PVHvnmykrT7/i1QnwbFEAoZl4BaIh7+Q4ZBD8=; b=ZkvZ04JyHUqK
        EKhKl9qgVeJw+aFrjyJIXS7+NcnGa5tQma35pvSFybaP2Kua7HqT/YESsko4VZlh983J/GaiDxM/o
        BK/JqULa93WSTPO2lLgkrwv9FGxqdVQ7840MOw8WdgGlK4bgQPdRmuVY9say3n4huwkdDYLkQ5Q2q
        qZpm4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iJz5u-0007WR-MS; Mon, 14 Oct 2019 12:04:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 236F02741EF2; Mon, 14 Oct 2019 13:04:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        ckeepax@opensource.cirrus.com, enric.balletbo@collabora.com,
        Hulk Robot <hulkci@huawei.com>, krzk@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        npoushin@opensource.cirrus.com, nuno.sa@analog.com,
        paul@crapouillou.net, perex@perex.cz, piotrs@opensource.cirrus.com,
        rf@opensource.wolfsonmicro.com, tiwai@suse.com
Subject: Applied "ASoC: adau7118: Fix Kconfig warning without CONFIG_I2C" to the asoc tree
In-Reply-To: <20191011150042.20096-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191014120458.236F02741EF2@ypsilon.sirena.org.uk>
Date:   Mon, 14 Oct 2019 13:04:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: adau7118: Fix Kconfig warning without CONFIG_I2C

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

From de729862cc0f0b46dd3a3c11079240ea4e13b97d Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 11 Oct 2019 23:00:42 +0800
Subject: [PATCH] ASoC: adau7118: Fix Kconfig warning without CONFIG_I2C

When building a kernel without CONFIG_I2C, Kconfig warns:

WARNING: unmet direct dependencies detected for REGMAP_I2C
  Depends on [n]: I2C [=n]
  Selected by [y]:
  - SND_SOC_ADAU7118_I2C [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y]

Add missing I2C dependency to SND_SOC_ADAU7118_I2C to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ca514c0f12b0 ("ASOC: Add ADAU7118 8 Channel PDM-to-I2S/TDM Converter driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191011150042.20096-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f4747ebc251e..5a706102db04 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -416,6 +416,7 @@ config SND_SOC_ADAU7118_HW
 
 config SND_SOC_ADAU7118_I2C
 	tristate "Analog Devices ADAU7118 8 Channel PDM-to-I2S/TDM Converter - I2C"
+	depends on I2C
 	select SND_SOC_ADAU7118
 	select REGMAP_I2C
 	help
-- 
2.20.1

