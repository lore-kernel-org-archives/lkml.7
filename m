Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C920CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20379208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbfJ2Jwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47802 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732898AbfJ2Jwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAo-0004Rl-2y; Tue, 29 Oct 2019 10:52:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B14F11C047B;
        Tue, 29 Oct 2019 10:52:21 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:21 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] context_tracking: Rename
 context_tracking_is_enabled() => context_tracking_enabled()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016025700.31277-6-frederic@kernel.org>
References: <20191016025700.31277-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234274142.29376.472993393911894001.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     74c578759f15cb5a0d0107759bdad671d7b52ab9
Gitweb:        https://git.kernel.org/tip/74c578759f15cb5a0d0107759bdad671d7b52ab9
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:12 +01:00

context_tracking: Rename context_tracking_is_enabled() => context_tracking_enabled()

Remove the superfluous "is" in the middle of the name. We want to
standardize the naming so that it can be expanded through suffixes:

	context_tracking_enabled()
	context_tracking_enabled_cpu()
	context_tracking_enabled_this_cpu()

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191016025700.31277-6-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h               |  2 +-
 include/linux/context_tracking.h       | 20 ++++++++++----------
 include/linux/context_tracking_state.h |  8 ++++----
 include/linux/tick.h                   |  2 +-
 include/linux/vtime.h                  |  2 +-
 kernel/context_tracking.c              |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 515c0ce..0789e13 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -354,7 +354,7 @@ For 32-bit we have the following conventions - kernel is built with
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
 #ifdef CONFIG_JUMP_LABEL
-	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_enabled, def=0
+	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_key, def=0
 #endif
 	call enter_from_user_mode
 .Lafter_call_\@:
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 558a209..f1601ba 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -22,26 +22,26 @@ extern void context_tracking_user_exit(void);
 
 static inline void user_enter(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		context_tracking_enter(CONTEXT_USER);
 
 }
 static inline void user_exit(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		context_tracking_exit(CONTEXT_USER);
 }
 
 /* Called with interrupts disabled.  */
 static inline void user_enter_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_USER);
 
 }
 static inline void user_exit_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_USER);
 }
 
@@ -49,7 +49,7 @@ static inline enum ctx_state exception_enter(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (!context_tracking_is_enabled())
+	if (!context_tracking_enabled())
 		return 0;
 
 	prev_ctx = this_cpu_read(context_tracking.state);
@@ -61,7 +61,7 @@ static inline enum ctx_state exception_enter(void)
 
 static inline void exception_exit(enum ctx_state prev_ctx)
 {
-	if (context_tracking_is_enabled()) {
+	if (context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
 			context_tracking_enter(prev_ctx);
 	}
@@ -77,7 +77,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
  */
 static inline enum ctx_state ct_state(void)
 {
-	return context_tracking_is_enabled() ?
+	return context_tracking_enabled() ?
 		this_cpu_read(context_tracking.state) : CONTEXT_DISABLED;
 }
 #else
@@ -90,7 +90,7 @@ static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
 #endif /* !CONFIG_CONTEXT_TRACKING */
 
-#define CT_WARN_ON(cond) WARN_ON(context_tracking_is_enabled() && (cond))
+#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
 
 #ifdef CONFIG_CONTEXT_TRACKING_FORCE
 extern void context_tracking_init(void);
@@ -108,7 +108,7 @@ static inline void guest_enter_irqoff(void)
 	else
 		current->flags |= PF_VCPU;
 
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_GUEST);
 
 	/* KVM does not hold any references to rcu protected data when it
@@ -124,7 +124,7 @@ static inline void guest_enter_irqoff(void)
 
 static inline void guest_exit_irqoff(void)
 {
-	if (context_tracking_is_enabled())
+	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
 	if (vtime_accounting_cpu_enabled())
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index f4633c2..91250bd 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -23,12 +23,12 @@ struct context_tracking {
 };
 
 #ifdef CONFIG_CONTEXT_TRACKING
-extern struct static_key_false context_tracking_enabled;
+extern struct static_key_false context_tracking_key;
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
-static inline bool context_tracking_is_enabled(void)
+static inline bool context_tracking_enabled(void)
 {
-	return static_branch_unlikely(&context_tracking_enabled);
+	return static_branch_unlikely(&context_tracking_key);
 }
 
 static inline bool context_tracking_cpu_is_enabled(void)
@@ -42,7 +42,7 @@ static inline bool context_tracking_in_user(void)
 }
 #else
 static inline bool context_tracking_in_user(void) { return false; }
-static inline bool context_tracking_is_enabled(void) { return false; }
+static inline bool context_tracking_enabled(void) { return false; }
 static inline bool context_tracking_cpu_is_enabled(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
diff --git a/include/linux/tick.h b/include/linux/tick.h
index f92a10b..7e050a3 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -174,7 +174,7 @@ extern cpumask_var_t tick_nohz_full_mask;
 
 static inline bool tick_nohz_full_enabled(void)
 {
-	if (!context_tracking_is_enabled())
+	if (!context_tracking_enabled())
 		return false;
 
 	return tick_nohz_full_running;
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index d9160ab..0fc7f11 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -28,7 +28,7 @@ extern void vtime_task_switch(struct task_struct *prev);
  */
 static inline bool vtime_accounting_enabled(void)
 {
-	return context_tracking_is_enabled();
+	return context_tracking_enabled();
 }
 
 static inline bool vtime_accounting_cpu_enabled(void)
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index be01a4d..0296b4b 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -25,8 +25,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE(context_tracking_enabled);
-EXPORT_SYMBOL_GPL(context_tracking_enabled);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
+EXPORT_SYMBOL_GPL(context_tracking_key);
 
 DEFINE_PER_CPU(struct context_tracking, context_tracking);
 EXPORT_SYMBOL_GPL(context_tracking);
@@ -192,7 +192,7 @@ void __init context_tracking_cpu_set(int cpu)
 
 	if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
-		static_branch_inc(&context_tracking_enabled);
+		static_branch_inc(&context_tracking_key);
 	}
 
 	if (initialized)
