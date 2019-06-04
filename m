Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4329FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C596124BBB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zU9GZzrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfFDLSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:18:40 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:54418 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfFDLSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:18:40 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x54BGvLH009633;
        Tue, 4 Jun 2019 20:16:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x54BGvLH009633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559647019;
        bh=0QZKxY5pgYied5dcdhzPAVfJ4vw59SmOyFiNqN2eH8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=zU9GZzrIDSRFvCVh22UF0auDxXNQY1UOH1VC8qhSJSrflclWa9p0lSsoH5fzjiYTT
         +4mYPcE3hXLAWcyOeOr0Zts1pGZyCaqkkB2wvG6r+HvJV0nIEnrHcPCOz9TWelrYxh
         uj98l9srM15CKvuhGxgGjHXMDS7H+v0cK6sj5KR8G2rNWQLqmEdaQTUFQrHNYJyxzF
         KYglswUnZ5u4XZnRpld3T1e6sbEtr8WG2AZDafPjNHltAabVyHE95uSdbJYRrOYGpr
         8YTfe0pi8nTwKmFMg3ZkfnlWhWfXrWLtjfBHlphKgBTTQAn4wXgYcuQ/Ir6502MGW7
         PzSsqx3DC0tYQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ocxl: do not use C++ style comments in uapi header
Date:   Tue,  4 Jun 2019 20:16:32 +0900
Message-Id: <20190604111632.22479-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel tolerates C++ style comments these days. Actually, the
SPDX License tags for .c files start with //.

On the other hand, uapi headers are written in more strict C, where
the C++ comment style is forbidden.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/misc/ocxl.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
index 97937cfa3baa..6d29a60a896a 100644
--- a/include/uapi/misc/ocxl.h
+++ b/include/uapi/misc/ocxl.h
@@ -33,23 +33,23 @@ struct ocxl_ioctl_attach {
 };
 
 struct ocxl_ioctl_metadata {
-	__u16 version; // struct version, always backwards compatible
+	__u16 version; /* struct version, always backwards compatible */
 
-	// Version 0 fields
+	/* Version 0 fields */
 	__u8  afu_version_major;
 	__u8  afu_version_minor;
-	__u32 pasid;		// PASID assigned to the current context
+	__u32 pasid;		/* PASID assigned to the current context */
 
-	__u64 pp_mmio_size;	// Per PASID MMIO size
+	__u64 pp_mmio_size;	/* Per PASID MMIO size */
 	__u64 global_mmio_size;
 
-	// End version 0 fields
+	/* End version 0 fields */
 
-	__u64 reserved[13]; // Total of 16*u64
+	__u64 reserved[13]; /* Total of 16*u64 */
 };
 
 struct ocxl_ioctl_p9_wait {
-	__u16 thread_id; // The thread ID required to wake this thread
+	__u16 thread_id; /* The thread ID required to wake this thread */
 	__u16 reserved1;
 	__u32 reserved2;
 	__u64 reserved3[3];
-- 
2.17.1

