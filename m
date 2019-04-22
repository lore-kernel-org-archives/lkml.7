Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3BCC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E752075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Kf88BwfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfDVJr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:47:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDVJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:47:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3M9l6Be1583137
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Apr 2019 02:47:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3M9l6Be1583137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555926426;
        bh=eNIsBiO73sq+41Uwvb49OR9RHQ+uVef++R88ebPPZw8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Kf88BwfHkfi0PQ0fz2fy2w4tR8ILhKYkRm5nZYZqUfXZnFRYdvD84tyRfhH5cX26c
         ignghodrk6Vel4Kc18ketNO0zigSFJGim/zctJNzw+ddFDWZYGG+wm6PU0imZa8IDZ
         o+uzKKEdwdGZDWpQOda0CqUKztpZX0AjdzgPIfkazxz/sNS6rP466Zl6COAD2X9Yza
         bBX8eS6lgelCmXxIib1uhPCKMlCwljhq1/YuqeuPp0rgCc9jbX4HF2bmmVom+refyH
         /QL2y7ptFveIIRMasNxp6JyK1ATKff/otIsUNFRXoL+OsdAPYeSLpaWlbGRCxgZWnw
         AJ1OUQaU/VELQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3M9l1091583133;
        Mon, 22 Apr 2019 02:47:01 -0700
Date:   Mon, 22 Apr 2019 02:47:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiang Biao <tipbot@zytor.com>
Message-ID: <tip-2c4645439e8f2f6e7c37f158feae6f6a82baa910@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, benbjiang@tencent.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: benbjiang@tencent.com, peterz@infradead.org, tglx@linutronix.de,
          mingo@kernel.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190422024943.71918-1-benbjiang@tencent.com>
References: <20190422024943.71918-1-benbjiang@tencent.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq: Fix outdated comments
Git-Commit-ID: 2c4645439e8f2f6e7c37f158feae6f6a82baa910
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

Commit-ID:  2c4645439e8f2f6e7c37f158feae6f6a82baa910
Gitweb:     https://git.kernel.org/tip/2c4645439e8f2f6e7c37f158feae6f6a82baa910
Author:     Jiang Biao <benbjiang@tencent.com>
AuthorDate: Mon, 22 Apr 2019 10:49:43 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Apr 2019 11:42:59 +0200

x86/irq: Fix outdated comments

INVALIDATE_TLB_VECTOR_START has been removed by:

  52aec3308db8("x86/tlb: replace INVALIDATE_TLB_VECTOR by CALL_FUNCTION_VECTOR")

while VSYSCALL_EMU_VECTO(204) has also been removed, by:

  3ae36655b97a("x86-64: Rework vsyscall emulation and add vsyscall= parameter")

so update the comments in <asm/irq_vectors.h> accordingly.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Link: http://lkml.kernel.org/r/20190422024943.71918-1-benbjiang@tencent.com
[ Improved the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/irq_vectors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 548d90bbf919..889f8b1b5b7f 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -18,8 +18,8 @@
  *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
  *  Vectors  32 ... 127 : device interrupts
  *  Vector  128         : legacy int80 syscall interface
- *  Vectors 129 ... INVALIDATE_TLB_VECTOR_START-1 except 204 : device interrupts
- *  Vectors INVALIDATE_TLB_VECTOR_START ... 255 : special interrupts
+ *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
+ *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
  *
  * 64-bit x86 has per CPU IDT tables, 32-bit has one shared IDT table.
  *
