Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8ABC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471292147A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201149;
	bh=hBm57Xew89RWN8jIR/QamUgYHH5TuIeK6aoC3BYwizQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zk0/S/F19OHDe6hbfACFxborqlOhdnIx1jsMwHZGM5ejU/tqxqk4haEwZATWHcTnW
	 HlZCGUh5bzO1nvnAloNPHuqP1I0LVfBM9eR7OAqIFaaqqpbIKadWfjvP1ENARk3/yT
	 Cwmt+8YLlpNxHJiAiDbm/JcdajqJ5RJRQywyFAhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfDBKc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbfDBKcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE25B2084C;
        Tue,  2 Apr 2019 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201143;
        bh=hBm57Xew89RWN8jIR/QamUgYHH5TuIeK6aoC3BYwizQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2PZpvrVYCM3X6/Pxc1rnGUNYyz/J+XMZQXux+/oZfs4TBdnykVZW4kgFrsRo23rd
         sJrb5Nz6BjSWOukaUwV82VOu0ldATXajqWCpOsiLXu2MlmaE/pZD291LauBmVfepac
         fne6JmGvoLG293nzLs9sSMsFsbAaqQHWz1BjIGXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/16] staging: rtl8192e: add proper SPDX identifiers on files that did not have them.
Date:   Tue,  2 Apr 2019 12:31:58 +0200
Message-Id: <20190402103203.14959-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few files for the rtl8192e driver that did not have SPDX
identifiers on them, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../staging/rtl8192e/rtl8192e/r8190P_def.h    | 18 ++++-----------
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        | 17 ++++----------
 .../rtl8192e/rtl8192e/r8190P_rtl8256.h        | 17 ++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c | 17 ++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h | 16 ++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 19 ++++------------
 .../staging/rtl8192e/rtl8192e/r8192E_dev.h    | 22 ++++---------------
 .../rtl8192e/rtl8192e/r8192E_firmware.c       | 17 ++++----------
 .../rtl8192e/rtl8192e/r8192E_firmware.h       | 16 ++++----------
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 18 ++++-----------
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.c  | 18 ++++-----------
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  | 16 ++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 17 ++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 16 ++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 16 ++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   | 19 ++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h   | 19 ++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 19 ++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  | 20 ++++-------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 16 ++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    | 16 ++++----------
 .../staging/rtl8192e/rtl8192e/rtl_eeprom.c    | 19 ++++------------
 .../staging/rtl8192e/rtl8192e/rtl_eeprom.h    | 21 ++++--------------
 .../staging/rtl8192e/rtl8192e/rtl_ethtool.c   | 18 +++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c   | 19 ++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h   | 19 ++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c    | 17 ++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.h    | 17 ++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    | 19 ++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.h    | 19 ++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 17 ++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.h    | 17 ++++----------
 drivers/staging/rtl8192e/rtl819x_BA.h         | 16 ++++----------
 drivers/staging/rtl8192e/rtl819x_BAProc.c     | 16 ++++----------
 drivers/staging/rtl8192e/rtl819x_HT.h         | 16 ++++----------
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 16 ++++----------
 drivers/staging/rtl8192e/rtl819x_Qos.h        | 16 ++++----------
 drivers/staging/rtl8192e/rtl819x_TS.h         | 16 ++++----------
 drivers/staging/rtl8192e/rtl819x_TSProc.c     | 16 ++++----------
 drivers/staging/rtl8192e/rtllib.h             |  6 +----
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |  6 +----
 drivers/staging/rtl8192e/rtllib_crypt_wep.c   |  6 +----
 drivers/staging/rtl8192e/rtllib_debug.h       | 22 ++++---------------
 drivers/staging/rtl8192e/rtllib_module.c      | 19 +++-------------
 drivers/staging/rtl8192e/rtllib_rx.c          | 20 +++++------------
 drivers/staging/rtl8192e/rtllib_softmac.c     |  5 +----
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  5 +----
 drivers/staging/rtl8192e/rtllib_tx.c          | 22 +++----------------
 drivers/staging/rtl8192e/rtllib_wx.c          | 19 +++-------------
 49 files changed, 179 insertions(+), 634 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 03421033d14a..53fd79a28189 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -1,19 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef R8190P_DEF_H
 #define R8190P_DEF_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 85f93056d28b..7876b389913a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -1,18 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_core.h"
 #include "r8192E_phyreg.h"
 #include "r8192E_phy.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
