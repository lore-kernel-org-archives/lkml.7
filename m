Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44347C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E783206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfIPP2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:28:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIPP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:28:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i9sum-0003A6-HS; Mon, 16 Sep 2019 17:27:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D7A481C06CD;
        Mon, 16 Sep 2019 17:27:43 +0200 (CEST)
Date:   Mon, 16 Sep 2019 15:27:43 -0000
From:   "tip-bot2 for Sylvain 'ythier' Hitier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/cpu: Clean up intel_tlb_table[]
Cc:     "Sylvain 'ythier' Hitier" <sylvain.hitier@gmail.com>,
        Alex Shi <alex.shi@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>, trivial@kernel.org,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190915090917.GA5086@lilas>
References: <20190915090917.GA5086@lilas>
MIME-Version: 1.0
Message-ID: <156864766375.24167.2061010311416733334.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     77df779de742d6616d4ddd177cba152a75259104
Gitweb:        https://git.kernel.org/tip/77df779de742d6616d4ddd177cba152a75259104
Author:        Sylvain 'ythier' Hitier <sylvain.hitier@gmail.com>
AuthorDate:    Sun, 15 Sep 2019 11:09:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Sep 2019 17:23:46 +02:00

x86/cpu: Clean up intel_tlb_table[]

- Remove the unneeded backslash at EOL: that's not a macro.
  And let's please checkpatch by aligning to open parenthesis.

- For 0x4f descriptor, remove " */" from the info field.

- For 0xc2 descriptor, sync the beginning of info to match the tlb_type.

(The value of info fields could be made more regular, but it's unused by
 the code and will be read only by developers, so don't bother.)

Signed-off-by: Sylvain 'ythier' Hitier <sylvain.hitier@gmail.com>
Cc: Alex Shi <alex.shi@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: trivial@kernel.org
Link: https://lkml.kernel.org/r/20190915090917.GA5086@lilas
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8d6d92e..24e619d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -813,7 +813,7 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x04, TLB_DATA_4M,		8,	" TLB_DATA 4 MByte pages, 4-way set associative" },
 	{ 0x05, TLB_DATA_4M,		32,	" TLB_DATA 4 MByte pages, 4-way set associative" },
 	{ 0x0b, TLB_INST_4M,		4,	" TLB_INST 4 MByte pages, 4-way set associative" },
-	{ 0x4f, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages */" },
+	{ 0x4f, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages" },
 	{ 0x50, TLB_INST_ALL,		64,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
 	{ 0x51, TLB_INST_ALL,		128,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
 	{ 0x52, TLB_INST_ALL,		256,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
@@ -841,7 +841,7 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0xba, TLB_DATA_4K,		64,	" TLB_DATA 4 KByte pages, 4-way associative" },
 	{ 0xc0, TLB_DATA_4K_4M,		8,	" TLB_DATA 4 KByte and 4 MByte pages, 4-way associative" },
 	{ 0xc1, STLB_4K_2M,		1024,	" STLB 4 KByte and 2 MByte pages, 8-way associative" },
-	{ 0xc2, TLB_DATA_2M_4M,		16,	" DTLB 2 MByte/4MByte pages, 4-way associative" },
+	{ 0xc2, TLB_DATA_2M_4M,		16,	" TLB_DATA 2 MByte/4MByte pages, 4-way associative" },
 	{ 0xca, STLB_4K,		512,	" STLB 4 KByte pages, 4-way associative" },
 	{ 0x00, 0, 0 }
 };
@@ -853,8 +853,8 @@ static void intel_tlb_lookup(const unsigned char desc)
 		return;
 
 	/* look up this descriptor in the table */
-	for (k = 0; intel_tlb_table[k].descriptor != desc && \
-			intel_tlb_table[k].descriptor != 0; k++)
+	for (k = 0; intel_tlb_table[k].descriptor != desc &&
+	     intel_tlb_table[k].descriptor != 0; k++)
 		;
 
 	if (intel_tlb_table[k].tlb_type == 0)
