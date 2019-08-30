Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96EE23429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hrqjn2XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfH3QMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:12:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbfH3QMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zKq+q+hTsr3kCF6Im8s43Dia3LtlLrIUG7ZsQ5nTU2k=; b=Hrqjn2XT9rYqeq+IKmITeYEdTW
        Ex41p84FoSAkT+IY9YfMtYEL1iz4MEo1JDoqO6u7qXeEtPrwqqwqt6D1Klyy8Ee1MfwMiOy4SJ1ns
        PTGEo91ebnhJlLYn+4fMoohgheFxh40FMJn0wy1FOvX6Ehdnpbu2/VDskqqgUcpOCmOCy3UOwoi79
        cMT7AIq24aAc+qn+A9hONFkrsIWnL+QlSeYnjcRezeBPwBCIKBy1Pk0Ob2UlreGwdtnJpxZqxXJgx
        g1Ep0EP31Mf1VBL4edbJDS2MGbsCm0mBC2qYr58SPwMLOEIOx6QcWalcGQ1DJB0wfkVdwPpDMkOwZ
        yEHGTyHg==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jW1-0000km-Fa; Fri, 30 Aug 2019 16:12:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] microblaze: remove ioremap_fullcache
Date:   Fri, 30 Aug 2019 18:12:36 +0200
Message-Id: <20190830161237.23033-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830161237.23033-1-hch@lst.de>
References: <20190830161237.23033-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No callers of this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/asm/io.h
index c7968139486f..86c95b2a1ce1 100644
--- a/arch/microblaze/include/asm/io.h
+++ b/arch/microblaze/include/asm/io.h
@@ -40,7 +40,6 @@ extern void iounmap(volatile void __iomem *addr);
 
 extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
 #define ioremap_nocache(addr, size)		ioremap((addr), (size))
-#define ioremap_fullcache(addr, size)		ioremap((addr), (size))
 #define ioremap_wc(addr, size)			ioremap((addr), (size))
 #define ioremap_wt(addr, size)			ioremap((addr), (size))
 
-- 
2.20.1

