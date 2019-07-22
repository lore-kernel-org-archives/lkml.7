Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B5C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D5F22305
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cD2jg8L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfGVJ6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:58:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57315 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfGVJ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:58:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M9w7QI3770733
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 02:58:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M9w7QI3770733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563789488;
        bh=ml5t2SaNThEysdiVQ9rS1D3l7gShBBZusvCxQZvZnEo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cD2jg8L9vYt3o0MK8a8KVLXbVS9Ot99ase3vsGOhgCKiX4s0RaJf+An5Mq5s/OOx3
         inbG/B87gxDQeTN6ovyYQ1AJDTELWyfVazzuke9j/YA0X3VOk7dWWXNSIVA6tgYMLb
         cYs4N2ok1MZ2OxRjUi1ObyWt8GCUdDOcsVMD1hKWmzP16YH8lpo0VK0iF4I/xCBTx9
         UbyVuu5gdLfmHo9MYKxKwP1XQE+yTC0Te9gkJUUEGYpj3LioiUlTfK8OwxKo1yHuUF
         Z4FJ4/VD60+0pqnj/I0o5QjGYodcRWh7qZaCwb5Ti/5jSipA6dgObr3wYLBvx8neg7
         SxblJ0gGzb9MA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M9w7MO3770728;
        Mon, 22 Jul 2019 02:58:07 -0700
Date:   Mon, 22 Jul 2019 02:58:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-48febc03e6c239d96f46d8b38d91863769fc18c8@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          dave.hansen@linux.intel.com, mingo@kernel.org
In-Reply-To: <20190705175318.784C233E@viggo.jf.intel.com>
References: <20190705175318.784C233E@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/mpx: Remove selftests Makefile entry
Git-Commit-ID: 48febc03e6c239d96f46d8b38d91863769fc18c8
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

Commit-ID:  48febc03e6c239d96f46d8b38d91863769fc18c8
Gitweb:     https://git.kernel.org/tip/48febc03e6c239d96f46d8b38d91863769fc18c8
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 5 Jul 2019 10:53:18 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 11:54:56 +0200

x86/mpx: Remove selftests Makefile entry

MPX is being removed from the kernel due to a lack of support in the
toolchain going forward (gcc).

This is the smallest possible patch to fix some issues that have been
reported around running the MPX selftests.  It it would also have been part
of any removal series, it is offered first.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190705175318.784C233E@viggo.jf.intel.com

---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index fa07d526fe39..3bc5b744e644 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,7 @@ CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
-			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
+			check_initial_reg_state sigreturn iopl ioperm \
 			protection_keys test_vdso test_vsyscall mov_ss_trap \
 			syscall_arg_fault
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
