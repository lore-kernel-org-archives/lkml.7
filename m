Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9995AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B719214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725058;
	bh=uTIwEdgyb3IU7x4fcazRcrtwOt5N/Q8uJWHzk3qCr6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RyagMBY2IinbP1bUMWPRlUWCJnwlxkEcqR7XGN1y44JUOYDl2DbUF2GM+5g9Ttawv
	 6gX4I54V/xsHnG1JqaIMJ6JPi5R9XezfXAWmtQvLuBFKczMF+bgrdwLbpeTMphpNdI
	 FOVUtBRn+A7NbgGrv0Ubi3aCZ+BoFsm2FTbECTt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfF1Ma4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:30:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfF1Map (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=elXp1aRzWl/H7rMMwgQt+6149bGjSIsrRSI9clCQq8s=; b=GNsqzjL07ulC+4iwMZEDlhTiew
        XY32uik+FfWmbVpMOqQi8oM0EYIfR8lET3XaUnbyOE4vPCLp5+YaoO+uAci65sf7m91HCZ0+jOWrx
        FVOX6qweQzlJ8psZtO1NV8ih3YZvyp7oTQU0Api0OkCmokV6NXI7jsjGINatWdKSKJI2xZE51eLk+
        O8Fl+LtlO38KS5ZGyzoWm2EKfXgydGz3Ki/ykDat+2arGmtH/BSRjFXvvOgkcV21bE1Diwc9Zly87
        5u3OQkbP8o5R7KunLFbFwdZidEAy9et7YcDJlfjmUAY3JPWrDX1RCtb26OnJ7n0uyGQgIabBnjKjR
        mrayjqLg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1V-00055v-0o; Fri, 28 Jun 2019 12:30:37 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005To-SY; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        drbd-dev@lists.linbit.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 36/39] docs: add SPDX tags to new index files
Date:   Fri, 28 Jun 2019 09:30:29 -0300
Message-Id: <d3cd5d1309647bd16b3590419e7a2387eaf24bad.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All those new files I added are under GPL v2.0 license.

Add the corresponding SPDX headers to them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/blockdev/drbd/figures.rst | 2 ++
 Documentation/admin-guide/blockdev/index.rst        | 2 ++
 Documentation/admin-guide/laptops/index.rst         | 1 +
 Documentation/admin-guide/namespaces/index.rst      | 2 ++
 Documentation/admin-guide/perf/index.rst            | 2 ++
 Documentation/arm/index.rst                         | 2 ++
 Documentation/arm/nwfpe/index.rst                   | 2 ++
 Documentation/arm/omap/index.rst                    | 2 ++
 Documentation/arm/sa1100/index.rst                  | 2 ++
 Documentation/arm/samsung-s3c24xx/index.rst         | 2 ++
 Documentation/arm/samsung/index.rst                 | 2 ++
 Documentation/driver-api/early-userspace/index.rst  | 2 ++
 Documentation/driver-api/md/index.rst               | 2 ++
 Documentation/driver-api/memory-devices/index.rst   | 2 ++
 Documentation/driver-api/mmc/index.rst              | 2 ++
 Documentation/driver-api/mtd/index.rst              | 2 ++
 Documentation/driver-api/nfc/index.rst              | 2 ++
 Documentation/driver-api/nvdimm/index.rst           | 2 ++
 Documentation/driver-api/phy/index.rst              | 2 ++
 Documentation/driver-api/rapidio/index.rst          | 2 ++
 Documentation/driver-api/thermal/index.rst          | 2 ++
 Documentation/ia64/index.rst                        | 2 ++
 22 files changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/drbd/figures.rst b/Documentation/admin-guide/blockdev/drbd/figures.rst
index 3e3fd4b8a478..bd9a4901fe46 100644
--- a/Documentation/admin-guide/blockdev/drbd/figures.rst
+++ b/Documentation/admin-guide/blockdev/drbd/figures.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. The here included files are intended to help understand the implementation
 
 Data flows that Relate some functions, and write packets
diff --git a/Documentation/admin-guide/blockdev/index.rst b/Documentation/admin-guide/blockdev/index.rst
index 20a738d9d047..b903cf152091 100644
--- a/Documentation/admin-guide/blockdev/index.rst
+++ b/Documentation/admin-guide/blockdev/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========================
 The Linux RapidIO Subsystem
 ===========================
diff --git a/Documentation/admin-guide/laptops/index.rst b/Documentation/admin-guide/laptops/index.rst
index 6b554e39863b..cd9a1c2695fd 100644
--- a/Documentation/admin-guide/laptops/index.rst
+++ b/Documentation/admin-guide/laptops/index.rst
@@ -1,3 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0
 
 ==============
 Laptop Drivers
diff --git a/Documentation/admin-guide/namespaces/index.rst b/Documentation/admin-guide/namespaces/index.rst
index 713ec4949fa7..384f2e0f33d2 100644
--- a/Documentation/admin-guide/namespaces/index.rst
+++ b/Documentation/admin-guide/namespaces/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==========
 Namespaces
 ==========
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 9d445451ea18..ee4bfd2a740f 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========================
 Performance monitor support
 ===========================
diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index 9c2f781f4685..5fc072dd0c5e 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ================
 ARM Architecture
 ================
diff --git a/Documentation/arm/nwfpe/index.rst b/Documentation/arm/nwfpe/index.rst
index 21fa8ce192ae..3c4d2f9aa10e 100644
--- a/Documentation/arm/nwfpe/index.rst
+++ b/Documentation/arm/nwfpe/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================================
 NetWinder's floating point emulator
 ===================================
diff --git a/Documentation/arm/omap/index.rst b/Documentation/arm/omap/index.rst
index f1e9c11d9f9b..8b365b212e49 100644
--- a/Documentation/arm/omap/index.rst
+++ b/Documentation/arm/omap/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =======
 TI OMAP
 =======
diff --git a/Documentation/arm/sa1100/index.rst b/Documentation/arm/sa1100/index.rst
index fb2385b3accf..68c2a280a745 100644
--- a/Documentation/arm/sa1100/index.rst
+++ b/Documentation/arm/sa1100/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ====================
 Intel StrongARM 1100
 ====================
diff --git a/Documentation/arm/samsung-s3c24xx/index.rst b/Documentation/arm/samsung-s3c24xx/index.rst
index 6c7b241cbf37..5b8a7f9398d8 100644
--- a/Documentation/arm/samsung-s3c24xx/index.rst
+++ b/Documentation/arm/samsung-s3c24xx/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ﻿==========================
 Samsung S3C24XX SoC Family
 ==========================
diff --git a/Documentation/arm/samsung/index.rst b/Documentation/arm/samsung/index.rst
index f54d95734362..8142cce3d23e 100644
--- a/Documentation/arm/samsung/index.rst
+++ b/Documentation/arm/samsung/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========
 Samsung SoC
 ===========
diff --git a/Documentation/driver-api/early-userspace/index.rst b/Documentation/driver-api/early-userspace/index.rst
index 6f20c3c560d8..149c1822f06d 100644
--- a/Documentation/driver-api/early-userspace/index.rst
+++ b/Documentation/driver-api/early-userspace/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============
 Early Userspace
 ===============
diff --git a/Documentation/driver-api/md/index.rst b/Documentation/driver-api/md/index.rst
index 205080891a1a..18f54a7d7d6e 100644
--- a/Documentation/driver-api/md/index.rst
+++ b/Documentation/driver-api/md/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ====
 RAID
 ====
diff --git a/Documentation/driver-api/memory-devices/index.rst b/Documentation/driver-api/memory-devices/index.rst
index 87549828f6ab..28101458cda5 100644
--- a/Documentation/driver-api/memory-devices/index.rst
+++ b/Documentation/driver-api/memory-devices/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =========================
 Memory Controller drivers
 =========================
diff --git a/Documentation/driver-api/mmc/index.rst b/Documentation/driver-api/mmc/index.rst
index 9aaf64951a8c..7339736ac774 100644
--- a/Documentation/driver-api/mmc/index.rst
+++ b/Documentation/driver-api/mmc/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ========================
 MMC/SD/SDIO card support
 ========================
diff --git a/Documentation/driver-api/mtd/index.rst b/Documentation/driver-api/mtd/index.rst
index 2e0e7cc4055e..436ba5a851d7 100644
--- a/Documentation/driver-api/mtd/index.rst
+++ b/Documentation/driver-api/mtd/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============================
 Memory Technology Device (MTD)
 ==============================
diff --git a/Documentation/driver-api/nfc/index.rst b/Documentation/driver-api/nfc/index.rst
index 3afb2c0c2e3c..b6e9eedbff29 100644
--- a/Documentation/driver-api/nfc/index.rst
+++ b/Documentation/driver-api/nfc/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ========================
 Near Field Communication
 ========================
diff --git a/Documentation/driver-api/nvdimm/index.rst b/Documentation/driver-api/nvdimm/index.rst
index 19dc8ee371dc..a4f8f98aeb94 100644
--- a/Documentation/driver-api/nvdimm/index.rst
+++ b/Documentation/driver-api/nvdimm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================================
 Non-Volatile Memory Device (NVDIMM)
 ===================================
diff --git a/Documentation/driver-api/phy/index.rst b/Documentation/driver-api/phy/index.rst
index fce9ffae2812..69ba1216de72 100644
--- a/Documentation/driver-api/phy/index.rst
+++ b/Documentation/driver-api/phy/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =====================
 Generic PHY Framework
 =====================
diff --git a/Documentation/driver-api/rapidio/index.rst b/Documentation/driver-api/rapidio/index.rst
index 4c5e51a05134..a41b4242d16f 100644
--- a/Documentation/driver-api/rapidio/index.rst
+++ b/Documentation/driver-api/rapidio/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========================
 The Linux RapidIO Subsystem
 ===========================
diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index 68ceb6886561..5ba61d19c6ae 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =======
 Thermal
 =======
diff --git a/Documentation/ia64/index.rst b/Documentation/ia64/index.rst
index ef99475f672b..0436e1034115 100644
--- a/Documentation/ia64/index.rst
+++ b/Documentation/ia64/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==================
 IA-64 Architecture
 ==================
-- 
2.21.0

