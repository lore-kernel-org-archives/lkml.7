Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C00E21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfCVQjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:39:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:60735 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbfCVQjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:39:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="144356619"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2019 09:39:36 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 09/23] perf/x86/intel/rapl: Add Icelake support
Date:   Fri, 22 Mar 2019 09:37:04 -0700
Message-Id: <20190322163718.2191-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322163718.2191-1-kan.liang@linux.intel.com>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Icelake support the same RAPL counters as Skylake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2.

 arch/x86/events/intel/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 94dc564146ca..37ebf6fc5415 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -775,6 +775,8 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X, hsw_rapl_init),
 
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS, hsw_rapl_init),
+
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,  skl_rapl_init),
 	{},
 };
 
-- 
2.17.1

