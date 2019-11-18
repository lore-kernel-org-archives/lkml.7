Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46878C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220902067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfKRJLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:11:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49457 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:11:46 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iWd46-0005HM-64; Mon, 18 Nov 2019 10:11:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C4CE71C0072;
        Mon, 18 Nov 2019 10:11:21 +0100 (CET)
Date:   Mon, 18 Nov 2019 09:11:21 -0000
From:   "tip-bot2 for Cao jin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix typos in comments
Cc:     Cao jin <caoj.fnst@cn.fujitsu.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Robert Richter <rrichter@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191118070012.27850-1-caoj.fnst@cn.fujitsu.com>
References: <20191118070012.27850-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Message-ID: <157406828172.12247.4218858363680758865.tip-bot2@tip-bot2>
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

Commit-ID:     11a98f37a5c11fd3cec9c7a566dfa902bceb5bde
Gitweb:        https://git.kernel.org/tip/11a98f37a5c11fd3cec9c7a566dfa902bceb5bde
Author:        Cao jin <caoj.fnst@cn.fujitsu.com>
AuthorDate:    Mon, 18 Nov 2019 15:00:12 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 18 Nov 2019 10:03:26 +01:00

x86: Fix typos in comments

BIOSen -> BIOSes; paing -> paging. Append to 640 its proper unit "Kb".
encomapssing -> encompassing.

 [ bp: Merge into a single patch, fix one more typo, massage. ]

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191118070012.27850-1-caoj.fnst@cn.fujitsu.com
---
 arch/x86/kernel/setup.c | 6 +++---
 arch/x86/mm/numa.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b..35b3f3a 100644
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
+	 * area (640Kb -> 1Mb) as RAM even though it is not.
 	 * take them out.
 	 */
 	e820__range_remove(BIOS_BEGIN, BIOS_END - BIOS_BEGIN, E820_TYPE_RAM, 1);
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
