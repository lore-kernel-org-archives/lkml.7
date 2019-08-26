Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA434C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB292053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HMtxX467"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfHZN00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:26:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbfHZN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=djaGEic6NaBK09gi+fCrcAouUdZlbuVe4m8rrYkWAaA=; b=HMtxX467OYOhWWY59hNqdCMA59
        gBLtoxsICumbABL0PkrTfLs57pmpCm1VMYgZnKuHh757K4MyGbm931kFbDFzoFZKPcFIegLSdSCJr
        vGva46cHn6bzhhlLr5LwX5AIp4RO172m7u8WMbrh+K4dTVffkNPCavoPAm0rY20AODNFZ9o4bXT6E
        ropSp2LGyGWHegp/NYLJVb0FN2pft3w1ly3Qryx3ZCErgDBrt6jxwxHjt3+6XNgbymi1n5aGtPJcV
        nl6WGpD2LnDY9Cplyu988MXSDmj6HGKbpu5QHvXI7tGsgEOyJ8CMV7nnxk/YL5jz/uBArPnCv/Krr
        vD+FRrBA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2F0R-0007uO-IH; Mon, 26 Aug 2019 13:26:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Guan Xuetao <gxt@pku.edu.cn>, Shawn Anastasio <shawn@anastas.io>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] unicore32: remove the unused pgprot_dmacoherent define
Date:   Mon, 26 Aug 2019 15:25:48 +0200
Message-Id: <20190826132553.4116-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826132553.4116-1-hch@lst.de>
References: <20190826132553.4116-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/unicore32/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/unicore32/include/asm/pgtable.h b/arch/unicore32/include/asm/pgtable.h
index 9492aa304f03..126e961a8cb0 100644
--- a/arch/unicore32/include/asm/pgtable.h
+++ b/arch/unicore32/include/asm/pgtable.h
@@ -198,8 +198,6 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 	__pgprot(pgprot_val(prot) & ~PTE_CACHEABLE)
 #define pgprot_writecombine(prot)	\
 	__pgprot(pgprot_val(prot) & ~PTE_CACHEABLE)
-#define pgprot_dmacoherent(prot)	\
-	__pgprot(pgprot_val(prot) & ~PTE_CACHEABLE)
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd) & PMD_PRESENT)
-- 
2.20.1

