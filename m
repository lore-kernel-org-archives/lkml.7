Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975ADC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7474E2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKZUPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:15:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:46912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbfKZUOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:14:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDE80B129;
        Tue, 26 Nov 2019 20:14:21 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/35] powerpc/64s/exception: trim unused arguments from KVMTEST macro
Date:   Tue, 26 Nov 2019 21:13:29 +0100
Message-Id: <85621a78ab8ced8a83dd5f41d5702b57692eb2e7.1574798487.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574798487.git.msuchanek@suse.de>
References: <cover.1574798487.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index abf26db36427..9fa71d51ecf4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -224,7 +224,7 @@ do_define_int n
 #define kvmppc_interrupt kvmppc_interrupt_pr
 #endif
 
-.macro KVMTEST name, hsrr, n
+.macro KVMTEST name
 	lbz	r10,HSTATE_IN_GUEST(r13)
 	cmpwi	r10,0
 	bne	\name\()_kvm
@@ -293,7 +293,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 .endm
 
 #else
-.macro KVMTEST name, hsrr, n
+.macro KVMTEST name
 .endm
 .macro GEN_KVM name
 .endm
@@ -437,7 +437,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 DEFINE_FIXED_SYMBOL(\name\()_common_real)
 \name\()_common_real:
 	.if IKVM_REAL
-		KVMTEST \name IHSRR IVEC
+		KVMTEST \name
 	.endif
 
 	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
@@ -460,7 +460,7 @@ DEFINE_FIXED_SYMBOL(\name\()_common_real)
 DEFINE_FIXED_SYMBOL(\name\()_common_virt)
 \name\()_common_virt:
 	.if IKVM_VIRT
-		KVMTEST \name IHSRR IVEC
+		KVMTEST \name
 1:
 	.endif
 	.endif /* IVIRT */
@@ -1595,7 +1595,7 @@ INT_DEFINE_END(system_call)
 	GET_PACA(r13)
 	std	r10,PACA_EXGEN+EX_R10(r13)
 	INTERRUPT_TO_KERNEL
-	KVMTEST system_call EXC_STD 0xc00 /* uses r10, branch to system_call_kvm */
+	KVMTEST system_call /* uses r10, branch to system_call_kvm */
 	mfctr	r9
 #else
 	mr	r9,r13
-- 
2.23.0

