Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F33C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F3F2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfFNHom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:44:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:49698 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNHol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:44:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 00:44:41 -0700
X-ExtLoop1: 1
Received: from rajneesh-desk.iind.intel.com ([10.66.234.53])
  by orsmga003.jf.intel.com with ESMTP; 14 Jun 2019 00:44:37 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael.j.wysocki@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] powercap/rapl: Add Ice Lake NNPI support to RAPL driver
Date:   Fri, 14 Jun 2019 13:09:47 +0530
Message-Id: <20190614073947.12270-2-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614073947.12270-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190614073947.12270-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables support for ICL-NNPI, neural network processor for deep learning
inference. From RAPL point of view it is same as Ice Lake Mobile
processor.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Link: https://lkml.org/lkml/2019/6/5/1034
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 4347f15165f8..19d470c73b6e 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1156,7 +1156,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	INTEL_CPU_FAM6(KABYLAKE_MOBILE,		rapl_defaults_core),
 	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	rapl_defaults_core),
 	INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_MOBILE,		rapl_defaults_core),
+	INTEL_CPU_FAM6(ICELAKE_NNPI,		rapl_defaults_core),
 
 	INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
-- 
2.17.1

