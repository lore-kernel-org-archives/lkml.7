Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB38C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8654220820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbfIWS7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:59:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:39237 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733155AbfIWS7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:59:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 11:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; 
   d="scan'208";a="203187143"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2019 11:59:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] Auto configuration mode and error
Date:   Mon, 23 Sep 2019 11:59:03 -0700
Message-Id: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are some changes, which help users to use the base-freq and
turbo-freq features without going through multiple steps for
basic configuration. Also add some error when user is trying
to disable core-power feature while it is getting used.

None of these patches are urgent and can wait for kernel version v5.5.

Srinivas Pandruvada (3):
  tools/power/x86/intel-speed-select: Base-freq feature auto mode
  tools/power/x86/intel-speed-select: Turbo-freq feature auto mode
  tools/power/x86/intel-speed-select: Refuse to disable core-power when
    getting used

 .../x86/intel-speed-select/isst-config.c      | 275 +++++++++++++++++-
 .../power/x86/intel-speed-select/isst-core.c  |  21 ++
 2 files changed, 281 insertions(+), 15 deletions(-)

-- 
2.17.2

