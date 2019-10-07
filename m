Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F2CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911EC206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfJGTbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:31:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:26154 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGTbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:31:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 12:31:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="192372871"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 12:31:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/6]  Add CascadeLake-N Support
Date:   Mon,  7 Oct 2019 12:30:54 -0700
Message-Id: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SST-BF on CascadeLake-N support.  The CascadeLake-N
processor only support SST-BF and not other SST functionality.

v3:
Fix crash due to geline
Fix display to perf-profile info and base-freq info command
Fix output for coremask
Fix base frequency CPU list. This should be displayed for a package
Auto mode support for base-freq enable/disable
One of the patch for config only change folded to next one where it is
used.

The patch 1 has nothing to do with the CLX-N. It saves some bytes in the
size.

v2: Updated with comments from Srinivas (use common clx_n_* function names,
common is_clx_n_platform() function call to identify CascadeLake-N)


Prarit Bhargava (6):
  tools/power/x86/intel-speed-select: Add int argument to command
    functions
  tools/power/x86/intel-speed-select: Make process_command generic
  tools/power/x86/intel-speed-select: Add check for CascadeLake-N models
  tools/power/x86/intel-speed-select: Implement CascadeLake-N help and
    command functions structures
  tools/power/x86/intel-speed-select: Implement 'perf-profile info' on
    CascadeLake-N
  tools/power/x86/intel-speed-select: Implement base-freq commands on
    CascadeLake-N

 .../x86/intel-speed-select/isst-config.c      | 523 ++++++++++++------
 .../x86/intel-speed-select/isst-display.c     |  14 +-
 tools/power/x86/intel-speed-select/isst.h     |   3 +
 3 files changed, 383 insertions(+), 157 deletions(-)

-- 
2.17.2

