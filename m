Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F1EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D1720883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201160;
	bh=gwpeR4uRptMkZpXpV8aGF7Vp9dLklxkS1rrZlnkJ3r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i5UH9zG0jPwrB58qSdZTLzjUfbHaC0EqjKuPrmkhXJx73C3yYl0UwCouKRjlfveG2
	 wXbp1g5lJG4D3uimTv4FXP4uvy+8ZLTMDU7XoNPtJx0uN2HKM3YlaIRfmlbqrBjg/Z
	 HZ4nB7E2TYkPoFM1YjTV8cyzZVuhK2HQrjKfpfC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfDBKci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbfDBKcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4082147A;
        Tue,  2 Apr 2019 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201153;
        bh=gwpeR4uRptMkZpXpV8aGF7Vp9dLklxkS1rrZlnkJ3r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1C0ZBIsol8q9vGY57e9CiotGJ/qqvtGvHLGlnZ0RdZZngVg2wiINqUdw0sr+z6F0
         WZGkY5/asCczuyjPK5cZq+oyTOCF5yAYwyvJdaPUWSoxiYYX/ayVpXkHAoAYVDLOs8
         l1g1MyzS6uVyzWa1vlBi3hvJrmFgtGDA6zRO93Y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org
Subject: [PATCH 15/16] staging: media: imx: add proper SPDX identifiers on files that did not have them.
Date:   Tue,  2 Apr 2019 12:32:02 +0200
Message-Id: <20190402103203.14959-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few files for the imx media drivers that did not have SPDX
identifiers on them, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Cc: Steve Longerbeam <slongerbeam@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-media@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/imx/imx-ic-common.c         | 6 +-----
 drivers/staging/media/imx/imx-ic-prp.c            | 6 +-----
 drivers/staging/media/imx/imx-ic-prpencvf.c       | 6 +-----
 drivers/staging/media/imx/imx-ic.h                | 6 +-----
 drivers/staging/media/imx/imx-media-capture.c     | 6 +-----
 drivers/staging/media/imx/imx-media-csi.c         | 6 +-----
 drivers/staging/media/imx/imx-media-dev.c         | 6 +-----
 drivers/staging/media/imx/imx-media-fim.c         | 6 +-----
 drivers/staging/media/imx/imx-media-internal-sd.c | 6 +-----
 drivers/staging/media/imx/imx-media-of.c          | 6 +-----
 drivers/staging/media/imx/imx-media-utils.c       | 6 +-----
 drivers/staging/media/imx/imx-media-vdic.c        | 6 +-----
 drivers/staging/media/imx/imx-media.h             | 6 +-----
 drivers/staging/media/imx/imx6-mipi-csi2.c        | 6 +-----
 14 files changed, 14 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-common.c b/drivers/staging/media/imx/imx-ic-common.c
index 765919487a73..7e2455097315 100644
--- a/drivers/staging/media/imx/imx-ic-common.c
+++ b/drivers/staging/media/imx/imx-ic-common.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * V4L2 Image Converter Subdev for Freescale i.MX5/6 SOC
  *
  * Copyright (c) 2014-2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/staging/media/imx/imx-ic-prp.c b/drivers/staging/media/imx/imx-ic-prp.c
index 3d43cdcb4bb9..10ffe00f1a54 100644
--- a/drivers/staging/media/imx/imx-ic-prp.c
+++ b/drivers/staging/media/imx/imx-ic-prp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * V4L2 Capture IC Preprocess Subdev for Freescale i.MX5/6 SOC
  *
@@ -6,11 +7,6 @@
  * for resizing, colorspace conversion, and rotation.
  *
  * Copyright (c) 2012-2017 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 5c8e6ad8c025..1ba4a5154fb5 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * V4L2 Capture IC Preprocess Subdev for Freescale i.MX5/6 SOC
  *
@@ -6,11 +7,6 @@
  * for resizing, colorspace conversion, and rotation.
  *
  * Copyright (c) 2012-2017 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/drivers/staging/media/imx/imx-ic.h b/drivers/staging/media/imx/imx-ic.h
index 6b2267bda8ab..0dbcf2a7ab5f 100644
--- a/drivers/staging/media/imx/imx-ic.h
+++ b/drivers/staging/media/imx/imx-ic.h
@@ -1,12 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * V4L2 Image Converter Subdev for Freescale i.MX5/6 SOC
  *
  * Copyright (c) 2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #ifndef _IMX_IC_H
 #define _IMX_IC_H
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index facce18975d8..b7ce9d439279 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Video Capture Subdev for Freescale i.MX5/6 SOC
  *
  * Copyright (c) 2012-2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/delay.h>
 #include <linux/fs.h>
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 3b7517348666..edc0e9a2a90d 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * V4L2 Capture CSI Subdev for Freescale i.MX5/6 SOC
  *
  * Copyright (c) 2014-2017 Mentor Graphics Inc.
  * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/delay.h>
 #include <linux/gcd.h>
diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index 28a3d23aad5b..bd4ddea488f1 100644
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * V4L2 Media Controller Driver for Freescale i.MX5/6 SOC
  *
  * Copyright (c) 2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/delay.h>
 #include <linux/fs.h>
diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
index 8cf773eef9da..2ab64bc30f5c 100644
--- a/drivers/staging/media/imx/imx-media-fim.c
+++ b/drivers/staging/media/imx/imx-media-fim.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Frame Interval Monitor.
  *
  * Copyright (c) 2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/delay.h>
 #include <linux/irq.h>
diff --git a/drivers/staging/media/imx/imx-media-internal-sd.c b/drivers/staging/media/imx/imx-media-internal-sd.c
index 5e10d95e5529..c547280a309e 100644
--- a/drivers/staging/media/imx/imx-media-internal-sd.c
+++ b/drivers/staging/media/imx/imx-media-internal-sd.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Media driver for Freescale i.MX5/6 SOC
  *
  * Adds the internal subdevices and the media links between them.
  *
  * Copyright (c) 2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/platform_device.h>
 #include "imx-media.h"
diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
index 03446335ac03..09580d83c685 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Media driver for Freescale i.MX5/6 SOC
  *
  * Open Firmware parsing.
  *
  * Copyright (c) 2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/of_platform.h>
 #include <media/v4l2-ctrls.h>
diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 1c63a2765a81..b41842dba5ec 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * V4L2 Media Controller Driver for Freescale i.MX5/6 SOC
  *
  * Copyright (c) 2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/module.h>
 #include "imx-media.h"
diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
index 2808662e2597..3f4b5e9080d4 100644
--- a/drivers/staging/media/imx/imx-media-vdic.c
+++ b/drivers/staging/media/imx/imx-media-vdic.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * V4L2 Deinterlacer Subdev for Freescale i.MX5/6 SOC
  *
  * Copyright (c) 2017 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index ae964c8d5be1..1f7501d527fb 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -1,12 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * V4L2 Media Controller Driver for Freescale i.MX5/6 SOC
  *
  * Copyright (c) 2016 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #ifndef _IMX_MEDIA_H
 #define _IMX_MEDIA_H
diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 2c5e3dd58cea..f29e28df36ed 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * MIPI CSI-2 Receiver Subdev for Freescale i.MX6 SOC.
  *
  * Copyright (c) 2012-2017 Mentor Graphics Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 #include <linux/clk.h>
 #include <linux/interrupt.h>
-- 
2.21.0

