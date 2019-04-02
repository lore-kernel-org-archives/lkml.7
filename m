Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEBEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783A32084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201220;
	bh=4SlOSe7Sk2HN9C1Jwnf4NILWZ/RsNV01Kv0SmrNqBbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y2CWBOCPAH74ewPMs5sWp5u8TXke2mG1XMzRRsrTTvG2f12qsWW9PgBwFsBY+/i/Z
	 /noUHbiNmAsm42NrHaaOjCmRONilllfvsST34C9li1i7W76Ao2jV0wW9a2Ph3gTzVK
	 Afj22ulrJNSslWvsmqHe7jOcAz6w/nrHGqaeC1jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfDBKdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbfDBKca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD232084C;
        Tue,  2 Apr 2019 10:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201148;
        bh=4SlOSe7Sk2HN9C1Jwnf4NILWZ/RsNV01Kv0SmrNqBbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFGoh8ChF9VrRATbA/R0TWXGpj0tRLll7lLRpnkIauRqpjD567uKjbaHZV2+BeJQe
         5oxKZ+1iTFVOVIZ8yM7Qj1fkkXuoRbWawWj/mZhCGmX+e97iJ4cVq1O5D3DF/3OS6F
         mx6dn7NtVEPuDDMwW55m7hieTfqVW5y9JOllQYXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        mjpeg-users@lists.sourceforge.net
Subject: [PATCH 13/16] staging: media: zoran: add proper SPDX identifiers on files that did not have them.
Date:   Tue,  2 Apr 2019 12:32:00 +0200
Message-Id: <20190402103203.14959-14-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few files for the zoran driver that did not have SPDX
identifiers on them, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org
Cc: mjpeg-users@lists.sourceforge.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/zoran/videocodec.h   | 17 +----------------
 drivers/staging/media/zoran/zoran.h        | 12 +-----------
 drivers/staging/media/zoran/zoran_card.c   | 12 +-----------
 drivers/staging/media/zoran/zoran_card.h   | 12 +-----------
 drivers/staging/media/zoran/zoran_device.c | 12 +-----------
 drivers/staging/media/zoran/zoran_device.h | 12 +-----------
 drivers/staging/media/zoran/zoran_driver.c | 13 +------------
 drivers/staging/media/zoran/zoran_procfs.c | 12 +-----------
 drivers/staging/media/zoran/zoran_procfs.h | 12 +-----------
 drivers/staging/media/zoran/zr36016.c      | 18 +-----------------
 drivers/staging/media/zoran/zr36016.h      | 18 +-----------------
 drivers/staging/media/zoran/zr36050.c      | 18 +-----------------
 drivers/staging/media/zoran/zr36050.h      | 18 +-----------------
 drivers/staging/media/zoran/zr36057.h      | 12 +-----------
 drivers/staging/media/zoran/zr36060.c      | 18 +-----------------
 drivers/staging/media/zoran/zr36060.h      | 18 +-----------------
 16 files changed, 16 insertions(+), 218 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
index 8ed5a0f7ac01..4946791fce0d 100644
--- a/drivers/staging/media/zoran/videocodec.h
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * VIDEO MOTION CODECs internal API for video devices
  *
@@ -5,22 +6,6 @@
  * bound to a master device.
  *
  * (c) 2002 Wolfgang Scherr <scherr@net4you.at>
- *
- * $Id: videocodec.h,v 1.1.2.4 2003/01/14 21:15:03 rbultje Exp $
- *
- * ------------------------------------------------------------------------
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
- *
- * ------------------------------------------------------------------------
  */
 
 /* =================== */
diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
index e84fb604a689..1b2e1fb3555f 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * zoran - Iomega Buz driver
  *
@@ -12,18 +13,7 @@
  * bttv - Bt848 frame grabber driver
  * Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@thp.uni-koeln.de)
  *                        & Marcus Metzler (mocm@thp.uni-koeln.de)
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
  */
-
 #ifndef _BUZ_H_
 #define _BUZ_H_
 
diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index ea10523194e8..dad5d1412033 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Zoran zr36057/zr36067 PCI controller driver, for the
  * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
@@ -11,18 +12,7 @@
  *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
  *   Laurent Pinchart <laurent.pinchart@skynet.be>
  *   Mailinglist      <mjpeg-users@lists.sf.net>
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
  */
