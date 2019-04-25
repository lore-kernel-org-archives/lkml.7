Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0567AC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1020E20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220463;
	bh=7zaHMpFvzdfAJedQih+4GJzqbFLpLYnJP0h2U17SoXA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0OVLNR1i5DeA92kyRN0oDy+Epmcl5s2b/QXE8DHT56ClL9mVAQ63r24wGWId0BkLj
	 KMSvLDskF1XElrPmfja2H1sRJC/C74mkaFfZ2x6VuVF11b8R9qOfzm9CYzbJfQfg42
	 1rS5fTKk5hc1xHS9ZyWfkpgOAHgY9Is1oLXXtcMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfDYT1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:27:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52434 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfDYT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eymhM/QjBk+uV0rS+9duOTLFjE7MvaW67Ovfry8MXAs=; b=rq7xLiPwIyHl
        iK2ikI9sWpJLOzWsqdLA5SJVR9kW+1bpFpOvvTtac3hlhk/+DxDoInaTOR9YTNUeFmeWOWNQ2jOiC
        kLVeF48A4IHrp1iDkxJ4YKqRQcv0xFJI/3maXUWsIIzl9fkBHN0XeRcWMHOZ7IrXoutLvClIdLbgl
        NNi5Q=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJk0w-0004dZ-Fz; Thu, 25 Apr 2019 19:26:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8EE75441D3B; Thu, 25 Apr 2019 20:26:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add proper SPDX identifiers on files that did not have them." to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190425192633.8EE75441D3B@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:26:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: add proper SPDX identifiers on files that did not have them.

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 37613fa5b762a73073de3c2e23baa4a1da337e71 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 25 Apr 2019 20:06:18 +0200
Subject: [PATCH] regmap: add proper SPDX identifiers on files that did not
 have them.

There were a few files in the regmap code that did not have SPDX
identifiers on them, so fix that up.  At the same time, remove the "free
form" text that specified the license of the file, as that is impossible
for any tool to properly parse.

Also, as Mark loves // comment markers, convert all of the headers to be
the same to make things look consistent :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
index fc45c2bb961a..263f82516ff4 100644
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
index 42d8404bc8cc..f1025452bb39 100644
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
2.20.1

