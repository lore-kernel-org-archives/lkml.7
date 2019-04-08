Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D118C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E85214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708380;
	bh=DkmKFVfKfQvb6yvfdfTCViffxH6mnnirGQb97nB+F1E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Rgu8k7aS3KuvQCRAE1TAX2yV3lMZFLtH07RzfstcaOAl9s4m6npAbauq/5iIy3rh7
	 5erj/MevIgcvQFqoZ49Rop/699OypX5Z8fWKfJ5L3UtlIPKiRMqJir7D1PXsWN6CO0
	 Fbq4x9YbXy9F98ifiMenuW4uwVlkhAwQrbPrUvIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDHH0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:26:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33720 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHH0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AaQ3ipbmv9dj4e0ITSdfd5pp10c4ej2O3oX65XtlBok=; b=Bs0lZ9f/sOfo
        tu567WyqE/I/o0F91ZENW2bd/sKkHbpbSfvKi8iNvFhhojaOySrVdPHQtwf5F3aq9K+s1Gro86yME
        xPiyuyhG7Xc4joC1t1W/XiGSMtHWS5144aJbnhTqhWlbwHP9xuIIamlXCQm4qoEMJhMLnF++jEMod
        cYTQI=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOfJ-0003pk-3K; Mon, 08 Apr 2019 07:26:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3DAE9441D3B; Mon,  8 Apr 2019 14:25:51 +0700 (+07)
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
Subject: Applied "ASoC: mpc8610_hpcd: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-15-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072551.3DAE9441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:25:51 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mpc8610_hpcd: Switch to SPDX identifier

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

From eed9bb238e08619547585e563499f79a700109b8 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:04 +0300
Subject: [PATCH] ASoC: mpc8610_hpcd: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mpc8610_hpcd.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index a639b52c16f6..f6261a3eeb0f 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -1,14 +1,10 @@
-/**
- * Freescale MPC8610HPCD ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale MPC8610HPCD ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-- 
2.20.1

