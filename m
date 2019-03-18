Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD73C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CF220854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfCRP5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:57:46 -0400
Received: from sauhun.de ([88.99.104.3]:36956 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfCRP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:57:40 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id 4B0914B20B8;
        Mon, 18 Mar 2019 16:57:38 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/4] mfd: da9063: convert headers to SPDX
Date:   Mon, 18 Mar 2019 16:57:24 +0100
Message-Id: <20190318155728.28365-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covnert the headers of the source and include files to SPDX.
And fix some typos in the descriptions ("interrupt" instead of "I2C").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mfd/da9063-core.c            | 8 ++------
 drivers/mfd/da9063-i2c.c             | 9 ++-------
 drivers/mfd/da9063-irq.c             | 9 ++-------
 include/linux/mfd/da9063/core.h      | 7 +------
 include/linux/mfd/da9063/registers.h | 7 +------
 5 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 6e4ce49b4405..4e5ebb7f2ef0 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- * da9063-core.c: Device access for Dialog DA9063 modules
+ * Device access for Dialog DA9063 modules
  *
  * Copyright 2012 Dialog Semiconductors Ltd.
  * Copyright 2013 Philipp Zabel, Pengutronix
@@ -7,11 +8,6 @@
  * Author: Krystian Garbaciak, Dialog Semiconductor
  * Author: Michal Hajduk, Dialog Semiconductor
  *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 50a24b1921d0..4a97ba0a35bb 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -1,15 +1,10 @@
-/* da9063-i2c.c: Interrupt support for Dialog DA9063
+// SPDX-License-Identifier: GPL-2.0+
+/* I2C support for Dialog DA9063
  *
  * Copyright 2012 Dialog Semiconductor Ltd.
  * Copyright 2013 Philipp Zabel, Pengutronix
  *
  * Author: Krystian Garbaciak, Dialog Semiconductor
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index ecc0c8ce6c58..e12b3dd0c99b 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -1,15 +1,10 @@
-/* da9063-irq.c: Interrupts support for Dialog DA9063
+// SPDX-License-Identifier: GPL-2.0+
+/* Interrupt support for Dialog DA9063
  *
  * Copyright 2012 Dialog Semiconductor Ltd.
  * Copyright 2013 Philipp Zabel, Pengutronix
  *
  * Author: Michal Hajduk, Dialog Semiconductor
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 71b09154e2db..5cd06ab26352 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Definitions for DA9063 MFD driver
  *
@@ -5,12 +6,6 @@
  *
  * Author: Michal Hajduk, Dialog Semiconductor
  * Author: Krystian Garbaciak, Dialog Semiconductor
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #ifndef __MFD_DA9063_CORE_H__
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index 5d42859cb441..272f984b766d 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Registers definition for DA9063 modules
  *
@@ -5,12 +6,6 @@
  *
  * Author: Michal Hajduk, Dialog Semiconductor
  * Author: Krystian Garbaciak, Dialog Semiconductor
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #ifndef _DA9063_REG_H
-- 
2.11.0

