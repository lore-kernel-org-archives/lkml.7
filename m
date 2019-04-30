Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63686C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B4D21707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CAfFvUb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfD3KwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:52:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfD3KwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OjOD2oMjxpggW41tpwAHqLAmFcrJ2PV74fctRCPb0YM=; b=CAfFvUb3h9Z5Ktfh8rxh+5IiDm
        lY97oHjJ7HjwOKCA8j31dx2moU99TYCoFTqmI699YPJyl4KkkkwxSH7DCdALtZyL8TB7wrHPN9ZCf
        ifeMmu1pv5uedYgpFQqiagEdgnChynosW3ZBFzzjah7r7s2Akt9qg/HwqpOVJLVTg3+TahiKvFnVq
        kMKZvPMEWQMLM5QoiTRFpjY2riHn/D3MqcUTjG81KwHd+FKu6pnv8qKReYmCEf7eAhFkXAY2HJoX9
        5DCuWwiUau852nNnlQv3dS1uj2fznNQU4fZVikPoHxnAjBO3ImVCwcG//VDzqFADdkQY65G+1SylZ
        Nxeq0yMA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQMw-0007EX-5d; Tue, 30 Apr 2019 10:52:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] LICENSES: Rename other to deprecated
Date:   Tue, 30 Apr 2019 06:51:30 -0400
Message-Id: <20190430105130.24500-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105130.24500-1-hch@lst.de>
References: <20190430105130.24500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear in the directory name that these are not intended for new
code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/process/license-rules.rst     | 8 ++++----
 LICENSES/{other => deprecated}/GPL-1.0      | 0
 LICENSES/{other => deprecated}/ISC          | 0
 LICENSES/{other => deprecated}/Linux-OpenIB | 0
 LICENSES/{other => deprecated}/X11          | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename LICENSES/{other => deprecated}/GPL-1.0 (100%)
 rename LICENSES/{other => deprecated}/ISC (100%)
 rename LICENSES/{other => deprecated}/Linux-OpenIB (100%)
 rename LICENSES/{other => deprecated}/X11 (100%)

diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 507b695fa9da..2ef44ada3f11 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -234,13 +234,13 @@ kernel, can be broken down into:
 
 |
 
-2. Not recommended licenses:
+2. Deprecated licenses:
 
    These licenses should only be used for existing code or for importing
    code from a different project.  These licenses are available from the
    directory::
 
-      LICENSES/other/
+      LICENSES/deprecated/
 
    in the kernel source tree.
 
@@ -250,12 +250,12 @@ kernel, can be broken down into:
 
    Examples::
 
-      LICENSES/other/ISC
+      LICENSES/deprecated/ISC
 
    Contains the Internet Systems Consortium license text and the required
    metatags::
 
-      LICENSES/other/GPL-1.0
+      LICENSES/deprecated/GPL-1.0
 
    Contains the GPL version 1 license text and the required metatags.
 
diff --git a/LICENSES/other/GPL-1.0 b/LICENSES/deprecated/GPL-1.0
similarity index 100%
rename from LICENSES/other/GPL-1.0
rename to LICENSES/deprecated/GPL-1.0
diff --git a/LICENSES/other/ISC b/LICENSES/deprecated/ISC
similarity index 100%
rename from LICENSES/other/ISC
rename to LICENSES/deprecated/ISC
diff --git a/LICENSES/other/Linux-OpenIB b/LICENSES/deprecated/Linux-OpenIB
similarity index 100%
rename from LICENSES/other/Linux-OpenIB
rename to LICENSES/deprecated/Linux-OpenIB
diff --git a/LICENSES/other/X11 b/LICENSES/deprecated/X11
similarity index 100%
rename from LICENSES/other/X11
rename to LICENSES/deprecated/X11
-- 
2.20.1

