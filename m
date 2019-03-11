Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A701218E2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCKN3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfCKNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:33 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCKO4-1hBYIb0MeQ-009Naz for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 026/114] arch: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:38 +0100
Message-Id: <1552310346-7629-27-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:STysZOHQFuelGFu5iQKGH7IWL9pi0HPTKbx+CWHVEKWOeja3ZcY
 MFyUZ3ULtCMDjMUMuTMQQ5u/SqDPfWMUGO6bKT/jf9cRjRyId4ka7HVRMej9G9FvzMMEkyT
 j806TETOirLyp+o+pJhRY6Jd7SsBgj44wwaxdmPTp+peMoqOrU3QWp4+qHbagxBELh19WsD
 mQGDOQKWYmlGLh8+lJcNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:08dBMHFiCYU=:wfjzJbKhQaYgqHUzidnAhK
 XihjyCFq/UzIEnk/5Frkg7TEHD8p3omCbrvzlIszVUensAIXiTGSdRuAlVjKw7UuXxMz3tHvu
 5lIBJh5/CEr2zo2osvp719pXIb315bZL4XL5mbmgGyUlA4ngL30l3+Hzga9pipMXgeWLD2JRK
 59dRJ3ojLqGkmgfmo1ZnBYdGfzapv/TWe+lyocXNBPUm1A1ZCWWYwunUR19qJZol1WFjLdda3
 DyVVO9fzdE7sHm7p2YIbq11lEnlEsXNYBV/8Wn9qGJJax8E8D7KGKgPnAkdWaqf8DYKymEFZl
 iWcLuOvQ9KXlZQxJQbm/3z3II0Bwi3etDMCyylwjkO0i6XyonfTR4OQZTODRNLRFY6S5VuDWo
 pW0Om/VYiFimMYSPDqlFilv9Yuv2v9tINzhUWYLLaP+17zMxsPyiibqXm3ezBQhWTkALoY5fw
 pFn26qV4zId216/YaWU5L4KDJ+/h9cprMCSdbze5nvoRPeux7li0YHMiSRNi1QBheaLmd9OYH
 lVyxCR8EEitjZ3qF8qsm1ijlCA/rrwWeVdNHGYNKJCCsyBqSsinuvY68Fz3iR85bpbrU0dRSG
 I0XlpOIRNPm5frUbIWDsn+R7X70XTkQkNWvqrwnS4aQZ12VURApTzulESOsBQKPBS8+JOPGKp
 4kaTeYovvQNLhgtLXUwGmtVyyUiAEeJxIX4jPqfHir7gG0LhUbFWawrIswM/Tq8I0/G8DDem0
 wSDvmldGlQ/9iTq9N9zeqPMKTCN5ndEIATejmw==
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

