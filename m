Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3308217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sTSEliLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfEAQPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfEAQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qeu4XawShc08TSDZ6EHrswB6lLFZ3eL+4JnriJ6bcNA=; b=sTSEliLxQKZEEZpeN5OLwIvEyL
        XU9HcdczI7f99Nxm0h/tY9hlRvgSV0hDFCRYL2EqLZYq2n6u3rgm7gpVafDvz+6ojVyqjckGP+ct3
        OSd6mkyf6GYFKtYVeCOureSzOqiY633xb9/URybflXaPa44CncTam8Zy6TLxKQ1VTIMcmN6HoX5iA
        YGXHhJ8ExM+pjbfy9bbL9JwO10WtSl1+3Ug7bxV7RV4D2IpX7H5G9D2MwC6Nv2EA5JATru2P1HE+s
        QjlaVfR3+75Jklp2y8DQSrOhOzznByYj9qF59aYU3FyUjIhMGagrBKzUGqpvwCwImgYOdaM0Y7JgX
        uvl3zznw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrtC-0005fS-Ij; Wed, 01 May 2019 16:15:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>, Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] libsas: switch remaining files to SPDX tags
Date:   Wed,  1 May 2019 12:14:10 -0400
Message-Id: <20190501161417.32592-18-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501161417.32592-1-hch@lst.de>
References: <20190501161417.32592-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the the GPLv2 SPDX tag instead of verbose boilerplate text.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/libsas/sas_discover.c  | 18 +-----------------
 drivers/scsi/libsas/sas_event.c     | 18 +-----------------
 drivers/scsi/libsas/sas_expander.c  | 16 +---------------
 drivers/scsi/libsas/sas_host_smp.c  |  5 +----
 drivers/scsi/libsas/sas_init.c      | 19 +------------------
 drivers/scsi/libsas/sas_internal.h  | 19 +------------------
 drivers/scsi/libsas/sas_phy.c       | 18 +-----------------
 drivers/scsi/libsas/sas_port.c      | 18 +-----------------
 drivers/scsi/libsas/sas_scsi_host.c | 19 +------------------
 include/scsi/libsas.h               | 19 +------------------
 include/scsi/sas.h                  | 19 +------------------
 include/scsi/sas_ata.h              | 17 +----------------
 12 files changed, 12 insertions(+), 193 deletions(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 726ada9b8c79..2518cecb7edf 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Serial Attached SCSI (SAS) Discover process
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include <linux/scatterlist.h>
diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_event.c
index b1e0f7d2b396..a1852f6c042b 100644
--- a/drivers/scsi/libsas/sas_event.c
+++ b/drivers/scsi/libsas/sas_event.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Serial Attached SCSI (SAS) Event processing
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include <linux/export.h>
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 83f2fd70ce76..76ea83ddafa7 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Serial Attached SCSI (SAS) Expander discovery and configuration
  *
@@ -5,21 +6,6 @@
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
  *
  * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include <linux/scatterlist.h>
diff --git a/drivers/scsi/libsas/sas_host_smp.c b/drivers/scsi/libsas/sas_host_smp.c
index 9ead93df3a6e..55dcc9c934b2 100644
--- a/drivers/scsi/libsas/sas_host_smp.c
+++ b/drivers/scsi/libsas/sas_host_smp.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Serial Attached SCSI (SAS) Expander discovery and configuration
  *
  * Copyright (C) 2007 James E.J. Bottomley
  *		<James.Bottomley@HansenPartnership.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; version 2 only.
  */
 #include <linux/scatterlist.h>
 #include <linux/blkdev.h>
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index 28a460c36c0b..8f2608995726 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -1,26 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Serial Attached SCSI (SAS) Transport Layer initialization
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
- * USA
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 2cdb981cf476..1bc248a1b4ea 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -1,26 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Serial Attached SCSI (SAS) class internal header file
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
- * USA
- *
  */
 
 #ifndef _SAS_INTERNAL_H_
diff --git a/drivers/scsi/libsas/sas_phy.c b/drivers/scsi/libsas/sas_phy.c
index e030e1452136..2455199e5ffc 100644
--- a/drivers/scsi/libsas/sas_phy.c
+++ b/drivers/scsi/libsas/sas_phy.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Serial Attached SCSI (SAS) Phy class
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include "sas_internal.h"
diff --git a/drivers/scsi/libsas/sas_port.c b/drivers/scsi/libsas/sas_port.c
index 38a10478605c..11f028a441dd 100644
--- a/drivers/scsi/libsas/sas_port.c
+++ b/drivers/scsi/libsas/sas_port.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Serial Attached SCSI (SAS) Port class
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include "sas_internal.h"
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index b775445892af..602bd1a17a63 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1,26 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Serial Attached SCSI (SAS) class SCSI Host glue.
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
- * USA
- *
  */
 
 #include <linux/kthread.h>
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index b08febec7895..901355a1bc53 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -1,26 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * SAS host prototypes and structures header file
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
- * USA
- *
  */
 
 #ifndef _LIBSAS_H_
diff --git a/include/scsi/sas.h b/include/scsi/sas.h
index 42a84ef42683..ded4d6b7a377 100644
--- a/include/scsi/sas.h
+++ b/include/scsi/sas.h
@@ -1,26 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * SAS structures and definitions header file
  *
  * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
  * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
- *
- * This file is licensed under GPLv2.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
- * USA
- *
  */
 
 #ifndef _SAS_H_
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index 00f41aeeecf5..9f5ce0a3e63e 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -1,25 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Support for SATA devices on Serial Attached SCSI (SAS) controllers
  *
  * Copyright (C) 2006 IBM Corporation
  *
  * Written by: Darrick J. Wong <djwong@us.ibm.com>, IBM Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
- * USA
- *
  */
 
 #ifndef _SAS_ATA_H_
-- 
2.20.1

