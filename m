Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF102C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D88420883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708367;
	bh=CrcJG5Y0o4wfZuJBz/Ue1zg26TPEaQoTe5xPGhMl11U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AFF1yQgSTpMOpOyO75wmm4V2o9N2vC584AZbK9MIPxnQckhOBA2GXd//3CDiJIDOd
	 eumy4G8yahJ/LwTLvvry9pQuPu3P/0+tS6EMlYXwOfO8TUwreW3uV7WiDmCmCwvm+E
	 osSxrQ5tXc99j2kAQzzp1mOD+VyMl/ExWSSk+t1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDHH0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:26:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33352 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfDHH0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OF32AdMGz9qGno4Sq2WPCUNbV3+0lXRDGQsy2yMrCU8=; b=pKFhx9McYbqy
        YZ96m1vmDg9P+4PGg+uq416594UM3nsuI6KeKEYjozdQeVCDbz9tCOHETmP41IM1yiZ7Ys7c4bXl4
        +Niegg6O4ipvSf2sglqnNm0t7bHRKaoUFla91XkS0XcIqZzXd4rkziHZ4usqSoLOY7eCpyC2AYwc0
        Q4mAM=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOf8-0003pT-BZ; Mon, 08 Apr 2019 07:25:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 20432441D3C; Mon,  8 Apr 2019 14:25:40 +0700 (+07)
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
Subject: Applied "ASoC: mx27vis-aic32x4: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <20190405115010.28838-16-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072540.20432441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:25:40 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mx27vis-aic32x4: Switch to SPDX identifier

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

From 1021ec41a909ee7961f63f38afd90b5ccc592c49 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:05 +0300
Subject: [PATCH] ASoC: mx27vis-aic32x4: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mx27vis-aic32x4.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index d7ec3d20065c..37a4520aef62 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -1,25 +1,10 @@
-/*
- * mx27vis-aic32x4.c
- *
- * Copyright 2011 Vista Silicon S.L.
- *
- * Author: Javier Martin <javier.martin@vista-silicon.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// mx27vis-aic32x4.c
+//
+// Copyright 2011 Vista Silicon S.L.
+//
+// Author: Javier Martin <javier.martin@vista-silicon.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.20.1

