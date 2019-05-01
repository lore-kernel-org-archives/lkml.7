Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CF6C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F9D21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WMqFGkHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfEAQQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:16:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfEAQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NfTQBgYcxK0mzG73An5I8H0OrL/vxG/1o8Trp8Fhb7M=; b=WMqFGkHFCyi1DB+wpXdhGe8zzG
        0bGFeQNG3TEElYawana7DkHkfuZSZt9MYC+27reFZWvxZ5/VbKuXsRxb2NqOflXsoTq9oksW9wCge
        5n+MR8taXAGlhoCcyD//sVGbt4Gze1iFxo2I8HcGby68vvRkFpbExyFLApecEyehQutFqMPD11Cd3
        JIHb2Q+UIRl9cyUf1rMeXFJQen7eLJiTU1NQIH20HTgBoPUo1HggkLBx3fIDK0vZrkrnTQqe02yCl
        LsyTzb/4iu/i7uyxUx1cCii8Kxm7qDFLndUr+Id+hfDU/lQRbvIR9dCWeRHkXRFSkAtRmfu71/Pgd
        UJuiCOxg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrt7-0005ek-1d; Wed, 01 May 2019 16:15:17 +0000
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
Subject: [PATCH 14/24] libiscsi: switch to SPDX tags
Date:   Wed,  1 May 2019 12:14:07 -0400
Message-Id: <20190501161417.32592-15-hch@lst.de>
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

Use the the GPLv2+ SPDX tag instead of verbose boilerplate text.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/libiscsi.c       | 15 +--------------
 drivers/scsi/libiscsi_tcp.c   | 13 +------------
 include/scsi/iscsi_if.h       | 13 +------------
 include/scsi/iscsi_proto.h    | 13 +------------
 include/scsi/libiscsi.h       | 15 +--------------
 include/scsi/libiscsi_tcp.h   | 13 +------------
 include/scsi/scsi_bsg_iscsi.h | 16 +---------------
 7 files changed, 7 insertions(+), 91 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index e893949a3d11..040b58a3d7d3 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * iSCSI lib functions
  *
@@ -6,20 +7,6 @@
  * Copyright (C) 2004 - 2005 Dmitry Yusupov
  * Copyright (C) 2004 - 2005 Alex Aizman
  * maintained by open-iscsi@googlegroups.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 #include <linux/types.h>
 #include <linux/kfifo.h>
diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index c3fe3f3a78f5..e0255bb2748f 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * iSCSI over TCP/IP Data-Path lib
  *
@@ -7,18 +8,6 @@
  * Copyright (C) 2006 Red Hat, Inc.  All rights reserved.
  * maintained by open-iscsi@googlegroups.com
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * See the file COPYING included with this distribution for more details.
- *
  * Credits:
  *	Christoph Hellwig
  *	FUJITA Tomonori
diff --git a/include/scsi/iscsi_if.h b/include/scsi/iscsi_if.h
index d66c07077d68..5b8af179b7ac 100644
--- a/include/scsi/iscsi_if.h
+++ b/include/scsi/iscsi_if.h
@@ -1,21 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * iSCSI User/Kernel Shares (Defines, Constants, Protocol definitions, etc)
  *
  * Copyright (C) 2005 Dmitry Yusupov
  * Copyright (C) 2005 Alex Aizman
  * maintained by open-iscsi@googlegroups.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * See the file COPYING included with this distribution for more details.
  */
 
 #ifndef ISCSI_IF_H
diff --git a/include/scsi/iscsi_proto.h b/include/scsi/iscsi_proto.h
index df156f1d50b2..3e930ab9b859 100644
--- a/include/scsi/iscsi_proto.h
+++ b/include/scsi/iscsi_proto.h
@@ -1,21 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * RFC 3720 (iSCSI) protocol data types
  *
  * Copyright (C) 2005 Dmitry Yusupov
  * Copyright (C) 2005 Alex Aizman
  * maintained by open-iscsi@googlegroups.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * See the file COPYING included with this distribution for more details.
  */
 
 #ifndef ISCSI_PROTO_H
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index c9bd935f4fd1..7992f6bb2ebc 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * iSCSI lib definitions
  *
@@ -5,20 +6,6 @@
  * Copyright (C) 2004 - 2006 Mike Christie
  * Copyright (C) 2004 - 2005 Dmitry Yusupov
  * Copyright (C) 2004 - 2005 Alex Aizman
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 #ifndef LIBISCSI_H
 #define LIBISCSI_H
diff --git a/include/scsi/libiscsi_tcp.h b/include/scsi/libiscsi_tcp.h
index 30520d5ee3d1..b7ce80422215 100644
--- a/include/scsi/libiscsi_tcp.h
+++ b/include/scsi/libiscsi_tcp.h
@@ -1,21 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * iSCSI over TCP/IP Data-Path lib
  *
  * Copyright (C) 2008 Mike Christie
  * Copyright (C) 2008 Red Hat, Inc.  All rights reserved.
  * maintained by open-iscsi@googlegroups.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * See the file COPYING included with this distribution for more details.
  */
 
 #ifndef LIBISCSI_TCP_H
diff --git a/include/scsi/scsi_bsg_iscsi.h b/include/scsi/scsi_bsg_iscsi.h
index fd5689d4c052..aa76c1e5b36f 100644
--- a/include/scsi/scsi_bsg_iscsi.h
+++ b/include/scsi/scsi_bsg_iscsi.h
@@ -1,22 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *  iSCSI Transport BSG Interface
  *
  *  Copyright (C) 2009   James Smart, Emulex Corporation
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #ifndef SCSI_BSG_ISCSI_H
-- 
2.20.1

