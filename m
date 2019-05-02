Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B8DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706A021734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763538;
	bh=x/JZ9Z0llpP6XYiwht1+5jCu8pZA6+F/HkNRy1K0Nbw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LJnDVqtOBfSG66gGfyVSEyhNWvTTUXwMyqn4PtCZbVOdIqM+3Ny17630yROw8dqzl
	 4k+dSTF52vhRrbTnllkurf3CfMzvq4wOu3WPvaEGFbkPcxr4VIUx/h99yi/SrUfRP/
	 +JwGk2EMln+p26Wl1Vr3F/PMMORRLXeWKg/51d/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEBCS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:18:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56048 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEBCSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vr2VIXn3Zn8E9lStqhtVN3FmIgvkBlu7YokpK9YQ9y0=; b=uNqKX7SDj5yL
        D43C2f1vMCFiH3NZTL00y+o4cNYiscmYhPVccI/tPTB1vRBsxFoWlayQ/KEoABKBHAhKlkniYjN39
        6+c3b5DqT52irUctnw5gqLTQowFIlMDnfV/gXoHbRu0RaalMm6IWSj6dBETbnKJ4TCg02V/j/kArg
        Sn9mo=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1Iv-0005sC-5U; Thu, 02 May 2019 02:18:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3FCBC441D3D; Thu,  2 May 2019 03:18:30 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>, daniel.baluta@gmail.com,
        festevam@gmail.com, kernel@pengutronix.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        perex@perex.cz, s.hauer@pengutronix.de, shawnguo@kernel.org,
        tglx@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
        timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: mpc5200_dma: Fix invalid license ID" to the asoc tree
In-Reply-To:  <20190414191450.18377-2-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021830.3FCBC441D3D@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:30 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mpc5200_dma: Fix invalid license ID

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

From ac097cac496f69e97083c6b128c5a209a85c6fcb Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Sun, 14 Apr 2019 22:14:49 +0300
Subject: [PATCH] ASoC: mpc5200_dma: Fix invalid license ID

As the file had no other license notice/reference, it falls under the
project license and therefore the proper SPDX id is: GPL-2.0-only

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mpc5200_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 4396442c2fdd..ccf9301889fe 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Freescale MPC5200 PSC DMA
 // ALSA SoC Platform driver
-- 
2.20.1

