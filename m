Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDE7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8E420835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519370;
	bh=eT2BeqDwjwcbTIAeRFJW2PL+VMX9Usc1fwI1EKkgGgY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BZJ2DyHJ0LoOulgxz+hQjRAG7E+xv7SED5eDNjLDmk4QLptcWC4nX7ln4AK/MzxV2
	 Wcsa/wNBz4BcT72fTgg3WyOLZA0I7oHaqzF2OFB66y96yL7nj1PT8L58dR+QECYmeU
	 5nkGty3OObKbDvaXehl6MndI2Tk59vtmHdQmk0uI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbfDQQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:42:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37436 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbfDQQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wc/2XhNh7xc0R3hPguRGY1tJ3GtPknUk344MjaY+PMA=; b=DEVqby/FfECd
        hvgw1pXg9kjZcbgTGAnGIFPdf7muZEsKeNRtHtEdoxlpeoMTv3RSnNgLzSh3Egf3yEC/KbjVI+16m
        cB/VGSxXequx7rvzmV5VOevLU7hnkoCghXPGHRTd6qyfKXUptNS4SRLoOjedGpBiu8GIKgiv2Kbw3
        WEhv0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGndW-00014u-7v; Wed, 17 Apr 2019 16:42:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C3B0C1128FC8; Wed, 17 Apr 2019 17:42:13 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, kaichieh.chuang@mediatek.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        matthias.bgg@gmail.com, perex@perex.cz, shunli.wang@mediatek.com,
        tiwai@suse.com
Subject: Applied "ASoC: Mediatek: MT8183: Fix build err while CONFIG_I2C set to module" to the asoc tree
In-Reply-To: <20190417152932.36436-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190417164213.C3B0C1128FC8@debutante.sirena.org.uk>
Date:   Wed, 17 Apr 2019 17:42:13 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Mediatek: MT8183: Fix build err while CONFIG_I2C set to module

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

From 04e7a02937527fd7edb1e493f04613f2340085dc Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 17 Apr 2019 23:29:32 +0800
Subject: [PATCH] ASoC: Mediatek: MT8183: Fix build err while CONFIG_I2C set to
 module

During randconfig builds, I occasionally run into an invalid configuration

WARNING: unmet direct dependencies detected for SND_SOC_TS3A227E
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=m]
  Selected by [y]:
  - SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_MT8183 [=y]

sound/soc/codecs/ts3a227e.o: In function `ts3a227e_i2c_probe':
ts3a227e.c:(.text+0x684): undefined reference to `__devm_regmap_init_i2c'
sound/soc/codecs/ts3a227e.o: In function `ts3a227e_driver_init':
ts3a227e.c:(.init.text+0x18): undefined reference to `i2c_register_driver'
sound/soc/codecs/ts3a227e.o: In function `ts3a227e_driver_exit':
ts3a227e.c:(.exit.text+0x14): undefined reference to `i2c_del_driver'

This patch add I2C dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ebbddc75bbe8 ("ASoC: Mediatek: MT8183: Add machine driver with DA7219")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 874404bcccfd..f70b7109f2b6 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -118,6 +118,7 @@ config SND_SOC_MT8183
 
 config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 	tristate "ASoC Audio driver for MT8183 with MT6358 TS3A227E MAX98357A codec"
+	depends on I2C
 	depends on SND_SOC_MT8183
 	select SND_SOC_MT6358
 	select SND_SOC_MAX98357A
-- 
2.20.1

