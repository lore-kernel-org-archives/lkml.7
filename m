Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2305C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5E12075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfCKNj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:39:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfCKNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:39:56 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MfHQp-1gadFK40iJ-00grDI; Mon, 11 Mar 2019 14:39:54 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     luto@amacapital.net, wad@chromium.org
Subject: [PATCH] arch: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:39:52 +0100
Message-Id: <1552311592-18060-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:CcgJiMmr7Y3dcvLO3hZqll609I6zDInyK89lLQtttlcT3Pi1jfR
 wzazBD1uU5VIMiUh1To5RriyJICbJ1jCb2lqWx4FPZGXh1nclh3olRGc2jaB1s+87td1gDw
 BrGkAOzu7FQSkIwmsdOOb2KqwEMXRJS3cZDJfEaji7GVQS//scMGSN5qckH5mJrq9KKvf03
 Ar4ocA23uzHV6vZCP4dxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2IW4nwaKPpc=:ufjgXdB92V0iX3cCg4yhJR
 qOKTpbG8IEXVc9mf+kw+X1g9uoYe/kz1l+aFev8BFWiy9LQti2PdIdbRwe0T5gRnQVqlau3ly
 W2hYNtDhgcxc3MEvBcisGXRUI18OIbgOVZ1XhNl7fB7/RgIlOO/fV1i8wCaS2FNrgCkzfE7JO
 CeE9Ui5egwOGlJQhM8C/qe3bWcNf7CC+p+Gj2NjDfhBzlckhgfWb7a7SaRsC3GK9GFwtayx4a
 dykFbnT+8D70oQwP4lfuGXb2WZYJAexZaBoQ6RmiAuruKs71VeG/w8hJzqqF7uj0hZcqyfkUb
 /WB5vP36e/Yj9H3lnKyHsxHXviad1ra81v9XB8Xi3sMj7FItiRH7roo3tiPYYZfYN29eMpsMN
 38zscdKthqPEL8ajBxcLNLj1hAgRs8V+M6LGK0pMjf0Bs9dt1GIrF/CRBEiSiivePIOLoGIn/
 Exr0KHifAhxfFGRezQJFTjkZF10pTdSgcumsoPS3uBsu9o+lwrFj9yCczzY8k51FNrVfAnjud
 gniAeXDA+9eiR0oaFRqJ3d2Uok2CW04dQzxWGxCJQmKV/eexHRqXS0Qe8jYZgRzOg+QnOTttG
 /RiNEs9Xuo1uxjq087eekKZ6v1PcovVhTqZQuowGEFFCVR7/sb3vAqgOYtjiMDcdcktyio7XR
 avMx69JcRYkthUamEpikmf1Tk+90sY3n3YrMiGstNxldLx6WqMhFrVvHXZsTle26NA6NtRB7A
 pzZgHscvAc4sQCRXNBPlF7IQBnf9sqyiIT+4LDdnJCUCrlgnkybpP8XSBrAU2jasMleEAqlup
 AwcXCRjC9+kYY1BDsEx3jDrm3xQ0PwxdOIhCnihMxd7sLJsH0S3xFALmODrXr2X6Lomke2yO/
 y3MQy1ezmmbow0ANuBiZpxhEJ7Cf6rkw5hRLgfUK4znsFIlPCpXSLL02TQmJnu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/Kconfig | 94 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 33687dd..41f9c4b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -69,30 +69,30 @@ config KPROBES
 	  If in doubt, say "N".
 
 config JUMP_LABEL
