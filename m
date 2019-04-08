Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408ACC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA9F20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708364;
	bh=IFUpWCJdA02/oXyTI3eICiiVgcFJn/yLFoB5VTrN5qg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HdFxsYHVo7LkJn57NtM5fuYC+CegJ+Hl9UEC9itvG/EHHVQbP5W3jld3EjtVg8OHc
	 qQsMP/WfSFzRGFkTuLk0N1wfjZw8yKkPI+R7+gZanhE7/5Wbxo93kHULIksgVUFcV4
	 iEpwWqG5SmYj1JoozXMtLy9atB1hlB/9bfISnj1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDHH0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:26:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33264 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=w9DGT1UQQsVAWJAyzkkYAvbrtKDK5tI7UM9utKcgM50=; b=nvMENv5tzbGQ
        /Y5QCpcBDLar59OcWKlqjmanrDQ+bmJwgf30gRPrV9bbvwNiSx5XQFkb1m0/ERuFqLx6fznjeKADy
        Cu8KTGfy8F71fqK93ocOnP+GVoPczaA0S1qhNPrg4ovY7fm3+/GBI5hg6xBYs/i2nUr3iryofUDlF
        ZSBq0=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOey-0003pH-I0; Mon, 08 Apr 2019 07:25:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B08DA441D3B; Mon,  8 Apr 2019 14:25:30 +0700 (+07)
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
Subject: Applied "ASoC: p1022_ds: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-17-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072530.B08DA441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:25:30 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: p1022_ds: Switch to SPDX identifier

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

From ab78529cfec09bf1a4327d48c4ba6d3d159a1540 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:06 +0300
Subject: [PATCH] ASoC: p1022_ds: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/p1022_ds.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 41c623c55c16..80384f70878d 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -1,14 +1,10 @@
-/**
- * Freescale P1022DS ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale P1022DS ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2010 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/fsl/guts.h>
-- 
2.20.1

