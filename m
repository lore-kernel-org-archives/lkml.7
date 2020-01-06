Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29B1C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EBC208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFSQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:16:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgAFSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:16:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ioWuo-0005ee-ME; Mon, 06 Jan 2020 19:15:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 55AF11C2C9F;
        Mon,  6 Jan 2020 19:15:44 +0100 (CET)
Date:   Mon, 06 Jan 2020 18:15:44 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Fix small issues
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191212210855.19260-2-yu-cheng.yu@intel.com>
References: <20191212210855.19260-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <157833454417.30329.7094304955658404850.tip-bot2@tip-bot2>
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

Commit-ID:     8c9e607376968865456b33d9a2efdee2c7e1030d
Gitweb:        https://git.kernel.org/tip/8c9e607376968865456b33d9a2efdee2c7e1030d
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Thu, 12 Dec 2019 13:08:53 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 06 Jan 2020 17:31:11 +01:00

x86/fpu/xstate: Fix small issues

In response to earlier comments, fix small issues before introducing
XSAVES supervisor states:

- Fix comments of xfeature_is_supervisor().
- Replace ((u64)1 << 63) with XCOMP_BV_COMPACTED_FORMAT.

No functional changes.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191212210855.19260-2-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index fa31470..4588fc5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -110,12 +110,9 @@ EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
 static int xfeature_is_supervisor(int xfeature_nr)
 {
 	/*
-	 * We currently do not support supervisor states, but if
-	 * we did, we could find out like this.
-	 *
-	 * SDM says: If state component 'i' is a user state component,
-	 * ECX[0] return 0; if state component i is a supervisor
-	 * state component, ECX[0] returns 1.
+	 * Extended State Enumeration Sub-leaves (EAX = 0DH, ECX = n, n > 1)
+	 * returns ECX[0] set to (1) for a supervisor state, and cleared (0)
+	 * for a user state.
 	 */
 	u32 eax, ebx, ecx, edx;
 
@@ -419,7 +416,8 @@ static void __init setup_init_fpu_buf(void)
 	print_xstate_features();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		init_fpstate.xsave.header.xcomp_bv = (u64)1 << 63 | xfeatures_mask;
+		init_fpstate.xsave.header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
+						     xfeatures_mask;
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
