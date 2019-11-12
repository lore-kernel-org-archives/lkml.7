Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2289C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 04:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9B320840
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 04:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKLEGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 23:06:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:34570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfKLEGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 23:06:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 20:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="202576628"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.161])
  by fmsmga007.fm.intel.com with ESMTP; 11 Nov 2019 20:06:42 -0800
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
Subject: [PATCH v2 0/6] x86/intel_pmc_core: Add Tiger Lake and Elkhart Lake
Date:   Mon, 11 Nov 2019 20:06:25 -0800
Message-Id: <cover.1573529092.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 1: Fix SoC naming inconsistency
Patch 2: Cleans up termination lines
Patch 3: Refactor driver for ease of adding new SoCs
Patch 4: Add debugfs entry for PCH IPs only if platform supports
Patch 5: Add Tiger Lake legacy support to pmc_core
Patch 6: Add Elkhart Lake legacy support to pmc_core

All the information regarding the PCH IPs and names of IPs will be
available in Intel's Platform Controller Hub (PCH) External Design
Specification (EDS) document expected to be released in 2020 before
product launch.

Changes since v1:
1)Added a patch that fixes the naming inconsistency.
2)Fixed the prefix of all the patches.

Gayatri Kammela (6):
  x86/intel_pmc_core: Fix the SoC naming inconsistency
  x86/intel_pmc_core: Clean up: Remove comma after the termination line
  x86/intel_pmc_core: Create platform dependent pmc bitmap structs
  x86/intel_pmc_core: Make debugfs entry for pch_ip_power_gating_status
    conditional
  platform/x86: Add Tiger Lake (TGL) platform support to intel_pmc_core
    driver
  platform/x86: Add Atom based Elkhart Lake (EHL) platform support to
    intel_pmc_core driver

 drivers/platform/x86/intel_pmc_core.c | 118 ++++++++++++++++++++------
 drivers/platform/x86/intel_pmc_core.h |   2 +-
 2 files changed, 93 insertions(+), 27 deletions(-)

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>

-- 
2.17.1

