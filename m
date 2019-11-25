Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D1BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CAA20823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfKYIT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:19:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfKYIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:19:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZ9aR-0001QQ-A3; Mon, 25 Nov 2019 09:19:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB3CC1C1AF1;
        Mon, 25 Nov 2019 09:19:10 +0100 (CET)
Date:   Mon, 25 Nov 2019 08:19:10 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lkdtm: Remove references to CONFIG_REFCOUNT_FULL
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121115902.2551-11-will@kernel.org>
References: <20191121115902.2551-11-will@kernel.org>
MIME-Version: 1.0
Message-ID: <157466995070.21853.2022025390906689136.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     500543c53a54134ced386aed85cd93cf1363f981
Gitweb:        https://git.kernel.org/tip/500543c53a54134ced386aed85cd93cf1363f981
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 11:59:02 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Nov 2019 09:15:46 +01:00

lkdtm: Remove references to CONFIG_REFCOUNT_FULL

CONFIG_REFCOUNT_FULL no longer exists, so remove all references to it.

Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191121115902.2551-11-will@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/misc/lkdtm/refcount.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
index abf3b7c..de7c5ab 100644
--- a/drivers/misc/lkdtm/refcount.c
+++ b/drivers/misc/lkdtm/refcount.c
@@ -119,7 +119,7 @@ void lkdtm_REFCOUNT_DEC_ZERO(void)
 static void check_negative(refcount_t *ref, int start)
 {
 	/*
-	 * CONFIG_REFCOUNT_FULL refuses to move a refcount at all on an
+	 * refcount_t refuses to move a refcount at all on an
 	 * over-sub, so we have to track our starting position instead of
 	 * looking only at zero-pinning.
 	 */
@@ -202,7 +202,6 @@ static void check_from_zero(refcount_t *ref)
 
 /*
  * A refcount_inc() from zero should pin to zero or saturate and may WARN.
- * Only CONFIG_REFCOUNT_FULL provides this protection currently.
  */
 void lkdtm_REFCOUNT_INC_ZERO(void)
 {
