Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE69C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26315206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfLPNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:30:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52817 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLPNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:30:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1igqRZ-0001o6-A1; Mon, 16 Dec 2019 14:29:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E2A461C0480;
        Mon, 16 Dec 2019 14:29:48 +0100 (CET)
Date:   Mon, 16 Dec 2019 13:29:48 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot: Fix a comment's incorrect file reference
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191126195911.3429-1-sean.j.christopherson@intel.com>
References: <20191126195911.3429-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157650298869.30329.17330469299720257853.tip-bot2@tip-bot2>
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

Commit-ID:     957a227d413b06130b7d57d1954d821edf6991c1
Gitweb:        https://git.kernel.org/tip/957a227d413b06130b7d57d1954d821edf6991c1
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Tue, 26 Nov 2019 11:59:11 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 16 Dec 2019 14:09:33 +01:00

x86/boot: Fix a comment's incorrect file reference

Fix the comment for 'struct real_mode_header' to reference the correct
assembly file, realmode/rm/header.S.  The comment has always incorrectly
referenced realmode.S, which doesn't exist, as defining the associated
asm blob.

Specify the file's path relative to arch/x86 to avoid confusion with
boot/header.S.  Update the comment for 'struct trampoline_header' to
also include the relative path to keep things consistent, and tweak the
dual 64/32 reference so that it doesn't appear to be an extension of the
relative path, i.e. avoid "realmode/rm/trampoline_32/64.S".

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191126195911.3429-1-sean.j.christopherson@intel.com
---
 arch/x86/include/asm/realmode.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 09ecc32..b35030e 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <asm/io.h>
 
-/* This must match data at realmode.S */
+/* This must match data at realmode/rm/header.S */
 struct real_mode_header {
 	u32	text_start;
 	u32	ro_end;
@@ -36,7 +36,7 @@ struct real_mode_header {
 #endif
 };
 
-/* This must match data at trampoline_32/64.S */
+/* This must match data at realmode/rm/trampoline_{32,64}.S */
 struct trampoline_header {
 #ifdef CONFIG_X86_32
 	u32 start;
