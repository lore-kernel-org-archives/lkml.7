Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687BAC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A27220866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ITG5F6Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFFHxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:53:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:53:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x567qvZX1883397
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 6 Jun 2019 00:52:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x567qvZX1883397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559807578;
        bh=fQ2bnxPL1VkezneG+glmF6X17iRoO7R+D2CFWkkdWtw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ITG5F6Pn/rNzihSr1KcBLcqxeLjn12VVIHicDw8yM7uhA2jd7pcS+liVfrTg8xS/6
         jNgTtcAd8Q3hW2+YWxlx4j3SXUgIpI+J3dP8ZVFtrqRYAZv7bHmU6vFpwfe6JCjB1H
         A8kN+RpQLsMKRT+eyiNqDW/3dNfLMY/eodKKigIOcd43YYJSwebqRoJLsaXYOKB+v1
         eNrLrPgghzXrsNlYBRdqENYZKCNnt1LTppnuvqebp0z+SU5DPXEwgEUaqK2H+vkLqo
         DvT1y5WCC7HY7/wz8OqDUxt7pqt6zlJ7sa7P+4eB/vugLy373j8adw6yZbbYm8m139
         zvCyaKfxCgZMw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x567quHG1883394;
        Thu, 6 Jun 2019 00:52:56 -0700
Date:   Thu, 6 Jun 2019 00:52:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-e35faeb64146f2015f2aec14b358ae508e4066db@git.kernel.org>
Cc:     tony.luck@intel.com, hpa@zytor.com, mingo@redhat.com,
        qiuxu.zhuo@intel.com, rajneesh.bhardwaj@linux.intel.com,
        bp@suse.de, x86@kernel.org, kan.liang@linux.intel.com,
        mingo@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: bp@suse.de, x86@kernel.org, tony.luck@intel.com, hpa@zytor.com,
          qiuxu.zhuo@intel.com, mingo@redhat.com,
          rajneesh.bhardwaj@linux.intel.com,
          andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de,
          kan.liang@linux.intel.com, mingo@kernel.org
In-Reply-To: <20190603134122.13853-1-kan.liang@linux.intel.com>
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/CPU: Add more Icelake model numbers
Git-Commit-ID: e35faeb64146f2015f2aec14b358ae508e4066db
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

Commit-ID:  e35faeb64146f2015f2aec14b358ae508e4066db
Gitweb:     https://git.kernel.org/tip/e35faeb64146f2015f2aec14b358ae508e4066db
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 3 Jun 2019 06:41:20 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 6 Jun 2019 09:42:36 +0200

x86/CPU: Add more Icelake model numbers

Add the CPUID model numbers of Icelake (ICL) desktop and server
processors to the Intel family list.

 [ Qiuxu: Sort the macros by model number. ]

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc: rui.zhang@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190603134122.13853-1-kan.liang@linux.intel.com
---
 arch/x86/include/asm/intel-family.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9f15384c504a..310118805f57 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -52,6 +52,9 @@
 
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
+#define INTEL_FAM6_ICELAKE_X		0x6A
+#define INTEL_FAM6_ICELAKE_XEON_D	0x6C
+#define INTEL_FAM6_ICELAKE_DESKTOP	0x7D
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
 
 /* "Small Core" Processors (Atom) */
