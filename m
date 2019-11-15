Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18FCC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912902073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKOH3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:29:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKOH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:29:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVW2L-0002Kz-Ah; Fri, 15 Nov 2019 08:28:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 00CE81C18B4;
        Fri, 15 Nov 2019 08:28:57 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:28:56 -0000
From:   "tip-bot2 for Cao jin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Fix typos
Cc:     Cao jin <caoj.fnst@cn.fujitsu.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191115050745.1941-1-ruansy.fnst@cn.fujitsu.com>
References: <20191115050745.1941-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Message-ID: <157380293663.29467.6488649519680691401.tip-bot2@tip-bot2>
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

Commit-ID:     0e1e9229ce790ce842fce50a0d8e684efcbf0f94
Gitweb:        https://git.kernel.org/tip/0e1e9229ce790ce842fce50a0d8e684efcbf0f94
Author:        Cao jin <caoj.fnst@cn.fujitsu.com>
AuthorDate:    Fri, 15 Nov 2019 13:07:45 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 08:26:07 +01:00

x86/setup: Fix typos

BIOSen -> BIOSes; paing -> paging.
And improve comments via 640"Kb".

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: <bp@alien8.de>
Cc: <hpa@zytor.com>
Cc: <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191115050745.1941-1-ruansy.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b..56ac9ff 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -459,7 +459,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
  * due to mapping restrictions.
  *
  * On 64bit, kdump kernel need be restricted to be under 64TB, which is
- * the upper limit of system RAM in 4-level paing mode. Since the kdump
+ * the upper limit of system RAM in 4-level paging mode. Since the kdump
  * jumping could be from 5-level to 4-level, the jumping will fail if
  * kernel is put above 64TB, and there's no way to detect the paging mode
  * of the kernel which will be loaded for dumping during the 1st kernel
@@ -743,8 +743,8 @@ static void __init trim_bios_range(void)
 	e820__range_update(0, PAGE_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 
 	/*
-	 * special case: Some BIOSen report the PC BIOS
-	 * area (640->1Mb) as ram even though it is not.
+	 * special case: Some BIOSes report the PC BIOS
+	 * area (640Kb->1Mb) as ram even though it is not.
 	 * take them out.
 	 */
 	e820__range_remove(BIOS_BEGIN, BIOS_END - BIOS_BEGIN, E820_TYPE_RAM, 1);
