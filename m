Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8534C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972292177E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554211941;
	bh=96TlRmx1G9sHfEYGnaVbbDrvStiHSsGVwEaArd+JkQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QuFAJyM1a/ZzHNiynM9RtKFMwc0qvZXusCrzYe/9yOqfNwgIE9894dpeZ2nHOhHAk
	 tFQ1o9WTlskI4c+4EFoFA/93ENdWME24DIP9UIhgC9pyUmSt/qg9FC5wPmtVeC1PL1
	 dPHNJOZMnARW+bo9pCd4OgOq7Vp0SY0oMXk4ZWZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfDBNcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730762AbfDBNcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:32:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3F220883;
        Tue,  2 Apr 2019 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554211937;
        bh=96TlRmx1G9sHfEYGnaVbbDrvStiHSsGVwEaArd+JkQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XG+NrNm0+krIN6uWmaUHzOujhMpW49ke016DCcnesQJ8sZxzQrXlbaem0vosL0vp2
         1aOJl2t/zUSvYNizzWK8ysKycHqZ91rz8DqKvsjPVT9oN0r2fhL4URMh72O4vlU3iK
         tJrhXh7I902asb00JjidfbFDj4nH7bpWHbX6Yhsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/4] drivers: base: power: add proper SPDX identifiers on files that did not have them.
Date:   Tue,  2 Apr 2019 15:32:01 +0200
Message-Id: <20190402133203.5463-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402133203.5463-1-gregkh@linuxfoundation.org>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few files in the driver core power code that did not have
SPDX identifiers on them, so fix that up.  At the same time, remove the
"free form" text that specified the license of the file, as that is
impossible for any tool to properly parse.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/clock_ops.c       |  3 +--
 drivers/base/power/common.c          |  4 +---
 drivers/base/power/domain.c          |  4 +---
 drivers/base/power/domain_governor.c |  4 +---
 drivers/base/power/generic_ops.c     |  4 +---
 drivers/base/power/main.c            |  4 +---
 drivers/base/power/qos.c             |  6 +-----
 drivers/base/power/runtime.c         |  4 +---
 drivers/base/power/sysfs.c           |  6 ++----
 drivers/base/power/trace.c           |  2 +-
 drivers/base/power/wakeirq.c         | 15 ++-------------
 drivers/base/power/wakeup.c          |  4 +---
 12 files changed, 14 insertions(+), 46 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 365ad751ce0f..59d19dd64928 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/clock_ops.c - Generic clock manipulation PM callbacks
  *
  * Copyright (c) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
- *
- * This file is released under the GPLv2.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 22aedb28aad7..8db98a1f83dc 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/common.c - Common device power management code.
  *
  * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
- *
- * This file is released under the GPLv2.
  */
-
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/export.h>
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 96a6dc9d305c..c98ac27d6443 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/domain.c - Common code related to device power domains.
  *
  * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
- *
- * This file is released under the GPLv2.
  */
-
 #define pr_fmt(fmt) "PM: " fmt
 
 #include <linux/delay.h>
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 4d07e38a8247..35925b174d0d 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/domain_governor.c - Governors for device PM domains.
  *
  * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
- *
- * This file is released under the GPLv2.
  */
-
 #include <linux/kernel.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index b2ed606265a8..4fa525668cb7 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/generic_ops.c - Generic PM callbacks for subsystems
  *
  * Copyright (c) 2010 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
- *
- * This file is released under the GPLv2.
  */
-
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/export.h>
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f80d298de3fa..bd5bb5a09723 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/main.c - Where the driver meets power management.
  *
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  *
- * This file is released under the GPLv2
- *
- *
  * The driver model core calls device_pm_add() when a device is registered.
  * This will initialize the embedded device_pm_info object in the device
  * and add it to the list of power-controlled devices. sysfs entries for
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index f80e402ef778..6c91f8df1d59 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Devices PM QoS constraints management
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *
  * This module exposes the interface to kernel space for specifying
  * per-device PM QoS dependencies. It provides infrastructure for registration
  * of:
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 977db40378b0..952a1e7057c7 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/runtime.c - Helper functions for device runtime PM
  *
  * Copyright (c) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  * Copyright (C) 2010 Alan Stern <stern@rowland.harvard.edu>
- *
- * This file is released under the GPLv2.
  */
-
 #include <linux/sched/mm.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 1226e441ddfe..1b9c281cbe41 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -1,7 +1,5 @@
-/*
- * drivers/base/power/sysfs.c - sysfs entries for device PM
- */
-
+// SPDX-License-Identifier: GPL-2.0
+/* sysfs entries for device PM */
 #include <linux/device.h>
 #include <linux/string.h>
 #include <linux/export.h>
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 2bd9d2c744ca..977d27bd1a22 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/trace.c
  *
@@ -6,7 +7,6 @@
  * Trace facility for suspend/resume problems, when none of the
  * devices may be working.
  */
-
 #define pr_fmt(fmt) "PM: " fmt
 
 #include <linux/pm-trace.h>
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index b8fa5c0f2d13..5ce77d1ef9fc 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -1,16 +1,5 @@
-/*
- * wakeirq.c - Device wakeirq helper functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
+// SPDX-License-Identifier: GPL-2.0
+/* Device wakeirq helper functions */
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index bb1ae175fae1..9066b2dfc3e1 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/base/power/wakeup.c - System wakeup events framework
  *
  * Copyright (c) 2010 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
- *
- * This file is released under the GPLv2.
  */
-
 #define pr_fmt(fmt) "PM: " fmt
 
 #include <linux/device.h>
-- 
2.21.0

