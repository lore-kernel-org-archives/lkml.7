Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23DFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB1D2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306582;
	bh=hIlGXiSU5SnrczKKiHi8MseNBB+eDECUYnyLZNXn52Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aY0EkHRBdK3Yl4GLzieLzizhVDEMhYmdyX94zjRZ4EOxuqDyOcud4m5hKfSLOSpsM
	 awZjB8x7MLF5U7aCIKW2dr+mdCIyA78tcsV9UYFSONOMKy3wa3TKz+OPTEQyuGKcRy
	 aB9BnuWs5C0Cz5HqSp3D+KY61AptB1AA1im5w9fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKUDXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfKUDXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:23:01 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98AA020721;
        Thu, 21 Nov 2019 03:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306580;
        bh=hIlGXiSU5SnrczKKiHi8MseNBB+eDECUYnyLZNXn52Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Hk+qF3jhYRDNh0NXSkG9Wx7IrytWXuUs1KqYsGbHyGm7aGI8nNa/82LCnDBRCAvCf
         pL9zQV97W5g3HLwIF/U+w36crdBvUT/uWiIv8cr6jjG+BoYqwR2srv1YyoRTHRusra
         0BScKvyn08YjBQNy2nSysQq4acmutBDVdJf48Uxg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] arch: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:22:53 +0100
Message-Id: <1574306573-10886-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 arch/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3c6ec65596da..3fd3e835f891 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -72,11 +72,11 @@ config KPROBES
 	  If in doubt, say "N".
 
 config JUMP_LABEL
-       bool "Optimize very unlikely/likely branches"
-       depends on HAVE_ARCH_JUMP_LABEL
-       depends on CC_HAS_ASM_GOTO
-       help
-         This option enables a transparent branch optimization that
+	bool "Optimize very unlikely/likely branches"
+	depends on HAVE_ARCH_JUMP_LABEL
+	depends on CC_HAS_ASM_GOTO
+	help
+	 This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
 	 conditions even cheaper to execute within the kernel.
 
@@ -84,7 +84,7 @@ config JUMP_LABEL
 	 scheduler functionality, networking code and KVM have such
 	 branches and include support for this optimization technique.
 
-         If it is detected that the compiler has support for "asm goto",
+	 If it is detected that the compiler has support for "asm goto",
 	 the kernel will compile such branches with just a nop
 	 instruction. When the condition flag is toggled to true, the
 	 nop will be converted to a jump instruction to execute the
@@ -151,8 +151,8 @@ config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	  information on the topic of unaligned memory accesses.
 
 config ARCH_USE_BUILTIN_BSWAP
-       bool
-       help
+	bool
+	help
 	 Modern versions of GCC (since 4.4) have builtin functions
 	 for handling byte-swapping. Using these, instead of the old
 	 inline assembler that the architecture code provides in the
@@ -221,10 +221,10 @@ config HAVE_DMA_CONTIGUOUS
 	bool
 
 config GENERIC_SMP_IDLE_THREAD
-       bool
+	bool
 
 config GENERIC_IDLE_POLL_SETUP
-       bool
+	bool
 
 config ARCH_HAS_FORTIFY_SOURCE
 	bool
@@ -257,7 +257,7 @@ config ARCH_HAS_UNCACHED_SEGMENT
 
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
-       bool
+	bool
 
 # Select if arch has its private alloc_task_struct() function
 config ARCH_TASK_STRUCT_ALLOCATOR
-- 
2.7.4

