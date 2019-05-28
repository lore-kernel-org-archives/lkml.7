Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79495C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4900021019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hBiuUKcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfE1VYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:24:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1VYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:24:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLO6EM2239960
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:24:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLO6EM2239960
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078647;
        bh=65jeStFY+/VN0605HKheOaSupMyY/pJAmSJskHTqky8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=hBiuUKcxhGGEsZVRJrdEHIIT/HTsPDsTeRPwbubvbMcJODRR3RfdDMkp2EbhDVe/u
         55WPdzJd0+aC6ie3YpWAY9UAZ1xQnlbJVnzoadxBQbzAoTX8jno2gm8c7Y+hL87zZu
         HV2uhxf6XujdWyVxoci+pDw05h5j13cmalwtS26dSaYRGmFRiIoFCHpIK0w6wu3iPx
         J26PUcjlvmqmTDs26BXAQVpAQ8tk1kU1ybUIv2JxJGJdz6wXuGideO0YSsCd3XB6W6
         eqWz0QlrjbfKUyCYAS+hVqOvKmFDOnpDwFV18HtZS/4RMCJ3tvNUlH4pwF3/j77HDt
         V69ZyhMTJfkxg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLO6nf2239811;
        Tue, 28 May 2019 14:24:06 -0700
Date:   Tue, 28 May 2019 14:24:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jp1afecx3ql1jkuirpgkqfad@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org, acme@redhat.com,
        lclaudio@redhat.com, hpa@zytor.com, brendan.d.gregg@gmail.com,
        adrian.hunter@intel.com, ak@linux.intel.com, jolsa@kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
          brendan.d.gregg@gmail.com, jolsa@kernel.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools arch x86: Sync asm/cpufeatures.h with the
 with the kernel
Git-Commit-ID: b979540a7522617e190636621e7c5ffae469f8f0
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

Commit-ID:  b979540a7522617e190636621e7c5ffae469f8f0
Gitweb:     https://git.kernel.org/tip/b979540a7522617e190636621e7c5ffae469f8f0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 16:39:42 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:49:03 -0300

tools arch x86: Sync asm/cpufeatures.h with the with the kernel

To pick up the changes in:

  ed5194c2732c ("x86/speculation/mds: Add basic bug infrastructure for MDS")
  e261f209c366 ("x86/speculation/mds: Add BUG_MSBDS_ONLY")

That don't affect anything in tools/.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/n/tip-jp1afecx3ql1jkuirpgkqfad@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 981ff9479648..75f27ee2c263 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -344,6 +344,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
@@ -382,5 +383,7 @@
 #define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre variant 2 attack with indirect branches */
 #define X86_BUG_SPEC_STORE_BYPASS	X86_BUG(17) /* CPU is affected by speculative store bypass attack */
 #define X86_BUG_L1TF			X86_BUG(18) /* CPU is affected by L1 Terminal Fault */
+#define X86_BUG_MDS			X86_BUG(19) /* CPU is affected by Microarchitectural data sampling */
+#define X86_BUG_MSBDS_ONLY		X86_BUG(20) /* CPU is only affected by the  MSDBS variant of BUG_MDS */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
