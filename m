Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F22C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A9D218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Zv8p6ZIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfDXLMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:12:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfDXLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:12:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3OBCBFS2549590
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 04:12:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3OBCBFS2549590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556104332;
        bh=0t2YRjSZFOi88v9CSLMha2C7ajjbdo7pkJT+II5/xp4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Zv8p6ZItKDcaSfPb76gAyZg0YOxvKxwcgwy00yLVvMN+JYx6GwujmiX8NxboIEjFM
         ZrZlbviwsxXPHOUvSGDrYgF5IhpiM9RkJYQCQrrQ8y+2JPJkdwdeS6FuLBPKMC4oRK
         DLgD2BWMuyqHqbyXK4lNKLX6K+0pr5EOvIlyh5YiqAhSs0J+mFPL3Fxvuvf2IPIg95
         AJegufCryQmBcuf5D3jqg2BzGnE7H1LYRsxg5KpiQoIQzGZo+EPHkyt92xAjWQdcAL
         Xa/7dmo/vkiR7hoUcOit1/yD0opC2luIy7NPMB4p7QD71/3c01FTjhbj52sn5AhaCW
         cZtKV6k8nd5cA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3OBCBtA2549587;
        Wed, 24 Apr 2019 04:12:11 -0700
Date:   Wed, 24 Apr 2019 04:12:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-3855f11d54a07256cc4a6fb85c692000208a73a7@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        yamada.masahiro@socionext.com, mingo@kernel.org,
        torvalds@linux-foundation.org, bp@alien8.de,
        ndesaulniers@google.com
Reply-To: tglx@linutronix.de, ndesaulniers@google.com, bp@alien8.de,
          mingo@kernel.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          yamada.masahiro@socionext.com, peterz@infradead.org
In-Reply-To: <20190423211554.1594-1-ndesaulniers@google.com>
References: <20190423211554.1594-1-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/um/vdso: Drop unnecessary cc-ldoption
Git-Commit-ID: 3855f11d54a07256cc4a6fb85c692000208a73a7
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

Commit-ID:  3855f11d54a07256cc4a6fb85c692000208a73a7
Gitweb:     https://git.kernel.org/tip/3855f11d54a07256cc4a6fb85c692000208a73a7
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Tue, 23 Apr 2019 14:15:53 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 24 Apr 2019 12:22:33 +0200

x86/um/vdso: Drop unnecessary cc-ldoption

Towards the goal of removing cc-ldoption, it seems that --hash-style=
was added to binutils 2.17.50.0.2 in 2006. The minimal required version
of binutils for the kernel according to
Documentation/process/changes.rst is 2.20.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: anton.ivanov@cambridgegreys.com
Cc: clang-built-linux@googlegroups.com
Cc: jdike@addtoit.com
Cc: linux-um@lists.infradead.org
Cc: richard@nod.at
Link: http://lkml.kernel.org/r/20190423211554.1594-1-ndesaulniers@google.com
Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/um/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index bf94060fc06f..0caddd6acb22 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -62,7 +62,7 @@ quiet_cmd_vdso = VDSO    $@
 		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
-VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv
 GCOV_PROFILE := n
 
 #
