Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4CAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E133E208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FHUCEwyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfEAQPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfEAQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wsq9CqoFxHpRiziE7z9eEKG21vxlvBxZ8PZ7HGgW28M=; b=FHUCEwywm+wxadvTWFlOKkrCb0
        esTDHaHZibRUOM6IntZ7Gw5qQhRMBlE2WHtRFd0PdinsMHO+iFChZbRmYMtrk+BGvAaHP8kkUm2Jr
        l/yKgT+35Wx0bBmZIP/wXi2tXU1yF1isH0qu4U3ddo7BVy8s1i3rgfoKUGi0PWogc8LZVvPjoCbzb
        Mw9DYx3ajLqTq2OkCuqFhRDs+og0dn2rbO/YtTEvgfJxqYNySKgZ0hnBbOKCLLNgvXF+CMHmhcA8S
        DygeFDTuSwLYsit3v9wOXkCzpRGjVM9EMMJ7WudLJy71Fyv/aRRSHoVcMSzwL3BUX4xLvkVhN0yXp
        APiFgu6Q==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrtI-0005gJ-6p; Wed, 01 May 2019 16:15:28 +0000
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
Subject: [PATCH 20/24] ses: switch to SPDX tags
Date:   Wed,  1 May 2019 12:14:13 -0400
Message-Id: <20190501161417.32592-21-hch@lst.de>
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
 drivers/scsi/ses.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 0fc39224ce1e..8afea5a1d3f0 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -1,25 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SCSI Enclosure Services
  *
  * Copyright (C) 2008 James Bottomley <James.Bottomley@HansenPartnership.com>
- *
-**-----------------------------------------------------------------------------
-**
-**  This program is free software; you can redistribute it and/or
-**  modify it under the terms of the GNU General Public License
-**  version 2 as published by the Free Software Foundation.
-**
-**  This program is distributed in the hope that it will be useful,
-**  but WITHOUT ANY WARRANTY; without even the implied warranty of
-**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-**  GNU General Public License for more details.
-**
-**  You should have received a copy of the GNU General Public License
-**  along with this program; if not, write to the Free Software
-**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-**
-**-----------------------------------------------------------------------------
-*/
+ */
 
 #include <linux/slab.h>
 #include <linux/module.h>
-- 
2.20.1

