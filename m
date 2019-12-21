Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B885C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEE4206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 19:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLUTxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:53:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbfLUTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 14:53:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBLJr32a039435
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 14:53:03 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x1gsa2h5y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 14:53:03 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 21 Dec 2019 19:52:58 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 21 Dec 2019 19:52:55 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBLJqAe932571738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Dec 2019 19:52:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CA48A4040;
        Sat, 21 Dec 2019 19:52:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0201DA4051;
        Sat, 21 Dec 2019 19:52:54 +0000 (GMT)
Received: from localhost (unknown [9.145.64.91])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 21 Dec 2019 19:52:53 +0000 (GMT)
Date:   Sat, 21 Dec 2019 20:52:52 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.5-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19122119-0012-0000-0000-000003773584
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122119-0013-0000-0000-000021B32F01
Message-Id: <your-ad-here.call-01576957972-ext-6011@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-21_06:2019-12-17,2019-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=2 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912210175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.5-rc3.

Thank you,
Vasily

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-4

for you to fetch changes up to b4adfe55915d8363e244e42386d69567db1719b9:

  s390/ftrace: save traced function caller (2019-12-18 23:29:26 +0100)

----------------------------------------------------------------
s390 updates for 5.5-rc3

- Fix unwinding from irq context of interrupted user process.

- Add purgatory build missing symbols check. That helped to uncover and
  fix missing symbols when built with kasan support enabled.

- Couple of ftrace fixes. Avoid broken stack trace and fix recursion
  loop in function_graph tracer.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/purgatory: do not build purgatory with kcov, kasan and friends

Hans de Goede (1):
      s390/purgatory: Make sure we fail the build if purgatory has missing symbols

Sven Schnelle (1):
      s390/ftrace: fix endless recursion in function_graph tracer

Vasily Gorbik (2):
      s390/unwind: stop gracefully at user mode pt_regs in irq stack
      s390/ftrace: save traced function caller

 arch/s390/include/asm/timex.h  |  4 ++--
 arch/s390/kernel/mcount.S      |  1 +
 arch/s390/kernel/unwind_bc.c   | 15 +++++++++++----
 arch/s390/purgatory/.gitignore |  1 +
 arch/s390/purgatory/Makefile   | 19 ++++++++++++++-----
 arch/s390/purgatory/string.c   |  3 +++
 6 files changed, 32 insertions(+), 11 deletions(-)
 create mode 100644 arch/s390/purgatory/string.c

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 6da8885251d6..670f14a228e5 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -194,9 +194,9 @@ static inline unsigned long long get_tod_clock_monotonic(void)
 {
 	unsigned long long tod;
 
-	preempt_disable();
+	preempt_disable_notrace();
 	tod = get_tod_clock() - *(unsigned long long *) &tod_clock_base[1];
-	preempt_enable();
+	preempt_enable_notrace();
 	return tod;
 }
 
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 9e1660a6b9db..c3597d2e2ae0 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -35,6 +35,7 @@ EXPORT_SYMBOL(_mcount)
 ENTRY(ftrace_caller)
 	.globl	ftrace_regs_caller
 	.set	ftrace_regs_caller,ftrace_caller
+	stg	%r14,(__SF_GPRS+8*8)(%r15)	# save traced function caller
 	lgr	%r1,%r15
 #if !(defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT))
 	aghi	%r0,MCOUNT_RETURN_FIXUP
diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.c
index da2d4d4c5b0e..707fd99f6734 100644
--- a/arch/s390/kernel/unwind_bc.c
+++ b/arch/s390/kernel/unwind_bc.c
@@ -36,10 +36,17 @@ static bool update_stack_info(struct unwind_state *state, unsigned long sp)
 	return true;
 }
 
-static inline bool is_task_pt_regs(struct unwind_state *state,
-				   struct pt_regs *regs)
+static inline bool is_final_pt_regs(struct unwind_state *state,
+				    struct pt_regs *regs)
 {
-	return task_pt_regs(state->task) == regs;
+	/* user mode or kernel thread pt_regs at the bottom of task stack */
+	if (task_pt_regs(state->task) == regs)
+		return true;
+
+	/* user mode pt_regs at the bottom of irq stack */
+	return state->stack_info.type == STACK_TYPE_IRQ &&
+	       state->stack_info.end - sizeof(struct pt_regs) == (unsigned long)regs &&
+	       READ_ONCE_NOCHECK(regs->psw.mask) & PSW_MASK_PSTATE;
 }
 
 bool unwind_next_frame(struct unwind_state *state)
@@ -80,7 +87,7 @@ bool unwind_next_frame(struct unwind_state *state)
 			if (!on_stack(info, sp, sizeof(struct pt_regs)))
 				goto out_err;
 			regs = (struct pt_regs *) sp;
-			if (is_task_pt_regs(state, regs))
+			if (is_final_pt_regs(state, regs))
 				goto out_stop;
 			ip = READ_ONCE_NOCHECK(regs->psw.addr);
 			sp = READ_ONCE_NOCHECK(regs->gprs[15]);
diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitignore
index 04a03433c720..c82157f46b18 100644
--- a/arch/s390/purgatory/.gitignore
+++ b/arch/s390/purgatory/.gitignore
@@ -1,3 +1,4 @@
 purgatory
+purgatory.chk
 purgatory.lds
 purgatory.ro
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index bc0d7a0d0394..c57f8c40e992 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -4,7 +4,7 @@ OBJECT_FILES_NON_STANDARD := y
 
 purgatory-y := head.o purgatory.o string.o sha256.o mem.o
 
-targets += $(purgatory-y) purgatory.lds purgatory purgatory.ro
+targets += $(purgatory-y) purgatory.lds purgatory purgatory.chk purgatory.ro
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
@@ -15,8 +15,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-$(obj)/string.o: $(srctree)/arch/s390/lib/string.c FORCE
-	$(call if_changed_rule,cc_o_c)
+KCOV_INSTRUMENT := n
+GCOV_PROFILE := n
+UBSAN_SANITIZE := n
+KASAN_SANITIZE := n
 
 KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
@@ -26,15 +28,22 @@ KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 
-LDFLAGS_purgatory := -r --no-undefined -nostdlib -z nodefaultlib -T
+# Since we link purgatory with -r unresolved symbols are not checked, so we
+# also link a purgatory.chk binary without -r to check for unresolved symbols.
+PURGATORY_LDFLAGS := -nostdlib -z nodefaultlib
+LDFLAGS_purgatory := -r $(PURGATORY_LDFLAGS) -T
+LDFLAGS_purgatory.chk := -e purgatory_start $(PURGATORY_LDFLAGS)
 $(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
+$(obj)/purgatory.chk: $(obj)/purgatory FORCE
+		$(call if_changed,ld)
+
 OBJCOPYFLAGS_purgatory.ro := -O elf64-s390
 OBJCOPYFLAGS_purgatory.ro += --remove-section='*debug*'
 OBJCOPYFLAGS_purgatory.ro += --remove-section='.comment'
 OBJCOPYFLAGS_purgatory.ro += --remove-section='.note.*'
-$(obj)/purgatory.ro: $(obj)/purgatory FORCE
+$(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
 		$(call if_changed,objcopy)
 
 $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
diff --git a/arch/s390/purgatory/string.c b/arch/s390/purgatory/string.c
new file mode 100644
index 000000000000..c98c22a72db7
--- /dev/null
+++ b/arch/s390/purgatory/string.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+#define __HAVE_ARCH_MEMCMP	/* arch function */
+#include "../lib/string.c"

