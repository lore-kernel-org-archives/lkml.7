Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B6FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F39C2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLDIeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfLDIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6N-0005GY-Gy; Wed, 04 Dec 2019 09:33:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1A5911C2655;
        Wed,  4 Dec 2019 09:33:36 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/kprobes: Convert to text-patching.h
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132458.103959370@infradead.org>
References: <20191111132458.103959370@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841600.21853.10735028166716804638.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     ab09e95ca0c697e67f986c4a45a179abf47e7bfc
Gitweb:        https://git.kernel.org/tip/ab09e95ca0c697e67f986c4a45a179abf47e7bfc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Oct 2019 13:57:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:24 +01:00

x86/kprobes: Convert to text-patching.h

Convert kprobes to the new text-poke naming.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132458.103959370@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/kprobes.h       | 14 +++------
 arch/x86/include/asm/text-patching.h |  2 +-
 arch/x86/kernel/kprobes/core.c       | 18 +++++------
 arch/x86/kernel/kprobes/opt.c        | 44 ++++++++++++---------------
 4 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 5dc909d..95b1f05 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -11,12 +11,11 @@
 
 #include <asm-generic/kprobes.h>
 
-#define BREAKPOINT_INSTRUCTION	0xcc
-
 #ifdef CONFIG_KPROBES
 #include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
+#include <asm/text-patching.h>
 #include <asm/insn.h>
 
 #define  __ARCH_WANT_KPROBES_INSN_SLOT
@@ -25,10 +24,7 @@ struct pt_regs;
 struct kprobe;
 
 typedef u8 kprobe_opcode_t;
-#define RELATIVEJUMP_OPCODE 0xe9
-#define RELATIVEJUMP_SIZE 5
-#define RELATIVECALL_OPCODE 0xe8
-#define RELATIVE_ADDR_SIZE 4
+
 #define MAX_STACK_SIZE 64
 #define CUR_STACK_SIZE(ADDR) \
 	(current_top_of_stack() - (unsigned long)(ADDR))
@@ -43,11 +39,11 @@ extern __visible kprobe_opcode_t optprobe_template_entry[];
 extern __visible kprobe_opcode_t optprobe_template_val[];
 extern __visible kprobe_opcode_t optprobe_template_call[];
 extern __visible kprobe_opcode_t optprobe_template_end[];
-#define MAX_OPTIMIZED_LENGTH (MAX_INSN_SIZE + RELATIVE_ADDR_SIZE)
+#define MAX_OPTIMIZED_LENGTH (MAX_INSN_SIZE + DISP32_SIZE)
 #define MAX_OPTINSN_SIZE 				\
 	(((unsigned long)optprobe_template_end -	\
 	  (unsigned long)optprobe_template_entry) +	\
-	 MAX_OPTIMIZED_LENGTH + RELATIVEJUMP_SIZE)
+	 MAX_OPTIMIZED_LENGTH + JMP32_INSN_SIZE)
 
 extern const int kretprobe_blacklist_size;
 
