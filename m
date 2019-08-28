Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D698C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6920C22CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfH1Gtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:49:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45740 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfH1Gtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:49:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2rlY-0000qF-8A; Wed, 28 Aug 2019 08:49:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A04AB1C07D2;
        Wed, 28 Aug 2019 08:49:11 +0200 (CEST)
Date:   Wed, 28 Aug 2019 06:49:11 -0000
From:   "tip-bot2 for Cao Jin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpufeature: Explain the macro duplication
Cc:     Borislav Petkov <bp@alien8.de>, Cao Jin <caoj.fnst@cn.fujitsu.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828061100.27032-1-caoj.fnst@cn.fujitsu.com>
References: <20190828061100.27032-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Message-ID: <156697495154.15133.9156303181767258276.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     cbb1133b563a63901cf778220eb17e3ff1425aed
Gitweb:        https://git.kernel.org/tip/cbb1133b563a63901cf778220eb17e3ff1425aed
Author:        Cao Jin <caoj.fnst@cn.fujitsu.com>
AuthorDate:    Wed, 28 Aug 2019 14:11:00 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 28 Aug 2019 08:38:39 +02:00

x86/cpufeature: Explain the macro duplication

Explain the intent behind the duplication of the

  BUILD_BUG_ON_ZERO(NCAPINTS != n)

check in *_MASK_CHECK and its immediate use in the *MASK_BIT_SET macros
too.

 [ bp: Massage. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Cao Jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190828061100.27032-1-caoj.fnst@cn.fujitsu.com
---
 arch/x86/include/asm/cpufeature.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 58acda5..59bf91c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -61,6 +61,13 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 #define CHECK_BIT_IN_MASK_WORD(maskname, word, bit)	\
 	(((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
 
+/*
+ * {REQUIRED,DISABLED}_MASK_CHECK below may seem duplicated with the
+ * following BUILD_BUG_ON_ZERO() check but when NCAPINTS gets changed, all
+ * header macros which use NCAPINTS need to be changed. The duplicated macro
+ * use causes the compiler to issue errors for all headers so that all usage
+ * sites can be corrected.
+ */
 #define REQUIRED_MASK_BIT_SET(feature_bit)		\
 	 ( CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  0, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK,  1, feature_bit) ||	\
