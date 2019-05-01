Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007BEC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09CF208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q7AWxcBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfEAQPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfEAQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vqy9GYMIb0rH6XPVOPvJOsTv8lYc6QyM7vi2h2ENsu8=; b=Q7AWxcBI8M/j0Tc0MTIOZZKT/O
        LWMt1qehWMWURFarpW+3J/WgAT7GG4QmzyZEvACkV0RJebu4acmO+r456XbHR/l+aHks2TFUvY5cS
        lIf+k/NKj8Y0w8yKcV/aD+yjuKPw3GAYjto0/vSaS41JiTNuC+9jYG3UPTRVpQyFBLkDZEAPZlpph
        N4ASTBkarr1TEQaMNu0adIgosYjzdTPtlApB7TYWEQhJJGFkw49+JUWzMJ/8LGmv/creacBa89A6h
        VPZlNK6/jDUMDtuDjj7ugtm31fBikXETO0NkXHXActzoR1B8y+KuhR1MRF0RaStaQ/Wqjxixz3F4g
        I7e+tHPw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrsv-0004k9-5Y; Wed, 01 May 2019 16:15:05 +0000
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
Subject: [PATCH 07/24] scsi_transport_iscsi: switch to SPDX tags
Date:   Wed,  1 May 2019 12:14:00 -0400
Message-Id: <20190501161417.32592-8-hch@lst.de>
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
 drivers/scsi/scsi_transport_iscsi.c | 15 +--------------
 include/scsi/scsi_transport_iscsi.h | 15 +--------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 0a82e93566dc..828b242e28b0 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * iSCSI transport class definitions
  *
@@ -5,20 +6,6 @@
  * Copyright (C) Mike Christie, 2004 - 2005
  * Copyright (C) Dmitry Yusupov, 2004 - 2005
  * Copyright (C) Alex Aizman, 2004 - 2005
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
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index b266d2a3bcb1..98149e82926b 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * iSCSI transport class definitions
  *
@@ -5,20 +6,6 @@
  * Copyright (C) Mike Christie, 2004 - 2006
  * Copyright (C) Dmitry Yusupov, 2004 - 2005
  * Copyright (C) Alex Aizman, 2004 - 2005
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
 #ifndef SCSI_TRANSPORT_ISCSI_H
 #define SCSI_TRANSPORT_ISCSI_H
-- 
2.20.1

