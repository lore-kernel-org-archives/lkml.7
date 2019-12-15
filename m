Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52138C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E7C20700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfLOKSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 05:18:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51108 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfLOKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 05:18:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1igQyj-0005P9-1Z; Sun, 15 Dec 2019 11:18:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B19671C2817;
        Sun, 15 Dec 2019 11:18:19 +0100 (CET)
Date:   Sun, 15 Dec 2019 10:18:19 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/tsx: Define pr_fmt()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112221823.19677-2-bp@alien8.de>
References: <20191112221823.19677-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157640509952.30329.3290134732886823091.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d157aa0fb241646e8818f699653ed983e6581b11
Gitweb:        https://git.kernel.org/tip/d157aa0fb241646e8818f699653ed983e6581b11
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 12 Nov 2019 22:06:03 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 15 Dec 2019 10:58:54 +01:00

x86/cpu/tsx: Define pr_fmt()

... so that all current and future pr_* statements in this file have the
proper prefix.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20191112221823.19677-2-bp@alien8.de
---
 arch/x86/kernel/cpu/tsx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 3e20d32..1674c8d 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -14,6 +14,9 @@
 
 #include "cpu.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "tsx: " fmt
+
 enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
 
 void tsx_disable(void)
@@ -99,7 +102,7 @@ void __init tsx_init(void)
 			tsx_ctrl_state = x86_get_tsx_auto_mode();
 		} else {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
-			pr_err("tsx: invalid option, defaulting to off\n");
+			pr_err("invalid option, defaulting to off\n");
 		}
 	} else {
 		/* tsx= not provided */
