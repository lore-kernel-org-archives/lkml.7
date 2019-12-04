Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83892C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E25720675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSbbWoEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLDAHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 19:07:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLDAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2KtDmWdvGCmxR2mK0YiKHb1fX6wYNN4zJ9xjwFiMUgY=; b=sSbbWoEo7m0ZysVS1/j+8In3k
        17b5idWPoNt6AeraONIVGM1rX2dkfj1ulbHtaVeMZt1vV0G/1nwIaYLgDbhSzxShWMeaVaUVRAElI
        Ji+p4+8A3payLnl0Fwhpttr9Qj8l8nyla30kyJIDImsiNzCIxx0yephmwWuE0eseLZ7KpKk+LtEDR
        jOND6xztFbTzzCBEt7AgasUq+giRTb2AuEPJgoxgZvlxeuZNd8DNLwIVYZQWBqB3fOLQ6CcPxO8cv
        qXu2eiYy9/GSb0GoeQQTr+leRVVNuq7h4+Nf1fUoBRiTeBWrR1gh8ISYA4W1WjeY+T37y/co/LT7e
        ZhCJC6r4g==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icIC6-0003xa-CW; Wed, 04 Dec 2019 00:07:02 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] x86: fix NUMA Kconfig help text
Message-ID: <1aff275a-b71b-e1dc-a137-caff06a8538f@infradead.org>
Date:   Tue, 3 Dec 2019 16:07:01 -0800
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

Fix minor NUMA-related Kconfig text:

- Use capitals letters for NUMA acronym.
- Hyphenate Non-Uniform.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: x86@kernel.org
---
 arch/x86/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-54.orig/arch/x86/Kconfig
+++ lnx-54/arch/x86/Kconfig
@@ -1554,12 +1554,12 @@ config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 
 # Common NUMA Features
 config NUMA
-	bool "Numa Memory Allocation and Scheduler Support"
+	bool "NUMA Memory Allocation and Scheduler Support"
 	depends on SMP
 	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
 	default y if X86_BIGSMP
 	---help---
-	  Enable NUMA (Non Uniform Memory Access) support.
+	  Enable NUMA (Non-Uniform Memory Access) support.
 
 	  The kernel will try to allocate memory used by a CPU on the
 	  local memory controller of the CPU and add some more


