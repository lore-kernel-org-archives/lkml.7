Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AD7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A7C2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfCKVSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:18:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:30404 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbfCKVSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:18:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 14:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="151382999"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2019 14:18:32 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 5/5] mei: adjust the copyright notice in the files.
Date:   Tue, 12 Mar 2019 00:10:44 +0200
Message-Id: <20190311221044.17623-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311221044.17623-1-tomas.winkler@intel.com>
References: <20190311221044.17623-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unified version of the copyright notice in the files
Update copyright years according the year the files
were touched, except this patch and SPDX conversions.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/Kconfig       | 1 +
 drivers/misc/mei/Makefile      | 2 +-
 drivers/misc/mei/bus-fixup.c   | 2 +-
 drivers/misc/mei/bus.c         | 2 +-
 drivers/misc/mei/client.c      | 2 +-
 drivers/misc/mei/client.h      | 2 +-
 drivers/misc/mei/debugfs.c     | 2 +-
 drivers/misc/mei/dma-ring.c    | 2 +-
 drivers/misc/mei/hbm.c         | 2 +-
 drivers/misc/mei/hbm.h         | 2 +-
 drivers/misc/mei/hdcp/Makefile | 2 +-
 drivers/misc/mei/hw-me-regs.h  | 2 +-
 drivers/misc/mei/hw-me.c       | 2 +-
 drivers/misc/mei/hw-me.h       | 2 +-
 drivers/misc/mei/hw-txe-regs.h | 2 +-
 drivers/misc/mei/hw-txe.c      | 2 +-
 drivers/misc/mei/hw-txe.h      | 2 +-
 drivers/misc/mei/hw.h          | 2 +-
 drivers/misc/mei/init.c        | 2 +-
 drivers/misc/mei/interrupt.c   | 2 +-
 drivers/misc/mei/main.c        | 2 +-
 drivers/misc/mei/mei-trace.c   | 2 +-
 drivers/misc/mei/mei-trace.h   | 2 +-
 drivers/misc/mei/mei_dev.h     | 2 +-
 drivers/misc/mei/pci-me.c      | 2 +-
 drivers/misc/mei/pci-txe.c     | 2 +-
 include/linux/mei_cl_bus.h     | 3 +++
 include/uapi/linux/mei.h       | 2 +-
 28 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 998fb4ae9791..132b07151f42 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
 config INTEL_MEI
 	tristate "Intel Management Engine Interface"
 	depends on X86 && PCI
diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
index 8c2d9565a4cb..f1c76f7ee804 100644
--- a/drivers/misc/mei/Makefile
+++ b/drivers/misc/mei/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
+# Copyright (c) 2010-2019, Intel Corporation. All rights reserved.
 # Makefile - Intel Management Engine Interface (Intel MEI) Linux driver
-# Copyright (c) 2010-2014, Intel Corporation.
 #
 obj-$(CONFIG_INTEL_MEI) += mei.o
 mei-objs := init.o
diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index c839bdf453d8..32e9b1aed2ca 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2013-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2018, Intel Corporation.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index e6788fbd611c..985bd4fd3328 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2012-2013, Intel Corporation.
  */
 
 #include <linux/module.h>
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 306b5fdeaf9c..88b83c4bc5b7 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #include <linux/sched/signal.h>
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index a0e2ec2ed7ab..c1f9e810cf81 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #ifndef _MEI_CLIENT_H_
diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 3b2dd5a1be06..0970142bcace 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2012-2016, Intel Corporation. All rights reserved
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2012-2013, Intel Corporation.
  */
 
 #include <linux/slab.h>
diff --git a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
index 795641b82181..ef56f849b251 100644
--- a/drivers/misc/mei/dma-ring.c
+++ b/drivers/misc/mei/dma-ring.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved.
+ * Copyright(c) 2016-2018 Intel Corporation. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include <linux/mei.h>
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index dfc21787d978..a44094cdbc36 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 #include <linux/export.h>
 #include <linux/sched.h>
