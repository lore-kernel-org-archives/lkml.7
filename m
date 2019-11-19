Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BCBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CE0223D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfKSQ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:57:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52890 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfKSQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oB-0007Q7-2U; Tue, 19 Nov 2019 17:56:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 146811C19D3;
        Tue, 19 Nov 2019 17:56:49 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:49 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn: perf tools: Add some instructions to the
 new instructions test
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191115135447.6519-2-adrian.hunter@intel.com>
References: <20191115135447.6519-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157418260903.12247.7675264466307635685.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1e5f015442e7b700941f8cd0274bb14962b3d78e
Gitweb:        https://git.kernel.org/tip/1e5f015442e7b700941f8cd0274bb14962b3d78e
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 15:54:46 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 18:53:54 -03:00

x86/insn: perf tools: Add some instructions to the new instructions test

Add to the "x86 instruction decoder - new instructions" test the following
instructions:
	cldemote
	tpause
	umonitor
	umwait
	movdiri
	movdir64b
	enqcmd
	enqcmds
	encls
	enclu
	enclv
	pconfig
	wbnoinvd

For information about the instructions, refer Intel SDM May 2019
(325462-070US) and Intel Architecture Instruction Set Extensions
May 2019 (319433-037).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/20191115135447.6519-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  |  52 +++++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  |  62 ++++++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 109 ++++++++++++++++++-
 3 files changed, 223 insertions(+)

diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-32.c b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
index fab3c6d..58f8f2a 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-32.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
@@ -1647,6 +1647,12 @@
 "0f ae 30             \txsaveopt (%eax)",},
 {{0x0f, 0xae, 0xf0, }, 3, 0, "", "",
 "0f ae f0             \tmfence ",},
