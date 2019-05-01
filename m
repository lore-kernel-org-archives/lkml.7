Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0B8C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8695208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i+2aZYPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEAQPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfEAQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hnEGiTF3cvFUVxv7N+HsUgXJr+bSX4IoZxtMu1jYf2k=; b=i+2aZYPX4wAc43i9clg/0xgVNv
        OTEtrsXIHIraOhGzPGdl1nyZ8L42jcOAEiPZw7km06bHh3PPslYfVJiFZ0NYIswT1jO8A4VoJ+imd
        1eaEeLHZXZLcSpfe1xWjD6jUaqUg+y0wt7raOJ5il3KREK6dbueJ6CbCEILzgxxUvftXrxhoc0kNg
        hOm0QtpfZomVc+OPkAoImbv+PpwJlOS3juxCVFJkghyf+LzFPyGWJsMXVa1qdv3jO52XX//Cm0OMG
        8447lnoN0ggNOdakcEUq13OwHnyZdbTSm22kBUi3Dx+Zw1WW5YxOmIzgwaXZIu05vo5/Qzja0HX3S
        jcGa3quQ==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrsn-0004OZ-Ma; Wed, 01 May 2019 16:14:57 +0000
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
Subject: [PATCH 02/24] scsi: switch the remaining scsi midlayer files to use SPDX tags
Date:   Wed,  1 May 2019 12:13:55 -0400
Message-Id: <20190501161417.32592-3-hch@lst.de>
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

Use the GPLv2 SPDX tag instead of verbose boilerplate text.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_logging.c |  3 +--
 drivers/scsi/scsi_sysctl.c  |  2 +-
 drivers/scsi/scsi_trace.c   | 14 +-------------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index bd70339c1242..ca582218d72d 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * scsi_logging.c
  *
  * Copyright (C) 2014 SUSE Linux Products GmbH
  * Copyright (C) 2014 Hannes Reinecke <hare@suse.de>
- *
- * This file is released under the GPLv2
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/scsi/scsi_sysctl.c b/drivers/scsi/scsi_sysctl.c
index 546f16299ef9..c74a965a51a7 100644
--- a/drivers/scsi/scsi_sysctl.c
+++ b/drivers/scsi/scsi_sysctl.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2003 Christoph Hellwig.
- *	Released under GPL v2.
  */
 
 #include <linux/errno.h>
diff --git a/drivers/scsi/scsi_trace.c b/drivers/scsi/scsi_trace.c
index 0ff083bbf5b1..6ae168fcc119 100644
--- a/drivers/scsi/scsi_trace.c
+++ b/drivers/scsi/scsi_trace.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010 FUJITSU LIMITED
  * Copyright (C) 2010 Tomohiro Kusumi <kusumi.tomohiro@jp.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/kernel.h>
 #include <linux/trace_seq.h>
-- 
2.20.1

