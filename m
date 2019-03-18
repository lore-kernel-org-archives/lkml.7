Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1E32175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfCRVpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:45:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:57595 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfCRVoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:44:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 14:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="308301796"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 14:44:19 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 08/22] perf/x86/intel/rapl: Add Icelake support
Date:   Mon, 18 Mar 2019 14:41:30 -0700
Message-Id: <20190318214144.4639-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318214144.4639-1-kan.liang@linux.intel.com>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Icelake support the same RAPL counters as Skylake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
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

