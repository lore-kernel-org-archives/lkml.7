Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5586FC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A3820693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lkWsamP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfDRIKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:10:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRIKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:10:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3I8ADIJ101254
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 01:10:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3I8ADIJ101254
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555575014;
        bh=mzgp7jf8hJ67ip8N9CmMmEjZG+v7tOLyeNKT2T7zvcM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lkWsamP/KXlNy2s0eLsN9DrzaYiSfDZ70gwCTH/ClUm4hY6qdJjaUNwITt1ky2RSq
         Zu0Mhj3rMGdlwM8hwR2KxQCmlgUncXogBHFBdYtUvHQ3bSyi9rQRRT4j19aM/AMnks
         eSU0BUNbzbUJpD3g9jfJbYgzQD78074DX+5mG41HHemyijoubEbMCvRxlpR5P0K2jy
         bpfRKBCNg1Cwrhdrx+dqV9TzRsnSvY8VXq3u1SuMsZInHGgiCnt7A+/77i1v/88Yme
         2wPzEC7gpPDbweSnJuAyUawxxTCnUG+QtuMWX4TJi/mF248DQZe4tn1WdpFC3SYbFs
         EN6kEKZGVRnLw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3I8ADRv101249;
        Thu, 18 Apr 2019 01:10:13 -0700
Date:   Thu, 18 Apr 2019 01:10:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-3c454f47e67bf5a65dc892cd50221a7de695870f@git.kernel.org>
Cc:     tglx@linutronix.de, torvalds@linux-foundation.org, bp@alien8.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, luto@kernel.org, yamada.masahiro@socionext.com
Reply-To: bp@alien8.de, peterz@infradead.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, luto@kernel.org,
          yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1554280212-10578-1-git-send-email-yamada.masahiro@socionext.com>
References: <1554280212-10578-1-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/build/vdso: Add FORCE to the build rule of %.so
Git-Commit-ID: 3c454f47e67bf5a65dc892cd50221a7de695870f
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

Commit-ID:  3c454f47e67bf5a65dc892cd50221a7de695870f
Gitweb:     https://git.kernel.org/tip/3c454f47e67bf5a65dc892cd50221a7de695870f
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Wed, 3 Apr 2019 17:30:12 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Apr 2019 10:05:34 +0200

x86/build/vdso: Add FORCE to the build rule of %.so

$(call if_changed,...) must have FORCE as a prerequisite.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1554280212-10578-1-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 5bfe2243a08f..42fe42e82baf 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -116,7 +116,7 @@ $(obj)/%-x32.o: $(obj)/%.o FORCE
 targets += vdsox32.lds $(vobjx32s-y)
 
 $(obj)/%.so: OBJCOPYFLAGS := -S
-$(obj)/%.so: $(obj)/%.so.dbg
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
