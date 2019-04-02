Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93868C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B8E2148E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201156;
	bh=GSkMsgGU710I4XQ+DpwfsgjvR5ZyVDUuIC6WRIyK9kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DEpsCrSdFSG6t5xnhg95QCMOaMfn+m60qjEYzQ7BOYtBZtcqSwy74ojRqKOymIzke
	 JFCvsIEBFeri8FmTF5jV1Si3nFQgWZXJW/KrNcwCXNl0KISiftYCkK0H3PnhFI8wJu
	 im9nwsJQ+HkE3faFaJl36xWURPlXthHkL7Lx5eC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfDBKce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbfDBKcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BE0208E4;
        Tue,  2 Apr 2019 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201151;
        bh=GSkMsgGU710I4XQ+DpwfsgjvR5ZyVDUuIC6WRIyK9kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7VMbSqatb+AiBCnFo3S30xGH8izlnMcfrjP1MnNN7AU1eCnZnZHcao0rGvuqLYHP
         DPQntZi+NGof1iOHboZx4GBxI1awXbB98YZLKEVvCSz3KfETiE+9i47eEKYn0+Tzq2
         q8X41DpreeJKwLAZmx2+2Tb+H8XfAx+pJhibMF4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Subject: [PATCH 14/16] staging: media: soc_camera: add proper SPDX identifiers on files that did not have them.
Date:   Tue,  2 Apr 2019 12:32:01 +0200
Message-Id: <20190402103203.14959-15-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few files for the soc_camera drivers that did not have SPDX
identifiers on them, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/soc_camera/imx074.c       | 6 +-----
 drivers/staging/media/soc_camera/mt9t031.c      | 6 +-----
 drivers/staging/media/soc_camera/soc_camera.c   | 6 +-----
 drivers/staging/media/soc_camera/soc_mediabus.c | 6 +-----
 drivers/staging/media/soc_camera/soc_mt9v022.c  | 6 +-----
 drivers/staging/media/soc_camera/soc_ov5642.c   | 6 +-----
 drivers/staging/media/soc_camera/soc_ov9740.c   | 6 +-----
 7 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/media/soc_camera/imx074.c b/drivers/staging/media/soc_camera/imx074.c
index 1676c166dc83..d907aa62f898 100644
--- a/drivers/staging/media/soc_camera/imx074.c
+++ b/drivers/staging/media/soc_camera/imx074.c
@@ -1,15 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for IMX074 CMOS Image Sensor from Sony
  *
  * Copyright (C) 2010, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
  *
  * Partially inspired by the IMX074 driver from the Android / MSM tree
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
-
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/v4l2-mediabus.h>
diff --git a/drivers/staging/media/soc_camera/mt9t031.c b/drivers/staging/media/soc_camera/mt9t031.c
index 4ff179302b4f..615ae9df2c57 100644
--- a/drivers/staging/media/soc_camera/mt9t031.c
+++ b/drivers/staging/media/soc_camera/mt9t031.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for MT9T031 CMOS Image Sensor from Micron
  *
  * Copyright (C) 2008, Guennadi Liakhovetski, DENX Software Engineering <lg@denx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
-
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/log2.h>
diff --git a/drivers/staging/media/soc_camera/soc_camera.c b/drivers/staging/media/soc_camera/soc_camera.c
index 1ab86a7499b9..a6232dcd59bc 100644
--- a/drivers/staging/media/soc_camera/soc_camera.c
+++ b/drivers/staging/media/soc_camera/soc_camera.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * camera image capture (abstract) bus driver
  *
@@ -10,12 +11,7 @@
  * SoCs. Later it should also be used for i.MX31 SoCs from Freescale.
  * It can handle multiple cameras and / or multiple buses, which can
  * be used, e.g., in stereo-vision applications.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
-
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
diff --git a/drivers/staging/media/soc_camera/soc_mediabus.c b/drivers/staging/media/soc_camera/soc_mediabus.c
index be74008ec0ca..2aa646c89c1f 100644
--- a/drivers/staging/media/soc_camera/soc_mediabus.c
+++ b/drivers/staging/media/soc_camera/soc_mediabus.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * soc-camera media bus helper routines
  *
  * Copyright (C) 2009, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 
diff --git a/drivers/staging/media/soc_camera/soc_mt9v022.c b/drivers/staging/media/soc_camera/soc_mt9v022.c
index 6d922b17ea94..e7e0d3d29499 100644
--- a/drivers/staging/media/soc_camera/soc_mt9v022.c
+++ b/drivers/staging/media/soc_camera/soc_mt9v022.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for MT9V022 CMOS Image Sensor from Micron
  *
  * Copyright (C) 2008, Guennadi Liakhovetski <kernel@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
-
 #include <linux/videodev2.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
diff --git a/drivers/staging/media/soc_camera/soc_ov5642.c b/drivers/staging/media/soc_camera/soc_ov5642.c
index 0931898c79dd..94696d7baf83 100644
--- a/drivers/staging/media/soc_camera/soc_ov5642.c
+++ b/drivers/staging/media/soc_camera/soc_ov5642.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for OV5642 CMOS Image Sensor from Omnivision
  *
@@ -8,12 +9,7 @@
  *
  * Based on Omnivision OV7670 Camera Driver
  * Copyright (C) 2006-7 Jonathan Corbet <corbet@lwn.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
-
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
diff --git a/drivers/staging/media/soc_camera/soc_ov9740.c b/drivers/staging/media/soc_camera/soc_ov9740.c
index a07d3145d1b4..7c765595d85f 100644
--- a/drivers/staging/media/soc_camera/soc_ov9740.c
+++ b/drivers/staging/media/soc_camera/soc_ov9740.c
@@ -1,15 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * OmniVision OV9740 Camera Driver
  *
  * Copyright (C) 2011 NVIDIA Corporation
  *
  * Based on ov9640 camera driver.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
-
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
-- 
2.21.0

