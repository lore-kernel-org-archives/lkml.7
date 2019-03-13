Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82D6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DBD206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491546;
	bh=wPtCKCMhCQ/Eyhh/9zkkUwa2ahTKJz+xvyI0JuaeucQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FU23ojM+2w2hrSHzpa9GuICq55f9GpGnQn47UpKjV410cOiUg3Tra5D9zHLzROvMe
	 DZaSvtp5yysaTCeSu/h4FrdShv2O/tD16gHR91KItIfArtLJTbdgQO1SIS4BM7ogrP
	 ZTZzpRU01LB2x9fMXDxvZ1haAXEe+7irNWyu7ed0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfCMPjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49616 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCMPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IyZ1aIEkaAhiOlWzkTbi3AeQ3U09TOy2g7vmarIUVNM=; b=ov1uhR2YZHBh
        8Z3t+sVIeJNF+ZlLvM+fRxNeGzBzK2jkMhb1t4zhDp4OVWL5bZSKCR8SJZeVE0glRZOtKZSoCgk3E
        kL7iSyA2i1Vianys+yVEnWdAVMm79KVIF3OS+gJKmm5b0sAfq3LIbcqo40Ychw5U9//DTQbW3l5pM
        AOteU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45y1-0003RE-BW; Wed, 13 Mar 2019 15:38:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DF31C1128B97; Wed, 13 Mar 2019 15:38:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: add i2c dependency for SND_SOC_SDM845" to the asoc tree
In-Reply-To:  <20190304203114.1894822-3-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190313153852.DF31C1128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:38:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: add i2c dependency for SND_SOC_SDM845

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

From 686174a0989b1c33698b26523a1e4ccdcc84cf22 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Mar 2019 21:30:52 +0100
Subject: [PATCH] ASoC: qcom: add i2c dependency for SND_SOC_SDM845

We must not select SND_SOC_MAX98927 unless CONFIG_I2C
is also enabled:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98927
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
  Selected by [y]:
  - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y] && MFD_CROS_EC [=y]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 75ceb04d8bf0..b1764af858ba 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && MFD_CROS_EC
+	depends on QCOM_APR && MFD_CROS_EC && I2C
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.20.1

