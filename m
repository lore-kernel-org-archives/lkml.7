Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F68FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC952087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318441;
	bh=adWlxOt0bEOlMBQ+lnCdxLDIzUXsob042xFZicPJsmI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=olje6u0ET/WPSiTrDdIYMTmRJzvEVV3auXZKoK0GTPUqqVh0c1JDcw6WrS+dM1gVT
	 9jUZbG/rfiFM6YJlMgPkmM8n0Lg3MqDt9RI3d2pj2Jn3t2kdXKSgf3CA0WZr7YJmW/
	 9sjU2zR3WI76ci4I6yR73o6EnND4XdQQjIr8LeM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDOIyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:54:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfDOIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VilkqsMrK/X8m0x72QmRyeKZ5cgL7sSahu18u47zU98=; b=wCNOs7fwoYmZ
        Gh4TP9LS7REl4ilXLHYR9l3v1RvG6eBGm071g4ljPRGObsfaY/rLyCJ1bE8x/nBny0HIc57O3t8Mc
        jRqqcb3ZzzMHkjJotqnHPj2WeSIUjpLYi+dWVS8h8syDxaKUiZ5/gb1JgSyJy+T+VHuHamiQi+Cfm
        Af/nM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hFxMp-0007io-F2; Mon, 15 Apr 2019 08:53:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 18F5911279F6; Mon, 15 Apr 2019 09:53:30 +0100 (BST)
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
In-Reply-To: <20190414191450.18377-2-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190415085330.18F5911279F6@debutante.sirena.org.uk>
Date:   Mon, 15 Apr 2019 09:53:30 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mpc5200_dma: Fix invalid license ID

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

From 8981d195355ecf898c8bacabba8ce9c178534b43 Mon Sep 17 00:00:00 2001
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

