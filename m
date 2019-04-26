Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AF3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A246E208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271632;
	bh=v2ARod7HjKep7IitZ+YopVdamp1JPG6yFnkBdKSIkZA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=t21uvPGCZLOHrev/poLWKjtMmxJx1K2OL04FWyXDe8ZJHr/qc918vefWQ11MBTQ0y
	 7mQNagIZB65cfHDgQjSuJBc1DG24sqdUhuHg5OCb1h7rxTM30qsgThGM/Yx4b7T/Sd
	 crINSu7LW9qH8YicbDaMHQM4U/tON2dH1J7BOSpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfDZJkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:40:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDZJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=d7fwDPCLOnIsD8KW6qDPNj2rt1PnG3weU5JoQ4wyNxs=; b=DNjwOjZi2mvh
        2OY3oOGU2/rm44cfoBiFZO2RQW6aHO/iinvzxMljpGuM9Yl/gqbi4xjCS+PDJH/y21I4BE/5B4P8G
        3ylIzGIXWx/vyZwuy9b9Xgqt7z8aSUQGGr/9yXZ2yzpqTJCwhyXewYIqsCvUC9tE2GBSYGtdS90RT
        Wfs8w=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxL8-0003IJ-PI; Fri, 26 Apr 2019 09:40:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8A031441D3C; Fri, 26 Apr 2019 10:40:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Applied "regulator: ltc3589: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190418114500.1098-3-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190426094017.8A031441D3C@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ltc3589: Switch to SPDX identifier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

From b2745697bfe46ce04af5493f194c6073e683b0f1 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 18 Apr 2019 19:45:00 +0800
Subject: [PATCH] regulator: ltc3589: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3589.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 077e73715514..9a037fdc5fc5 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -1,21 +1,9 @@
-/*
- * Linear Technology LTC3589,LTC3589-1 regulator support
- *
- * Copyright (c) 2014 Philipp Zabel <p.zabel@pengutronix.de>, Pengutronix
- *
- * See file CREDITS for list of people who contributed to this
- * project.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Linear Technology LTC3589,LTC3589-1 regulator support
+//
+// Copyright (c) 2014 Philipp Zabel <p.zabel@pengutronix.de>, Pengutronix
+
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
2.20.1

