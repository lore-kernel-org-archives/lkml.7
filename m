Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30D3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EBC24A74
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JsTNyu0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfFDHPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:15:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfFDHPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fMf3b6bg5LyqgpEH+kDoDuxBDE3IWF5sv16TMGitWo0=; b=JsTNyu0dpJkQj/tlFp5A/q7HzT
        svGefZTxklfSTgzKnLpeupEUihJNjvW5qTX7oFQYrsx8kbQzbyBEN2VgUxWYhplVR2SaJnmYe0JrI
        eiOeYJGBuCGjB0mSJJ3MUNfmGqLSKNnEpbYqEpczi4c7ohn9NWskQrfLgL6+3KKgWQeOovwrO4MT5
        uDGmWNGly924DqYCQquWIlxwrzA7DV5vi046bIRTGJMku+1EswOBR51GKNghrCzKhmbE9JrQsALhS
        m1t7itXCAwcLCMrQ93GYUCPY61xRwrNhW7LYJCyXzRbAlTfu7n3ZK5I3f++h1euL7s94I8RUj4nt0
        BnIjD8DQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY3fU-0004EO-8M; Tue, 04 Jun 2019 07:15:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/fpu: remove the fpu__save export
Date:   Tue,  4 Jun 2019 09:15:24 +0200
Message-Id: <20190604071524.12835-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604071524.12835-1-hch@lst.de>
References: <20190604071524.12835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is only use by the core fpu code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/fpu/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 03c2d306e6f2..5e0240d029fd 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -133,7 +133,6 @@ void fpu__save(struct fpu *fpu)
 	trace_x86_fpu_after_save(fpu);
 	fpregs_unlock();
 }
-EXPORT_SYMBOL_GPL(fpu__save);
 
 /*
  * Legacy x87 fpstate state init:
-- 
2.20.1

