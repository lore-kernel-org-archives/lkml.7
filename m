Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1EFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ED320883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708417;
	bh=6B7F0YY+1C/ayicjYviMBqGLRxj+v1ImfhGeLjYoMrg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=NYcLE9te1/mszZ0Qah1MU3EJlblYZvym+Pm339X0xX8vS2cqTBg3vMegUrDHMRy1+
	 qy3nnVTSUYFVV07GuMsAXjjZDPrNdmKiSopCu23QLO/VPZkXKiDBaccglwnrP15C15
	 xVkhlcrIq4AT4k4AGDWzWuHpCNZUqeyR3hCjaacE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDHH04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:26:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QrLh50gz7s5/FxcajZUFRBeSd2n+aFn/bqhWxmm7HyE=; b=V2TBzIpQs/XD
        rHHaDCkBKk04w/tBSBcDSVF25nwae96miQUjOFkIsZZTyWYHgvwJbhoePMFHFIIUKzJGVLFi+McyD
        PpKhh4VYixSZlnuY+26+4zQpeTMg5C6VgFap/UzeFqjGTCThnxEvYBaRsOV7Bpn7QY6SrW3dlDOss
        dURgI=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOfv-0003qm-IJ; Mon, 08 Apr 2019 07:26:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F2B00441D3B; Mon,  8 Apr 2019 14:26:27 +0700 (+07)
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
Subject: Applied "ASoC: mpc5200_dma: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-12-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072627.F2B00441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:26:27 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mpc5200_dma: Switch to SPDX identifier

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

From 1edfc2485d8dcf4c766a5be8049cab1cddc6700d Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:01 +0300
Subject: [PATCH] ASoC: mpc5200_dma: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mpc5200_dma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index c1a4544eb16b..4396442c2fdd 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -1,10 +1,10 @@
-/*
- * Freescale MPC5200 PSC DMA
- * ALSA SoC Platform driver
- *
- * Copyright (C) 2008 Secret Lab Technologies Ltd.
- * Copyright (C) 2009 Jon Smirl, Digispeaker
- */
+// SPDX-License-Identifier: GPL
+//
+// Freescale MPC5200 PSC DMA
+// ALSA SoC Platform driver
+//
+// Copyright (C) 2008 Secret Lab Technologies Ltd.
+// Copyright (C) 2009 Jon Smirl, Digispeaker
 
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.20.1

