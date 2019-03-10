Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE4BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E93520657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 09:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbfCJJLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 05:11:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:48893 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfCJJLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 05:11:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2019 01:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,463,1544515200"; 
   d="scan'208";a="325851862"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2019 01:11:09 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc] mei: convert to SPDX license tags
Date:   Sun, 10 Mar 2019 12:03:23 +0200
Message-Id: <20190310100323.6912-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/Kconfig         |  1 +
 drivers/misc/mei/Makefile        |  2 +-
 drivers/misc/mei/bus-fixup.c     | 13 +-----
 drivers/misc/mei/bus.c           | 14 ++-----
 drivers/misc/mei/client.c        | 13 +-----
 drivers/misc/mei/client.h        | 13 +-----
 drivers/misc/mei/debugfs.c       | 14 ++-----
 drivers/misc/mei/dma-ring.c      |  5 ++-
 drivers/misc/mei/hbm.c           | 13 +-----
 drivers/misc/mei/hbm.h           | 13 +-----
 drivers/misc/mei/hdcp/mei_hdcp.c |  2 +-
 drivers/misc/mei/hdcp/mei_hdcp.h |  2 +-
 drivers/misc/mei/hw-me-regs.h    | 70 +++-----------------------------
 drivers/misc/mei/hw-me.c         | 13 +-----
 drivers/misc/mei/hw-me.h         | 15 +------
 drivers/misc/mei/hw-txe-regs.h   | 65 +++--------------------------
 drivers/misc/mei/hw-txe.c        | 13 +-----
 drivers/misc/mei/hw-txe.h        | 13 +-----
 drivers/misc/mei/hw.h            | 13 +-----
 drivers/misc/mei/init.c          | 13 +-----
 drivers/misc/mei/interrupt.c     | 14 +------
 drivers/misc/mei/main.c          | 14 ++-----
 drivers/misc/mei/mei-trace.c     | 14 ++-----
 drivers/misc/mei/mei-trace.h     | 13 +-----
 drivers/misc/mei/mei_dev.h       | 14 ++-----
 drivers/misc/mei/pci-me.c        | 14 ++-----
 drivers/misc/mei/pci-txe.c       | 13 +-----
 include/linux/mei_cl_bus.h       |  6 +++
 include/uapi/linux/mei.h         | 70 ++------------------------------
 29 files changed, 75 insertions(+), 417 deletions(-)

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 74e2c667dce0..998fb4ae9791 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config INTEL_MEI
 	tristate "Intel Management Engine Interface"
 	depends on X86 && PCI
diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
index 8c2d9565a4cb..68b6e72c777f 100644
--- a/drivers/misc/mei/Makefile
+++ b/drivers/misc/mei/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile - Intel Management Engine Interface (Intel MEI) Linux driver
-# Copyright (c) 2010-2014, Intel Corporation.
+# Copyright (c) 2010-2019, Intel Corporation.
 #
 obj-$(CONFIG_INTEL_MEI) += mei.o
 mei-objs := init.o
diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 5fcac02233af..465612fea5bb 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2018, Intel Corporation.
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
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 65bec998eb6e..bbdb0e4f48de 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2012-2013, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
+ * Copyright(c) 2012-2019, Intel Corporation. All rights reserved.
  *
+ * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
 #include <linux/module.h>
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index ca4c9cc218a2..81db5a536d06 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
 #include <linux/sched/signal.h>
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index 64e318f589b4..e0df59a9690c 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
 #ifndef _MEI_CLIENT_H_
diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 7b5df8fd6c5a..96dcb2bbb056 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2012-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2012-2013, Intel Corporation.
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
  */
+
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
diff --git a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
index 795641b82181..346453f44bc5 100644
--- a/drivers/misc/mei/dma-ring.c
+++ b/drivers/misc/mei/dma-ring.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved.
+ * Copyright(c) 2016-2019, Intel Corporation. All rights reserved.
+ *
+ * Intel Management Engine Interface (Intel MEI) Linux driver
  */
+
 #include <linux/dma-mapping.h>
 #include <linux/mei.h>
 
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index e6207f614816..2104403b5938 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
 #include <linux/export.h>
diff --git a/drivers/misc/mei/hbm.h b/drivers/misc/mei/hbm.h
index 0171a7e79bab..a0eeb4aa871a 100644
--- a/drivers/misc/mei/hbm.h
+++ b/drivers/misc/mei/hbm.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
 #ifndef _MEI_HBM_H_
diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index 90b6ae8e9dae..b07000202d4a 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0)
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright © 2019 Intel Corporation
  *
diff --git a/drivers/misc/mei/hdcp/mei_hdcp.h b/drivers/misc/mei/hdcp/mei_hdcp.h
index 5f74b908e486..e4b1cd54c853 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.h
+++ b/drivers/misc/mei/hdcp/mei_hdcp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+) */
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright © 2019 Intel Corporation
  *
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index bb1ee9834a02..6e0a5bb12f53 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -1,68 +1,8 @@
-/******************************************************************************
- * Intel Management Engine Interface (Intel MEI) Linux driver
- * Intel MEI Interface Header
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110,
- * USA
- *
- * The full GNU General Public License is included in this distribution
- * in the file called LICENSE.GPL.
- *
- * Contact Information:
- *	Intel Corporation.
- *	linux-mei@linux.intel.com
- *	http://www.intel.com
- *
- * BSD LICENSE
- *
- * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  * Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  * Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  * Neither the name Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *****************************************************************************/
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
+ */
+
 #ifndef _MEI_HW_MEI_REGS_H_
 #define _MEI_HW_MEI_REGS_H_
 
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 3fbbadfa2ae1..5e6a40e05b75 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
 #include <linux/pci.h>
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index bbcc5fc106cd..3d86b660ee44 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -1,21 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
-
-
 #ifndef _MEI_INTERFACE_H_
 #define _MEI_INTERFACE_H_
 
