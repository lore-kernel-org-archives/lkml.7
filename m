Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31626C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F191A217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AKNaxSXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDYHb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:31:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfDYHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:31:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3P7VAai3004800
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Apr 2019 00:31:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3P7VAai3004800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556177471;
        bh=67myhOhw289xTpaB/LuRTwKmFVTIcIhpDwHmcWYKWf0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AKNaxSXrDazjjtzs9B8809ZFjJOB4aUyzjZUFIqG/V3pJ6sayCv9Cqw6woBdUbECP
         eYgQ14ybR1gPQLIWRAQsp72cgEksv8opwI0Mb1m6BX+pdpWtf+snyeySCUmXpLb6V1
         U3/uQDoxXKdF3bPtqPmQiqFgvBAV0rgVwXnqHvjGLJOTksTWXfgm68bJyMb+IlKtLc
         ZT8JgMOTyizbnxRVnqki38YCl9rJFlKjZdxzf8t0EKXWlZ+FSWjhMibkhxTVU3tccc
         fpJ1WC8LOkg0723Ya5WrPuZ+qvsMRh1cnUravsf49RmHntDPxJ7LI1jf2b+y/cZUIB
         Zz0H1zhYG5d/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3P7VAE73004797;
        Thu, 25 Apr 2019 00:31:10 -0700
Date:   Thu, 25 Apr 2019 00:31:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-465f81857c16ae17f461e4738ceb1f4f8cce2077@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jgross@suse.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          jgross@suse.com, mingo@kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com
In-Reply-To: <20190424134223.501598258@linutronix.de>
References: <20190424134223.501598258@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Remove bogus extern declarations
Git-Commit-ID: 465f81857c16ae17f461e4738ceb1f4f8cce2077
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

Commit-ID:  465f81857c16ae17f461e4738ceb1f4f8cce2077
Gitweb:     https://git.kernel.org/tip/465f81857c16ae17f461e4738ceb1f4f8cce2077
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 24 Apr 2019 15:41:16 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 08:45:01 +0200

x86/paravirt: Remove bogus extern declarations

These functions are already declared in asm/paravirt.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
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
