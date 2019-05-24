Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0537C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B0520879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hOYmy/JX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbfEXIAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:00:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59967 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389001AbfEXIAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:00:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O7w4Tb114801
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 00:58:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O7w4Tb114801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558684685;
        bh=vN9cOtYt2QHny5PGLta3R0axse/CYhigz4jDBZWA6Xc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hOYmy/JXzEz7jz09FUgQ/2SoTGW9/dM4S3atoRi5C+9WiSzgFXsJoDShScrwZP+e4
         3hpFeRJPPc39QHzqo7JcuqNTWyzIi6fWiPWsVxki4nTozVS6WRNOo/+VBaP3eBHHz7
         8ruWrw6J+N+dvhTh6qnR5mIhaCbAOVMunS5GILRfVaCBxhj1hSGfKlTpv0ExxHDsyP
         iTXsLWKAh/jzbe/lRsB7nkN1qE6R/BcB+fU8kcpsh5L5B7xJZ+eqOZshIyK9DSDiI1
         +h6YVrL0Yd2epr3CG24jDA+djPG6Zr17buPCGOnxSBGRWH+xxGHMvSW9o8ISyRVWLy
         LI+MntP58/a1A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O7w3uH114795;
        Fri, 24 May 2019 00:58:03 -0700
Date:   Fri, 24 May 2019 00:58:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e05196401657cff3178dc392b739e520b26d4aef@git.kernel.org>
Cc:     bp@alien8.de, jgross@suse.com, brgerst@gmail.com,
        peterz@infradead.org, riel@surriel.com, tglx@linutronix.de,
        luto@kernel.org, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com
Reply-To: dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tglx@linutronix.de, luto@kernel.org,
          dvlasenk@redhat.com, riel@surriel.com, peterz@infradead.org,
          brgerst@gmail.com, torvalds@linux-foundation.org,
          mingo@kernel.org, bp@alien8.de, jgross@suse.com
In-Reply-To: <20190424134223.501598258@linutronix.de>
References: <20190424134223.501598258@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Remove bogus extern declarations
Git-Commit-ID: e05196401657cff3178dc392b739e520b26d4aef
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

Commit-ID:  e05196401657cff3178dc392b739e520b26d4aef
Gitweb:     https://git.kernel.org/tip/e05196401657cff3178dc392b739e520b26d4aef
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 24 Apr 2019 15:41:16 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 11:35:55 +0200

x86/paravirt: Remove bogus extern declarations

These functions are already declared in asm/paravirt.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Link: http://lkml.kernel.org/r/20190424134223.501598258@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/paravirt_patch_32.c | 3 ---
 arch/x86/kernel/paravirt_patch_64.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index de138d3912e4..05d771f81e74 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -23,9 +23,6 @@ DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
 DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
 #endif
 
-extern bool pv_is_native_spin_unlock(void);
-extern bool pv_is_native_vcpu_is_preempted(void);
-
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
 #define PATCH_SITE(ops, x)					\
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 9d9e04b31077..bd1558f90cfb 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -29,9 +29,6 @@ DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
 DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
 #endif
 
-extern bool pv_is_native_spin_unlock(void);
-extern bool pv_is_native_vcpu_is_preempted(void);
-
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
 #define PATCH_SITE(ops, x)					\
