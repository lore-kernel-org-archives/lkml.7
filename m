Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9334C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B0F20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391696AbfIFFmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:42:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403997AbfIFFmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:42:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i670a-0008Cs-4n; Fri, 06 Sep 2019 07:42:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AA93F1C0DE8;
        Fri,  6 Sep 2019 07:42:07 +0200 (CEST)
Date:   Fri, 06 Sep 2019 05:42:07 -0000
From:   "tip-bot2 for Rahul Tanwar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add new Airmont variant to Intel family
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156774852765.13152.9663331748626480891.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     855fa1f362cab2dc7574acb853b0963dd01d6b8d
Gitweb:        https://git.kernel.org/tip/855fa1f362cab2dc7574acb853b0963dd01d6b8d
Author:        Rahul Tanwar <rahul.tanwar@linux.intel.com>
AuthorDate:    Thu, 05 Sep 2019 12:30:19 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Sep 2019 07:30:39 +02:00

x86/cpu: Add new Airmont variant to Intel family

Add new Airmont variant CPU model to Intel family.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Cc: Gayatri Kammela <gayatri.kammela@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190905193020.14707-4-tony.luck@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 55568af..f046225 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -98,6 +98,7 @@
 
 #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
 #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
+#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
 
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_D	0x5F /* Denverton */
