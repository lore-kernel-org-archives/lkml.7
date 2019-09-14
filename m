Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DAC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79A32081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfINHFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 03:05:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:2408 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfINHFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 03:05:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 00:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,503,1559545200"; 
   d="scan'208";a="210615622"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.120])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2019 00:05:33 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/5] tools/power/x86/intel-speed-select: New command and
Date:   Sat, 14 Sep 2019 00:05:08 -0700
Message-Id: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some minor fixes, when firmware mask is including
invalid CPU in the perf-profile mask. Also add some commands to
better manage core-power feature.

Srinivas Pandruvada (4):
  tools/power/x86/intel-speed-select: Allow online/offline based on tdp
  tools/power/x86/intel-speed-select: Format get-assoc information
  tools/power/x86/intel-speed-select: Fix some debug prints
  tools/power/x86/intel-speed-select: Extend core-power command set

Youquan Song (1):
  tools/power/x86/intel-speed-select: Fix high priority core mask over
    count

 .../x86/intel-speed-select/isst-config.c      | 108 ++++++++++++++++--
 .../power/x86/intel-speed-select/isst-core.c  |  25 ++++
 .../x86/intel-speed-select/isst-display.c     |  51 +++++++++
 tools/power/x86/intel-speed-select/isst.h     |   9 +-
 4 files changed, 182 insertions(+), 11 deletions(-)

-- 
2.17.2

