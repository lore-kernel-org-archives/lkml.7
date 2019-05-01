Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F474C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F03A20652
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A92pWCzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfEAQPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfEAQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9gqGkobIhZryEowiPA+7IhnJAwe31pJ4qW8m9/0O+C8=; b=A92pWCzAxl29kmydRFgKcXNRiV
        p5ql0XMeMdI+sp7yCytrZ4hVXUmuz2t5iQyyeHHKsfoyr9Q+RAsYfR/jUdsgREUocgT3fAgSGPPUP
        XoVfO9BrgtV46YIQDNpJ2wW0NTAMdT5pbW5gqpSXSiHrCWr64b47MKmh46yf1wZ17aMX+uVC72xdp
        Z4U/mjzblzdA15RgO0UkZabIhhfq04zF4yfMROYTGGm0+7wi9vYGdEu1iWt5dNVS16sg7r1/mZJ0x
        5UttJRPJ12c4UZFG5XI5/4Rmi2RuPpcR8Rln2+pIui+ISi6VHx5kmUr614u576XqIGvAEi0gUOspA
        d5k6fgkQ==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrsq-0004PG-Fj; Wed, 01 May 2019 16:15:00 +0000
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
Subject: [PATCH 04/24] scsi_transport.h: switch to SPDX tags
Date:   Wed,  1 May 2019 12:13:57 -0400
Message-Id: <20190501161417.32592-5-hch@lst.de>
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
 include/scsi/scsi_transport.h | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/scsi/scsi_transport.h b/include/scsi/scsi_transport.h
index a3dcb1bfb362..a0643b9f6f13 100644
--- a/include/scsi/scsi_transport.h
+++ b/include/scsi/scsi_transport.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* 
  *  Transport specific attributes.
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
 #ifndef SCSI_TRANSPORT_H
 #define SCSI_TRANSPORT_H
-- 
2.20.1