@@ -73,7 +69,7 @@ struct arch_specific_insn {
 
 struct arch_optimized_insn {
 	/* copy of the original instructions */
-	kprobe_opcode_t copied_insn[RELATIVE_ADDR_SIZE];
+	kprobe_opcode_t copied_insn[DISP32_SIZE];
 	/* detour code buffer */
 	kprobe_opcode_t *insn;
 	/* the size of instructions copied to detour code buffer */
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index ad8f9f4..4c09f42 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -61,6 +61,8 @@ extern void text_poke_finish(void);
 #define JMP8_INSN_SIZE		2
 #define JMP8_INSN_OPCODE	0xEB
 
+#define DISP32_SIZE		4
+
 static inline int text_opcode_size(u8 opcode)
 {
 	int size = 0;
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4f13af7..697c059 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -119,14 +119,14 @@ __synthesize_relative_insn(void *dest, void *from, void *to, u8 op)
 /* Insert a jump instruction at address 'from', which jumps to address 'to'.*/
 void synthesize_reljump(void *dest, void *from, void *to)
 {
-	__synthesize_relative_insn(dest, from, to, RELATIVEJUMP_OPCODE);
+	__synthesize_relative_insn(dest, from, to, JMP32_INSN_OPCODE);
 }
 NOKPROBE_SYMBOL(synthesize_reljump);
 
 /* Insert a call instruction at address 'from', which calls address 'to'.*/
 void synthesize_relcall(void *dest, void *from, void *to)
 {
-	__synthesize_relative_insn(dest, from, to, RELATIVECALL_OPCODE);
+	__synthesize_relative_insn(dest, from, to, CALL_INSN_OPCODE);
 }
 NOKPROBE_SYMBOL(synthesize_relcall);
 
@@ -301,7 +301,7 @@ static int can_probe(unsigned long paddr)
 		 * Another debugging subsystem might insert this breakpoint.
 		 * In that case, we can't recover it.
 		 */
-		if (insn.opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
+		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
 			return 0;
 		addr += insn.length;
 	}
@@ -356,7 +356,7 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 		return 0;
 
 	/* Another subsystem puts a breakpoint, failed to recover */
-	if (insn->opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
+	if (insn->opcode.bytes[0] == INT3_INSN_OPCODE)
 		return 0;
 
 	/* We should not singlestep on the exception masking instructions */
@@ -400,14 +400,14 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
 	int len = insn->length;
 
 	if (can_boost(insn, p->addr) &&
-	    MAX_INSN_SIZE - len >= RELATIVEJUMP_SIZE) {
+	    MAX_INSN_SIZE - len >= JMP32_INSN_SIZE) {
 		/*
 		 * These instructions can be executed directly if it
 		 * jumps back to correct address.
 		 */
 		synthesize_reljump(buf + len, p->ainsn.insn + len,
 				   p->addr + insn->length);
-		len += RELATIVEJUMP_SIZE;
+		len += JMP32_INSN_SIZE;
 		p->ainsn.boostable = true;
 	} else {
 		p->ainsn.boostable = false;
@@ -501,7 +501,7 @@ int arch_prepare_kprobe(struct kprobe *p)
 
 void arch_arm_kprobe(struct kprobe *p)
 {
-	text_poke(p->addr, ((unsigned char []){BREAKPOINT_INSTRUCTION}), 1);
+	text_poke(p->addr, ((unsigned char []){INT3_INSN_OPCODE}), 1);
 }
 
 void arch_disarm_kprobe(struct kprobe *p)
@@ -609,7 +609,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 	regs->flags |= X86_EFLAGS_TF;
 	regs->flags &= ~X86_EFLAGS_IF;
 	/* single step inline if the instruction is an int3 */
-	if (p->opcode == BREAKPOINT_INSTRUCTION)
+	if (p->opcode == INT3_INSN_OPCODE)
 		regs->ip = (unsigned long)p->addr;
 	else
 		regs->ip = (unsigned long)p->ainsn.insn;
@@ -695,7 +695,7 @@ int kprobe_int3_handler(struct pt_regs *regs)
 				reset_current_kprobe();
 			return 1;
 		}
-	} else if (*addr != BREAKPOINT_INSTRUCTION) {
+	} else if (*addr != INT3_INSN_OPCODE) {
 		/*
 		 * The breakpoint instruction was removed right
 		 * after we hit it.  Another cpu has removed
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 9b01ee7..0d9ea48 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -38,7 +38,7 @@ unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr)
 	long offs;
 	int i;
 
-	for (i = 0; i < RELATIVEJUMP_SIZE; i++) {
+	for (i = 0; i < JMP32_INSN_SIZE; i++) {
 		kp = get_kprobe((void *)addr - i);
 		/* This function only handles jump-optimized kprobe */
 		if (kp && kprobe_optimized(kp)) {
@@ -62,10 +62,10 @@ found:
 
 	if (addr == (unsigned long)kp->addr) {
 		buf[0] = kp->opcode;
-		memcpy(buf + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
+		memcpy(buf + 1, op->optinsn.copied_insn, DISP32_SIZE);
 	} else {
 		offs = addr - (unsigned long)kp->addr - 1;
-		memcpy(buf, op->optinsn.copied_insn + offs, RELATIVE_ADDR_SIZE - offs);
+		memcpy(buf, op->optinsn.copied_insn + offs, DISP32_SIZE - offs);
 	}
 
 	return (unsigned long)buf;
@@ -141,8 +141,6 @@ STACK_FRAME_NON_STANDARD(optprobe_template_func);
 #define TMPL_END_IDX \
 	((long)optprobe_template_end - (long)optprobe_template_entry)
 
-#define INT3_SIZE sizeof(kprobe_opcode_t)
-
 /* Optimized kprobe call back function: called from optinsn */
 static void
 optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
@@ -162,7 +160,7 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 		regs->cs |= get_kernel_rpl();
 		regs->gs = 0;
 #endif
-		regs->ip = (unsigned long)op->kp.addr + INT3_SIZE;
+		regs->ip = (unsigned long)op->kp.addr + INT3_INSN_SIZE;
 		regs->orig_ax = ~0UL;
 
 		__this_cpu_write(current_kprobe, &op->kp);
@@ -179,7 +177,7 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
 	struct insn insn;
 	int len = 0, ret;
 
-	while (len < RELATIVEJUMP_SIZE) {
+	while (len < JMP32_INSN_SIZE) {
 		ret = __copy_instruction(dest + len, src + len, real + len, &insn);
 		if (!ret || !can_boost(&insn, src + len))
 			return -EINVAL;
@@ -271,7 +269,7 @@ static int can_optimize(unsigned long paddr)
 		return 0;
 
 	/* Check there is enough space for a relative jump. */
-	if (size - offset < RELATIVEJUMP_SIZE)
+	if (size - offset < JMP32_INSN_SIZE)
 		return 0;
 
 	/* Decode instructions */
@@ -290,15 +288,15 @@ static int can_optimize(unsigned long paddr)
 		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
 		insn_get_length(&insn);
 		/* Another subsystem puts a breakpoint */
-		if (insn.opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
+		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
 			return 0;
 		/* Recover address */
 		insn.kaddr = (void *)addr;
 		insn.next_byte = (void *)(addr + insn.length);
 		/* Check any instructions don't jump into target */
 		if (insn_is_indirect_jump(&insn) ||
-		    insn_jump_into_range(&insn, paddr + INT3_SIZE,
-					 RELATIVE_ADDR_SIZE))
+		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
+					 DISP32_SIZE))
 			return 0;
 		addr += insn.length;
 	}
@@ -374,7 +372,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	 * Verify if the address gap is in 2GB range, because this uses
 	 * a relative jump.
 	 */
-	rel = (long)slot - (long)op->kp.addr + RELATIVEJUMP_SIZE;
+	rel = (long)slot - (long)op->kp.addr + JMP32_INSN_SIZE;
 	if (abs(rel) > 0x7fffffff) {
 		ret = -ERANGE;
 		goto err;
@@ -401,7 +399,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	/* Set returning jmp instruction at the tail of out-of-line buffer */
 	synthesize_reljump(buf + len, slot + len,
 			   (u8 *)op->kp.addr + op->optinsn.size);
-	len += RELATIVEJUMP_SIZE;
+	len += JMP32_INSN_SIZE;
 
 	/* We have to use text_poke() for instruction buffer because it is RO */
 	text_poke(slot, buf, len);
@@ -422,22 +420,22 @@ err:
 void arch_optimize_kprobes(struct list_head *oplist)
 {
 	struct optimized_kprobe *op, *tmp;
-	u8 insn_buff[RELATIVEJUMP_SIZE];
+	u8 insn_buff[JMP32_INSN_SIZE];
 
 	list_for_each_entry_safe(op, tmp, oplist, list) {
 		s32 rel = (s32)((long)op->optinsn.insn -
-			((long)op->kp.addr + RELATIVEJUMP_SIZE));
+			((long)op->kp.addr + JMP32_INSN_SIZE));
 
 		WARN_ON(kprobe_disabled(&op->kp));
 
 		/* Backup instructions which will be replaced by jump address */
-		memcpy(op->optinsn.copied_insn, op->kp.addr + INT3_SIZE,
-		       RELATIVE_ADDR_SIZE);
+		memcpy(op->optinsn.copied_insn, op->kp.addr + INT3_INSN_SIZE,
+		       DISP32_SIZE);
 
-		insn_buff[0] = RELATIVEJUMP_OPCODE;
+		insn_buff[0] = JMP32_INSN_OPCODE;
 		*(s32 *)(&insn_buff[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE, NULL);
+		text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE, NULL);
 
 		list_del_init(&op->list);
 	}
@@ -446,13 +444,13 @@ void arch_optimize_kprobes(struct list_head *oplist)
 /* Replace a relative jump with a breakpoint (int3).  */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
-	u8 insn_buff[RELATIVEJUMP_SIZE];
+	u8 insn_buff[JMP32_INSN_SIZE];
 
 	/* Set int3 to first byte for kprobes */
-	insn_buff[0] = BREAKPOINT_INSTRUCTION;
-	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
+	insn_buff[0] = INT3_INSN_OPCODE;
+	memcpy(insn_buff + 1, op->optinsn.copied_insn, DISP32_SIZE);
 
-	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
+	text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE,
 		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
 }
 