+{{0x0f, 0x1c, 0x00, }, 3, 0, "", "",
+"0f 1c 00             \tcldemote (%eax)",},
+{{0x0f, 0x1c, 0x05, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "", "",
+"0f 1c 05 78 56 34 12 \tcldemote 0x12345678",},
+{{0x0f, 0x1c, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"0f 1c 84 c8 78 56 34 12 \tcldemote 0x12345678(%eax,%ecx,8)",},
 {{0x0f, 0xc7, 0x20, }, 3, 0, "", "",
 "0f c7 20             \txsavec (%eax)",},
 {{0x0f, 0xc7, 0x25, 0x78, 0x56, 0x34, 0x12, }, 7, 0, "", "",
@@ -1677,3 +1683,49 @@
 "f3 0f ae 25 78 56 34 12 \tptwritel 0x12345678",},
 {{0xf3, 0x0f, 0xae, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
 "f3 0f ae a4 c8 78 56 34 12 \tptwritel 0x12345678(%eax,%ecx,8)",},
+{{0x66, 0x0f, 0xae, 0xf3, }, 4, 0, "", "",
+"66 0f ae f3          \ttpause %ebx",},
+{{0x67, 0xf3, 0x0f, 0xae, 0xf0, }, 5, 0, "", "",
+"67 f3 0f ae f0       \tumonitor %ax",},
+{{0xf3, 0x0f, 0xae, 0xf0, }, 4, 0, "", "",
+"f3 0f ae f0          \tumonitor %eax",},
+{{0xf2, 0x0f, 0xae, 0xf0, }, 4, 0, "", "",
+"f2 0f ae f0          \tumwait %eax",},
+{{0x0f, 0x38, 0xf9, 0x03, }, 4, 0, "", "",
+"0f 38 f9 03          \tmovdiri %eax,(%ebx)",},
+{{0x0f, 0x38, 0xf9, 0x88, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"0f 38 f9 88 78 56 34 12 \tmovdiri %ecx,0x12345678(%eax)",},
+{{0x66, 0x0f, 0x38, 0xf8, 0x18, }, 5, 0, "", "",
+"66 0f 38 f8 18       \tmovdir64b (%eax),%ebx",},
+{{0x66, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"66 0f 38 f8 88 78 56 34 12 \tmovdir64b 0x12345678(%eax),%ecx",},
+{{0x67, 0x66, 0x0f, 0x38, 0xf8, 0x1c, }, 6, 0, "", "",
+"67 66 0f 38 f8 1c    \tmovdir64b (%si),%bx",},
+{{0x67, 0x66, 0x0f, 0x38, 0xf8, 0x8c, 0x34, 0x12, }, 8, 0, "", "",
+"67 66 0f 38 f8 8c 34 12 \tmovdir64b 0x1234(%si),%cx",},
+{{0xf2, 0x0f, 0x38, 0xf8, 0x18, }, 5, 0, "", "",
+"f2 0f 38 f8 18       \tenqcmd (%eax),%ebx",},
+{{0xf2, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f2 0f 38 f8 88 78 56 34 12 \tenqcmd 0x12345678(%eax),%ecx",},
+{{0x67, 0xf2, 0x0f, 0x38, 0xf8, 0x1c, }, 6, 0, "", "",
+"67 f2 0f 38 f8 1c    \tenqcmd (%si),%bx",},
+{{0x67, 0xf2, 0x0f, 0x38, 0xf8, 0x8c, 0x34, 0x12, }, 8, 0, "", "",
+"67 f2 0f 38 f8 8c 34 12 \tenqcmd 0x1234(%si),%cx",},
+{{0xf3, 0x0f, 0x38, 0xf8, 0x18, }, 5, 0, "", "",
+"f3 0f 38 f8 18       \tenqcmds (%eax),%ebx",},
+{{0xf3, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f3 0f 38 f8 88 78 56 34 12 \tenqcmds 0x12345678(%eax),%ecx",},
+{{0x67, 0xf3, 0x0f, 0x38, 0xf8, 0x1c, }, 6, 0, "", "",
+"67 f3 0f 38 f8 1c    \tenqcmds (%si),%bx",},
+{{0x67, 0xf3, 0x0f, 0x38, 0xf8, 0x8c, 0x34, 0x12, }, 8, 0, "", "",
+"67 f3 0f 38 f8 8c 34 12 \tenqcmds 0x1234(%si),%cx",},
+{{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
+"0f 01 cf             \tencls  ",},
+{{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
+"0f 01 d7             \tenclu  ",},
+{{0x0f, 0x01, 0xc0, }, 3, 0, "", "",
+"0f 01 c0             \tenclv  ",},
+{{0x0f, 0x01, 0xc5, }, 3, 0, "", "",
+"0f 01 c5             \tpconfig ",},
+{{0xf3, 0x0f, 0x09, }, 3, 0, "", "",
+"f3 0f 09             \twbnoinvd ",},
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-64.c b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
index c57f346..656f8ae 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-64.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
@@ -1667,6 +1667,16 @@
 "41 0f ae 30          \txsaveopt (%r8)",},
 {{0x0f, 0xae, 0xf0, }, 3, 0, "", "",
 "0f ae f0             \tmfence ",},
+{{0x0f, 0x1c, 0x00, }, 3, 0, "", "",
+"0f 1c 00             \tcldemote (%rax)",},
+{{0x41, 0x0f, 0x1c, 0x00, }, 4, 0, "", "",
+"41 0f 1c 00          \tcldemote (%r8)",},
+{{0x0f, 0x1c, 0x04, 0x25, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"0f 1c 04 25 78 56 34 12 \tcldemote 0x12345678",},
+{{0x0f, 0x1c, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 8, 0, "", "",
+"0f 1c 84 c8 78 56 34 12 \tcldemote 0x12345678(%rax,%rcx,8)",},
+{{0x41, 0x0f, 0x1c, 0x84, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"41 0f 1c 84 c8 78 56 34 12 \tcldemote 0x12345678(%r8,%rcx,8)",},
 {{0x0f, 0xc7, 0x20, }, 3, 0, "", "",
 "0f c7 20             \txsavec (%rax)",},
 {{0x41, 0x0f, 0xc7, 0x20, }, 4, 0, "", "",
@@ -1727,3 +1737,55 @@
 "f3 48 0f ae a4 c8 78 56 34 12 \tptwriteq 0x12345678(%rax,%rcx,8)",},
 {{0xf3, 0x49, 0x0f, 0xae, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
 "f3 49 0f ae a4 c8 78 56 34 12 \tptwriteq 0x12345678(%r8,%rcx,8)",},
+{{0x66, 0x0f, 0xae, 0xf3, }, 4, 0, "", "",
+"66 0f ae f3          \ttpause %ebx",},
+{{0x66, 0x41, 0x0f, 0xae, 0xf0, }, 5, 0, "", "",
+"66 41 0f ae f0       \ttpause %r8d",},
+{{0x67, 0xf3, 0x0f, 0xae, 0xf0, }, 5, 0, "", "",
+"67 f3 0f ae f0       \tumonitor %eax",},
+{{0xf3, 0x0f, 0xae, 0xf0, }, 4, 0, "", "",
+"f3 0f ae f0          \tumonitor %rax",},
+{{0x67, 0xf3, 0x41, 0x0f, 0xae, 0xf0, }, 6, 0, "", "",
+"67 f3 41 0f ae f0    \tumonitor %r8d",},
+{{0xf2, 0x0f, 0xae, 0xf0, }, 4, 0, "", "",
+"f2 0f ae f0          \tumwait %eax",},
+{{0xf2, 0x41, 0x0f, 0xae, 0xf0, }, 5, 0, "", "",
+"f2 41 0f ae f0       \tumwait %r8d",},
+{{0x48, 0x0f, 0x38, 0xf9, 0x03, }, 5, 0, "", "",
+"48 0f 38 f9 03       \tmovdiri %rax,(%rbx)",},
+{{0x48, 0x0f, 0x38, 0xf9, 0x88, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"48 0f 38 f9 88 78 56 34 12 \tmovdiri %rcx,0x12345678(%rax)",},
+{{0x66, 0x0f, 0x38, 0xf8, 0x18, }, 5, 0, "", "",
+"66 0f 38 f8 18       \tmovdir64b (%rax),%rbx",},
+{{0x66, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"66 0f 38 f8 88 78 56 34 12 \tmovdir64b 0x12345678(%rax),%rcx",},
+{{0x67, 0x66, 0x0f, 0x38, 0xf8, 0x18, }, 6, 0, "", "",
+"67 66 0f 38 f8 18    \tmovdir64b (%eax),%ebx",},
+{{0x67, 0x66, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"67 66 0f 38 f8 88 78 56 34 12 \tmovdir64b 0x12345678(%eax),%ecx",},
+{{0xf2, 0x0f, 0x38, 0xf8, 0x18, }, 5, 0, "", "",
+"f2 0f 38 f8 18       \tenqcmd (%rax),%rbx",},
+{{0xf2, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f2 0f 38 f8 88 78 56 34 12 \tenqcmd 0x12345678(%rax),%rcx",},
+{{0x67, 0xf2, 0x0f, 0x38, 0xf8, 0x18, }, 6, 0, "", "",
+"67 f2 0f 38 f8 18    \tenqcmd (%eax),%ebx",},
+{{0x67, 0xf2, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"67 f2 0f 38 f8 88 78 56 34 12 \tenqcmd 0x12345678(%eax),%ecx",},
+{{0xf3, 0x0f, 0x38, 0xf8, 0x18, }, 5, 0, "", "",
+"f3 0f 38 f8 18       \tenqcmds (%rax),%rbx",},
+{{0xf3, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 9, 0, "", "",
+"f3 0f 38 f8 88 78 56 34 12 \tenqcmds 0x12345678(%rax),%rcx",},
+{{0x67, 0xf3, 0x0f, 0x38, 0xf8, 0x18, }, 6, 0, "", "",
+"67 f3 0f 38 f8 18    \tenqcmds (%eax),%ebx",},
+{{0x67, 0xf3, 0x0f, 0x38, 0xf8, 0x88, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"67 f3 0f 38 f8 88 78 56 34 12 \tenqcmds 0x12345678(%eax),%ecx",},
+{{0x0f, 0x01, 0xcf, }, 3, 0, "", "",
+"0f 01 cf             \tencls  ",},
+{{0x0f, 0x01, 0xd7, }, 3, 0, "", "",
+"0f 01 d7             \tenclu  ",},
+{{0x0f, 0x01, 0xc0, }, 3, 0, "", "",
+"0f 01 c0             \tenclv  ",},
+{{0x0f, 0x01, 0xc5, }, 3, 0, "", "",
+"0f 01 c5             \tpconfig ",},
+{{0xf3, 0x0f, 0x09, }, 3, 0, "", "",
+"f3 0f 09             \twbnoinvd ",},
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-src.c b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
index 891415b..dd85a3a 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-src.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
@@ -1320,6 +1320,14 @@ int main(void)
 	asm volatile("xsaveopt (%r8)");
 	asm volatile("mfence");
 
+	/* cldemote m8 */
+
+	asm volatile("cldemote (%rax)");
+	asm volatile("cldemote (%r8)");
+	asm volatile("cldemote (0x12345678)");
+	asm volatile("cldemote 0x12345678(%rax,%rcx,8)");
+	asm volatile("cldemote 0x12345678(%r8,%rcx,8)");
+
 	/* xsavec mem */
 
 	asm volatile("xsavec (%rax)");
@@ -1364,6 +1372,48 @@ int main(void)
 	asm volatile("ptwriteq 0x12345678(%rax,%rcx,8)");
 	asm volatile("ptwriteq 0x12345678(%r8,%rcx,8)");
 
+	/* tpause */
+
+	asm volatile("tpause %ebx");
+	asm volatile("tpause %r8d");
+
+	/* umonitor */
+
+	asm volatile("umonitor %eax");
+	asm volatile("umonitor %rax");
+	asm volatile("umonitor %r8d");
+
+	/* umwait */
+
+	asm volatile("umwait %eax");
+	asm volatile("umwait %r8d");
+
+	/* movdiri */
+
+	asm volatile("movdiri %rax,(%rbx)");
+	asm volatile("movdiri %rcx,0x12345678(%rax)");
+
+	/* movdir64b */
+
+	asm volatile("movdir64b (%rax),%rbx");
+	asm volatile("movdir64b 0x12345678(%rax),%rcx");
+	asm volatile("movdir64b (%eax),%ebx");
+	asm volatile("movdir64b 0x12345678(%eax),%ecx");
+
+	/* enqcmd */
+
+	asm volatile("enqcmd (%rax),%rbx");
+	asm volatile("enqcmd 0x12345678(%rax),%rcx");
+	asm volatile("enqcmd (%eax),%ebx");
+	asm volatile("enqcmd 0x12345678(%eax),%ecx");
+
+	/* enqcmds */
+
+	asm volatile("enqcmds (%rax),%rbx");
+	asm volatile("enqcmds 0x12345678(%rax),%rcx");
+	asm volatile("enqcmds (%eax),%ebx");
+	asm volatile("enqcmds 0x12345678(%eax),%ecx");
+
 #else  /* #ifdef __x86_64__ */
 
 	/* bound r32, mem (same op code as EVEX prefix) */
@@ -2656,6 +2706,12 @@ int main(void)
 	asm volatile("xsaveopt (%eax)");
 	asm volatile("mfence");
 
+	/* cldemote m8 */
+
+	asm volatile("cldemote (%eax)");
+	asm volatile("cldemote (0x12345678)");
+	asm volatile("cldemote 0x12345678(%eax,%ecx,8)");
+
 	/* xsavec mem */
 
 	asm volatile("xsavec (%eax)");
@@ -2684,8 +2740,61 @@ int main(void)
 	asm volatile("ptwritel (0x12345678)");
 	asm volatile("ptwritel 0x12345678(%eax,%ecx,8)");
 
+	/* tpause */
+
+	asm volatile("tpause %ebx");
+
+	/* umonitor */
+
+	asm volatile("umonitor %ax");
+	asm volatile("umonitor %eax");
+
+	/* umwait */
+
+	asm volatile("umwait %eax");
+
+	/* movdiri */
+
+	asm volatile("movdiri %eax,(%ebx)");
+	asm volatile("movdiri %ecx,0x12345678(%eax)");
+
+	/* movdir64b */
+
+	asm volatile("movdir64b (%eax),%ebx");
+	asm volatile("movdir64b 0x12345678(%eax),%ecx");
+	asm volatile("movdir64b (%si),%bx");
+	asm volatile("movdir64b 0x1234(%si),%cx");
+
+	/* enqcmd */
+
+	asm volatile("enqcmd (%eax),%ebx");
+	asm volatile("enqcmd 0x12345678(%eax),%ecx");
+	asm volatile("enqcmd (%si),%bx");
+	asm volatile("enqcmd 0x1234(%si),%cx");
+
+	/* enqcmds */
+
+	asm volatile("enqcmds (%eax),%ebx");
+	asm volatile("enqcmds 0x12345678(%eax),%ecx");
+	asm volatile("enqcmds (%si),%bx");
+	asm volatile("enqcmds 0x1234(%si),%cx");
+
 #endif /* #ifndef __x86_64__ */
 
+	/* SGX */
+
+	asm volatile("encls");
+	asm volatile("enclu");
+	asm volatile("enclv");
+
+	/* pconfig */
+
+	asm volatile("pconfig");
+
+	/* wbnoinvd */
+
+	asm volatile("wbnoinvd");
+
 	/* Following line is a marker for the awk script - do not change */
 	asm volatile("rdtsc"); /* Stop here */
 
