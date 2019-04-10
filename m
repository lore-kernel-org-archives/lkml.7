Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332A8C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6892077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDJS5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:57:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:12518 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfDJS5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:57:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 11:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="141655352"
Received: from otc-lr-04.jf.intel.com ([10.54.39.19])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2019 11:57:47 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, acme@kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/2] perf: Add Tremont support
Date:   Wed, 10 Apr 2019 11:57:07 -0700
Message-Id: <1554922629-126287-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The patch series intends to add Tremont support for Linux perf.

The patch series is on top of Icelake V5 patch series (with Peter's cleanup patch).
https://lkml.org/lkml/2019/4/8/630

PATCH 1: A fix for Icelake V5 patch series (with Peter's cleanup patch).
         It can be merged back into "Subject: perf/x86/intel: Add Icelake support"
PATCH 2: Tremont core PMU support.

Changes since V1:
- The previous patch "perf/x86/intel: Support adaptive PEBS for fixed counters"
  will be merged back.
- New patch to fix the checking for instruction event.
- Allow instruction:ppp on generic purpose counter 0

Kan Liang (2):
  perf/x86/intel: Fix the checking for instruction event
  perf/x86/intel: Add Tremont core PMU support

 arch/x86/events/intel/core.c | 96 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

-- 
2.7.4

