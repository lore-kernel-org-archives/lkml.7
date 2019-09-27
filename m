Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293FFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F2E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfI0ILO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45296 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfI0ILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlL8-0005me-3P; Fri, 27 Sep 2019 10:10:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BE81C1C0440;
        Fri, 27 Sep 2019 10:10:57 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:57 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Clean up the pmd_read_atomic() comments
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156957185765.9866.13900435982443947626.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     44e09568cf2d874cb2a8e2ac35acf71a9ae3402b
Gitweb:        https://git.kernel.org/tip/44e09568cf2d874cb2a8e2ac35acf71a9ae3402b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 25 Sep 2019 08:38:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 10:13:27 +02:00

x86/mm: Clean up the pmd_read_atomic() comments

Fix spelling, consistent parenthesis and grammar - and also clarify
the language where needed.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable-3level.h | 44 +++++++++++++-------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 1796462..5afb5e0 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -36,39 +36,41 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
 
 #define pmd_read_atomic pmd_read_atomic
 /*
- * pte_offset_map_lock on 32bit PAE kernels was reading the pmd_t with
- * a "*pmdp" dereference done by gcc. Problem is, in certain places
- * where pte_offset_map_lock is called, concurrent page faults are
+ * pte_offset_map_lock() on 32-bit PAE kernels was reading the pmd_t with
+ * a "*pmdp" dereference done by GCC. Problem is, in certain places
+ * where pte_offset_map_lock() is called, concurrent page faults are
  * allowed, if the mmap_sem is hold for reading. An example is mincore
  * vs page faults vs MADV_DONTNEED. On the page fault side
- * pmd_populate rightfully does a set_64bit, but if we're reading the
+ * pmd_populate() rightfully does a set_64bit(), but if we're reading the
  * pmd_t with a "*pmdp" on the mincore side, a SMP race can happen
- * because gcc will not read the 64bit of the pmd atomically. To fix
- * this all places running pte_offset_map_lock() while holding the
+ * because GCC will not read the 64-bit value of the pmd atomically.
+ *
+ * To fix this all places running pte_offset_map_lock() while holding the
  * mmap_sem in read mode, shall read the pmdp pointer using this
- * function to know if the pmd is null nor not, and in turn to know if
+ * function to know if the pmd is null or not, and in turn to know if
  * they can run pte_offset_map_lock() or pmd_trans_huge() or other pmd
  * operations.
  *
- * Without THP if the mmap_sem is hold for reading, the pmd can only
- * transition from null to not null while pmd_read_atomic runs. So
+ * Without THP if the mmap_sem is held for reading, the pmd can only
+ * transition from null to not null while pmd_read_atomic() runs. So
  * we can always return atomic pmd values with this function.
  *
- * With THP if the mmap_sem is hold for reading, the pmd can become
+ * With THP if the mmap_sem is held for reading, the pmd can become
  * trans_huge or none or point to a pte (and in turn become "stable")
- * at any time under pmd_read_atomic. We could read it really
- * atomically here with a atomic64_read for the THP enabled case (and
+ * at any time under pmd_read_atomic(). We could read it truly
+ * atomically here with an atomic64_read() for the THP enabled case (and
  * it would be a whole lot simpler), but to avoid using cmpxchg8b we
  * only return an atomic pmdval if the low part of the pmdval is later
- * found stable (i.e. pointing to a pte). And we're returning a none
- * pmdval if the low part of the pmd is none. In some cases the high
- * and low part of the pmdval returned may not be consistent if THP is
- * enabled (the low part may point to previously mapped hugepage,
- * while the high part may point to a more recently mapped hugepage),
- * but pmd_none_or_trans_huge_or_clear_bad() only needs the low part
- * of the pmd to be read atomically to decide if the pmd is unstable
- * or not, with the only exception of when the low part of the pmd is
- * zero in which case we return a none pmd.
+ * found to be stable (i.e. pointing to a pte). We are also returning a
+ * 'none' (zero) pmdval if the low part of the pmd is zero.
+ *
+ * In some cases the high and low part of the pmdval returned may not be
+ * consistent if THP is enabled (the low part may point to previously
+ * mapped hugepage, while the high part may point to a more recently
+ * mapped hugepage), but pmd_none_or_trans_huge_or_clear_bad() only
+ * needs the low part of the pmd to be read atomically to decide if the
+ * pmd is unstable or not, with the only exception when the low part
+ * of the pmd is zero, in which case we return a 'none' pmd.
  */
 static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 {
