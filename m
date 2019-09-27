Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB1C32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E921E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfI0ILR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45313 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfI0ILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlL8-0005mg-AD; Fri, 27 Sep 2019 10:10:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE9E01C073C;
        Fri, 27 Sep 2019 10:10:57 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:57 -0000
From:   "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Fix function name typo in pmd_read_atomic() comment
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
In-Reply-To: <20190925014453.20236-1-richardw.yang@linux.intel.com>
References: <20190925014453.20236-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156957185789.9866.15298763161487547551.tip-bot2@tip-bot2>
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

Commit-ID:     a2f7a0bfcaaa3928e4876d15edd4dfdc09e139b6
Gitweb:        https://git.kernel.org/tip/a2f7a0bfcaaa3928e4876d15edd4dfdc09e139b6
Author:        Wei Yang <richardw.yang@linux.intel.com>
AuthorDate:    Wed, 25 Sep 2019 09:44:53 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 08:40:19 +02:00

x86/mm: Fix function name typo in pmd_read_atomic() comment

The function involved should be pte_offset_map_lock() and we never have
function pmd_offset_map_lock defined.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190925014453.20236-1-richardw.yang@linux.intel.com
[ Minor edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable-3level.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index e363379..1796462 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -44,10 +44,10 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
  * pmd_populate rightfully does a set_64bit, but if we're reading the
  * pmd_t with a "*pmdp" on the mincore side, a SMP race can happen
  * because gcc will not read the 64bit of the pmd atomically. To fix
- * this all places running pmd_offset_map_lock() while holding the
+ * this all places running pte_offset_map_lock() while holding the
  * mmap_sem in read mode, shall read the pmdp pointer using this
  * function to know if the pmd is null nor not, and in turn to know if
- * they can run pmd_offset_map_lock or pmd_trans_huge or other pmd
+ * they can run pte_offset_map_lock() or pmd_trans_huge() or other pmd
  * operations.
  *
  * Without THP if the mmap_sem is hold for reading, the pmd can only
