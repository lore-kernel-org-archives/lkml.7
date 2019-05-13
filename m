Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CDC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD721479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y3gzEAIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfEMJK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:10:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfEMJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:10:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4D9ARM23449154
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 13 May 2019 02:10:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4D9ARM23449154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557738628;
        bh=LW7RaAhTHnFGb/D0ckNxHjb2HrqYgHigrR7E5Mtwdxs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Y3gzEAILKVuVjCC+UoKFUiHQ74vNjis7WlB9zwLQruYf9bn3ez8iKxkyQFGY1h03V
         0mmenmnIax+6MyYfiH7+dxmQ8bmn49BW4us0XRY1zSU9w3mc1hrWQaWtq2A9mLkcF5
         0e5O/XtD25KSi2Zfk/Qk9QP40xXQdadDuNPX4R013Ss6v+tnG2/KOvTkeUsWyEXbKp
         nHgTijhQlfu2HuGZl6xRrMaoK8TRUi1V15dD1Haz+s9SPbbOamlvgiQzMVuV0CIxRw
         BDkQWsy6LHTppg2T8PX4Z4EXgZNCWy9KBRCQzKzJQL4ojIBhyZV3QXP0Jar/0+hKkA
         XqfhS9DcMhJRg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4D9ARJp3449149;
        Mon, 13 May 2019 02:10:27 -0700
Date:   Mon, 13 May 2019 02:10:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-409ca45526a428620d8efb362ccfd4b1e6b80642@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        yamada.masahiro@socionext.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        ubizjak@gmail.com
Reply-To: torvalds@linux-foundation.org, yamada.masahiro@socionext.com,
          linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
          mingo@kernel.org, ubizjak@gmail.com, peterz@infradead.org,
          hpa@zytor.com
In-Reply-To: <1557665521-17570-1-git-send-email-yamada.masahiro@socionext.com>
References: <1557665521-17570-1-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/kconfig: Disable CONFIG_GENERIC_HWEIGHT and
 remove __HAVE_ARCH_SW_HWEIGHT
Git-Commit-ID: 409ca45526a428620d8efb362ccfd4b1e6b80642
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

Commit-ID:  409ca45526a428620d8efb362ccfd4b1e6b80642
Gitweb:     https://git.kernel.org/tip/409ca45526a428620d8efb362ccfd4b1e6b80642
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Sun, 12 May 2019 21:52:01 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 13 May 2019 11:07:33 +0200

x86/kconfig: Disable CONFIG_GENERIC_HWEIGHT and remove __HAVE_ARCH_SW_HWEIGHT

Remove an unnecessary arch complication:

arch/x86/include/asm/arch_hweight.h uses __sw_hweight{32,64} as
alternatives, and they are implemented in arch/x86/lib/hweight.S

x86 does not rely on the generic C implementation lib/hweight.c
at all, so CONFIG_GENERIC_HWEIGHT should be disabled.

__HAVE_ARCH_SW_HWEIGHT is not necessary either.

No change in functionality intended.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: http://lkml.kernel.org/r/1557665521-17570-1-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig                    | 3 ---
 arch/x86/include/asm/arch_hweight.h | 2 --
 lib/hweight.c                       | 4 ----
 3 files changed, 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0a3cc347143f..de071d7e67b6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -261,9 +261,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	bool
 
-config GENERIC_HWEIGHT
-	def_bool y
-
 config ARCH_MAY_HAVE_PC_FDC
 	def_bool y
 	depends on ISA_DMA_API
diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index fc0693569f7a..ba88edd0d58b 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -12,8 +12,6 @@
 #define REG_OUT "a"
 #endif
 
-#define __HAVE_ARCH_SW_HWEIGHT
-
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
diff --git a/lib/hweight.c b/lib/hweight.c
index 7660d88fd496..c94586b62551 100644
--- a/lib/hweight.c
+++ b/lib/hweight.c
@@ -10,7 +10,6 @@
  * The Hamming Weight of a number is the total number of bits set in it.
  */
 
-#ifndef __HAVE_ARCH_SW_HWEIGHT
 unsigned int __sw_hweight32(unsigned int w)
 {
 #ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
@@ -27,7 +26,6 @@ unsigned int __sw_hweight32(unsigned int w)
 #endif
 }
 EXPORT_SYMBOL(__sw_hweight32);
-#endif
 
 unsigned int __sw_hweight16(unsigned int w)
 {
@@ -46,7 +44,6 @@ unsigned int __sw_hweight8(unsigned int w)
 }
 EXPORT_SYMBOL(__sw_hweight8);
 
-#ifndef __HAVE_ARCH_SW_HWEIGHT
 unsigned long __sw_hweight64(__u64 w)
 {
 #if BITS_PER_LONG == 32
@@ -69,4 +66,3 @@ unsigned long __sw_hweight64(__u64 w)
 #endif
 }
 EXPORT_SYMBOL(__sw_hweight64);
-#endif
