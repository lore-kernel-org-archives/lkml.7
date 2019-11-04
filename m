Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD3CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78E120659
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfKDVOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:14:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38916 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfKDVOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:14:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRjgG-0005Zh-HM; Mon, 04 Nov 2019 22:14:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2AD961C0017;
        Mon,  4 Nov 2019 22:14:32 +0100 (CET)
Date:   Mon, 04 Nov 2019 21:14:31 -0000
From:   "tip-bot2 for Cyrill Gorcunov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Update stale variable name in comment
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191101123850.GE1615@uranus.lan>
References: <20191101123850.GE1615@uranus.lan>
MIME-Version: 1.0
Message-ID: <157290207189.29376.14835910803471702677.tip-bot2@tip-bot2>
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

Commit-ID:     58db103784994e9be5322237df7ef0cf4c0afc39
Gitweb:        https://git.kernel.org/tip/58db103784994e9be5322237df7ef0cf4c0afc39
Author:        Cyrill Gorcunov <gorcunov@gmail.com>
AuthorDate:    Fri, 01 Nov 2019 15:38:50 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 04 Nov 2019 22:04:19 +01:00

x86/fpu: Update stale variable name in comment

When the fpu code was reworked pcntxt_mask was renamed to
xfeatures_mask. Reflect it in the comment as well.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191101123850.GE1615@uranus.lan

---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e5cb67d..18ffc6f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -840,7 +840,7 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 
 	/*
 	 * We should not ever be requesting features that we
-	 * have not enabled.  Remember that pcntxt_mask is
+	 * have not enabled.  Remember that xfeatures_mask is
 	 * what we write to the XCR0 register.
 	 */
 	WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr)),
