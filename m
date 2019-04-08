Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA417C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855E920B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708333;
	bh=FjnD2dLV4w+EPP5364NLNq/6my598zRFYSEO6ib0yFU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PNe8ZODrvZwHwykUqtH/7zZTpm2aem4IF58ITm28oldzSGvXDb/MN6pthJIC/Piua
	 C6hjUd3Jjj+wmS/QlO7sD8P0ActDXxkFI9lPG7lpJXUVnOQKWBQkg+4VGdjlPHGQs0
	 S5SsIfCsYDsRqtdeM9qsBMzpnEyPeucjNEgQeXzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDHHZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:25:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60424 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=L0x3uXSWAj7XZcmb7SUkPLJUz8kz6EsQHNdd2tiDlbM=; b=mRud1YL0cDNy
        oL/ExvurLT7u8HTOflw7pLHf0fIlahGuUboq3gdbxWDeUGDrKMYNN37xQAH5RRqaU3DLwZlj9Rh+0
        Zvm+GCZopya44Ydv9kTKQ4SQak4eApEYcSw6UiBJn4n3oWhZxe7hRuYUl9HP8TJl08VUkgxf+yqfW
        pNV6A=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOeM-0003oN-U6; Mon, 08 Apr 2019 07:25:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5F08F441D3B; Mon,  8 Apr 2019 14:24:48 +0700 (+07)
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
Subject: Applied "ASoC: wm1133-ev1: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-21-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072448.5F08F441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:24:48 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm1133-ev1: Switch to SPDX identifier

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

From a03584b75a28450a2a64646e3c1b3d6c48aacf3b Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:10 +0300
Subject: [PATCH] ASoC: wm1133-ev1: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/wm1133-ev1.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index 2f80b21b2921..aad24ccbef90 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -1,16 +1,11 @@
-/*
- *  wm1133-ev1.c - Audio for WM1133-EV1 on i.MX31ADS
- *
- *  Copyright (c) 2010 Wolfson Microelectronics plc
- *  Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  Based on an earlier driver for the same hardware by Liam Girdwood.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  wm1133-ev1.c - Audio for WM1133-EV1 on i.MX31ADS
+//
+//  Copyright (c) 2010 Wolfson Microelectronics plc
+//  Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+//
+//  Based on an earlier driver for the same hardware by Liam Girdwood.
 
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-- 
2.20.1

