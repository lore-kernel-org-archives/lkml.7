Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4811EC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECBB20720
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKWSNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:13:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfKWSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C892073A;
        Sat, 23 Nov 2019 18:12:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZti-000F1j-7X; Sat, 23 Nov 2019 13:12:42 -0500
Message-Id: <20191123181242.114947112@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:12:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Paul Burton <paulburton@kernel.org>
Subject: [for-next][PATCH 10/10] tracing: Enable syscall optimization for MIPS
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hassan Naveed <hnaveed@wavecomp.com>

Since MIPS architecture has a sparse syscall array, select the
HAVE_SPARSE_SYSCALL_NR to save space.

Link: http://lkml.kernel.org/r/20191115234314.21599-2-hnaveed@wavecomp.com

Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
Reviewed-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a0bd9bdb5f83..c7f59c4a00d8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -73,6 +73,7 @@ config MIPS
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
+	select HAVE_SPARSE_SYSCALL_NR
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
-- 
2.24.0


