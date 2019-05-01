Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7C4C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39875208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRBjSgkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfEAQPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:15:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfEAQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=faf3x95W7b/ShH6i+qBMl/ENbouWlKtYNQW2pyAitx0=; b=JRBjSgkW46GdmEjN5hnlErNI71
        CmRuaBeO3z7kbSA/xpapED0y12CvNiDuE10kA7k8FhL3Djzfkj/ESUC1bP0okEP4miAD96E6cG2aa
        X8FbjW7x6Bo5/fcKzXfLExoxgOK8N758m8kt3XiVteS0t47SjuZi3XmsD/EjUkJa7XiXTjVnQyhyh
        sHhQ9TkXTxNmR5Vuik5ORhKrQ2V59GH/1lFdUAeyHVVobex505nPKNSUu7mPrpjOA8xH/CLhl9foB
        KL/yMU8D9iPG8FcykcW5pR/+UAOH7imIpy6eDlB0nK2KOO4oK1je5lcuABjR81CxgRkcWAlSNhPB/
        dF7fAcsA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrsm-0004OM-6N; Wed, 01 May 2019 16:14:56 +0000
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
Subject: [PATCH 01/24] scsi: add SPDX tags to scsi midlayer files missing licensing information
Date:   Wed,  1 May 2019 12:13:54 -0400
Message-Id: <20190501161417.32592-2-hch@lst.de>
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

Add the default kernel GPLv2 annotation to SCSI midlayer files missing
any licensing information.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/hosts.c        | 1 +
 drivers/scsi/scsi.c         | 1 +
 drivers/scsi/scsi_debugfs.h | 1 +
 drivers/scsi/scsi_error.c   | 1 +
 drivers/scsi/scsi_ioctl.c   | 1 +
 drivers/scsi/scsi_lib.c     | 1 +
 drivers/scsi/scsi_pm.c      | 1 +
 drivers/scsi/scsi_sysfs.c   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index eaf329db3973..96ed24841c33 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  hosts.c Copyright (C) 1992 Drew Eckhardt
  *          Copyright (C) 1993, 1994, 1995 Eric Youngdale
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 99a7b9f520ae..49821f138ae0 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  scsi.c Copyright (C) 1992 Drew Eckhardt
  *         Copyright (C) 1993, 1994, 1995, 1999 Eric Youngdale
diff --git a/drivers/scsi/scsi_debugfs.h b/drivers/scsi/scsi_debugfs.h
index 951b043e82d0..d125d1bd4184 100644
--- a/drivers/scsi/scsi_debugfs.h
+++ b/drivers/scsi/scsi_debugfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 struct request;
 struct seq_file;
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 8e9680572b9f..f490994374f6 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  scsi_error.c Copyright (C) 1997 Eric Youngdale
  *
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 840d96fe81bc..00397205466b 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Changes:
  * Arnaldo Carvalho de Melo <acme@conectiva.com.br> 08/23/2000
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6b2570a5642d..94de50745616 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1999 Eric Youngdale
  * Copyright (C) 2014 Christoph Hellwig
diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index 7639df91b110..3a5dfbb81622 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	scsi_pm.c	Copyright (C) 2010 Alan Stern
  *
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 3b119ca0cc0c..ff0aea7ac87f 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * scsi_sysfs.c
  *
-- 
2.20.1

