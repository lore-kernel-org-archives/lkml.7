Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F6C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F421850
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SBk3G7PW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfEAQPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfEAQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GJLxfg47z5zmIYUnbxiCrlaCmFGP4tL9Ue8BxujcGKc=; b=SBk3G7PWSgsHFXsfeH/0Dradex
        QUHBzeq1K2pCLbWceGonhCBirec9RvOFEOF9Ca2R45hg1o5+54omlqwAXn12qp++b8LG6E/zeRdOf
        6r5Kfk4ASwoPo8zQ+EJSZ7i9N4P1laf0gfmnitEb4cHN/eI0KUeNxMTLqaF6MAeFna5IN7Pe+TBdd
        nOm8SPHPV2qyolHimCsu8Lq5FXY2+syL0LhjtPgDiCgb0FtAHPyJw+ELo0PkzZ6qzqFCWtgeJgCn4
        sTtro3lNTEsGj/FNmWBko/Y/knF0hEan08I3zbJj9uFumVLqo0IGfaT10YMBwjPdBYe7FxkBmKDHi
        x022MMOQ==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrt1-0005du-NP; Wed, 01 May 2019 16:15:12 +0000
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
Subject: [PATCH 11/24] libfc: remove duplicate GPL boilerplate text
Date:   Wed,  1 May 2019 12:14:04 -0400
Message-Id: <20190501161417.32592-12-hch@lst.de>
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

The libfc uapi headers already have proper SPDX tags, remove the
duplicate boilerplate text.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/scsi/fc/fc_els.h | 13 -------------
 include/uapi/scsi/fc/fc_fs.h  | 13 -------------
 include/uapi/scsi/fc/fc_gs.h  | 13 -------------
 include/uapi/scsi/fc/fc_ns.h  | 13 -------------
 4 files changed, 52 deletions(-)

diff --git a/include/uapi/scsi/fc/fc_els.h b/include/uapi/scsi/fc/fc_els.h
index a81c53508cc6..76f627f0d13b 100644
--- a/include/uapi/scsi/fc/fc_els.h
+++ b/include/uapi/scsi/fc/fc_els.h
@@ -2,19 +2,6 @@
 /*
  * Copyright(c) 2007 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Maintained at www.Open-FCoE.org
  */
 
diff --git a/include/uapi/scsi/fc/fc_fs.h b/include/uapi/scsi/fc/fc_fs.h
index 8c0a292a61ed..0dab49dbb2f7 100644
--- a/include/uapi/scsi/fc/fc_fs.h
+++ b/include/uapi/scsi/fc/fc_fs.h
@@ -2,19 +2,6 @@
 /*
  * Copyright(c) 2007 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Maintained at www.Open-FCoE.org
  */
 
diff --git a/include/uapi/scsi/fc/fc_gs.h b/include/uapi/scsi/fc/fc_gs.h
index 2153f3524555..effb4c662fe5 100644
--- a/include/uapi/scsi/fc/fc_gs.h
+++ b/include/uapi/scsi/fc/fc_gs.h
@@ -2,19 +2,6 @@
 /*
  * Copyright(c) 2007 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Maintained at www.Open-FCoE.org
  */
 
diff --git a/include/uapi/scsi/fc/fc_ns.h b/include/uapi/scsi/fc/fc_ns.h
index 015e5e1ce8f1..4cf0a40a099a 100644
--- a/include/uapi/scsi/fc/fc_ns.h
+++ b/include/uapi/scsi/fc/fc_ns.h
@@ -2,19 +2,6 @@
 /*
  * Copyright(c) 2007 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Maintained at www.Open-FCoE.org
  */
 
-- 
2.20.1

