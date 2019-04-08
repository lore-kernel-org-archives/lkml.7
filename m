Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC90C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0846D20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708617;
	bh=T0tLjmo6PBqAU2JPUd2VK1QVa+C9wN0Y+f9LBPKeER4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2mMQOVboINN+3JTuk2JJPeaUWEUsTPvmmWH4VvPfl+koaipjiwIxuiJHOPE+aQ8aZ
	 QoIAa5XJyuNExmMwJmM1fGsrb4x1F1WLa6He/1Y9d/sobv6IcwCpyfv3cisj7uTsui
	 yXeVmT5qh8A4lGu7EEG1p0Qo+mwE/c03QHimWuuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDHHaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:30:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40598 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VQsj8TlyqpPEUdjLgicK+e4dY7Alb6XE3coJsvJL+zU=; b=ePIDvHENjp/j
        q+j//6YPcNNQRALot/yMMasIrZBUVjPHFqMPOKmYxAalAT/FCKVt8+8zZiRst/jV8yczJq6uTx5zV
        9dBSe7e9emPQm+dNElyHRrpxKtfb+k2CIVZ5LaIorQ75JQ1qCILW/v7A0vFi3Djh7cTMOJLpcwdQN
        UrrJ4=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOj9-0003uC-85; Mon, 08 Apr 2019 07:30:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0B2BA441D3B; Mon,  8 Apr 2019 14:29:49 +0700 (+07)
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
Subject: Applied "ASoC: imx-pcm: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-2-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072949.0B2BA441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:29:48 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: imx-pcm: Switch to SPDX identifier

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

From 1c05c1ed6f4dd267a2ca30bacd63870cd5ecc860 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:49:51 +0300
Subject: [PATCH] ASoC: imx-pcm: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-pcm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 133c4470acad..5dd406774d3e 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
  *
  * This code is based on code copyrighted by Freescale,
  * Liam Girdwood, Javier Martin and probably others.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef _IMX_PCM_H
-- 
2.20.1

