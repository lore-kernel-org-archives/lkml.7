Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5A0208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWe64MUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfEAQPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEAQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0ccOfTUTOdyHq0X8QUevEj9XvIItBVa9QWY8Gu0sU4g=; b=qWe64MUOFJLRKjB1CcwDwkAd/E
        f0GVh13h0W7KMxSVTgrHFCXT4cHWAtqw4+8wHePSQnrjvkIVWZIrEFwy2Htn86Q6VvQPTpCxphBgK
        EEQ/IZbN4b6hl52t7McPlhqX/0Y6HuAktWrGk2w6qRYncMqpnIVIlWGwh9mbu47zs9NFBARcpJAwV
        3f6eRnKyPUcYJyqVZj1nYTE5ADQgydEIQSspIno6Nw6qPyxywS4mo3Q3TYSTRm54jeDVot6ub1vHZ
        7qLGYJ/F36MRaODFzar8HLiSRx3XQZ7ds1dHoEdUdaHUnJi7gaK+8f8MH2GjHr1ToRYJrRZeQJ8I4
        1AokzVRA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrtN-0005h6-Ke; Wed, 01 May 2019 16:15:33 +0000
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
Subject: [PATCH 23/24] st: add a SPDX tag to st.c
Date:   Wed,  1 May 2019 12:14:16 -0400
Message-Id: <20190501161417.32592-24-hch@lst.de>
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

st.c is the only st file missing licensing information.  Add a
GPLv2 tag for the default kernel license.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 19c022e66d63..b814906af0a3 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
    SCSI Tape Driver for Linux version 1.1 and newer. See the accompanying
    file Documentation/scsi/st.txt for more information.
-- 
2.20.1