-
 #include <linux/delay.h>
 
 #include <linux/types.h>
diff --git a/drivers/staging/media/zoran/zoran_card.h b/drivers/staging/media/zoran/zoran_card.h
index 0cdb7d34926d..600b9a3f320c 100644
--- a/drivers/staging/media/zoran/zoran_card.h
+++ b/drivers/staging/media/zoran/zoran_card.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Zoran zr36057/zr36067 PCI controller driver, for the
  * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
@@ -11,18 +12,7 @@
  *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
  *   Laurent Pinchart <laurent.pinchart@skynet.be>
  *   Mailinglist      <mjpeg-users@lists.sf.net>
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
  */
-
 #ifndef __ZORAN_CARD_H__
 #define __ZORAN_CARD_H__
 
diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
index b60c4823ce5e..2191fe69b0f9 100644
--- a/drivers/staging/media/zoran/zoran_device.c
+++ b/drivers/staging/media/zoran/zoran_device.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Zoran zr36057/zr36067 PCI controller driver, for the
  * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
@@ -11,18 +12,7 @@
  *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
  *   Laurent Pinchart <laurent.pinchart@skynet.be>
  *   Mailinglist      <mjpeg-users@lists.sf.net>
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
  */
-
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/staging/media/zoran/zoran_device.h b/drivers/staging/media/zoran/zoran_device.h
index 20bf75dfbb76..b3b8a03f2004 100644
--- a/drivers/staging/media/zoran/zoran_device.h
+++ b/drivers/staging/media/zoran/zoran_device.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Zoran zr36057/zr36067 PCI controller driver, for the
  * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
@@ -11,18 +12,7 @@
  *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
  *   Laurent Pinchart <laurent.pinchart@skynet.be>
  *   Mailinglist      <mjpeg-users@lists.sf.net>
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
  */
-
 #ifndef __ZORAN_DEVICE_H__
 #define __ZORAN_DEVICE_H__
 
diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 4c281d9a0e60..438d2d1cd1fc 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Zoran zr36057/zr36067 PCI controller driver, for the
  * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
@@ -27,19 +28,7 @@
  * bttv - Bt848 frame grabber driver
  * Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@thp.uni-koeln.de)
  *                        & Marcus Metzler (mocm@thp.uni-koeln.de)
- *
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
  */
-
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff --git a/drivers/staging/media/zoran/zoran_procfs.c b/drivers/staging/media/zoran/zoran_procfs.c
index 78ac8f853748..941f73fe323b 100644
--- a/drivers/staging/media/zoran/zoran_procfs.c
+++ b/drivers/staging/media/zoran/zoran_procfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Zoran zr36057/zr36067 PCI controller driver, for the
  * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
@@ -11,18 +12,7 @@
  *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
  *   Laurent Pinchart <laurent.pinchart@skynet.be>
  *   Mailinglist      <mjpeg-users@lists.sf.net>
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
  */
-
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/staging/media/zoran/zoran_procfs.h b/drivers/staging/media/zoran/zoran_procfs.h
index 0ac7cb0011f2..db9f642c851a 100644
--- a/drivers/staging/media/zoran/zoran_procfs.h
+++ b/drivers/staging/media/zoran/zoran_procfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Zoran zr36057/zr36067 PCI controller driver, for the
  * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
@@ -11,18 +12,7 @@
  *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
  *   Laurent Pinchart <laurent.pinchart@skynet.be>
  *   Mailinglist      <mjpeg-users@lists.sf.net>
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
  */
-
 #ifndef __ZORAN_PROCFS_H__
 #define __ZORAN_PROCFS_H__
 
diff --git a/drivers/staging/media/zoran/zr36016.c b/drivers/staging/media/zoran/zr36016.c
index 8736b9d8d97e..b300a0abe95f 100644
--- a/drivers/staging/media/zoran/zr36016.c
+++ b/drivers/staging/media/zoran/zr36016.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Zoran ZR36016 basic configuration functions
  *
  * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
- *
- * $Id: zr36016.c,v 1.1.2.14 2003/08/20 19:46:55 rbultje Exp $
- *
- * ------------------------------------------------------------------------
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
- *
- * ------------------------------------------------------------------------
  */
