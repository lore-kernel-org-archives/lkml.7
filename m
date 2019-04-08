Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D5CC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6E3208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708577;
	bh=IbWATgno2TmjH7ORscfhjtZGjzwdd6Iw+JwrgF9xYdY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ciGjIvOanAmVGLiTt22/OCBZJWSxzg8wSMyoI51S3QzuCl5PpaWtippSJawUDnKqg
	 FWk83MfPN8scTzpQ+fPszAJu4H14i5Ibr2pPeT/8AotIHSdlAidfwbGXPg6qG4X7eX
	 DUQQ8pgJ752kbj2DztKoPu7JFIK0rPW5H1BVqftg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfDHH3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:29:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39370 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jyoGHS6dk4RCT/4XYMVWL4TiqajVEeELVDKtsSr7PDw=; b=iRB8dEHb6j6i
        oVwgkR6pJrpeB32V1xhAHBGmbP4FDkyYWIuHoTCJA1ZuQ7gUNEo6bBfYnCcJi3n8oX9x3hFScnzLn
        tKNBLY1mQKVJQICnKDw0SqTUmJzuUEQqfqnFEwlccKR7MtXi1oz24TzpPpgLagPO/hBcSkVcU8zZB
        P7J7g=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOiV-0003sj-8j; Mon, 08 Apr 2019 07:29:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 91F93441D3B; Mon,  8 Apr 2019 14:29:08 +0700 (+07)
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
Subject: Applied "ASoC: imx-es8328: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-7-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072908.91F93441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:29:08 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: imx-es8328: Switch to SPDX identifier

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

From 0fe61fc0c243b965d941f24e8b25cfc94697757a Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:49:56 +0300
Subject: [PATCH] ASoC: imx-es8328: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-es8328.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 9953438086e4..c9d8739b04a9 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -1,14 +1,7 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+// Copyright 2012 Linaro Ltd.
 
 #include <linux/gpio.h>
 #include <linux/module.h>
-- 
2.20.1

