Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEF9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5440520870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708586;
	bh=ubypH6EWy123jBeo+oEThe+8GzGzZ5JMK/pWovb5eNg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=TCXbf6LHLwwIB/4nNx6oDQmJWHZU6aPlM8Go5NvaHrsl7K7UMHK5G0pcNZeE262mz
	 rU+6gnpBGtVAhPg6gHXgd8HiewiDzbDEGucdbNv6Yi5w74a+MJzXEfAKSY89HUUMxP
	 YqKoY4YU8UeooMQhOMcyo6FbHz+TOU5Xyqy6uQo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDHH3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:29:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39670 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Y8smWxqFTq9UQos/mryAL8rpepInuCxIeJa11gsgOXI=; b=Xwl98nuHIu6J
        wE1FJ+Fm8K+MCBrhzSAuuNrHGIPDtaU9djeRKkpfHYZfLa0DtVHjrDHQT0CB52j5i+/j0Q66HwMZH
        jSm0Y17kw38p4el0aXXAAcyXOTc5Jo+V+VCz9A5YvmUUOw6zu6JMT2NSFo71hB5dBl2gbvZl0vXd7
        qWvZ4=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOif-0003t3-V7; Mon, 08 Apr 2019 07:29:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A7FAC441D3C; Mon,  8 Apr 2019 14:29:19 +0700 (+07)
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
Subject: Applied "ASoC: imx-audmux: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-6-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072919.A7FAC441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:29:19 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: imx-audmux: Switch to SPDX identifier

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

From 47bbcbfeb8ac99164067485a8322d92e69044211 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:49:55 +0300
Subject: [PATCH] ASoC: imx-audmux: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmux.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 99e07b01a2ce..04e59e66711d 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -1,21 +1,11 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
- *
- * Initial development of this code was funded by
- * Phytec Messtechnik GmbH, http://www.phytec.de
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+// Copyright 2012 Linaro Ltd.
+// Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+//
+// Initial development of this code was funded by
+// Phytec Messtechnik GmbH, http://www.phytec.de
 
 #include <linux/clk.h>
 #include <linux/debugfs.h>
-- 
2.20.1