index bbea13b452b2..4cb483f1a152 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
@@ -1,18 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef RTL8225H
 #define RTL8225H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index 467287ae6c1c..fece982475e8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -1,18 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_core.h"
 #include "r8192E_hw.h"
 #include "r8192E_cmdpkt.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h
index a8c63ad2ac2e..c63909199e93 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef R819XUSB_CMDPKT_H
 #define R819XUSB_CMDPKT_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f70d65e3d64b..0353f7ee5341 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1,23 +1,12 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_core.h"
 #include "r8192E_phy.h"
 #include "r8192E_phyreg.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
index f4233bb12f81..1713381dc2b4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
@@ -1,23 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * Based on the r8180 driver, which is:
- * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _RTL8192E_H
 #define _RTL8192E_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
index 3c7831250987..9b025b9fa7ab 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
@@ -1,18 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_core.h"
 #include "r8192E_hw.h"
 #include "r8192E_hwimg.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.h
index 61c8dac826a8..b9059abc901b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef __INC_FIRMWARE_H
 #define __INC_FIRMWARE_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 5c20cb476281..3e223151d4b7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -1,19 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef R8180_HW
 #define R8180_HW
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
index d437a8efe933..e6fce749e65b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
@@ -1,19 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-/*Created on  2008/11/18,  3: 7*/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "r8192E_hwimg.h"
 
 u32 Rtl8192PciEPHY_REGArray[PHY_REGArrayLengthPciE] = {0x0,};
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
index 4e2bbab6a413..7d63f5a5c1b7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef __INC_HAL8192PciE_FW_IMG_H
 #define __INC_HAL8192PciE_FW_IMG_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 5603570f6dda..5d2f86afb24b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1,18 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include <linux/bitops.h>
 #include "rtl_core.h"
 #include "r8192E_hw.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index b534d72bf708..7c9148e033d8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _R819XU_PHY_H
 #define _R819XU_PHY_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
index 03d6d70b2d28..433272a2aae8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _R819XU_PHYREG_H
 #define _R819XU_PHYREG_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index c62481fcf0b1..627ea1029509 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -1,23 +1,12 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_core.h"
 #include "r8192E_phy.h"
 #include "r8192E_phyreg.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
index 12f01f196752..1ebd92e27441 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
@@ -1,23 +1,12 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _RTL_CAM_H
 #define _RTL_CAM_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 253f1911a3f4..f932cb15e4e5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1,23 +1,12 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include <linux/uaccess.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 866fe4d4cb28..736f1a824cd2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -1,24 +1,12 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _RTL_CORE_H
 #define _RTL_CORE_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 157bcee34067..55d857926bba 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1,17 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_core.h"
 #include "rtl_dm.h"
 #include "r8192E_hw.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 52a4a1522bae..ea1b14bbcdcd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef	__R8192UDM_H__
 #define __R8192UDM_H__
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c b/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
index e1d305d4fa20..59532ed2156d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
@@ -1,23 +1,12 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_core.h"
 #include "rtl_eeprom.h"
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h b/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h
index 6212e5eadede..66f1979bb1d5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h
@@ -1,25 +1,12 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #define EPROM_DELAY 10
 
 u32 rtl92e_eeprom_read(struct net_device *dev, u32 addr);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
