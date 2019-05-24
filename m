Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE77C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C492721841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oef7WUhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbfEXIGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:06:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:06:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O85UPa117819
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:05:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O85UPa117819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685131;
        bh=b5Mk8+O5JggMQDdmGsEqlOa99HQfvr9AjMdNl4+YzcA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=oef7WUhXs7GIQc96au2HQdbc9R6FOrle3NXKXu9pVP8Izfo2tAXP/yOKF2VnA5iEe
         oZCd0NRhWY/+ECTFWiEglH3bijZ08xBOLhZi0zrZS/KYvYfF8cF2ZDczCZGYkqgan/
         W3klNfsIyQxLRsUF55MnJSqqpaJL/G3POgi+fYVtXl00gL8VAANlFQTXaT2iYLMZ26
         yRe3TQX4v3AyGEA3Jsi+6M0PpJwc+nLhLzRyTr3S9fsjc7SbbcZ9WcsVHh7wmVuU70
         iXHuARqhxbAvR7V/LSBfcSGopl1dywoiu/2wHP59sz2RYXbr9ABYgDqGnAzgxQvf3M
         YANCI6mpyJZGw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O85URr117814;
        Fri, 24 May 2019 01:05:30 -0700
Date:   Fri, 24 May 2019 01:05:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-7231d0165df3754ec90a2868a026a146401ec751@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        luto@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        bp@alien8.de, mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: rostedt@goodmis.org, luto@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, bp@alien8.de
In-Reply-To: <20190523102325.22eacdf7@gandalf.local.home>
References: <20190523102325.22eacdf7@gandalf.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Remove unused TASK_TI_flags from
 asm-offsets.c
Git-Commit-ID: 7231d0165df3754ec90a2868a026a146401ec751
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

Commit-ID:  7231d0165df3754ec90a2868a026a146401ec751
Gitweb:     https://git.kernel.org/tip/7231d0165df3754ec90a2868a026a146401ec751
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Thu, 23 May 2019 10:23:25 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 08:48:17 +0200

x86/asm: Remove unused TASK_TI_flags from asm-offsets.c

Since commit:

  21d375b6b34ff5 ("x86/entry/64: Remove the SYSCALL64 fast path")

there is no user of TASK_TI_flags in assembly. There's no need to
keep it around in asm-offsets.c

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190523102325.22eacdf7@gandalf.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/asm-offsets.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 168543d077d7..da64452584b0 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -38,7 +38,6 @@ static void __used common(void)
 #endif
 
 	BLANK();
-	OFFSET(TASK_TI_flags, task_struct, thread_info.flags);
 	OFFSET(TASK_addr_limit, task_struct, thread.addr_limit);
 
 	BLANK();
