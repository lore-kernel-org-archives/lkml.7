Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DEFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DDD20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNvxZF+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfLDAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 19:06:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLDAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IM+PKkKail1pE96xE6nqz6r5Q7wnGRk237iXDfr/sHE=; b=hNvxZF+ygKSZr6liz3AOtfR/n
        b1mQtF1O+bjIzfv2nzGt7lq+mjHJjCAoweZdJMDVXnuyZx4Ii6xZBFH30zJOOeeK/aNzHnH4Ayv3S
        PZdLmoiDo/92fpOOP+UJwqpU+okjIIA+C+QC/VsBPCPSoYhgIZPZSQlGyT+0wumqWcYI5OBZRMP5T
        DKr2RlUdjsSVetW/SdAUXa0Q/kFnkjr44YVUuVx76SnLMPDpWKEYfDVL9O7vRKUbCrnqXPjQ/URTM
        olS8dlOiRFfpi8HypAdlmbRcp+h4bJo0LobLkkw+duc9F0C3+U82dldS8D7ynWCJpOwO9u8SJPFW/
        Gr6zcGddg==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icIBs-0003pq-5Y; Wed, 04 Dec 2019 00:06:48 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] x86: fix Kconfig punctuation for X86_BIGSMP
Message-ID: <443ed0a8-783d-6c7c-3258-e1c44df03fd7@infradead.org>
Date:   Tue, 3 Dec 2019 16:06:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

End a sentence with a period (aka full stop) in Kconfig
help text.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: x86@kernel.org
---
 arch/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-54.orig/arch/x86/Kconfig
+++ lnx-54/arch/x86/Kconfig
@@ -476,7 +476,7 @@ config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
 	depends on SMP
 	---help---
-	  This option is needed for the systems that have more than 8 CPUs
+	  This option is needed for the systems that have more than 8 CPUs.
 
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"

