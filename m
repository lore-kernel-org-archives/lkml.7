Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C4C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856D220879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IzHxSC11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfEXIB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:01:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389107AbfEXIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:01:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O81QDL115529
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:01:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O81QDL115529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558684887;
        bh=wU1wye6VwFxbTxc1rlgCig3dc5q1Lv5STGKTdQuFUhE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IzHxSC11t4+aMOEpfqW5SZEGSKwztpGjveLqkdMylZggtJDjafaczCj2mAXPT1FLt
         ErziPOjgMIiIbQ4sMYnGGXWyvpljwvm3yv+mi7Kc6cfegoygjtNyp6lNw3BFBl4ptI
         fH93NrwulB5VXkRr+KVQxcTSZl/3rm9Y4JkW4MXS3qL2g2OZfv0lIAnNVt7Q/IuXtW
         LOhwKLdjhBDUNcBrXxnIEFscL01xqmabKik14b8Cr7QBlj/jZySpI9dt8J/ooCGION
         YZZbyMAyl7gAgcYrZYyEIOf1ne0YFCMQgUUzOgtSCJirCiD1jkePgBg6jdsT7pgMr7
         jIfAetxcrrSdA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O81Q32115525;
        Fri, 24 May 2019 01:01:26 -0700
Date:   Fri, 24 May 2019 01:01:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-fc93dfd9345bb8b29a62b21cb0447dd1a3815f91@git.kernel.org>
Cc:     brgerst@gmail.com, torvalds@linux-foundation.org, jgross@suse.com,
        peterz@infradead.org, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, hpa@zytor.com,
        luto@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        riel@surriel.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, riel@surriel.com, mingo@kernel.org,
          dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
          bp@alien8.de, linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
          peterz@infradead.org, jgross@suse.com,
          torvalds@linux-foundation.org, brgerst@gmail.com
In-Reply-To: <20190425081012.GA115378@gmail.com>
References: <20190425081012.GA115378@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Match paravirt patchlet field
 definition ordering to initialization ordering
Git-Commit-ID: fc93dfd9345bb8b29a62b21cb0447dd1a3815f91
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

Commit-ID:  fc93dfd9345bb8b29a62b21cb0447dd1a3815f91
Gitweb:     https://git.kernel.org/tip/fc93dfd9345bb8b29a62b21cb0447dd1a3815f91
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Thu, 25 Apr 2019 10:10:12 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 12:00:44 +0200

x86/paravirt: Match paravirt patchlet field definition ordering to initialization ordering

Here's the objdump -D output of the PATCH_XXL data table:

0000000000000010 <patch_data_xxl>:
  10:   fa                      cli
  11:   fb                      sti
  12:   57                      push   %rdi
  13:   9d                      popfq
  14:   9c                      pushfq
  15:   58                      pop    %rax
  16:   0f 20 d0                mov    %cr2,%rax
  19:   0f 20 d8                mov    %cr3,%rax
  1c:   0f 22 df                mov    %rdi,%cr3
  1f:   0f 09                   wbinvd
  21:   0f 01 f8                swapgs
  24:   48 0f 07                sysretq
  27:   0f 01 f8                swapgs
  2a:   48 89 f8                mov    %rdi,%rax

Note how this doesn't match up to the source code:

static const struct patch_xxl patch_data_xxl = {
        .irq_irq_disable        = { 0xfa },             // cli
        .irq_irq_enable         = { 0xfb },             // sti
        .irq_save_fl            = { 0x9c, 0x58 },       // pushf; pop %[re]ax
        .mmu_read_cr2           = { 0x0f, 0x20, 0xd0 }, // mov %cr2, %[re]ax
        .mmu_read_cr3           = { 0x0f, 0x20, 0xd8 }, // mov %cr3, %[re]ax
        .irq_restore_fl         = { 0x57, 0x9d },       // push %rdi; popfq
        .mmu_write_cr3          = { 0x0f, 0x22, 0xdf }, // mov %rdi, %cr3
        .cpu_wbinvd             = { 0x0f, 0x09 },       // wbinvd
        .cpu_usergs_sysret64    = { 0x0f, 0x01, 0xf8,
                                    0x48, 0x0f, 0x07 }, // swapgs; sysretq
        .cpu_swapgs             = { 0x0f, 0x01, 0xf8 }, // swapgs
        .mov64                  = { 0x48, 0x89, 0xf8 }, // mov %rdi, %rax
        .irq_restore_fl         = { 0x50, 0x9d },       // push %eax; popf
        .mmu_write_cr3          = { 0x0f, 0x22, 0xd8 }, // mov %eax, %cr3
        .cpu_iret               = { 0xcf },             // iret
};

Note how they are reordered: in the generated code .irq_restore_fl comes
before .irq_save_fl, etc. This is because the field ordering in struct
patch_xxl does not match the initialization ordering of patch_data_xxl.

Match up the initialization order with the definition order - this makes
the disassembly easily reviewable:

0000000000000010 <patch_data_xxl>:
  10:   fa                      cli
  11:   fb                      sti
  12:   9c                      pushfq
  13:   58                      pop    %rax
  14:   0f 20 d0                mov    %cr2,%rax
  17:   0f 20 d8                mov    %cr3,%rax
  1a:   0f 22 df                mov    %rdi,%cr3
  1d:   57                      push   %rdi
  1e:   9d                      popfq
  1f:   0f 09                   wbinvd
  21:   0f 01 f8                swapgs
  24:   48 0f 07                sysretq
  27:   0f 01 f8                swapgs
  2a:   48 89 f8                mov    %rdi,%rax

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
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190425081012.GA115378@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/paravirt_patch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 60e7a5e236c0..37b1d43d1e17 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -21,11 +21,11 @@
 struct patch_xxl {
 	const unsigned char	irq_irq_disable[1];
 	const unsigned char	irq_irq_enable[1];
-	const unsigned char	irq_restore_fl[2];
 	const unsigned char	irq_save_fl[2];
 	const unsigned char	mmu_read_cr2[3];
 	const unsigned char	mmu_read_cr3[3];
 	const unsigned char	mmu_write_cr3[3];
+	const unsigned char	irq_restore_fl[2];
 # ifdef CONFIG_X86_64
 	const unsigned char	cpu_wbinvd[2];
 	const unsigned char	cpu_usergs_sysret64[6];
@@ -43,16 +43,16 @@ static const struct patch_xxl patch_data_xxl = {
 	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
 	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
 # ifdef CONFIG_X86_64
-	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
+	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
 	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
 				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
 	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 # else
-	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
+	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
 	.cpu_iret		= { 0xcf },		// iret
 # endif
 };
