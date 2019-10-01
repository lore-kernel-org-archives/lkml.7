Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345DC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504D52133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfJASiq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:38:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56346 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJASiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:38:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFN2i-0002L4-Ec; Tue, 01 Oct 2019 20:38:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0E0ED1C03AB;
        Tue,  1 Oct 2019 20:38:36 +0200 (CEST)
Date:   Tue, 01 Oct 2019 18:38:35 -0000
From:   "tip-bot2 for Nishad Kamdar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] x86: Use the correct SPDX License Identifier in headers
Cc:     Joe Perches <joe@perches.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Waiman Long <longman@redhat.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C697848ff866ade29e78e872525d7a3067642fd37=2E15554?=
 =?utf-8?q?27420=2Egit=2Enishadkamdar=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C697848ff866ade29e78e872525d7a3067642fd37=2E155542?=
 =?utf-8?q?7420=2Egit=2Enishadkamdar=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <156995511592.9978.4673936343643990987.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     6184488a19be96d89cb6c36fb4bc277198309484
Gitweb:        https://git.kernel.org/tip/6184488a19be96d89cb6c36fb4bc277198309484
Author:        Nishad Kamdar <nishadkamdar@gmail.com>
AuthorDate:    Tue, 16 Apr 2019 21:16:14 +05:30
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 20:31:35 +02:00

x86: Use the correct SPDX License Identifier in headers

Correct the SPDX License Identifier format in a couple of headers.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/697848ff866ade29e78e872525d7a3067642fd37.1555427420.git.nishadkamdar@gmail.com
---
 arch/x86/include/asm/cpu_entry_area.h | 2 +-
 arch/x86/include/asm/pti.h            | 2 +-
 arch/x86/kernel/process.h             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index cff3f3f..8348f7d 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _ASM_X86_CPU_ENTRY_AREA_H
 #define _ASM_X86_CPU_ENTRY_AREA_H
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 5df09a0..07375b4 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PTI_H
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 320ab97..1d0797b 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Code shared between 32 and 64 bit
 
