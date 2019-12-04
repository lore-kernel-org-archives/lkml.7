Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22415C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F9B2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfLDIe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56435 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfLDIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:34:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6J-0005Fx-Sb; Wed, 04 Dec 2019 09:33:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 896191C2656;
        Wed,  4 Dec 2019 09:33:35 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] module: Remove set_all_modules_text_*()
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Greentime Hu <green.hu@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <deanbo422@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132458.284298307@infradead.org>
References: <20191111132458.284298307@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841542.21853.3750826406774748874.tip-bot2@tip-bot2>
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

Commit-ID:     958de668197651bbf2b4b9528f204ab5a0f1af65
Gitweb:        https://git.kernel.org/tip/958de668197651bbf2b4b9528f204ab5a0f1af65
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 15 Oct 2019 21:07:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:25 +01:00

module: Remove set_all_modules_text_*()

Now that there are no users of set_all_modules_text_*() left, remove
it.

While it appears nds32 uses it, it does not have STRICT_MODULE_RWX and
therefore ends up with the NOP stubs.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Chen <deanbo422@gmail.com>
Link: https://lkml.kernel.org/r/20191111132458.284298307@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/nds32/kernel/ftrace.c | 12 +----------
 include/linux/module.h     |  4 +---
 kernel/module.c            | 43 +-------------------------------------
 3 files changed, 59 deletions(-)

diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index fd2a54b..22ab77e 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -89,18 +89,6 @@ int __init ftrace_dyn_arch_init(void)
 	return 0;
 }
 
-int ftrace_arch_code_modify_prepare(void)
-{
-	set_all_modules_text_rw();
-	return 0;
-}
-
-int ftrace_arch_code_modify_post_process(void)
-{
-	set_all_modules_text_ro();
-	return 0;
-}
-
 static unsigned long gen_sethi_insn(unsigned long addr)
 {
 	unsigned long opcode = 0x46000000;
diff --git a/include/linux/module.h b/include/linux/module.h
index 6d20895..daae847 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -846,13 +846,9 @@ extern int module_sysfs_initialized;
 #define __MODULE_STRING(x) __stringify(x)
 
 #ifdef CONFIG_STRICT_MODULE_RWX
-extern void set_all_modules_text_rw(void);
-extern void set_all_modules_text_ro(void);
 extern void module_enable_ro(const struct module *mod, bool after_init);
 extern void module_disable_ro(const struct module *mod);
 #else
-static inline void set_all_modules_text_rw(void) { }
-static inline void set_all_modules_text_ro(void) { }
 static inline void module_enable_ro(const struct module *mod, bool after_init) { }
 static inline void module_disable_ro(const struct module *mod) { }
 #endif
diff --git a/kernel/module.c b/kernel/module.c
index acf7962..5cd9bed 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2029,49 +2029,6 @@ static void module_enable_nx(const struct module *mod)
 	frob_writable_data(&mod->init_layout, set_memory_nx);
 }
 
-/* Iterate through all modules and set each module's text as RW */
-void set_all_modules_text_rw(void)
-{
-	struct module *mod;
-
-	if (!rodata_enabled)
-		return;
-
-	mutex_lock(&module_mutex);
-	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-
-		frob_text(&mod->core_layout, set_memory_rw);
-		frob_text(&mod->init_layout, set_memory_rw);
-	}
-	mutex_unlock(&module_mutex);
-}
-
-/* Iterate through all modules and set each module's text as RO */
-void set_all_modules_text_ro(void)
-{
-	struct module *mod;
-
-	if (!rodata_enabled)
-		return;
-
-	mutex_lock(&module_mutex);
-	list_for_each_entry_rcu(mod, &modules, list) {
-		/*
-		 * Ignore going modules since it's possible that ro
-		 * protection has already been disabled, otherwise we'll
-		 * run into protection faults at module deallocation.
-		 */
-		if (mod->state == MODULE_STATE_UNFORMED ||
-			mod->state == MODULE_STATE_GOING)
-			continue;
-
-		frob_text(&mod->core_layout, set_memory_ro);
-		frob_text(&mod->init_layout, set_memory_ro);
-	}
-	mutex_unlock(&module_mutex);
-}
 #else /* !CONFIG_STRICT_MODULE_RWX */
 static void module_enable_nx(const struct module *mod) { }
 #endif /*  CONFIG_STRICT_MODULE_RWX */
