Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D54BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84012084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201186;
	bh=jBtHIEdVQ8IAyQFEaqyHxk2V5r4gmiegc9UTj9j2l/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jl034mG+iVq8vWrOmbPA4bXDG/W0o/5Vg7Am4Tr/F6+ov35AygDcE1ffz/mS89UMV
	 JMXioo019ubLvoDdUShziw/CAxQ2R4cZ5NyLqAJB9HDj0zLCr5+T3j60ptD5nV3KGQ
	 +vc8SPOTqRP57SijpvODectLr415TbCTTbCVsFPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfDBKdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730498AbfDBKc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA79D2147C;
        Tue,  2 Apr 2019 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201177;
        bh=jBtHIEdVQ8IAyQFEaqyHxk2V5r4gmiegc9UTj9j2l/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NK+wl3hWkPF9NK4KcssM8YsYi1MBm0DQ+KXIgGu+wRzMfHeNITTZkHBDBrNumDzgP
         t+l4ZkZ1NJijW0vLPQvIl3t3b69Lnir+PKy1Ohorsc4AcAAbV7lBXhZYrKIV4e056r
         k+3tYjwd+Ei38D4VoP1Jj7TMhuyUC2nJOUmbk6w0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Bhanusree Pola <bhanusreemahesh@gmail.com>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 09/16] staging: rtl8192u: add proper SPDX identifiers on files that did not have them.
Date:   Tue,  2 Apr 2019 12:31:56 +0200
Message-Id: <20190402103203.14959-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few files for the rtl8192u driver that did not have SPDX
identifiers on them, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Cc: John Whitmore <johnfwhitmore@gmail.com>
Cc: Bhanusree Pola <bhanusreemahesh@gmail.com>
Cc: Sanjana Sanikommu <sanjana99reddy99@gmail.com>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h  |  6 +-----
 .../rtl8192u/ieee80211/ieee80211_crypt.c        |  7 +------
 .../rtl8192u/ieee80211/ieee80211_crypt.h        |  6 +-----
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c   |  6 +-----
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c   |  6 +-----
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c    |  6 +-----
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c   |  6 +-----
 .../rtl8192u/ieee80211/ieee80211_softmac.c      |  3 +--
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c   |  3 +--
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c   | 17 +----------------
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c   | 17 +----------------
 drivers/staging/rtl8192u/r8180_93cx6.c          |  2 +-
 drivers/staging/rtl8192u/r8190_rtl8256.c        |  2 +-
 drivers/staging/rtl8192u/r8192U_core.c          | 16 +---------------
 drivers/staging/rtl8192u/r8192U_hw.h            |  2 +-
 drivers/staging/rtl8192u/r8192U_wx.c            |  2 +-
 drivers/staging/rtl8192u/r8192U_wx.h            |  2 +-
 17 files changed, 17 insertions(+), 92 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 638cad6df1c4..d36963469015 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Merged with mainline ieee80211.h in Aug 2004.  Original ieee802_11
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
 #ifndef IEEE80211_H
 #define IEEE80211_H
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
index 6f457812e5a3..36987fccac5d 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Host AP crypto routines
  *
  * Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
  * Portions Copyright (C) 2004, Intel Corporation <jketreno@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. See README and COPYING for
- * more details.
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.h b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.h
index 1f2aea7e0e55..d3bd5598b25b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Original code based on Host AP (software wireless LAN access point) driver
  * for Intersil Prism2/2.5/3.
@@ -10,11 +11,6 @@
  * <jketreno@linux.intel.com>
  *
  * Copyright (c) 2004, Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. See README and COPYING for
- * more details.
  */
 
 /*
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index 3534ddb900d1..f2d64ab563c3 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Host AP crypt: host-based CCMP encryption implementation for Host AP driver
  *
  * Copyright (c) 2003-2004, Jouni Malinen <jkmaline@cc.hut.fi>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. See README and COPYING for
- * more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index 829fa4bd253c..d260b47d9f04 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
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
 
 #include <linux/module.h>
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
index d4a1bf0caa7a..805493a0870d 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
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
 
 #include <linux/module.h>
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index b7316b21565f..23e9cf35b601 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Original code based Host AP (software wireless LAN access point) driver
  * for Intersil Prism2/2.5/3 - hostap.o module, common routines
@@ -6,11 +7,6 @@
  * <jkmaline@cc.hut.fi>
  * Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
  * Copyright (c) 2004, Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. See README and COPYING for
- * more details.
  ******************************************************************************
 
   Few modifications for Realtek's Wi-Fi drivers by
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 8635faf84316..944c8894f9ff 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* IEEE 802.11 SoftMAC layer
  * Copyright (c) 2005 Andrea Merello <andrea.merello@gmail.com>
  *
@@ -9,8 +10,6 @@
  *
  * WPA code stolen from the ipw2200 driver.
  * Copyright who own it's copyright.
- *
- * released under the GPL
  */
 #include "ieee80211.h"
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
index 81020fbcdc20..aab1586fe0dd 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* IEEE 802.11 SoftMAC layer
  * Copyright (c) 2005 Andrea Merello <andrea.merello@gmail.com>
  *
