Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0333C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9373E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aalUzvRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF0Xgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:36:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0Xgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:36:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNaFWt499666
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:36:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNaFWt499666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678577;
        bh=MLE0fRTtBXYeRHPeXVF/h5wt7ZshUFV/bjRzM3uy6q8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aalUzvRmTQMaxQHpDCEYy0H1q7saU869mCpABRLVSLT6nwacE+kqahVp6Cs2cWZv0
         bNM6VEEMTxn30/JwqqteFyFRre4V2stANddtrApsRwkzJwJD/X8NREOWO60N2TGCF2
         Ul89+IidRtl1kVjtiS2bKgIv/yHHiUmaZz0gpmhbhmmTHYXHQDNPxH8mcQNR5293Ic
         u6S+fYeY6sQwshH6Hs8HtH1ePDX6Rsk10rHzwUTQXP7pcdeOV7HYQhRuHffcyPTiYN
         ky9viafg+EbRTSCcELY6kvjFrWq7g56CVyxNI8iKMRsyhhjHFGh79H45EK2AYPydFG
         7Gj4SkMFzGfGw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNaFVN499663;
        Thu, 27 Jun 2019 16:36:15 -0700
Date:   Thu, 27 Jun 2019 16:36:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7c4b0e0898ebff4d4821d5dd7a564903a1e88821@git.kernel.org>
Cc:     Suravee.Suthikulpanit@amd.com, andi.kleen@intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ricardo.neri-calderon@linux.intel.com, ravi.v.shankar@intel.com,
        tglx@linutronix.de, hpa@zytor.com, ashok.raj@intel.com,
        eranian@google.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, ashok.raj@intel.com, hpa@zytor.com,
          mingo@kernel.org, eranian@google.com,
          ricardo.neri-calderon@linux.intel.com, peterz@infradead.org,
          ravi.v.shankar@intel.com, andi.kleen@intel.com,
          linux-kernel@vger.kernel.org, Suravee.Suthikulpanit@amd.com
In-Reply-To: <20190623132434.339011567@linutronix.de>
References: <20190623132434.339011567@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Remove pointless x86-64 specific
 #include
Git-Commit-ID: 7c4b0e0898ebff4d4821d5dd7a564903a1e88821
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

Commit-ID:  7c4b0e0898ebff4d4821d5dd7a564903a1e88821
Gitweb:     https://git.kernel.org/tip/7c4b0e0898ebff4d4821d5dd7a564903a1e88821
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:44 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:16 +0200

x86/hpet: Remove pointless x86-64 specific #include

Nothing requires asm/pgtable.h here anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.339011567@linutronix.de

---
 arch/x86/kernel/hpet.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index daa97e14296b..76d63ed62ce8 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -71,10 +71,6 @@ static inline void hpet_writel(unsigned int d, unsigned int a)
 	writel(d, hpet_virt_address + a);
 }
 
-#ifdef CONFIG_X86_64
-#include <asm/pgtable.h>
-#endif
-
 static inline void hpet_set_mapping(void)
 {
 	hpet_virt_address = ioremap_nocache(hpet_address, HPET_MMAP_SIZE);
