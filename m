Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8533EC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6573620843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfFDPVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:21:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43070 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfFDPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:20:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 216FE285369
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org
Subject: [PATCH 07/10] mfd: cros_ec: Update with SPDX Licence identifier and fix description
Date:   Tue,  4 Jun 2019 17:20:16 +0200
Message-Id: <20190604152019.16100-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604152019.16100-1-enric.balletbo@collabora.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update with SPDX Licence identifier to remove the licence boiler plate
and fix description to be more clear on what's about this driver and to
avoid confusions.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/cros_ec_dev.c   |  4 ++--
 include/linux/mfd/cros_ec.h | 12 ++----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 5481df4e1216..658622807b41 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * cros_ec_dev - expose the Chrome OS Embedded Controller to user-space
+ * ChromeOS Embedded Controller multifunction device
  *
  * Copyright (C) 2014 Google, Inc.
  */
@@ -403,6 +403,6 @@ module_exit(cros_ec_dev_exit);
 
 MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Bill Richardson <wfrichar@chromium.org>");
-MODULE_DESCRIPTION("Userspace interface to the Chrome OS Embedded Controller");
+MODULE_DESCRIPTION("ChromeOS Embedded Controller multifunction device");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index e0bae49535e1..dd09e56b6350 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * ChromeOS EC multi-function device
+ * ChromeOS Embedded Controller multifunction device
  *
  * Copyright (C) 2012 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __LINUX_MFD_CROS_EC_H
-- 
2.20.1

