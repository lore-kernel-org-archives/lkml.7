Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D11C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60852084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfDJIsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:48:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49047 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfDJIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:48:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3A8lTKx699861
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 01:47:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3A8lSg3699857;
        Wed, 10 Apr 2019 01:47:28 -0700
Date:   Wed, 10 Apr 2019 01:47:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-547571b5abe61bb33c6005d8981e86e3c61fedcc@git.kernel.org>
Cc:     jbeulich@suse.com, boris.ostrovsky@oracle.com, dvlasenk@redhat.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, bp@alien8.de,
        hpa@zytor.com, mingo@kernel.org, brgerst@gmail.com,
        jgross@suse.com, JBeulich@suse.com, luto@amacapital.net,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: brgerst@gmail.com, mingo@kernel.org, hpa@zytor.com, bp@alien8.de,
          torvalds@linux-foundation.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, luto@amacapital.net,
          JBeulich@suse.com, jgross@suse.com, boris.ostrovsky@oracle.com,
          jbeulich@suse.com, tglx@linutronix.de, dvlasenk@redhat.com
In-Reply-To: <5C9B93870200007800222289@prv1-mh.provo.novell.com>
References: <5C9B93870200007800222289@prv1-mh.provo.novell.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Modernize sync_bitops.h
Git-Commit-ID: 547571b5abe61bb33c6005d8981e86e3c61fedcc
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

Commit-ID:  547571b5abe61bb33c6005d8981e86e3c61fedcc
Gitweb:     https://git.kernel.org/tip/547571b5abe61bb33c6005d8981e86e3c61fedcc
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Wed, 27 Mar 2019 09:15:19 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 09:53:31 +0200

x86/asm: Modernize sync_bitops.h

Add missing instruction suffixes and use rmwcc.h just like was (more or less)
recently done for bitops.h as well, see:

  22636f8c9511: x86/asm: Add instruction suffixes to bitops
  288e4521f0f6: x86/asm: 'Simplify' GEN_*_RMWcc() macros

No change in functionality intended.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/5C9B93870200007800222289@prv1-mh.provo.novell.com
[ Cleaned up the changelog a bit. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/sync_bitops.h | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/sync_bitops.h b/arch/x86/include/asm/sync_bitops.h
index 2fe745356fb1..6d8d6bc183b7 100644
--- a/arch/x86/include/asm/sync_bitops.h
+++ b/arch/x86/include/asm/sync_bitops.h
@@ -14,6 +14,8 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
+#include <asm/rmwcc.h>
+
 #define ADDR (*(volatile long *)addr)
 
 /**
@@ -29,7 +31,7 @@
  */
 static inline void sync_set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; bts %1,%0"
+	asm volatile("lock; " __ASM_SIZE(bts) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -47,7 +49,7 @@ static inline void sync_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; btr %1,%0"
+	asm volatile("lock; " __ASM_SIZE(btr) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -64,7 +66,7 @@ static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void sync_change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; btc %1,%0"
+	asm volatile("lock; " __ASM_SIZE(btc) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -78,14 +80,9 @@ static inline void sync_change_bit(long nr, volatile unsigned long *addr)
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int sync_test_and_set_bit(long nr, volatile unsigned long *addr)
+static inline bool sync_test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	unsigned char oldbit;
-
-	asm volatile("lock; bts %2,%1\n\tsetc %0"
-		     : "=qm" (oldbit), "+m" (ADDR)
-		     : "Ir" (nr) : "memory");
-	return oldbit;
+	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(bts), *addr, c, "Ir", nr);
 }
 
 /**
@@ -98,12 +95,7 @@ static inline int sync_test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	unsigned char oldbit;
-
-	asm volatile("lock; btr %2,%1\n\tsetc %0"
-		     : "=qm" (oldbit), "+m" (ADDR)
-		     : "Ir" (nr) : "memory");
-	return oldbit;
+	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btr), *addr, c, "Ir", nr);
 }
 
 /**
@@ -116,12 +108,7 @@ static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline int sync_test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	unsigned char oldbit;
-
-	asm volatile("lock; btc %2,%1\n\tsetc %0"
-		     : "=qm" (oldbit), "+m" (ADDR)
-		     : "Ir" (nr) : "memory");
-	return oldbit;
+	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
 #define sync_test_bit(nr, addr) test_bit(nr, addr)
