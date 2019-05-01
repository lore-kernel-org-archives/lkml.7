Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A8CC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3889521743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aPIp1h1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfEAQPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfEAQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7wF9/X0wGwJAMhr4kPyoJ140TdbKKXGR7HzBAxsGj/Q=; b=aPIp1h1m8n30DK+wxopjCuLguq
        E4C45cbPKVGKtC6ETicrA4opditKkXcO7QGuxqHQJEpPBcPTcLHq+JEsbf7iZkf6IsVYXSefM/BZy
        +GPqiY6QIOrgSJpFe8JlTcdiGYM34lU3cpLnwhVRuaGRsew13tHJxhieEYfpb+d7IkOg6FLvUEHv8
        mS8BRNY/V5qI1q7bbrNJ72lpSXEJzVj/Uxn/QpiUNo3oiPFLNTAxPvtdn8BBdnvwmWApycmdTmYns
        ftWcXxbg128Ku2RIEsV8s4FZ4L52xJEBL3rruLaEX0ZGo34fg3Z9RUX/1FMHGAiWQRF8r1uChbFZz
        rL5z6U4g==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrtL-0005gs-Sz; Wed, 01 May 2019 16:15:32 +0000
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
Subject: [PATCH 22/24] sr: add a SPDX tag to sr.c
Date:   Wed,  1 May 2019 12:14:15 -0400
Message-Id: <20190501161417.32592-23-hch@lst.de>
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

sr.c is the only sr file missing licensing information.  Add a
GPLv2 tag for the default kernel license.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 039c27c2d7b3..701d1e68d86e 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  sr.c Copyright (C) 1992 David Giller
  *           Copyright (C) 1993, 1994, 1995, 1999 Eric Youngdale
-- 
2.20.1

