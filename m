Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45466C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282092073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKOH3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:29:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42506 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfKOH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:29:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVW2L-0002Kw-8i; Fri, 15 Nov 2019 08:28:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 81CFC1C08AC;
        Fri, 15 Nov 2019 08:28:56 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:28:55 -0000
From:   "tip-bot2 for Cao jin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/numa: Fix typo
Cc:     Cao jin <caoj.fnst@cn.fujitsu.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Message-ID: <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     bff3dc88003badacb7ed685e301ab38dbdc36a8b
Gitweb:        https://git.kernel.org/tip/bff3dc88003badacb7ed685e301ab38dbdc36a8b
Author:        Cao jin <caoj.fnst@cn.fujitsu.com>
AuthorDate:    Fri, 15 Nov 2019 13:08:28 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 08:26:07 +01:00

x86/numa: Fix typo

encomapssing -> encompassing.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: <bp@alien8.de>
Cc: <dave.hansen@linux.intel.com>
Cc: <hpa@zytor.com>
Cc: <luto@kernel.org>
Cc: <peterz@infradead.org>
Cc: <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 4123100..99f7a68 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -699,7 +699,7 @@ static int __init dummy_numa_init(void)
  * x86_numa_init - Initialize NUMA
  *
  * Try each configured NUMA initialization method until one succeeds.  The
- * last fallback is dummy single node config encomapssing whole memory and
+ * last fallback is dummy single node config encompassing whole memory and
  * never fails.
  */
 void __init x86_numa_init(void)