@@ -9,8 +10,6 @@
  *
  * PS wx handler mostly stolen from hostap, copyright who
  * own it's copyright ;-)
- *
- * released under the GPL
  */
 
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index 29ee9fd89f7b..8e1ec4409b4f 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -1,23 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  *
  *  Copyright(c) 2003 - 2004 Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of version 2 of the GNU General Public License as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- *  more details.
- *
- *  You should have received a copy of the GNU General Public License along with
- *  this program; if not, write to the Free Software Foundation, Inc., 59
- *  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
- *  The full GNU General Public License is included in this distribution in the
- *  file called LICENSE.
- *
  *  Contact Information:
  *  James P. Ketrenos <ipw2100-admin@linux.intel.com>
  *  Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index ebcc642e0215..90c7ab2189cc 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
 
   Copyright(c) 2004 Intel Corporation. All rights reserved.
@@ -8,22 +9,6 @@
   <jkmaline@cc.hut.fi>
   Copyright (c) 2002-2003, Jouni Malinen <jkmaline@cc.hut.fi>
 
-  This program is free software; you can redistribute it and/or modify it
-  under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but WITHOUT
-  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-  more details.
-
-  You should have received a copy of the GNU General Public License along with
-  this program; if not, write to the Free Software Foundation, Inc., 59
-  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
-
-  The full GNU General Public License is included in this distribution in the
-  file called LICENSE.
-
   Contact Information:
   James P. Ketrenos <ipw2100-admin@linux.intel.com>
   Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
diff --git a/drivers/staging/rtl8192u/r8180_93cx6.c b/drivers/staging/rtl8192u/r8180_93cx6.c
index f98bb11a66af..de83daa0c9ed 100644
--- a/drivers/staging/rtl8192u/r8180_93cx6.c
+++ b/drivers/staging/rtl8192u/r8180_93cx6.c
@@ -1,10 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  This files contains card eeprom (93c46 or 93c56) programming routines,
  *  memory is addressed by 16 bits words.
  *
  *  This is part of rtl8180 OpenSource driver.
  *  Copyright (C) Andrea Merello 2004  <andrea.merello@gmail.com>
- *  Released under the terms of GPL (General Public Licence)
  *
  *  Parts of this driver are based on the GPL part of the
  *  official realtek driver.
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index a8c8e8c0660d..92de92a3325a 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This is part of the rtl8192 driver
- * released under the GPL (See file COPYING for details).
  *
  * This files contains programming code for the rtl8256
  * radio frontend.
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index f1eaab337dca..4065a4710142 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192U
  *
  * Based on the r8187 driver, which is:
  * Copyright 2004-2005 Andrea Merello <andrea.merello@gmail.com>, et al.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
  *
  * Contact Information:
  * Jerry chuang <wlanfae@realtek.com>
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 5a958335681d..95a2d2ee3c65 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *	This is part of rtl8187 OpenSource driver.
  *	Copyright (C) Andrea Merello 2004-2005  <andrea.merello@gmail.com>
- *	Released under the terms of GPL (General Public Licence)
  *
  *	Parts of this driver are based on the GPL part of the
  *	official Realtek driver.
diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index e4e6c979bedf..5822bb7984b9 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -1,10 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
  *
  * This file contains wireless extension handlers.
  *
  * This is part of rtl8180 OpenSource driver.
  * Copyright (C) Andrea Merello 2004-2005  <andrea.merello@gmail.com>
- * Released under the terms of GPL (General Public Licence)
  *
  * Parts of this driver are based on the GPL part
  * of the official realtek driver.
diff --git a/drivers/staging/rtl8192u/r8192U_wx.h b/drivers/staging/rtl8192u/r8192U_wx.h
index a6c2b95e2e69..27423cd64b4c 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.h
+++ b/drivers/staging/rtl8192u/r8192U_wx.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This is part of rtl8180 OpenSource driver - v 0.3
  * Copyright (C) Andrea Merello 2004  <andrea.merello@gmail.com>
- * Released under the terms of GPL (General Public Licence)
  *
  * Parts of this driver are based on the GPL part of the official realtek driver
  * Parts of this driver are based on the rtl8180 driver skeleton from Patric
-- 
2.21.0