-
 #define ZR016_VERSION "v0.7"
 
 #include <linux/module.h>
diff --git a/drivers/staging/media/zoran/zr36016.h b/drivers/staging/media/zoran/zr36016.h
index 784bcf5727b8..6e66581c27b2 100644
--- a/drivers/staging/media/zoran/zr36016.h
+++ b/drivers/staging/media/zoran/zr36016.h
@@ -1,25 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Zoran ZR36016 basic configuration functions - header file
  *
  * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
- *
- * $Id: zr36016.h,v 1.1.2.3 2003/01/14 21:18:07 rbultje Exp $
- *
- * ------------------------------------------------------------------------
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
- *
- * ------------------------------------------------------------------------
  */
-
 #ifndef ZR36016_H
 #define ZR36016_H
 
diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
index 5ebfc16672f3..cd58307af378 100644
--- a/drivers/staging/media/zoran/zr36050.c
+++ b/drivers/staging/media/zoran/zr36050.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Zoran ZR36050 basic configuration functions
  *
  * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
- *
- * $Id: zr36050.c,v 1.1.2.11 2003/08/03 14:54:53 rbultje Exp $
- *
- * ------------------------------------------------------------------------
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
- *
- * ------------------------------------------------------------------------
  */
-
 #define ZR050_VERSION "v0.7.1"
 
 #include <linux/module.h>
diff --git a/drivers/staging/media/zoran/zr36050.h b/drivers/staging/media/zoran/zr36050.h
index 9236486d3c2b..c485913dc820 100644
--- a/drivers/staging/media/zoran/zr36050.h
+++ b/drivers/staging/media/zoran/zr36050.h
@@ -1,25 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Zoran ZR36050 basic configuration functions - header file
  *
  * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
- *
- * $Id: zr36050.h,v 1.1.2.2 2003/01/14 21:18:22 rbultje Exp $
- *
- * ------------------------------------------------------------------------
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
- *
- * ------------------------------------------------------------------------
  */
-
 #ifndef ZR36050_H
 #define ZR36050_H
 
diff --git a/drivers/staging/media/zoran/zr36057.h b/drivers/staging/media/zoran/zr36057.h
index c8acb21dcb5c..c5138cef4ef5 100644
--- a/drivers/staging/media/zoran/zr36057.h
+++ b/drivers/staging/media/zoran/zr36057.h
@@ -1,19 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * zr36057.h - zr36057 register offsets
  *
  * Copyright (C) 1998 Dave Perks <dperks@ibm.net>
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
  */
-
 #ifndef _ZR36057_H_
 #define _ZR36057_H_
 
diff --git a/drivers/staging/media/zoran/zr36060.c b/drivers/staging/media/zoran/zr36060.c
index 7ee53ba4f7fc..a3c817fd5c07 100644
--- a/drivers/staging/media/zoran/zr36060.c
+++ b/drivers/staging/media/zoran/zr36060.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Zoran ZR36060 basic configuration functions
  *
  * Copyright (C) 2002 Laurent Pinchart <laurent.pinchart@skynet.be>
- *
- * $Id: zr36060.c,v 1.1.2.22 2003/05/06 09:35:36 rbultje Exp $
- *
- * ------------------------------------------------------------------------
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
- *
- * ------------------------------------------------------------------------
  */
-
 #define ZR060_VERSION "v0.7"
 
 #include <linux/module.h>
diff --git a/drivers/staging/media/zoran/zr36060.h b/drivers/staging/media/zoran/zr36060.h
index 82911757ba78..9fa553dc475f 100644
--- a/drivers/staging/media/zoran/zr36060.h
+++ b/drivers/staging/media/zoran/zr36060.h
@@ -1,25 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Zoran ZR36060 basic configuration functions - header file
  *
  * Copyright (C) 2002 Laurent Pinchart <laurent.pinchart@skynet.be>
- *
- * $Id: zr36060.h,v 1.1.1.1.2.3 2003/01/14 21:18:47 rbultje Exp $
- *
- * ------------------------------------------------------------------------
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
- *
- * ------------------------------------------------------------------------
  */
-
 #ifndef ZR36060_H
 #define ZR36060_H
 
-- 
2.21.0

