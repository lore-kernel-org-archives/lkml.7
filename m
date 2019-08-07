Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA50C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BD521EF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fug2b3b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbfHGNcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:32:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbfHGNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DDlZ3PlciDMCdlnMfWl/lPT/65XlqwrZdQcrkjYE7pY=; b=fug2b3b67uZxPyTjk34G5Ua3q4
        ID8apIShr1LYID7hdJXyF9+Se1yw5NNIIBHbr2VbRssd8I0bQNH9th/oOube4x3FH083negvWFxQD
        HL5+aJND6p2aZGp+OGQIvUeYIWzwrSpYKAmb48gC96LsNRjJhMHwUKpwDbgNHQIHfUBIUhfTkJfLN
        7RJwvZW4v93zCeYbDllg4N50gzS+Ugd5t8s9m0aEu6D63g83hvJA0zj8tkc9q27C2/iWcawKlHSJx
        64HE8QnPrGAZCB+duHUTQ/07oR3nRkF6jGBM3JL9MIWXQxLgX/mVeDRVLRbTaqfEdFV8gMHRHSGPZ
        LxuGs0/Q==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvM2s-0008Cz-Cr; Wed, 07 Aug 2019 13:32:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/29] ia64: remove the unused sn_coherency_id symbol
Date:   Wed,  7 Aug 2019 16:30:42 +0300
Message-Id: <20190807133049.20893-23-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807133049.20893-1-hch@lst.de>
References: <20190807133049.20893-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sn_coherency_id symbol isn't used anywhere, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/uv/kernel/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/ia64/uv/kernel/setup.c b/arch/ia64/uv/kernel/setup.c
index 6ac4bd314d92..b081f5138f5c 100644
--- a/arch/ia64/uv/kernel/setup.c
+++ b/arch/ia64/uv/kernel/setup.c
@@ -16,9 +16,6 @@
 DEFINE_PER_CPU(struct uv_hub_info_s, __uv_hub_info);
 EXPORT_PER_CPU_SYMBOL_GPL(__uv_hub_info);
 
-long sn_coherency_id;
-EXPORT_SYMBOL_GPL(sn_coherency_id);
-
 struct redir_addr {
 	unsigned long redirect;
 	unsigned long alias;
-- 
2.20.1

