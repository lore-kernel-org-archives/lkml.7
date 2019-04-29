Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E138FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFBE214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S3TmnvHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfD2L4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:56:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2L4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vCvuZ9fpcVRO2XTnb0TlXvgmmRSwAJ+bZOAtSdyhHNc=; b=S3TmnvHq3wo+i5XL7Wk5Wi/C6
        w5kENEvja58q4JIp4W0D0bLjks/VvA2O8J6VIJQhQ0QT2Uk/SM3JeWVovvmcjCVRM8g01TPH5pyLs
        NDda1CdlFYU9ZPslnoUUSag2WPQlRTDVKyX7eBetBNJcFik1yqCuSxXq4IyzjRpH/buNkCsYHulwi
        ZpUNhCqw2g3suhyGznOXYG2vVJgvOpi3YjwBLbrUNsq/pTa6ftVqN8+Lm28+uzSBBJKIPBEv80Nxj
        9H5rZW34dG5EzGbcnZEJsMy6wvq8aA42as8oMntbKzyEUH5UuixDD9Vhzi1cLHN1pLCFmweYJmP/r
        9+FepRbEQ==;
Received: from 65-114-90-19.dia.static.qwest.net ([65.114.90.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hL4tH-0001N0-F2; Mon, 29 Apr 2019 11:56:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: remove the unused device_private_entry_fault export
Date:   Mon, 29 Apr 2019 06:55:35 -0500
Message-Id: <20190429115535.12793-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This export has been entirely unused since it was added more than 1 1/2
years ago.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/memremap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 4e59d29245f4..1490e63f69a9 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -45,7 +45,6 @@ vm_fault_t device_private_entry_fault(struct vm_area_struct *vma,
 	 */
 	return devmem->page_fault(vma, addr, page, flags, pmdp);
 }
-EXPORT_SYMBOL(device_private_entry_fault);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 static void pgmap_array_delete(struct resource *res)
-- 
2.20.1

