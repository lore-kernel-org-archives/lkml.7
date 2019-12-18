Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA7C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473962072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLRMOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:14:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRMOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:14:54 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihYE2-00013W-04; Wed, 18 Dec 2019 13:14:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A3D451C2A74;
        Wed, 18 Dec 2019 13:14:45 +0100 (CET)
Date:   Wed, 18 Dec 2019 12:14:45 -0000
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Kconfig: Correct spelling and punctuation
Cc:     Randy Dunlap <rdunlap@infradead.org>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <443ed0a8-783d-6c7c-3258-e1c44df03fd7@infradead.org>
References: <443ed0a8-783d-6c7c-3258-e1c44df03fd7@infradead.org>
MIME-Version: 1.0
Message-ID: <157667128550.30329.11583222842063841039.tip-bot2@tip-bot2>
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

Commit-ID:     e133f6eac3fa6591384133b2270b24376813d231
Gitweb:        https://git.kernel.org/tip/e133f6eac3fa6591384133b2270b24376813d231
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 03 Dec 2019 16:06:47 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Dec 2019 13:06:53 +01:00

x86/Kconfig: Correct spelling and punctuation

End a sentence with a period (aka full stop) in Kconfig help text. Fix
minor NUMA-related Kconfig text:

- Use capital letters for NUMA acronym.
- Hyphenate Non-Uniform.

 [ bp: Merge into a single patch. ]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: X86 ML <x86@kernel.org>
Link: https://lkml.kernel.org/r/443ed0a8-783d-6c7c-3258-e1c44df03fd7@infradead.org
---
 arch/x86/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d7bbed5..97956b5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -477,7 +477,7 @@ config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
 	depends on SMP
 	---help---
-	  This option is needed for the systems that have more than 8 CPUs
+	  This option is needed for the systems that have more than 8 CPUs.
 
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
@@ -1543,12 +1543,12 @@ config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 
 # Common NUMA Features
 config NUMA
-	bool "Numa Memory Allocation and Scheduler Support"
+	bool "NUMA Memory Allocation and Scheduler Support"
 	depends on SMP
 	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
 	default y if X86_BIGSMP
 	---help---
-	  Enable NUMA (Non Uniform Memory Access) support.
+	  Enable NUMA (Non-Uniform Memory Access) support.
 
 	  The kernel will try to allocate memory used by a CPU on the
 	  local memory controller of the CPU and add some more
