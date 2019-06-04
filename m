Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28999C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028D724B00
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559660357;
	bh=LH2EXWFP9bRtxm0ahdivG4wKLFjsAhI3LHhunp6mYHE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CeO2gJGQTohd64FsrXeSYu6HaHIyJnhvwIive1VPN97p0GiW2UGvxKew7scFL7ITw
	 r3dkSaZFcGmD9dhVb2XBsA+eHy1lZtb0DjdH1S7rngKuxBCAu3M7kdccEUZ0IAPfbP
	 aaN0Xcpz+pFTW747lSv1is0B2uQ73jvPdShz/bis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfFDO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:59:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48888 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfFDO7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Z6xN0yGWulWekvwXXiRFtdPpBCls+d5un3yiyvhzWJA=; b=X7BkEqWKl2vx
        eFmyzsSa+3DadoZ9AeZmxFZ05FVHdT+qL8M5kDSju8lXI3UFKy4JHg+lLuRoRdyEVDmkzf0ukwtFx
        iYlhRxTA7rRNXC3AWCSQR75rXxTBWXW7smwMat7oBzlxZB2UFlUmUtOOpXD+1g+rC2cJh0hKWHeYH
        5e/48=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAtv-0006ER-2y; Tue, 04 Jun 2019 14:58:59 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A0D11440049; Tue,  4 Jun 2019 15:58:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        perex@perex.cz, shunli.wang@mediatek.com, tiwai@suse.com
Subject: Applied "ASoC: da7219: Fix build error without CONFIG_I2C" to the asoc tree
In-Reply-To: <20190601085144.13832-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190604145858.A0D11440049@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:58:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: Fix build error without CONFIG_I2C

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

From cbc0fa7b6e8c6180c18fd951d28197281a526330 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 1 Jun 2019 16:51:44 +0800
Subject: [PATCH] ASoC: da7219: Fix build error without CONFIG_I2C

Fix gcc build error while CONFIG_I2C is not set

sound/soc/codecs/da7219.c:2640:1: warning: data definition has no type or storage class
 module_i2c_driver(da7219_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/da7219.c:2640:1: error: type defaults to int in declaration of module_i2c_driver [-Werror=implicit-int]
sound/soc/codecs/da7219.c:2640:1: warning: parameter names (without types) in function declaration
sound/soc/codecs/da7219.c:2629:26: warning: da7219_i2c_driver defined but not used [-Wunused-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 6d817c0e9fd7 ("ASoC: codecs: Add da7219 codec driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index f70b7109f2b6..59980df5add6 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -132,7 +132,7 @@ config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 
 config SND_SOC_MT8183_DA7219_MAX98357A
 	tristate "ASoC Audio driver for MT8183 with DA7219 MAX98357A codec"
-	depends on SND_SOC_MT8183
+	depends on SND_SOC_MT8183 && I2C
 	select SND_SOC_MT6358
 	select SND_SOC_MAX98357A
 	select SND_SOC_DA7219
-- 
2.20.1

