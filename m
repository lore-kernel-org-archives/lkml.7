Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B22C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DB321019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zkuQsxJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391176AbfGRTL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:11:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390241AbfGRTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:11:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJBEgf2124265
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:11:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJBEgf2124265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477075;
        bh=YK3+GoPo0S1EpG7Fcnf6ZuExXfJK994acIvY0hrrNkw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zkuQsxJRUeoRT9Cf8ts7S6GBcct4O2xdPo91tbfJ2s28CCFijKOEu/ykk26Agcv3c
         Wp+jGTDKE4jNrj44ZONP0HCDZ04duYczhPr0VMa/Dz4tT4V25FXLWlA5nQZDxvKQap
         T8lBnQpAwXn/ZMsoCEhuHuNn375/UvabE3IcZKPuJgl7WNTp3sXH+xT0IyGOXE8rMW
         ScDBtC1sFn3pcZScCl4eMUcjiAxar2CV2ZpDqpf8vUHvrVGSd7gGa+U8Iy3+xexX1j
         6R1xPkqdBf6G62m0csz/ly+xUY+ldxksb7xfHIXKhuqo/Z0f9ZWQxMCP9HmvXAzwnL
         lKo4/bB8hLbvQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJBE7o2124262;
        Thu, 18 Jul 2019 12:11:14 -0700
Date:   Thu, 18 Jul 2019 12:11:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-61a73f5cd1a5794626d216cc56e20a1b195c5d0c@git.kernel.org>
Cc:     hpa@zytor.com, jpoimboe@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, jpoimboe@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <6b1b4505fcb90571a55fa1b52d71fb458ca24454.1563413318.git.jpoimboe@redhat.com>
References: <6b1b4505fcb90571a55fa1b52d71fb458ca24454.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/head/64: Annotate start_cpu0() as
 non-callable
Git-Commit-ID: 61a73f5cd1a5794626d216cc56e20a1b195c5d0c
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

Commit-ID:  61a73f5cd1a5794626d216cc56e20a1b195c5d0c
Gitweb:     https://git.kernel.org/tip/61a73f5cd1a5794626d216cc56e20a1b195c5d0c
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:41 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:04 +0200

x86/head/64: Annotate start_cpu0() as non-callable

After an objtool improvement, it complains about the fact that
start_cpu0() jumps to code which has an LRET instruction.

  arch/x86/kernel/head_64.o: warning: objtool: .head.text+0xe4: unsupported instruction in callable function

Technically, start_cpu0() is callable, but it acts nothing like a
callable function.  Prevent objtool from treating it like one by
removing its ELF function annotation.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/6b1b4505fcb90571a55fa1b52d71fb458ca24454.1563413318.git.jpoimboe@redhat.com

---
 arch/x86/kernel/head_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index bcd206c8ac90..66b4a7757397 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -253,10 +253,10 @@ END(secondary_startup_64)
  * start_secondary() via .Ljump_to_C_code.
  */
 ENTRY(start_cpu0)
-	movq	initial_stack(%rip), %rsp
 	UNWIND_HINT_EMPTY
+	movq	initial_stack(%rip), %rsp
 	jmp	.Ljump_to_C_code
-ENDPROC(start_cpu0)
+END(start_cpu0)
 #endif
 
 	/* Both SMP bootup and ACPI suspend change these variables */
