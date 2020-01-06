Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E8C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C223207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAFJ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:57:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:30954 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFJ5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:57:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 01:57:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="210741075"
Received: from tuedungt-mobl.ger.corp.intel.com (HELO M5530.gar.corp.intel.com) ([10.255.164.193])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2020 01:56:59 -0800
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     rajatja@google.com, gs0622@gmail.com,
        Harry Pan <harry.pan@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH] platform/x86: intel_pmc_core: update Comet Lake platform driver
Date:   Mon,  6 Jan 2020 17:57:00 +0800
Message-Id: <20200106175643.1.Iaff1da2791b9a00377e8d93aa81b5394ffc5b1b8@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new CML CPU model ID into platform driver support list.

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 drivers/platform/x86/intel_pmc_core_pltdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
index 6fe829f30997..e1266f5c6359 100644
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -44,6 +44,8 @@ static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
 	INTEL_CPU_FAM6(KABYLAKE, pmc_core_device),
 	INTEL_CPU_FAM6(CANNONLAKE_L, pmc_core_device),
 	INTEL_CPU_FAM6(ICELAKE_L, pmc_core_device),
+	INTEL_CPU_FAM6(COMETLAKE, pmc_core_device),
+	INTEL_CPU_FAM6(COMETLAKE_L, pmc_core_device),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
-- 
2.24.1

