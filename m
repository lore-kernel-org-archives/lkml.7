Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AEEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9333020708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVWCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:02:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35763 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVWCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:02:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYH0J-0005vj-Tc; Fri, 22 Nov 2019 23:02:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2CED51C1A91;
        Fri, 22 Nov 2019 23:02:15 +0100 (CET)
Date:   Fri, 22 Nov 2019 22:02:15 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/32: Increase the size of CPU_ENTRY_AREA_PAGES
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157446013502.21853.8227778923037920355.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d9976e424909d44585206e90154f74723b5f9fe5
Gitweb:        https://git.kernel.org/tip/d9976e424909d44585206e90154f74723b5f9fe5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 22 Nov 2019 22:54:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Nov 2019 22:55:10 +01:00

x86/entry/32: Increase the size of CPU_ENTRY_AREA_PAGES

The following commit:

  880a98c33996: ("x86/cpu_entry_area: Add guard page for entry stack on 32bit")

Increased the size of 'struct cpu_entry_area' by 4K, so increase
CPU_ENTRY_AREA_PAGES from 40 to 41.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_32_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index b0bc0ff..0fab4bf 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,7 +44,7 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
  * Define this here and validate with BUILD_BUG_ON() in pgtable_32.c
  * to avoid include recursion hell
  */
-#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
+#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 41)
 
 #define CPU_ENTRY_AREA_BASE						\
 	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
