Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76767C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE320C01
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864348;
	bh=/ISepoMzEGK5m4ufBbXUfo51A3qsK9vPOI2XFbGxTYY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WsJhS5nWuYqkKYzwzqks8+sMvYz56TIjNB8+Vp4/WoASU7rr12iqlV/TRdGBuvn/p
	 CbOmNCqu5uZq8JP2K6SdiGnN5G6zFR0TMpVY01fvUsJKf4iv6yZchGdgyn/LsuZHcO
	 jgLItnIKHxhdg9i0X0b/ULrZHBRxhmFeX5U5EYgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfECGTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:19:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfECGTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JMqAUqFDCfWR43uVUQqmT3XaGk1njZ/YvJJAmJYVw94=; b=WDuFI4iLnvwg
        MabkdS6RYYj/qRL7H4oFkXyCn7/ywzqB8HWffGDxw2g1CHzd6Bp7Adb6g6Uwk0ErUN1zZ2yBmw0Gb
        Q2YfUIsYWtvarxCizLMWY2QQgsP5IBHLSbsUM4N1kmNHLkkU1HXeR2U1Q69699DJngWoTSSOBLejW
        o0xv0=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRX7-0000Yl-C3; Fri, 03 May 2019 06:18:58 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 163C1441D3D; Fri,  3 May 2019 07:18:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Subject: Applied "regulator: pv880x0: Switch to SPDX identifier" to the regulator tree
In-Reply-To: <20190503053637.25911-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503061850.163C1441D3D@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:18:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pv880x0: Switch to SPDX identifier

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

From 0ae3b061df3037e887ee6085b0bedea7f8809441 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 3 May 2019 13:36:36 +0800
Subject: [PATCH] regulator: pv880x0: Switch to SPDX identifier

Convert Powerventure Semiconductor PV88060/PV88080/PV88090 regulator
drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pv88060-regulator.c | 18 ++++--------------
 drivers/regulator/pv88060-regulator.h | 11 +----------
 drivers/regulator/pv88080-regulator.c | 18 ++++--------------
 drivers/regulator/pv88080-regulator.h | 11 +----------
 drivers/regulator/pv88090-regulator.c | 18 ++++--------------
 drivers/regulator/pv88090-regulator.h | 11 +----------
 6 files changed, 15 insertions(+), 72 deletions(-)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 810816e9df5d..3d3415839ba2 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -1,17 +1,7 @@
-/*
- * pv88060-regulator.c - Regulator device driver for PV88060
- * Copyright (C) 2015  Powerventure Semiconductor Ltd.
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
+// pv88060-regulator.c - Regulator device driver for PV88060
+// Copyright (C) 2015  Powerventure Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/pv88060-regulator.h b/drivers/regulator/pv88060-regulator.h
index 02ca9203a172..d333dbf3be94 100644
--- a/drivers/regulator/pv88060-regulator.h
+++ b/drivers/regulator/pv88060-regulator.h
@@ -1,16 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * pv88060-regulator.h - Regulator definitions for PV88060
  * Copyright (C) 2015 Powerventure Semiconductor Ltd.
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
 
 #ifndef __PV88060_REGISTERS_H__
diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 6279216fb254..a444f68af1a8 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -1,17 +1,7 @@
-/*
- * pv88080-regulator.c - Regulator device driver for PV88080
- * Copyright (C) 2016  Powerventure Semiconductor Ltd.
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
+// pv88080-regulator.c - Regulator device driver for PV88080
+// Copyright (C) 2016  Powerventure Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/pv88080-regulator.h b/drivers/regulator/pv88080-regulator.h
index ae25ff360e3d..7d7f8f11a75a 100644
--- a/drivers/regulator/pv88080-regulator.h
+++ b/drivers/regulator/pv88080-regulator.h
@@ -1,16 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * pv88080-regulator.h - Regulator definitions for PV88080
  * Copyright (C) 2016 Powerventure Semiconductor Ltd.
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
 
 #ifndef __PV88080_REGISTERS_H__
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 90f4f907fb3f..b1d0d97ae935 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -1,17 +1,7 @@
-/*
- * pv88090-regulator.c - Regulator device driver for PV88090
- * Copyright (C) 2015  Powerventure Semiconductor Ltd.
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
+// pv88090-regulator.c - Regulator device driver for PV88090
+// Copyright (C) 2015  Powerventure Semiconductor Ltd.
 
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/regulator/pv88090-regulator.h b/drivers/regulator/pv88090-regulator.h
index 62d9029277f4..f814ee52cff3 100644
--- a/drivers/regulator/pv88090-regulator.h
+++ b/drivers/regulator/pv88090-regulator.h
@@ -1,16 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * pv88090-regulator.h - Regulator definitions for PV88090
  * Copyright (C) 2015 Powerventure Semiconductor Ltd.
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
 
 #ifndef __PV88090_REGISTERS_H__
-- 
2.20.1

