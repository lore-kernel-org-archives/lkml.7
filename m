Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B546CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FC4206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfC2OEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:04:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44637 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfC2OEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:04:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TE4EvA3813375
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 07:04:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TE4D1I3813370;
        Fri, 29 Mar 2019 07:04:13 -0700
Date:   Fri, 29 Mar 2019 07:04:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-a72a19327b92e09dab0eb9fd2bc83466465cbffb@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        luto@kernel.org, sai.praneeth.prakhya@intel.com,
        peterz@infradead.org, bigeasy@linutronix.de, x86@kernel.org,
        hpa@zytor.com, mojha@codeaurora.org, dave.hansen@intel.com,
        jannh@google.com, tglx@linutronix.de, bp@suse.de, riel@surriel.com
Reply-To: dave.hansen@intel.com, hpa@zytor.com, mojha@codeaurora.org,
          x86@kernel.org, jannh@google.com, tglx@linutronix.de,
          riel@surriel.com, bp@suse.de, mingo@kernel.org,
          bigeasy@linutronix.de, peterz@infradead.org,
          sai.praneeth.prakhya@intel.com, luto@kernel.org,
          mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190328230939.15711-1-jannh@google.com>
References: <20190328230939.15711-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/mm/tlb: Define LOADED_MM_SWITCHING with
 pointer-sized number
Git-Commit-ID: a72a19327b92e09dab0eb9fd2bc83466465cbffb
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

Commit-ID:  a72a19327b92e09dab0eb9fd2bc83466465cbffb
Gitweb:     https://git.kernel.org/tip/a72a19327b92e09dab0eb9fd2bc83466465cbffb
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 29 Mar 2019 00:09:39 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 29 Mar 2019 14:55:31 +0100

x86/mm/tlb: Define LOADED_MM_SWITCHING with pointer-sized number

sparse complains that LOADED_MM_SWITCHING's definition casts an int to a
pointer:

  arch/x86/mm/tlb.c:409:17: warning: non size-preserving integer to pointer cast

Use a pointer-sized integer constant instead.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sai Praneeth <sai.praneeth.prakhya@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190328230939.15711-1-jannh@google.com
---
 arch/x86/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f4204bf377fc..90926e8dd1f8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -167,7 +167,7 @@ struct tlb_state {
 	 */
 	struct mm_struct *loaded_mm;
 
-#define LOADED_MM_SWITCHING ((struct mm_struct *)1)
+#define LOADED_MM_SWITCHING ((struct mm_struct *)1UL)
 
 	/* Last user mm for optimizing IBPB */
 	union {
