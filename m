Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8A0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1B920870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708595;
	bh=VKEjfmGF6Fcq8S49wkvaZU/RnyDT510McauoOdi1aPo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=S+WAJ9fQQZ9lvpi1CJKaQZZPT0UDZ6qXiURDl/kkPvufll6MA7z+DqUGI1yY4KU/J
	 5IlbKoJ/5fQ7+s/cBJfQ0KSnBnDMq/bR2MIecTiMzEmcYX8xByEP12wUsTwkpemj3n
	 VwJbUPZsGivjtBraqqZ0ks51DNKWBNLtnc7L7Ot4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfDHH3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:29:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Xsikzgq2bYyWz3Jsob3OBHkJg2bXcZpUpXeR7jtJeSg=; b=tDtHkokMfbgN
        mQwB+9RQOgD7yJdpR307a8i/0dOybuNa5ZuQkW14djJrGTcGIXzS/OblYVq1Y4qPG1D4Yzpxo9iOT
        KKUkIXJTngoGNpM6s2o36eg6m/VM3SNiuCYLOrd6K16Asl6tMpbm/DYLHfFAkn9YDsq5Kmz+OiwUV
        EMJXk=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOip-0003tW-Uu; Mon, 08 Apr 2019 07:29:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 952A1441D3B; Mon,  8 Apr 2019 14:29:29 +0700 (+07)
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
Subject: Applied "ASoC: fsl-dma: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-5-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072929.952A1441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:29:29 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl-dma: Switch to SPDX identifier

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

From e073564fe653eacbef6723a0a5210131b3998000 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:49:54 +0300
Subject: [PATCH] ASoC: fsl-dma: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_dma.c | 26 +++++++++++---------------
 sound/soc/fsl/fsl_dma.h |  5 +----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 78871de35086..e22508301412 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -1,18 +1,14 @@
-/*
- * Freescale DMA ALSA SoC PCM driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- * This driver implements ASoC support for the Elo DMA controller, which is
- * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
- * the PCM driver is what handles the DMA buffer.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale DMA ALSA SoC PCM driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
+//
+// This driver implements ASoC support for the Elo DMA controller, which is
+// the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
+// the PCM driver is what handles the DMA buffer.
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 78fee97e8036..f19ae765b656 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mpc8610-pcm.h - ALSA PCM interface for the Freescale MPC8610 SoC
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _MPC8610_PCM_H
-- 
2.20.1

