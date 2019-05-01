Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89364C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C443208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kz3MYmyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfEAQPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfEAQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UXZQf5uORHjO699A4RsfuSsjKt6Jg++LKU72VXs3P30=; b=kz3MYmyOkGt9BAHPBWnTnSzmUL
        I4hg5DVsxjEkJ7cns/0nVgbZbJ4Gjq4I9akoJ3jiG6/vlbPCPchdwMGwr3afhdCxrfEBJVayG08sO
        QSaafn1IavVK57UpN445+5E7/+q4iLLkO5Spfi30QtIFMdhFsfOTkWVSBRvxL1s4cwuFZbbjX1hvC
        Ct19PN3MqmVgpBfxmsWkJTkXEDUcjYf/Hzoep32+SUaJaLjp9Tt8vr3vaI9uKfpamsEyucX59jN6d
        8Me/IeXzp+/tGCCSkINH1WiZ1PKDy6hoi51CMtfC9HhJatx6eHa+M+8P/8hkGJlSIKE5yasfPTWVj
        KpGkCa/Q==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrsy-0005Fk-7s; Wed, 01 May 2019 16:15:08 +0000
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
Subject: [PATCH 09/24] scsi_transport_spi: switch to SPDX tags
Date:   Wed,  1 May 2019 12:14:02 -0400
Message-Id: <20190501161417.32592-10-hch@lst.de>
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
 drivers/scsi/scsi_transport_spi.c | 15 +--------------
 include/scsi/scsi_transport_spi.h | 15 +--------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index 40b85b752b79..474d2ffad9d8 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* 
  *  Parallel SCSI (SPI) transport specific attributes exported to sysfs.
  *
  *  Copyright (c) 2003 Silicon Graphics, Inc.  All rights reserved.
  *  Copyright (c) 2004, 2005 James Bottomley <James.Bottomley@SteelEye.com>
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
  */
 #include <linux/ctype.h>
 #include <linux/init.h>
diff --git a/include/scsi/scsi_transport_spi.h b/include/scsi/scsi_transport_spi.h
index a4fa52b4d5c5..12516d16933d 100644
--- a/include/scsi/scsi_transport_spi.h
+++ b/include/scsi/scsi_transport_spi.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* 
  *  Parallel SCSI (SPI) transport specific attributes exported to sysfs.
  *
  *  Copyright (c) 2003 Silicon Graphics, Inc.  All rights reserved.
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
  */
 #ifndef SCSI_TRANSPORT_SPI_H
 #define SCSI_TRANSPORT_SPI_H
-- 
2.20.1

