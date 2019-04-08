Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF83C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E7721906
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708606;
	bh=M10yyQ/MlUHky6OQTtkITX+PonSAdQKww30nsJdK7s0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ACE9MsNxsM0OWZfjpzUwZFiZxw0Cre2l7a7Aen5tnp98HC9rHt53dey9FbcB0gEs6
	 jOznajE00lMzqteXPxAXvzi2sv7Hh0odIhJ0pUPDRPspiIHP1CBH6jLoW+LOa3yPvp
	 S8P6S47taqqObz1iXjulOUb9Fd8WRN+xY5oKzRaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDHHaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:30:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40276 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mct+e0HiaPQS+MrRvE7XzXrHGFRBrnGgY2EsefpFgmQ=; b=jeF3xs9FdIcM
        0GH6PCV3Zfn5utQTISmp4MtLA691YmOreLGBHSs/dIEE7PUjI161n44mxUkWDhO4qxHfoL54njDOb
        vDzizOa60R5/jeYAC4xlPmHZJXWlrXAe71VcATCH0tcQvG10RqbcXkACMNWBWxTp44GlcMa9sqiUt
        fRjgM=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOiz-0003tr-Jb; Mon, 08 Apr 2019 07:29:50 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 725D5441D3C; Mon,  8 Apr 2019 14:29:39 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: eukrea-tlv320: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-4-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072939.725D5441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:29:39 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: eukrea-tlv320: Switch to SPDX identifier

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

From ecf4630f1b9857141e38ea798bc30b8fd7c11dfc Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:49:53 +0300
Subject: [PATCH] ASoC: eukrea-tlv320: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/eukrea-tlv320.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 30a3d68b5c03..d648268cb454 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -1,19 +1,13 @@
-/*
- * eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
- *
- * Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
- *
- * based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
- * which is Copyright 2009 Simtec Electronics
- * and on sound/soc/imx/phycore-ac97.c which is
- * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
+//
+// Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
+//
+// based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+// which is Copyright 2009 Simtec Electronics
+// and on sound/soc/imx/phycore-ac97.c which is
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/errno.h>
 #include <linux/module.h>
-- 
2.20.1

