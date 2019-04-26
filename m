Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C7BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152952089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271881;
	bh=MrO73lF01rKrm3OWM7DuMT4urQjPOTtdPBJYJThzyu0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Pa7pDeaAdCx+ilPNUzsyEE2e2C89voqgJSR1hG/kisvMIPqarKkwyRoljSvWvSs3G
	 iEPMb0r36vOZXu3Jj4FDiGj5Gm+QrFt2k0aJ7RtPHySg/7eISJqn5IMNCsReFJQnsR
	 EFEXOt4FGjHU0w4f+O6AMNWfd9GsWHoextVUE3KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfDZJok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:44:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52942 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfDZJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=71xIvrdd/UbC/ELpdax1XEj7xWILX11LMSxb2okDwUM=; b=jU+V4ufdPktF
        X47ovQlmGKWMKsv3r8VBZgGVuExJg/1obKG7iAjnTsPrsiZUXsrltdbi45dCYPv+AyXEFfb9b50s9
        n/Ktrngr9VpDMyyq7RWYAkt7UXGeOoEMVezqWKeOnqv2yXav6m9VQILi81ufSO3gLK5b+PIJivCck
        YgygI=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxPG-0003P9-PI; Fri, 26 Apr 2019 09:44:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B1EB6441D3B; Fri, 26 Apr 2019 10:44:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: wm831x: Switch to SPDX identifier" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094433.B1EB6441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:44:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm831x: Switch to SPDX identifier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 3cad5fc89ac97e4b0bf5a011d54617ee8b9eeb11 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 17 Apr 2019 22:16:30 +0800
Subject: [PATCH] regulator: wm831x: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm831x-dcdc.c  | 19 +++++++------------
 drivers/regulator/wm831x-isink.c | 19 +++++++------------
 drivers/regulator/wm831x-ldo.c   | 19 +++++++------------
 3 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index d1873f94bca7..b422eef97b77 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -1,15 +1,10 @@
-/*
- * wm831x-dcdc.c  --  DC-DC buck convertor driver for the WM831x series
- *
- * Copyright 2009 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// wm831x-dcdc.c  --  DC-DC buck converter driver for the WM831x series
+//
+// Copyright 2009 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index bdc521a6f048..ff3d2bf50410 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -1,15 +1,10 @@
-/*
- * wm831x-isink.c  --  Current sink driver for the WM831x series
- *
- * Copyright 2009 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// wm831x-isink.c  --  Current sink driver for the WM831x series
+//
+// Copyright 2009 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index fcd038e7cd80..56754686c982 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -1,15 +1,10 @@
-/*
- * wm831x-ldo.c  --  LDO driver for the WM831x series
- *
- * Copyright 2009 Wolfson Microelectronics PLC.
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// wm831x-ldo.c  --  LDO driver for the WM831x series
+//
+// Copyright 2009 Wolfson Microelectronics PLC.
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.20.1

