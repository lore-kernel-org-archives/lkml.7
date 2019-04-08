Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7343C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9086B208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708371;
	bh=tUeHvaz1mtziC/gvA8V3XQdO9029ZziTsD1/FzNEkNo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HoL/g4my5d9RzHE82GLIEvHPHhzoc/lWUErVzkUupoWmlGIe4PK+ZCi6PeHStNnua
	 GVC7ycT1eT1HzbcpTkpWB1Yh7GQZdvM+emD2QW9X0BbVbfKgWCrsbry6z2IjBL08U1
	 ncFgWK1BQkGFoYNnykvsFhCZL2VGSQLuDTT+cRrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDHH0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:26:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33452 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfDHH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=G490sET7cjt6wYbqkPoZfZNPjdA36XERssFBLmkaUV4=; b=jCwTi826VgQy
        DMC5tr9LPZVhJdW6m1bXQQsqPAFz25RlZmGJmilWSxjTLNlp/Jz8h1i6Pgv0oSRBIrIv9OQ9Mi69h
        nWZQEmfW9XtCWJd/VCfLdvjZjKbjc7OvN/GbRIKFI9YLMf0Io976DVuJUHL/lGLNGClkfeP9DRwRI
        kwgbs=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOer-0003ox-4Y; Mon, 08 Apr 2019 07:25:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 52262441D3C; Mon,  8 Apr 2019 14:25:21 +0700 (+07)
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
Subject: Applied "ASoC: p1022_rdk: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-18-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072521.52262441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:25:21 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: p1022_rdk: Switch to SPDX identifier

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

From 8acfeb65cbaa92ff2e4f3305c7a18a6edabd1d92 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:07 +0300
Subject: [PATCH] ASoC: p1022_rdk: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/p1022_rdk.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 4afbdd610bfa..1c32c2d8c6b0 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -1,21 +1,17 @@
-/**
- * Freescale P1022RDK ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2012 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- * Note: in order for audio to work correctly, the output controls need
- * to be enabled, because they control the clock.  So for playback, for
- * example:
- *
- *      amixer sset 'Left Output Mixer PCM' on
- *      amixer sset 'Right Output Mixer PCM' on
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale P1022RDK ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+//
+// Note: in order for audio to work correctly, the output controls need
+// to be enabled, because they control the clock.  So for playback, for
+// example:
+//
+//      amixer sset 'Left Output Mixer PCM' on
+//      amixer sset 'Right Output Mixer PCM' on
 
 #include <linux/module.h>
 #include <linux/fsl/guts.h>
-- 
2.20.1

