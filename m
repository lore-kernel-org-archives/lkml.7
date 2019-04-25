Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B8C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0199217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lKjyhnT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfDYHeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:34:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60577 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfDYHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:34:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3P7WgMC3004961
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Apr 2019 00:32:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3P7WgMC3004961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556177563;
        bh=RGcMisWW/6jsGL1BORw7d4Dh3jILUKMCU3LzbBb1qjM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lKjyhnT3D5THFYp2vWQyj2hO+7AXNsZMLGh4L28rBvDwD9J3l9RMjCKcj+keK0omp
         jL5JeKBaDeNDc5UyIHOEQ/OWIWPjwIsWF/VzWwAokjgCoB5RnSTOmUS8/aCJewwJWH
         z0DYXFHoTCQ1mJFvC/bFNiMxR0QyVPaaXPy3DTtjgOAfBKTAHbVqqeU4cESzK+P6B7
         xHbzEFjIK+Q6xA6ndO/Q7vpqnBviCEzEIFPGXt1SnDT0yjQB1G2ysze5KdVShnuYve
         Yezvfl/NycDybOvTx7gf4nWtmciUbSrdFNdZSmVTYf5sQ+fuvUTEZn1gfZadTsY11I
         4xXdBosCj/nuA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3P7WfvJ3004953;
        Thu, 25 Apr 2019 00:32:41 -0700
Date:   Thu, 25 Apr 2019 00:32:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mike Rapoport <tipbot@zytor.com>
Message-ID: <tip-6ad57f7f2cbf65daced27f023cc99360742a24b9@git.kernel.org>
Cc:     luto@kernel.org, hch@infradead.org, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        peterz@infradead.org, rppt@linux.ibm.com,
        dave.hansen@linux.intel.com, willy@infradead.org,
        tglx@linutronix.de, riel@surriel.com,
        torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          riel@surriel.com, hpa@zytor.com, torvalds@linux-foundation.org,
          mingo@kernel.org, luto@kernel.org, hch@infradead.org,
          bp@alien8.de, peterz@infradead.org, mgorman@techsingularity.net,
          willy@infradead.org, rppt@linux.ibm.com,
          dave.hansen@linux.intel.com
In-Reply-To: <1556112252-9339-2-git-send-email-rppt@linux.ibm.com>
References: <1556112252-9339-2-git-send-email-rppt@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/Kconfig: Make SPARSEMEM default for 32-bit x86
Git-Commit-ID: 6ad57f7f2cbf65daced27f023cc99360742a24b9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6ad57f7f2cbf65daced27f023cc99360742a24b9
Gitweb:     https://git.kernel.org/tip/6ad57f7f2cbf65daced27f023cc99360742a24b9
Author:     Mike Rapoport <rppt@linux.ibm.com>
AuthorDate: Wed, 24 Apr 2019 16:24:11 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 09:02:17 +0200

x86/Kconfig: Make SPARSEMEM default for 32-bit x86

Sparsemem has been a default memory model for x86-64 for over a decade,
since:

  b263295dbffd ("x86: 64-bit, make sparsemem vmemmap the only memory model").

Make it the default for 32-bit NUMA systems (if there any left) as well.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/1556112252-9339-2-git-send-email-rppt@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..0b91756ed980 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1609,10 +1609,6 @@ config ARCH_DISCONTIGMEM_ENABLE
 	def_bool y
 	depends on NUMA && X86_32
 
-config ARCH_DISCONTIGMEM_DEFAULT
-	def_bool y
-	depends on NUMA && X86_32
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
@@ -1620,8 +1616,7 @@ config ARCH_SPARSEMEM_ENABLE
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
-	def_bool y
-	depends on X86_64
+	def_bool X86_64 || (NUMA && X86_32)
 
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
