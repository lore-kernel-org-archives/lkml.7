Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB78DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B4020675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfDPLmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:42:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfDPLmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:42:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBgIDv3429610
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:42:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBgIfI3429607;
        Tue, 16 Apr 2019 04:42:18 -0700
Date:   Tue, 16 Apr 2019 04:42:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-a943245adc9ae31942af752e879fbbc182166573@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        torvalds@linux-foundation.org, bp@alien8.de, tglx@linutronix.de,
        colin.king@canonical.com, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
          colin.king@canonical.com, bp@alien8.de,
          torvalds@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190416105751.18899-1-colin.king@canonical.com>
References: <20190416105751.18899-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/Kconfig: Fix spelling mistake "effectivness"
 -> "effectiveness"
Git-Commit-ID: a943245adc9ae31942af752e879fbbc182166573
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

Commit-ID:  a943245adc9ae31942af752e879fbbc182166573
Gitweb:     https://git.kernel.org/tip/a943245adc9ae31942af752e879fbbc182166573
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Tue, 16 Apr 2019 11:57:51 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 13:27:34 +0200

x86/Kconfig: Fix spelling mistake "effectivness" -> "effectiveness"

The Kconfig text contains a spelling mistake, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/20190416105751.18899-1-colin.king@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3cf437c..01dbb05bc498 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1499,7 +1499,7 @@ config X86_CPA_STATISTICS
 	depends on DEBUG_FS
 	---help---
 	  Expose statistics about the Change Page Attribute mechanims, which
-	  helps to determine the effectivness of preserving large and huge
+	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
 config ARCH_HAS_MEM_ENCRYPT
