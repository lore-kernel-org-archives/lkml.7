Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B619C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CDF207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKYITW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:19:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38680 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:19:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZ9aR-0001QR-Gd; Mon, 25 Nov 2019 09:19:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 23B611C1AF2;
        Mon, 25 Nov 2019 09:19:11 +0100 (CET)
Date:   Mon, 25 Nov 2019 08:19:11 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/refcount: Remove unused
 'refcount_error_report()' function
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121115902.2551-10-will@kernel.org>
References: <20191121115902.2551-10-will@kernel.org>
MIME-Version: 1.0
Message-ID: <157466995104.21853.2462265674410709018.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2f30b36943adca070f2e1551f701bd524ed1ae5a
Gitweb:        https://git.kernel.org/tip/2f30b36943adca070f2e1551f701bd524ed1ae5a
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 11:59:01 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Nov 2019 09:15:42 +01:00

locking/refcount: Remove unused 'refcount_error_report()' function

'refcount_error_report()' has no callers. Remove it.

Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191121115902.2551-10-will@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel.h |  7 -------
 kernel/panic.c         | 11 -----------
 2 files changed, 18 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d83d403..09f7592 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -328,13 +328,6 @@ extern int oops_may_print(void);
 void do_exit(long error_code) __noreturn;
 void complete_and_exit(struct completion *, long) __noreturn;
 
-#ifdef CONFIG_ARCH_HAS_REFCOUNT
-void refcount_error_report(struct pt_regs *regs, const char *err);
-#else
-static inline void refcount_error_report(struct pt_regs *regs, const char *err)
-{ }
-#endif
-
 /* Internal, do not use. */
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
diff --git a/kernel/panic.c b/kernel/panic.c
index f470a03..b69ee9e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -671,17 +671,6 @@ EXPORT_SYMBOL(__stack_chk_fail);
 
 #endif
 
-#ifdef CONFIG_ARCH_HAS_REFCOUNT
-void refcount_error_report(struct pt_regs *regs, const char *err)
-{
-	WARN_RATELIMIT(1, "refcount_t %s at %pB in %s[%d], uid/euid: %u/%u\n",
-		err, (void *)instruction_pointer(regs),
-		current->comm, task_pid_nr(current),
-		from_kuid_munged(&init_user_ns, current_uid()),
-		from_kuid_munged(&init_user_ns, current_euid()));
-}
-#endif
-
 core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
