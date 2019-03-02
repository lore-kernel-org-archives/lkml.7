Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29BBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDBD2084F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfCBCw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:52:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:49771 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfCBCwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 21:52:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 18:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,430,1544515200"; 
   d="scan'208";a="148572622"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2019 18:52:29 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, kvm@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 12/17] Change document for kernel option clearcpuid
Date:   Fri,  1 Mar 2019 18:45:06 -0800
Message-Id: <1551494711-213533-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel option clearcpuid now supports multiple options and CPU
capability flags, the document needs to be changed.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0b9a15..1a195f93d3cc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -558,10 +558,12 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clearcpuid=BITNUM [X86]
+	clearcpuid=BITNUM | FLAG [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
-			numbers. Note the Linux specific bits are not necessarily
+			numbers or /proc/cpuinfo for valid CPU flags.
+			Multiple options can be used to disable a few features.
+			Note the Linux specific bits are not necessarily
 			stable over kernel options, but the vendor specific
 			ones should be.
 			Also note that user programs calling CPUID directly
-- 
2.7.4

