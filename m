Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F6FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DB3207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfIZSmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:42:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:57431 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfIZSmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:42:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 11:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="214574480"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.161])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2019 11:42:45 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     vishwanath.somayaji@intel.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core driver
Date:   Thu, 26 Sep 2019 12:25:58 -0700
Message-Id: <20190926192603.18647-1-gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 1: Cleans up termination lines
Patch 2: Refactor driver for ease of adding new SoCs
Patch 3: Refactor debugfs entry for PCH IPs power gating status
Patch 4: Add Tiger Lake legacy support to pmc_core
Patch 5: Add Elkhart Lake legacy support to pmc_core

All the information regarding the PCH IPs and names of IPs will be available
in *future* Intel's Platform Controller Hub (PCH) External Design Specification
(EDS) document.

Gayatri Kammela (5):
  x86/intel_pmc_core: Clean up: Remove comma after the termination line
  x86/intel_pmc_core: Create platform dependent pmc bitmap structs
  x86/intel_pmc_core: Make debugfs entry for pch_ip_power_gating_status
    conditional
  platform/x86: Add Tiger Lake(TGL) platform support to intel_pmc_core
    driver
  platform/x86: Add Atom based Elkhart Lake(EHL) platform support to
    intel_pmc_core driver

 drivers/platform/x86/intel_pmc_core.c | 108 +++++++++++++++++++++-----
 drivers/platform/x86/intel_pmc_core.h |   2 +-
 2 files changed, 88 insertions(+), 22 deletions(-)

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
-- 
2.17.1

