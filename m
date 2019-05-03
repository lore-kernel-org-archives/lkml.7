Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE262C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8818120B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864704;
	bh=sTEzmzJe/wBL5QDfL5DoYLT6SJuXW3GNt0X7I9wUiLM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MsjPZPzcBimVwf4ihULWeRZoMQWfv/iJ/72BP1xsFpviPUFur/ZJ4G+8PokVYFNT4
	 /q2ba6/wDW6yoFsfaW+maTfpv0mD8gUR/IYYxUaJKj1+nPnncqrGmHfn12v2QPgux/
	 /FZgCc8e8RnaDcDQCwCRanNFoE99YNzGV3M0OXRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfECGXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:23:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfECGXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dr8iiJcg2+vpOn+Dy6n/2x3VLOxcn420oALuCMcHAYQ=; b=v5A2hVPHhQv7
        l72/x03qRBmvK/WIsLn/WWiK7rUORLwa0ZsGHt6IGFJE+vVirjPTERgSB+q3lJMLBBW4d8CRRClIS
        TXSnJrp4IHQB7QpATlqV4k2dNBgGoMK4ke9HRP2s4tJl02JVDO7hgzY9p0gaWggNlVkSL461E0WvO
        ZZHYo=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRb3-0000az-AQ; Fri, 03 May 2019 06:23:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 38005441D6E; Fri,  3 May 2019 07:21:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Subject: Applied "regulator: da9xxx: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190503053637.25911-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503062134.38005441D6E@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:21:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9xxx: Switch to SPDX identifier

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

From fd2f02f9724c416221b42af95e1a7a57fa42d681 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 3 May 2019 13:36:37 +0800
Subject: [PATCH] regulator: da9xxx: Switch to SPDX identifier

Convert Dialog Semiconductor DA9xxx regulator drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da903x.c           | 16 ++++++----------
 drivers/regulator/da9052-regulator.c | 20 +++++++-------------
 drivers/regulator/da9055-regulator.c | 20 +++++++-------------
 drivers/regulator/da9062-regulator.c | 19 +++++--------------
 drivers/regulator/da9210-regulator.c | 23 ++++-------------------
 drivers/regulator/da9210-regulator.h | 17 +----------------
 drivers/regulator/da9211-regulator.c | 20 +++++---------------
 drivers/regulator/da9211-regulator.h | 11 +----------
 8 files changed, 36 insertions(+), 110 deletions(-)

diff --git a/drivers/regulator/da903x.c b/drivers/regulator/da903x.c
index 33e8f3b8d2bd..5493c3a86426 100644
--- a/drivers/regulator/da903x.c
+++ b/drivers/regulator/da903x.c
@@ -1,13 +1,9 @@
-/*
- * Regulators driver for Dialog Semiconductor DA903x
- *
- * Copyright (C) 2006-2008 Marvell International Ltd.
- * Copyright (C) 2008 Compulab Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulators driver for Dialog Semiconductor DA903x
+//
+// Copyright (C) 2006-2008 Marvell International Ltd.
+// Copyright (C) 2008 Compulab Ltd.
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index b90a7ac3f3de..e18d291c7f21 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -1,16 +1,10 @@
-/*
-* da9052-regulator.c: Regulator driver for DA9052
-*
-* Copyright(c) 2011 Dialog Semiconductor Ltd.
-*
-* Author: David Dajun Chen <dchen@diasemi.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9052-regulator.c: Regulator driver for DA9052
+//
+// Copyright(c) 2011 Dialog Semiconductor Ltd.
+//
+// Author: David Dajun Chen <dchen@diasemi.com>
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index bcbc2fbd7fea..c025ccb1a30a 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -1,16 +1,10 @@
-/*
-* Regulator driver for DA9055 PMIC
-*
-* Copyright(c) 2012 Dialog Semiconductor Ltd.
-*
-* Author: David Dajun Chen <dchen@diasemi.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-*/
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator driver for DA9055 PMIC
+//
+// Copyright(c) 2012 Dialog Semiconductor Ltd.
+//
+// Author: David Dajun Chen <dchen@diasemi.com>
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index a7d929b7776a..a02e0488410f 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1,17 +1,8 @@
-/*
- * Regulator device driver for DA9061 and DA9062.
- * Copyright (C) 2015-2017  Dialog Semiconductor
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Regulator device driver for DA9061 and DA9062.
+// Copyright (C) 2015-2017  Dialog Semiconductor
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 528303771723..f9448ed50e05 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -1,22 +1,7 @@
-/*
- * da9210-regulator.c - Regulator device driver for DA9210
- * Copyright (C) 2013  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9210-regulator.c - Regulator device driver for DA9210
+// Copyright (C) 2013  Dialog Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/da9210-regulator.h b/drivers/regulator/da9210-regulator.h
index 749c550808b6..b1f1a607c208 100644
--- a/drivers/regulator/da9210-regulator.h
+++ b/drivers/regulator/da9210-regulator.h
@@ -1,22 +1,7 @@
-
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * da9210-regulator.h - Regulator definitions for DA9210
  * Copyright (C) 2013  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with this library; if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
- * Boston, MA  02110-1301, USA.
  */
 
 #ifndef __DA9210_REGISTERS_H__
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 4d7fe4819c1c..da37b4ccd834 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -1,18 +1,8 @@
-/*
- * da9211-regulator.c - Regulator device driver for DA9211/DA9212
- * /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
- * Copyright (C) 2015  Dialog Semiconductor Ltd.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// da9211-regulator.c - Regulator device driver for DA9211/DA9212
+// /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
+// Copyright (C) 2015  Dialog Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/da9211-regulator.h b/drivers/regulator/da9211-regulator.h
index 2cb32aab4f82..1201e7cc056c 100644
--- a/drivers/regulator/da9211-regulator.h
+++ b/drivers/regulator/da9211-regulator.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * da9211-regulator.h - Regulator definitions for DA9211/DA9212
  * /DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DA9211_REGISTERS_H__
-- 
2.20.1

