Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA7C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D342072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAFSQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:16:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41916 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:16:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ioWuo-0005eb-Mx; Mon, 06 Jan 2020 19:15:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 10FF11C2C34;
        Mon,  6 Jan 2020 19:15:44 +0100 (CET)
Date:   Mon, 06 Jan 2020 18:15:43 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Make
 xfeature_is_supervisor()/xfeature_is_user() return bool
Cc:     Borislav Petkov <bp@suse.de>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, "x86-ml" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191212210855.19260-3-yu-cheng.yu@intel.com>
References: <20191212210855.19260-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <157833454385.30329.3292220275280944464.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     158e2ee61f22b878d61de92bea5aad3d2df1c146
Gitweb:        https://git.kernel.org/tip/158e2ee61f22b878d61de92bea5aad3d2df1c146
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Thu, 12 Dec 2019 13:08:54 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 06 Jan 2020 19:08:40 +01:00

x86/fpu/xstate: Make xfeature_is_supervisor()/xfeature_is_user() return bool

Have both xfeature_is_supervisor()/xfeature_is_user() return bool
because they are used only in boolean context.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191212210855.19260-3-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4588fc5..a180659 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -107,7 +107,7 @@ int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 }
 EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
 
-static int xfeature_is_supervisor(int xfeature_nr)
+static bool xfeature_is_supervisor(int xfeature_nr)
 {
 	/*
 	 * Extended State Enumeration Sub-leaves (EAX = 0DH, ECX = n, n > 1)
@@ -117,10 +117,10 @@ static int xfeature_is_supervisor(int xfeature_nr)
 	u32 eax, ebx, ecx, edx;
 
 	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
-	return !!(ecx & 1);
+	return ecx & 1;
 }
 
-static int xfeature_is_user(int xfeature_nr)
+static bool xfeature_is_user(int xfeature_nr)
 {
 	return !xfeature_is_supervisor(xfeature_nr);
 }
