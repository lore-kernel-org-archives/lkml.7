Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136CAC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28C9208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfDMUrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:47:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfDMUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:47:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKlK482264859
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:47:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKlJ3H2264856;
        Sat, 13 Apr 2019 13:47:19 -0700
Date:   Sat, 13 Apr 2019 13:47:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-6dd677a044e606fd343e31c2108b13d74aec1ca5@git.kernel.org>
Cc:     jroedel@suse.de, bp@suse.de, Babu.Moger@amd.com, jannh@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mingo@kernel.org,
        bigeasy@linutronix.de, dave.hansen@intel.com, x86@kernel.org,
        dima@arista.com, pbonzini@redhat.com, nstange@suse.de,
        luto@kernel.org, chang.seok.bae@intel.com, aubrey.li@intel.com,
        corbet@lwn.net, rkrcmar@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, Jason@zx2c4.com, riel@surriel.com,
        kvm@vger.kernel.org
Reply-To: bp@suse.de, jroedel@suse.de, Babu.Moger@amd.com,
          jannh@google.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          mingo@redhat.com, dave.hansen@intel.com, bigeasy@linutronix.de,
          x86@kernel.org, dima@arista.com, pbonzini@redhat.com,
          nstange@suse.de, luto@kernel.org, chang.seok.bae@intel.com,
          aubrey.li@intel.com, corbet@lwn.net, tglx@linutronix.de,
          rkrcmar@redhat.com, hpa@zytor.com, Jason@zx2c4.com,
          riel@surriel.com, kvm@vger.kernel.org
In-Reply-To: <20190403164156.19645-3-bigeasy@linutronix.de>
References: <20190403164156.19645-3-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Remove fpu__restore()
Git-Commit-ID: 6dd677a044e606fd343e31c2108b13d74aec1ca5
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

Commit-ID:  6dd677a044e606fd343e31c2108b13d74aec1ca5
Gitweb:     https://git.kernel.org/tip/6dd677a044e606fd343e31c2108b13d74aec1ca5
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:31 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 9 Apr 2019 19:27:42 +0200

x86/fpu: Remove fpu__restore()

There are no users of fpu__restore() so it is time to remove it. The
comment regarding fpu__restore() and TS bit is stale since commit

  b3b0870ef3ffe ("i387: do not preload FPU state at task switch time")

and has no meaning since.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Babu Moger <Babu.Moger@amd.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: Nicolai Stange <nstange@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-3-bigeasy@linutronix.de
---
 Documentation/preempt-locking.txt   |  1 -
 arch/x86/include/asm/fpu/internal.h |  1 -
 arch/x86/kernel/fpu/core.c          | 24 ------------------------
 arch/x86/kernel/process_32.c        |  4 +---
 arch/x86/kernel/process_64.c        |  4 +---
 5 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/Documentation/preempt-locking.txt b/Documentation/preempt-locking.txt
index 509f5a422d57..dce336134e54 100644
--- a/Documentation/preempt-locking.txt
+++ b/Documentation/preempt-locking.txt
@@ -52,7 +52,6 @@ preemption must be disabled around such regions.
 
 Note, some FPU functions are already explicitly preempt safe.  For example,
 kernel_fpu_begin and kernel_fpu_end will disable and enable preemption.
-However, fpu__restore() must be called with preemption disabled.
 
 
 RULE #3: Lock acquire and release must be performed by same task
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index fb04a3ded7dd..75a1d5f712ee 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -28,7 +28,6 @@ extern void fpu__initialize(struct fpu *fpu);
 extern void fpu__prepare_read(struct fpu *fpu);
 extern void fpu__prepare_write(struct fpu *fpu);
 extern void fpu__save(struct fpu *fpu);
-extern void fpu__restore(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern int  fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2e5003fef51a..1d3ae7988f7f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -303,30 +303,6 @@ void fpu__prepare_write(struct fpu *fpu)
 	}
 }
 
-/*
- * 'fpu__restore()' is called to copy FPU registers from
- * the FPU fpstate to the live hw registers and to activate
- * access to the hardware registers, so that FPU instructions
- * can be used afterwards.
- *
- * Must be called with kernel preemption disabled (for example
- * with local interrupts disabled, as it is in the case of
- * do_device_not_available()).
- */
-void fpu__restore(struct fpu *fpu)
-{
-	fpu__initialize(fpu);
-
-	/* Avoid __kernel_fpu_begin() right after fpregs_activate() */
-	kernel_fpu_disable();
-	trace_x86_fpu_before_restore(fpu);
-	fpregs_activate(fpu);
-	copy_kernel_to_fpregs(&fpu->state);
-	trace_x86_fpu_after_restore(fpu);
-	kernel_fpu_enable();
-}
-EXPORT_SYMBOL_GPL(fpu__restore);
-
 /*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index e471d8e6f0b2..7888a41a03cd 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -267,9 +267,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/*
 	 * Leave lazy mode, flushing any hypercalls made here.
 	 * This must be done before restoring TLS segments so
-	 * the GDT and LDT are properly updated, and must be
-	 * done before fpu__restore(), so the TS bit is up
-	 * to date.
+	 * the GDT and LDT are properly updated.
 	 */
 	arch_end_context_switch(next_p);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6a62f4af9fcf..e1983b3a16c4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -538,9 +538,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/*
 	 * Leave lazy mode, flushing any hypercalls made here.  This
 	 * must be done after loading TLS entries in the GDT but before
-	 * loading segments that might reference them, and and it must
-	 * be done before fpu__restore(), so the TS bit is up to
-	 * date.
+	 * loading segments that might reference them.
 	 */
 	arch_end_context_switch(next_p);
 