index f172f776245d..6ae7a67e767f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
@@ -1,23 +1,11 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************
+ * Contact Information: wlanfae <wlanfae@realtek.com>
  */
 #include <linux/netdevice.h>
 #include <linux/ethtool.h>
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
index 2ff52e7dd32f..bab41ab7c0a5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
@@ -1,23 +1,12 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_pci.h"
 #include "rtl_core.h"
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
index 73d357d530d0..866e0efbc4fd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
@@ -1,23 +1,12 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- ******************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _RTL_PCI_H
 #define _RTL_PCI_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
index 81a68b0b4a7f..cd3e17b41d6f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
@@ -1,18 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_core.h"
 #include "r8192E_hw.h"
 #include "r8190P_rtl8256.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.h
index 03fe79ff5a1b..e58f2bcdb1dd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.h
@@ -1,18 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef R8192E_PM_H
 #define R8192E_PM_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 9281116366d2..9475f8c6edf7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -1,23 +1,12 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtl_ps.h"
 #include "rtl_core.h"
 #include "r8192E_phy.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.h b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.h
index a46f4cffca23..70fe5d39be9a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.h
@@ -1,23 +1,12 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * Based on the r8180 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- ******************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _RTL_PS_H
 #define _RTL_PS_H
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 44e06cba7b7b..16bcee13f64b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -1,18 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include <linux/string.h>
 #include "rtl_core.h"
 #include "rtl_wx.h"
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.h b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.h
index c313fb79de4d..d70a747ac1dd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.h
@@ -1,18 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
-
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef R819x_WX_H
 #define R819x_WX_H
 