diff --git a/drivers/misc/mei/hbm.h b/drivers/misc/mei/hbm.h
index 1e33359f27f0..5aa58cffdd2e 100644
--- a/drivers/misc/mei/hbm.h
+++ b/drivers/misc/mei/hbm.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #ifndef _MEI_HBM_H_
diff --git a/drivers/misc/mei/hdcp/Makefile b/drivers/misc/mei/hdcp/Makefile
index adbe7506282d..3fbb56485ce8 100644
--- a/drivers/misc/mei/hdcp/Makefile
+++ b/drivers/misc/mei/hdcp/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Copyright (c) 2019, Intel Corporation.
+# Copyright (c) 2019, Intel Corporation. All rights reserved.
 #
 # Makefile - HDCP client driver for Intel MEI Bus Driver.
 
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 535eb63a9dee..d74b182e19f3 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
+ * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
  */
 #ifndef _MEI_HW_MEI_REGS_H_
 #define _MEI_HW_MEI_REGS_H_
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index ea1cd7043323..de21e3083526 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #include <linux/pci.h>
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index e1c1b4e18f3c..08c84a0de4a8 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (c) 2012-2018, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #ifndef _MEI_INTERFACE_H_
diff --git a/drivers/misc/mei/hw-txe-regs.h b/drivers/misc/mei/hw-txe-regs.h
index d71798cb6272..a92b306dac8b 100644
--- a/drivers/misc/mei/hw-txe-regs.h
+++ b/drivers/misc/mei/hw-txe-regs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
+ * Copyright (c) 2013-2014, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
  */
 #ifndef _MEI_HW_TXE_REGS_H_
 #define _MEI_HW_TXE_REGS_H_
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index c99a5360df27..5e58656b8e19 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2013-2014, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2013-2014, Intel Corporation.
  */
 
 #include <linux/pci.h>
diff --git a/drivers/misc/mei/hw-txe.h b/drivers/misc/mei/hw-txe.h
index b82dd5cb4a78..96511b04bf88 100644
--- a/drivers/misc/mei/hw-txe.h
+++ b/drivers/misc/mei/hw-txe.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (c) 2013-2016, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2013-2014, Intel Corporation.
  */
 
 #ifndef _MEI_HW_TXE_H_
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index a4c16eaad1fb..d025a5f8317e 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (c) 2003-2018, Intel Corporation. All rights reserved
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #ifndef _MEI_HW_TYPES_H_
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 0d719f3b941f..cc359ae968ce 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2012-2018, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #include <linux/export.h>
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 5385293b973e..c70a8c74cc57 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #include <linux/export.h>
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index e796f149b6a5..b454df214dde 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2018, Intel Corporation.
  */
 
 #include <linux/module.h>
diff --git a/drivers/misc/mei/mei-trace.c b/drivers/misc/mei/mei-trace.c
index 32ee5d3d856c..48d4c4fcefd2 100644
--- a/drivers/misc/mei/mei-trace.c
+++ b/drivers/misc/mei/mei-trace.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2015-2016, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2015, Intel Corporation.
  */
 #include <linux/module.h>
 
diff --git a/drivers/misc/mei/mei-trace.h b/drivers/misc/mei/mei-trace.h
index 9883bd8ece26..df758033dc93 100644
--- a/drivers/misc/mei/mei-trace.h
+++ b/drivers/misc/mei/mei-trace.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (c) 2015-2016, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2015, Intel Corporation.
  */
 
 #if !defined(_MEI_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 3b45f12229e0..3146df37ffb0 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2018, Intel Corporation.
  */
 
 #ifndef _MEI_DEV_H_
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 723f9a8fb53d..7a2b3545a7f9 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
  */
 
 #include <linux/module.h>
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index 1e3dd806c483..2e37fc2e0fa8 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2013-2017, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2013-2014, Intel Corporation.
  */
 
 #include <linux/module.h>
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index 03b6ba2a63f8..52aa4821093a 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2013-2016, Intel Corporation. All rights reserved.
+ */
 #ifndef _LINUX_MEI_CL_BUS_H
 #define _LINUX_MEI_CL_BUS_H
 
diff --git a/include/uapi/linux/mei.h b/include/uapi/linux/mei.h
index 1b932cad61b4..c6aec86cc5de 100644
--- a/include/uapi/linux/mei.h
+++ b/include/uapi/linux/mei.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
+ * Copyright(c) 2003-2015 Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Intel MEI Interface Header
- * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
  */
 #ifndef _LINUX_MEI_H
 #define _LINUX_MEI_H
-- 
2.20.1

