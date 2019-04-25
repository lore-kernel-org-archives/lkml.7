Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57391C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243F0217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qVc12468"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfDYHdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:33:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49281 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfDYHdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:33:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3P7XMhb3005261
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Apr 2019 00:33:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3P7XMhb3005261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556177603;
        bh=8V1mYx6tNBtKCY4KfdQiQh5Yzk1UK7Tv9cPHXVrSbUE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qVc124688ZWsV5zyI/8Hyk5wApBzG8iqd5kIxV59BVRZ1mXgHAsO5Suf94AYdmwYC
         BBk2Dp9io7+8VyUxSA3cv7x/qXlv3SU0gbtQ8FpZiDeqkMHRPBnD+yIM1VaSqKr/hp
         E9Qttdx09fh4hGyhduqlhe5G9mFvr6BiI6JDM0pOUFLmfB3X45iocxexxb8g1CTLEv
         8DsW8ReQHLJZRWU//PUO7rXzLcqX0fmJgu9J2/8Cw3rJk2vP+OudNdE76/nYCiCrk3
         1LOm0IMnqnb4m1Ju77Q8rVKxoEIY2aZXuy4cocLqA97rmQLDiRMPtjzJNgfpNMhdUr
         DigCGLZXINB/w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3P7XMKV3005258;
        Thu, 25 Apr 2019 00:33:22 -0700
Date:   Thu, 25 Apr 2019 00:33:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mike Rapoport <tipbot@zytor.com>
Message-ID: <tip-2792107dc3af29ecc1a9b3dc5bc873dac4b61cd6@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, willy@infradead.org,
        tglx@linutronix.de, hch@infradead.org, bp@alien8.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        mgorman@techsingularity.net, luto@kernel.org, riel@surriel.com,
        torvalds@linux-foundation.org, peterz@infradead.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          luto@kernel.org, riel@surriel.com, mgorman@techsingularity.net,
          rppt@linux.ibm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, bp@alien8.de,
          hch@infradead.org, tglx@linutronix.de, willy@infradead.org,
          dave.hansen@linux.intel.com
In-Reply-To: <1556112252-9339-3-git-send-email-rppt@linux.ibm.com>
References: <1556112252-9339-3-git-send-email-rppt@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/Kconfig: Deprecate DISCONTIGMEM support for 32-bit
 x86
Git-Commit-ID: 2792107dc3af29ecc1a9b3dc5bc873dac4b61cd6
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

Commit-ID:  2792107dc3af29ecc1a9b3dc5bc873dac4b61cd6
Gitweb:     https://git.kernel.org/tip/2792107dc3af29ecc1a9b3dc5bc873dac4b61cd6
Author:     Mike Rapoport <rppt@linux.ibm.com>
AuthorDate: Wed, 24 Apr 2019 16:24:12 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 09:02:18 +0200

x86/Kconfig: Deprecate DISCONTIGMEM support for 32-bit x86

Mel Gorman says:

  "32-bit NUMA systems should be non-existent in practice.  The last NUMA
   system I'm aware of that was both NUMA and 32-bit only died somewhere
   between 2004 and 2007. If someone is running a 64-bit capable system in
   32-bit mode with NUMA, they really are just punishing themselves for fun."

Mark DISCONTIGMEM broken for now as suggested by Christoph Hellwig,
and (hopefully) remove it in a couple of releases.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/1556112252-9339-3-git-send-email-rppt@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0b91756ed980..335d6e37f151 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1606,8 +1606,9 @@ config ARCH_FLATMEM_ENABLE
 	depends on X86_32 && !NUMA
 
 config ARCH_DISCONTIGMEM_ENABLE
-	def_bool y
+	def_bool n
 	depends on NUMA && X86_32
+	depends on BROKEN
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
