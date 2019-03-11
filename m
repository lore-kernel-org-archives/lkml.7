Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A3CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061942087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfCKVSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:18:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:30404 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbfCKVS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:18:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 14:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="151382940"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2019 14:18:26 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 2/5] mei: convert to SPDX license tags
Date:   Tue, 12 Mar 2019 00:10:41 +0200
Message-Id: <20190311221044.17623-3-tomas.winkler@intel.com>
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
identifiers in the mei files header.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c   | 12 +------
 drivers/misc/mei/bus.c         | 11 +-----
 drivers/misc/mei/client.c      | 12 +------
 drivers/misc/mei/client.h      | 12 +------
 drivers/misc/mei/debugfs.c     | 13 ++-----
 drivers/misc/mei/hbm.c         | 13 +------
 drivers/misc/mei/hbm.h         | 12 +------
 drivers/misc/mei/hw-me-regs.h  | 66 ++--------------------------------
 drivers/misc/mei/hw-me.c       | 12 +------
 drivers/misc/mei/hw-me.h       | 14 +-------
 drivers/misc/mei/hw-txe-regs.h | 61 ++-----------------------------
 drivers/misc/mei/hw-txe.c      | 12 +------
 drivers/misc/mei/hw-txe.h      | 12 +------
 drivers/misc/mei/hw.h          | 12 +------
 drivers/misc/mei/init.c        | 12 +------
 drivers/misc/mei/interrupt.c   | 13 +------
 drivers/misc/mei/main.c        | 13 ++-----
 drivers/misc/mei/mei-trace.c   | 12 +------
 drivers/misc/mei/mei-trace.h   | 12 +------
 drivers/misc/mei/mei_dev.h     | 12 +------
 drivers/misc/mei/pci-me.c      | 13 ++-----
 drivers/misc/mei/pci-txe.c     | 12 +------
 include/uapi/linux/mei.h       | 65 ++-------------------------------
 23 files changed, 31 insertions(+), 407 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 5fcac02233af..c839bdf453d8 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2018, Intel Corporation.
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
index 65bec998eb6e..e6788fbd611c 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2012-2013, Intel Corporation.
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
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index ca4c9cc218a2..306b5fdeaf9c 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
index 64e318f589b4..a0e2ec2ed7ab 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
index 7b5df8fd6c5a..3b2dd5a1be06 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2012-2013, Intel Corporation.
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
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index e6207f614816..dfc21787d978 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
 #include <linux/sched.h>
 #include <linux/wait.h>
diff --git a/drivers/misc/mei/hbm.h b/drivers/misc/mei/hbm.h
index 0171a7e79bab..1e33359f27f0 100644
--- a/drivers/misc/mei/hbm.h
+++ b/drivers/misc/mei/hbm.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index bb1ee9834a02..535eb63a9dee 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -1,68 +1,8 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
  * Intel Management Engine Interface (Intel MEI) Linux driver
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
  * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
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
+ */
 #ifndef _MEI_HW_MEI_REGS_H_
 #define _MEI_HW_MEI_REGS_H_
 
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 3fbbadfa2ae1..ea1cd7043323 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
index bbcc5fc106cd..e1c1b4e18f3c 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -1,21 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
index f19229c4e655..d71798cb6272 100644
--- a/drivers/misc/mei/hw-txe-regs.h
+++ b/drivers/misc/mei/hw-txe-regs.h
@@ -1,63 +1,8 @@
-/******************************************************************************
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Intel MEI Interface Header
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
  * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
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
- *
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
+ */
 #ifndef _MEI_HW_TXE_REGS_H_
 #define _MEI_HW_TXE_REGS_H_
 
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 8449fe0367ff..c99a5360df27 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2013-2014, Intel Corporation.
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
index e1e8b66d7648..b82dd5cb4a78 100644
--- a/drivers/misc/mei/hw-txe.h
+++ b/drivers/misc/mei/hw-txe.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2013-2014, Intel Corporation.
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
index b7d2487b8409..a4c16eaad1fb 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
index eb026e2a0537..0d719f3b941f 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
index 055c2d89b310..5385293b973e 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
index 87281b3695e6..e796f149b6a5 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2018, Intel Corporation.
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
index 374edde72a14..32ee5d3d856c 100644
--- a/drivers/misc/mei/mei-trace.c
+++ b/drivers/misc/mei/mei-trace.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2015, Intel Corporation.
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
 
diff --git a/drivers/misc/mei/mei-trace.h b/drivers/misc/mei/mei-trace.h
index b52e9b97a7c0..9883bd8ece26 100644
--- a/drivers/misc/mei/mei-trace.h
+++ b/drivers/misc/mei/mei-trace.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2015, Intel Corporation.
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
index 685b78ce30a5..3b45f12229e0 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2018, Intel Corporation.
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
 
 #ifndef _MEI_DEV_H_
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 3ab946ad3257..723f9a8fb53d 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2003-2012, Intel Corporation.
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
index e1b909123fb0..1e3dd806c483 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2013-2014, Intel Corporation.
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
diff --git a/include/uapi/linux/mei.h b/include/uapi/linux/mei.h
index 0f681cbd38d3..1b932cad61b4 100644
--- a/include/uapi/linux/mei.h
+++ b/include/uapi/linux/mei.h
@@ -1,70 +1,9 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-/******************************************************************************
+/*
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Intel MEI Interface Header
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
  * Copyright(c) 2003 - 2012 Intel Corporation. All rights reserved.
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
-
+ */
 #ifndef _LINUX_MEI_H
 #define _LINUX_MEI_H
 
-- 
2.20.1