-       bool "Optimize very unlikely/likely branches"
-       depends on HAVE_ARCH_JUMP_LABEL
-       depends on CC_HAS_ASM_GOTO
-       help
-         This option enables a transparent branch optimization that
-	 makes certain almost-always-true or almost-always-false branch
-	 conditions even cheaper to execute within the kernel.
-
-	 Certain performance-sensitive kernel code, such as trace points,
-	 scheduler functionality, networking code and KVM have such
-	 branches and include support for this optimization technique.
-
-         If it is detected that the compiler has support for "asm goto",
-	 the kernel will compile such branches with just a nop
-	 instruction. When the condition flag is toggled to true, the
-	 nop will be converted to a jump instruction to execute the
-	 conditional block of instructions.
-
-	 This technique lowers overhead and stress on the branch prediction
-	 of the processor and generally makes the kernel faster. The update
-	 of the condition is slower, but those are always very rare.
-
-	 ( On 32-bit x86, the necessary options added to the compiler
-	   flags may increase the size of the kernel slightly. )
+	bool "Optimize very unlikely/likely branches"
+	depends on HAVE_ARCH_JUMP_LABEL
+	depends on CC_HAS_ASM_GOTO
+	help
+	  This option enables a transparent branch optimization that
+	  makes certain almost-always-true or almost-always-false branch
+	  conditions even cheaper to execute within the kernel.
+
+	  Certain performance-sensitive kernel code, such as trace points,
+	  scheduler functionality, networking code and KVM have such
+	  branches and include support for this optimization technique.
+
+	  If it is detected that the compiler has support for "asm goto",
+	  the kernel will compile such branches with just a nop
+	  instruction. When the condition flag is toggled to true, the
+	  nop will be converted to a jump instruction to execute the
+	  conditional block of instructions.
+
+	  This technique lowers overhead and stress on the branch prediction
+	  of the processor and generally makes the kernel faster. The update
+	  of the condition is slower, but those are always very rare.
+
+	  ( On 32-bit x86, the necessary options added to the compiler
+	    flags may increase the size of the kernel slightly. )
 
 config STATIC_KEYS_SELFTEST
 	bool "Static key selftest"
@@ -110,9 +110,9 @@ config KPROBES_ON_FTRACE
 	depends on KPROBES && HAVE_KPROBES_ON_FTRACE
 	depends on DYNAMIC_FTRACE_WITH_REGS
 	help
-	 If function tracer is enabled and the arch supports full
-	 passing of pt_regs to function tracing, then kprobes can
-	 optimize on top of function tracing.
+	  If function tracer is enabled and the arch supports full
+	  passing of pt_regs to function tracing, then kprobes can
+	  optimize on top of function tracing.
 
 config UPROBES
 	def_bool n
@@ -164,23 +164,23 @@ config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	  information on the topic of unaligned memory accesses.
 
 config ARCH_USE_BUILTIN_BSWAP
-       bool
-       help
-	 Modern versions of GCC (since 4.4) have builtin functions
-	 for handling byte-swapping. Using these, instead of the old
-	 inline assembler that the architecture code provides in the
-	 __arch_bswapXX() macros, allows the compiler to see what's
-	 happening and offers more opportunity for optimisation. In
-	 particular, the compiler will be able to combine the byteswap
-	 with a nearby load or store and use load-and-swap or
-	 store-and-swap instructions if the architecture has them. It
-	 should almost *never* result in code which is worse than the
-	 hand-coded assembler in <asm/swab.h>.  But just in case it
-	 does, the use of the builtins is optional.
-
-	 Any architecture with load-and-swap or store-and-swap
-	 instructions should set this. And it shouldn't hurt to set it
-	 on architectures that don't have such instructions.
+	bool
+	help
+	  Modern versions of GCC (since 4.4) have builtin functions
+	  for handling byte-swapping. Using these, instead of the old
+	  inline assembler that the architecture code provides in the
+	  __arch_bswapXX() macros, allows the compiler to see what's
+	  happening and offers more opportunity for optimisation. In
+	  particular, the compiler will be able to combine the byteswap
+	  with a nearby load or store and use load-and-swap or
+	  store-and-swap instructions if the architecture has them. It
+	  should almost *never* result in code which is worse than the
+	  hand-coded assembler in <asm/swab.h>.  But just in case it
+	  does, the use of the builtins is optional.
+
+	  Any architecture with load-and-swap or store-and-swap
+	  instructions should set this. And it shouldn't hurt to set it
+	  on architectures that don't have such instructions.
 
 config KRETPROBES
 	def_bool y
@@ -234,10 +234,10 @@ config HAVE_DMA_CONTIGUOUS
 	bool
 
 config GENERIC_SMP_IDLE_THREAD
-       bool
+	bool
 
 config GENERIC_IDLE_POLL_SETUP
-       bool
+	bool
 
 config ARCH_HAS_FORTIFY_SOURCE
 	bool
@@ -251,7 +251,7 @@ config ARCH_HAS_SET_MEMORY
 
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
-       bool
+	bool
 
 # Select if arch has its private alloc_task_struct() function
 config ARCH_TASK_STRUCT_ALLOCATOR
-- 
1.9.1

