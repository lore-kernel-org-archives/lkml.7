Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E28DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C9217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FkCZIMcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfDJICv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:02:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfDJICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tk6DNiEIeFsDsGwywyWXjRAK6TPLB/fxahYqD+4pjHw=; b=FkCZIMcfJ693XyKrNv1YvaHABo
        V3YsnSjgIDJz62jFNH+y/IUi8MJ2Qe3r3jjVVafBevokolAVcrC87v4aZsfTMlkLYBd2e7KnMN9ir
        +Y2LtXWEYN280pByTdIq972Y5LtKIS62I2ITARSzX4NtSubZVwiUHXddMMJSOG7J0gOH4DfofuDYS
        sqzkEK279ZHrPokkOaXLVWgfJQ+BiI8PYaHbLzZXwo4L3va9Sgx8u8idxJOlOiOL/Y5LPHQZ4aQyc
        tE7V6CfhxT3r7dt84PQGXUe6gjC2OjCrZ9TjlhfjE9APvtZ//PwA1N+Gb1D+wCHjjNHN9YKzymkMN
        gwl1HuEA==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE8C0-0007XV-Sw; Wed, 10 Apr 2019 08:02:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86: Remove the unused X86_DMA_REMAP kconfig symbol
Date:   Wed, 10 Apr 2019 10:02:19 +0200
Message-Id: <20190410080220.21705-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410080220.21705-1-hch@lst.de>
References: <20190410080220.21705-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..38c62ff8a3f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -704,7 +704,6 @@ config STA2X11
 	depends on X86_32_NON_STANDARD && PCI
 	select ARCH_HAS_PHYS_TO_DMA
 	select X86_DEV_DMA_OPS
-	select X86_DMA_REMAP
 	select SWIOTLB
 	select MFD_STA2X11
 	select GPIOLIB
@@ -2880,10 +2879,6 @@ config X86_DEV_DMA_OPS
 	bool
 	depends on X86_64 || STA2X11
 
-config X86_DMA_REMAP
-	bool
-	depends on STA2X11
-
 config HAVE_GENERIC_GUP
 	def_bool y
 
-- 
2.20.1

