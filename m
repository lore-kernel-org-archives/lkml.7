Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A548C282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71C020870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708573;
	bh=V44OXIFFriTAwZ5p58hFVwuCuUspIqtpiwzwUmGRVyk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=J9yrkQS/XbJ6oy/FpvVwros0tOIfxTZHJQ/ShF5B0+Yy7O6Wwt8JDx41Yk9nLlDEq
	 iT8bBqpd8laru/Wnueinb9az4U7BCYsgq6C2+jcIblPeWvsEHykOqY7qVoLfe10zr5
	 2jTvoCOIhJS8O++4K52pGmBms8Q235uIMT3xuQoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDHH3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:29:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHH3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YJZj91uVimlfiDWfJE8PvGbUgisNETs6+qnHm70mzbg=; b=jXAj4roOLBiG
        zcu0ezYbE/s+f0TXbxRd2OcLokxlaava8Aj5bPJN9LXXiNJHyKxL72o0LVjWxXqguSUAQFZNldQ57
        QB6m2P04oksYiPPpm772b092dedkMz3gL2EarB3WMT6ZaPk9OT3iZR1m/0RmGMfgjQssKHxLR1nMO
        xelYA=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOiM-0003sV-Jq; Mon, 08 Apr 2019 07:29:12 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 657C2441D3C; Mon,  8 Apr 2019 14:28:59 +0700 (+07)
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
Subject: Applied "ASoC: imx-mc13783: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-8-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072859.657C2441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:28:59 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: imx-mc13783: Switch to SPDX identifier

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

From a134f42eaacaa4d31785d51cf19a45845721b212 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:49:57 +0300
Subject: [PATCH] ASoC: imx-mc13783: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-mc13783.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 9d19b808f634..545815a27074 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -1,17 +1,11 @@
-/*
- * imx-mc13783.c  --  SoC audio for imx based boards with mc13783 codec
- *
- * Copyright 2012 Philippe Retornaz, <philippe.retornaz@epfl.ch>
- *
- * Heavly based on phycore-mc13783:
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
+// imx-mc13783.c  --  SoC audio for imx based boards with mc13783 codec
+//
+// Copyright 2012 Philippe Retornaz, <philippe.retornaz@epfl.ch>
+//
+// Heavly based on phycore-mc13783:
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.20.1

