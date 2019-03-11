Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9452087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfCKVSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:18:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:30404 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbfCKVSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:18:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 14:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="151382946"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2019 14:18:28 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 3/5] nfc/mei: convert to SPDX license tags
Date:   Tue, 12 Mar 2019 00:10:42 +0200
Message-Id: <20190311221044.17623-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311221044.17623-1-tomas.winkler@intel.com>
References: <20190311221044.17623-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace boiler plate licenses texts with the SPDX license
identifiers in the mei nfc files header.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/nfc/mei_phy.c       | 18 +++---------------
 drivers/nfc/microread/mei.c | 17 +++--------------
 drivers/nfc/pn544/mei.c     | 15 ++-------------
 3 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index 8a04c5e02999..0f43bb389566 100644
--- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -1,21 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * MEI Library for mei bus nfc device access
- *
- * Copyright (C) 2013  Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
+ * Copyright (c) 2013, Intel Corporation.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * MEI Library for mei bus nfc device access
  */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
diff --git a/drivers/nfc/microread/mei.c b/drivers/nfc/microread/mei.c
index eb5eddf1794e..5dad8847a9b3 100644
--- a/drivers/nfc/microread/mei.c
+++ b/drivers/nfc/microread/mei.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * HCI based Driver for Inside Secure microread NFC Chip
- *
- * Copyright (C) 2013  Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
+ * Copyright (C) 2013 Intel Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * HCI based Driver for Inside Secure microread NFC Chip
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/nfc/pn544/mei.c b/drivers/nfc/pn544/mei.c
index ad57a8ec00d6..579bc599f545 100644
--- a/drivers/nfc/pn544/mei.c
+++ b/drivers/nfc/pn544/mei.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * HCI based Driver for NXP pn544 NFC Chip
- *
  * Copyright (C) 2013  Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * HCI based Driver for NXP pn544 NFC Chip
  */
 
 #include <linux/module.h>
-- 
2.20.1

