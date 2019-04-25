Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87DAC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBE020693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556219092;
	bh=injq/jFTUuegdqfvUZ2YrGjKmvBPlbIHU8O5MYWDxPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JmvRrsclPNdudls1UjUj/SVs3LNOg+V2y5jL3FJ0Z/Oh3nu4LNTTSjTCLlDsn3X1K
	 yUNrIbh06G3z+9CLBKk9AG+bUvDdiTpXXkaKJ/FCqHTN3WSFS2kGyRQLkgN1bL7J1O
	 ixD+opD7DedlhRT9ZKNJf1L4MohIz1ridgY2emDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfDYTEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfDYTEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:04:48 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 192CF20693;
        Thu, 25 Apr 2019 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556219087;
        bh=injq/jFTUuegdqfvUZ2YrGjKmvBPlbIHU8O5MYWDxPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xDNQphtDSzD/wDaQ0VJJM/BzzvX90ySJgVtMqDCXnSSfJTUTC/xQsq4towNm7928c
         PYIWYmREyIjoZcd6smB3XxqGsAdmj5BDf2kDxKr5mA8gC8aQWOJk1E9IXbY4r5IOJ+
         mVv7qP/GKIlOonGPJm5vhsYyrLvERmbSuRAAWXHk=
Date:   Thu, 25 Apr 2019 21:04:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3] regmap: add proper SPDX identifiers on files that did not
 have them.
Message-ID: <20190425190444.GC22421@kroah.com>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402133203.5463-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few files in the regmap code that did not have SPDX
identifiers on them, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Also, as Mark loves // comment markers, convert all of the headers to be
the same to make things look consistent :)

Cc: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3: drop "drivers: base:" from the subject: line
v2: make the whole header of the .c files use // markers as per Mark's
    request.

 drivers/base/regmap/internal.h        |  5 +----
 drivers/base/regmap/regcache-flat.c   | 18 +++++++----------
 drivers/base/regmap/regcache-lzo.c    | 18 +++++++----------
 drivers/base/regmap/regcache-rbtree.c | 18 +++++++----------
 drivers/base/regmap/regcache.c        | 18 +++++++----------
 drivers/base/regmap/regmap-ac97.c     | 22 +++++---------------
 drivers/base/regmap/regmap-debugfs.c  | 18 +++++++----------
 drivers/base/regmap/regmap-i2c.c      | 18 +++++++----------
 drivers/base/regmap/regmap-irq.c      | 18 +++++++----------
 drivers/base/regmap/regmap-mmio.c     | 22 +++++---------------
 drivers/base/regmap/regmap-spi.c      | 18 +++++++----------
 drivers/base/regmap/regmap-spmi.c     | 29 +++++++++------------------
 drivers/base/regmap/regmap-w1.c       | 16 ++++++---------
 drivers/base/regmap/regmap.c          | 18 +++++++----------
 14 files changed, 90 insertions(+), 166 deletions(-)

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
index bc6cd88b8cc6..b7e4b2464102 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -1,14 +1,10 @@
-/*
- * Register cache access API - flat caching support
- *
- * Copyright 2012 Wolfson Microelectronics plc
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register cache access API - flat caching support
+//
+// Copyright 2012 Wolfson Microelectronics plc
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/device.h>
 #include <linux/seq_file.h>
diff --git a/drivers/base/regmap/regcache-lzo.c b/drivers/base/regmap/regcache-lzo.c
index 4ff311374c4a..fc14e8b9344f 100644
--- a/drivers/base/regmap/regcache-lzo.c
+++ b/drivers/base/regmap/regcache-lzo.c
@@ -1,14 +1,10 @@
-/*
- * Register cache access API - LZO caching support
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *
- * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register cache access API - LZO caching support
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//
+// Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
 
 #include <linux/device.h>
 #include <linux/lzo.h>
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 9cbb4b0cd01b..cfa29dc89bbf 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -1,14 +1,10 @@
-/*
- * Register cache access API - rbtree caching support
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *
- * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register cache access API - rbtree caching support
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//
+// Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 773560348337..a93cafd7be4f 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -1,14 +1,10 @@
-/*
- * Register cache access API
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *
- * Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register cache access API
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//
+// Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
 
 #include <linux/bsearch.h>
 #include <linux/device.h>
diff --git a/drivers/base/regmap/regmap-ac97.c b/drivers/base/regmap/regmap-ac97.c
index c03ebfd4c731..b9f76bdf74a9 100644
--- a/drivers/base/regmap/regmap-ac97.c
+++ b/drivers/base/regmap/regmap-ac97.c
@@ -1,20 +1,8 @@
-/*
- * Register map access API - AC'97 support
- *
- * Copyright 2013 Linaro Ltd.  All rights reserved.
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
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - AC'97 support
+//
+// Copyright 2013 Linaro Ltd.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/err.h>
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 19eb454f26c3..bc20eaae683c 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -1,14 +1,10 @@
-/*
- * Register map access API - debugfs
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - debugfs
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/slab.h>
 #include <linux/mutex.h>
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 056acde5e7d3..ac9b31c57967 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -1,14 +1,10 @@
-/*
- * Register map access API - I2C support
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - I2C support
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/regmap.h>
 #include <linux/i2c.h>
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 5059748afd4c..c4dcfca01faa 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -1,14 +1,10 @@
-/*
- * regmap based irq_chip
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// regmap based irq_chip
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/device.h>
 #include <linux/export.h>
diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 8741fb5f8f54..af967d8f975e 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -1,20 +1,8 @@
-/*
- * Register map access API - MMIO support
- *
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
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
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - MMIO support
+//
+// Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/err.h>
diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index c7150dd264d5..c1894e93c378 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -1,14 +1,10 @@
-/*
- * Register map access API - SPI support
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - SPI support
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
diff --git a/drivers/base/regmap/regmap-spmi.c b/drivers/base/regmap/regmap-spmi.c
index 0bfb8ed244d5..cdf12d2aa3a1 100644
--- a/drivers/base/regmap/regmap-spmi.c
+++ b/drivers/base/regmap/regmap-spmi.c
@@ -1,22 +1,13 @@
-/*
- * Register map access API - SPMI support
- *
- * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
- *
- * Based on regmap-i2c.c:
- * Copyright 2011 Wolfson Microelectronics plc
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
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
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - SPMI support
+//
+// Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+//
+// Based on regmap-i2c.c:
+// Copyright 2011 Wolfson Microelectronics plc
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+
 #include <linux/regmap.h>
 #include <linux/spmi.h>
 #include <linux/module.h>
diff --git a/drivers/base/regmap/regmap-w1.c b/drivers/base/regmap/regmap-w1.c
index e6c64b0be5b2..3a7d30b8c3ac 100644
--- a/drivers/base/regmap/regmap-w1.c
+++ b/drivers/base/regmap/regmap-w1.c
@@ -1,13 +1,9 @@
-/*
- * Register map access API - W1 (1-Wire) support
- *
- * Copyright (c) 2017 Radioavionica Corporation
- * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API - W1 (1-Wire) support
+//
+// Copyright (c) 2017 Radioavionica Corporation
+// Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
 
 #include <linux/regmap.h>
 #include <linux/module.h>
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4f822e087def..92a07e079c43 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1,14 +1,10 @@
-/*
- * Register map access API
- *
- * Copyright 2011 Wolfson Microelectronics plc
- *
- * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Register map access API
+//
+// Copyright 2011 Wolfson Microelectronics plc
+//
+// Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
 #include <linux/device.h>
 #include <linux/slab.h>
-- 
2.21.0

