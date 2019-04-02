Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E97C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6AE20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554211934;
	bh=1ggbgC4j7sDA9wgW3Rknp37rzQIUTYlMYumXZqqGFEE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=slvF7ReffJEJDV8YRItF6gduLpytHNSEdm8ZD7swkaXjOF9N4uhGg3470+ygaSy90
	 8sXs0V8afie+PGA1FV8fMNvekoeZcpTh+3TAEQFVY173HdB7WE0/dncALLwIMGnipL
	 XgK+1psM+eaTj0zQgg07YYNCI+BSwP9DKChLrFWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfDBNcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731322AbfDBNcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:32:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A0120883;
        Tue,  2 Apr 2019 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554211929;
        bh=1ggbgC4j7sDA9wgW3Rknp37rzQIUTYlMYumXZqqGFEE=;
        h=From:To:Cc:Subject:Date:From;
        b=ejqFDN5TW7j7Z441Tnd4oQbi9XGqTxty8iGizlbfNzG3+rPJEK+v+oyWxToJ/HRLY
         bA4Lxgcm3ClIe3i/dHOEtymOsjdTXRpeNZuG6sDTV/wsH+6C+ZR95rD67nFWx1kpwJ
         M4zZMJqvmO1r9ZkOtqNn+63Rhmr3noUVDBRz8FGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/4] drivers: base: regmap: add proper SPDX identifiers on files that did not have them.
Date:   Tue,  2 Apr 2019 15:32:00 +0200
Message-Id: <20190402133203.5463-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few files in the regmap code that did not have SPDX
identifiers on them, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Cc: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/internal.h        |  5 +----
 drivers/base/regmap/regcache-flat.c   |  5 +----
 drivers/base/regmap/regcache-lzo.c    |  5 +----
 drivers/base/regmap/regcache-rbtree.c |  5 +----
 drivers/base/regmap/regcache.c        |  5 +----
 drivers/base/regmap/regmap-ac97.c     | 13 +------------
 drivers/base/regmap/regmap-debugfs.c  |  5 +----
 drivers/base/regmap/regmap-i2c.c      |  5 +----
 drivers/base/regmap/regmap-irq.c      |  5 +----
 drivers/base/regmap/regmap-mmio.c     | 13 +------------
 drivers/base/regmap/regmap-spi.c      |  5 +----
 drivers/base/regmap/regmap-spmi.c     | 11 +----------
 drivers/base/regmap/regmap-w1.c       |  5 +----
 drivers/base/regmap/regmap.c          |  5 +----
 14 files changed, 14 insertions(+), 78 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a98fced9bff8..3d80c4b43f72 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Register map access API internal header
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _REGMAP_INTERNAL_H
diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index bc6cd88b8cc6..4f3d1d714a65 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register cache access API - flat caching support
  *
  * Copyright 2012 Wolfson Microelectronics plc
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/device.h>
diff --git a/drivers/base/regmap/regcache-lzo.c b/drivers/base/regmap/regcache-lzo.c
index 4ff311374c4a..60e605de7d68 100644
--- a/drivers/base/regmap/regcache-lzo.c
+++ b/drivers/base/regmap/regcache-lzo.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register cache access API - LZO caching support
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/device.h>
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 9cbb4b0cd01b..eb593764eab5 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register cache access API - rbtree caching support
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/debugfs.h>
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 773560348337..5d3a86479083 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register cache access API
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/bsearch.h>
diff --git a/drivers/base/regmap/regmap-ac97.c b/drivers/base/regmap/regmap-ac97.c
index c03ebfd4c731..8cfff2953b47 100644
--- a/drivers/base/regmap/regmap-ac97.c
+++ b/drivers/base/regmap/regmap-ac97.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register map access API - AC'97 support
  *
  * Copyright 2013 Linaro Ltd.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 19eb454f26c3..98c398a20f97 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register map access API - debugfs
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/slab.h>
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 056acde5e7d3..e9401bb2e7c1 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register map access API - I2C support
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/regmap.h>
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 5059748afd4c..80bbe3fa0235 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * regmap based irq_chip
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/device.h>
diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 8741fb5f8f54..77efe0ed1ad0 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register map access API - MMIO support
  *
  * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index c7150dd264d5..3d87c477332b 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register map access API - SPI support
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/regmap.h>
diff --git a/drivers/base/regmap/regmap-spmi.c b/drivers/base/regmap/regmap-spmi.c
index 0bfb8ed244d5..678ded44cbe6 100644
--- a/drivers/base/regmap/regmap-spmi.c
+++ b/drivers/base/regmap/regmap-spmi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register map access API - SPMI support
  *
@@ -6,16 +7,6 @@
  * Based on regmap-i2c.c:
  * Copyright 2011 Wolfson Microelectronics plc
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 #include <linux/regmap.h>
 #include <linux/spmi.h>
diff --git a/drivers/base/regmap/regmap-w1.c b/drivers/base/regmap/regmap-w1.c
index e6c64b0be5b2..8c10be9e8889 100644
--- a/drivers/base/regmap/regmap-w1.c
+++ b/drivers/base/regmap/regmap-w1.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register map access API - W1 (1-Wire) support
  *
  * Copyright (c) 2017 Radioavionica Corporation
  * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation
  */
 
 #include <linux/regmap.h>
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4f822e087def..771d5d0a1e9a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Register map access API
  *
  * Copyright 2011 Wolfson Microelectronics plc
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/device.h>
-- 
2.21.0