diff --git a/drivers/staging/rtl8192e/rtl819x_BA.h b/drivers/staging/rtl8192e/rtl819x_BA.h
index 978c9a54043e..8b6e4c26f0fb 100644
--- a/drivers/staging/rtl8192e/rtl819x_BA.h
+++ b/drivers/staging/rtl8192e/rtl819x_BA.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _BATYPE_H_
 #define _BATYPE_H_
 
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 2d330d2bbf6d..816d31c1d5c7 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -1,17 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- ******************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 #include <linux/etherdevice.h>
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 24e86620c94c..11269fe6b395 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _RTL819XU_HTTYPE_H_
 #define _RTL819XU_HTTYPE_H_
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f0e11726a72a..f02263af9624 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -1,17 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- ******************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtllib.h"
 #include "rtl819x_HT.h"
 u8 MCS_FILTER_ALL[16] = {
diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 576241233a35..5073f9f40fdc 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef __INC_QOS_TYPE_H
 #define __INC_QOS_TYPE_H
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 654c223030e3..9dc93d41939d 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -1,17 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _TSTYPE_H_
 #define _TSTYPE_H_
 #include "rtl819x_Qos.h"
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index f839d2447b85..672bf0987943 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -1,17 +1,9 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- ******************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #include "rtllib.h"
 #include <linux/etherdevice.h>
 #include "rtl819x_TS.h"
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 61ebd12831c3..2dd57e88276e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Merged with mainline rtllib.h in Aug 2004.  Original ieee802_11
  * remains copyright by the original authors
@@ -15,11 +16,6 @@
  *
  * Modified for Realtek's wi-fi cards by Andrea Merello
  * <andrea.merello@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. See README and COPYING for
- * more details.
  */
 #ifndef RTLLIB_H
 #define RTLLIB_H
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 55da8c9dfe50..25fa1eb677a6 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Host AP crypt: host-based TKIP encryption implementation for Host AP driver
  *
  * Copyright (c) 2003-2004, Jouni Malinen <jkmaline@cc.hut.fi>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. See README and COPYING for
- * more details.
  */
 
 #include <crypto/hash.h>
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index d11ec39171d5..b1ea650036d2 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Host AP crypt: host-based WEP encryption implementation for Host AP driver
  *
  * Copyright (c) 2002-2004, Jouni Malinen <jkmaline@cc.hut.fi>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. See README and COPYING for
- * more details.
  */
 
 #include <crypto/skcipher.h>
diff --git a/drivers/staging/rtl8192e/rtllib_debug.h b/drivers/staging/rtl8192e/rtllib_debug.h
index 7b0e6e9c4456..9065901636f5 100644
--- a/drivers/staging/rtl8192e/rtllib_debug.h
+++ b/drivers/staging/rtl8192e/rtllib_debug.h
@@ -1,23 +1,9 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * Based on the r8180 driver, which is:
- * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- *****************************************************************************/
+ * Contact Information: wlanfae <wlanfae@realtek.com>
+ */
 #ifndef _RTL_DEBUG_H
 #define _RTL_DEBUG_H
 
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index cdf4c9060c51..265ad437ae2e 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -1,5 +1,5 @@
-/*******************************************************************************
- *
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2004 Intel Corporation. All rights reserved.
  *
  * Portions of this file are based on the WEP enablement code provided by the
@@ -8,23 +8,10 @@
  * <jkmaline@cc.hut.fi>
  * Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
  * Contact Information:
  * James P. Ketrenos <ipw2100-admin@linux.intel.com>
  * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
- ******************************************************************************/
+ */
 
 #include <linux/compiler.h>
 #include <linux/errno.h>
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index debc2e40af00..0c19ac2bc3bf 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Original code based Host AP (software wireless LAN access point) driver
  * for Intersil Prism2/2.5/3 - hostap.o module, common routines
@@ -7,20 +8,11 @@
  * Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
  * Copyright (c) 2004, Intel Corporation
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. See README and COPYING for
- * more details.
- ******************************************************************************
-
-  Few modifications for Realtek's Wi-Fi drivers by
-  Andrea Merello <andrea.merello@gmail.com>
-
-  A special thanks goes to Realtek for their support !
-
-******************************************************************************/
-
-
+ * Few modifications for Realtek's Wi-Fi drivers by
+ * Andrea Merello <andrea.merello@gmail.com>
+ *
+ * A special thanks goes to Realtek for their support !
+ */
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/if_arp.h>
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ee275857868f..e29e8d6f4611 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* IEEE 802.11 SoftMAC layer
  * Copyright (c) 2005 Andrea Merello <andrea.merello@gmail.com>
  *
@@ -9,11 +10,7 @@
  *
  * WPA code stolen from the ipw2200 driver.
  * Copyright who own it's copyright.
- *
- * released under the GPL
  */
-
-
 #include "rtllib.h"
 
 #include <linux/random.h>
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 5f1412fc410d..f89799d43b1b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* IEEE 802.11 SoftMAC layer
  * Copyright (c) 2005 Andrea Merello <andrea.merello@gmail.com>
  *
@@ -9,11 +10,7 @@
  *
  * PS wx handler mostly stolen from hostap, copyright who
  * own it's copyright ;-)
- *
- * released under the GPL
  */
-
-
 #include <linux/etherdevice.h>
 
 #include "rtllib.h"
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index d314b2f602e4..8cddb2e12dc4 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -1,32 +1,16 @@
-/******************************************************************************
- *
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2003 - 2004 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
  * Contact Information:
  * James P. Ketrenos <ipw2100-admin@linux.intel.com>
  * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *
- *****************************************************************************
- *
  * Few modifications for Realtek's Wi-Fi drivers by
  * Andrea Merello <andrea.merello@gmail.com>
  *
  * A special thanks goes to Realtek for their support !
- *
- *****************************************************************************/
-
+ */
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/if_arp.h>
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 4f4904a300e0..beb40967936a 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -1,5 +1,5 @@
-/******************************************************************************
- *
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright(c) 2004 Intel Corporation. All rights reserved.
  *
  * Portions of this file are based on the WEP enablement code provided by the
@@ -8,23 +8,10 @@
  * <jkmaline@cc.hut.fi>
  * Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
  * Contact Information:
  * James P. Ketrenos <ipw2100-admin@linux.intel.com>
  * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
- *****************************************************************************/
+ */
 #include <linux/wireless.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
-- 
2.21.0