diff --git a/drivers/misc/mei/hw-txe-regs.h b/drivers/misc/mei/hw-txe-regs.h
index f19229c4e655..1bf7b2f3a12e 100644
--- a/drivers/misc/mei/hw-txe-regs.h
+++ b/drivers/misc/mei/hw-txe-regs.h
@@ -1,63 +1,10 @@
-/******************************************************************************
- * Intel Management Engine Interface (Intel MEI) Linux driver
- * Intel MEI Interface Header
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING
- *
- * Contact Information:
- *	Intel Corporation.
- *	linux-mei@linux.intel.com
- *	http://www.intel.com
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2013-2019, Intel Corporation. All rights reserved.
  *
- * BSD LICENSE
- *
- * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  * Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  * Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  * Neither the name Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *****************************************************************************/
+ * Intel Management Engine Interface (Intel MEI) Linux driver
+ */
+
 #ifndef _MEI_HW_TXE_REGS_H_
 #define _MEI_HW_TXE_REGS_H_
 
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 8449fe0367ff..4e857ce3d3e4 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2013-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2013-2014, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
  */
 
 #include <linux/pci.h>
diff --git a/drivers/misc/mei/hw-txe.h b/drivers/misc/mei/hw-txe.h
index e1e8b66d7648..a83b371d0f8d 100644
--- a/drivers/misc/mei/hw-txe.h
+++ b/drivers/misc/mei/hw-txe.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright(c) 2013-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2013-2014, Intel Corporation.
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
  */
 
 #ifndef _MEI_HW_TXE_H_
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b7d2487b8409..9d6d6da2fb53 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
+ * Copyright(c) 2003-2013, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
 #ifndef _MEI_HW_TYPES_H_
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index eb026e2a0537..c9652ab9ea7d 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
 #include <linux/export.h>
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 055c2d89b310..baf19cb80924 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -1,20 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
 
-
 #include <linux/export.h>
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 87281b3695e6..8d4a068e4690 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2018, Intel Corporation.
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
  */
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
diff --git a/drivers/misc/mei/mei-trace.c b/drivers/misc/mei/mei-trace.c
index 374edde72a14..483a40dd0739 100644
--- a/drivers/misc/mei/mei-trace.c
+++ b/drivers/misc/mei/mei-trace.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2015-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2015, Intel Corporation.
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
  */
+
 #include <linux/module.h>
 
 /* sparse doesn't like tracepoint macros */
diff --git a/drivers/misc/mei/mei-trace.h b/drivers/misc/mei/mei-trace.h
index b52e9b97a7c0..87a1604438fe 100644
--- a/drivers/misc/mei/mei-trace.h
+++ b/drivers/misc/mei/mei-trace.h
@@ -1,17 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright(c) 2015-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2015, Intel Corporation.
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
  */
 
 #if !defined(_MEI_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 685b78ce30a5..9f5367c79731 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -1,17 +1,9 @@
 /*
+ * SPDX-License-Identifier: GPL-2.0
  *
- * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2018, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
+ * Copyright(c) 2003-2018, Intel Corporation. All rights reserved.
  *
+ * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
 #ifndef _MEI_DEV_H_
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 3ab946ad3257..1f6d7bde9419 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2003-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
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
  */
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index e1b909123fb0..49ac5382ca2e 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright(c) 2013-2019, Intel Corporation. All rights reserved.
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2013-2014, Intel Corporation.
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
  */
 
 #include <linux/module.h>
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index 03b6ba2a63f8..8e8856625158 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -1,4 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2013-2019, Intel Corporation. All rights reserved.
+ *
+ * Intel Management Engine Interface (Intel MEI) Linux driver
+ */
+
 #ifndef _LINUX_MEI_CL_BUS_H
 #define _LINUX_MEI_CL_BUS_H
 
diff --git a/include/uapi/linux/mei.h b/include/uapi/linux/mei.h
index 0f681cbd38d3..4a8c9fde1185 100644
--- a/include/uapi/linux/mei.h
+++ b/include/uapi/linux/mei.h
@@ -1,69 +1,7 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-/******************************************************************************
- * Intel Management Engine Interface (Intel MEI) Linux driver
- * Intel MEI Interface Header
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110,
- * USA
- *
- * The full GNU General Public License is included in this distribution
- * in the file called LICENSE.GPL.
- *
- * Contact Information:
- *	Intel Corporation.
- *	linux-mei@linux.intel.com
- *	http://www.intel.com
- *
- * BSD LICENSE
- *
- * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  * Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  * Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  * Neither the name Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *****************************************************************************/
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause */
+/*
+ * Copyright(c) 2003-2012, Intel Corporation. All rights reserved.
+ */
 
 #ifndef _LINUX_MEI_H
 #define _LINUX_MEI_H
-- 
2.20.1

