Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CAEC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0608A20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfEAAyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 20:54:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:6348 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfEAAyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:54:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 17:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,415,1549958400"; 
   d="scan'208";a="228225461"
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga001.jf.intel.com with ESMTP; 30 Apr 2019 17:54:51 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 0/6] Perf uncore support for Snow Ridge server
Date:   Tue, 30 Apr 2019 17:53:42 -0700
Message-Id: <1556672028-119221-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The patch series intends to enable perf uncore support for Snow Ridge
server.

Here is the link for the uncore document.
https://cdrdv2.intel.com/v1/dl/getContent/611319

Patch 1: Fixes a generic issue for uncore free-running counter, which
also impacts the Snow Ridge server.

Patch 2-6: Perf uncore support for Snow Ridge server.

Kan Liang (6):
  perf/x86/intel/uncore: Handle invalid event coding for free-running
    counter
  perf/x86/intel/uncore: Add uncore support for Snow Ridge server
  perf/x86/intel/uncore: Extract codes of box ref/unref
  perf/x86/intel/uncore: Support MMIO type uncore blocks
  perf/x86/intel/uncore: Clean up client IMC
  perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge

 arch/x86/events/intel/uncore.c       | 122 +++++--
 arch/x86/events/intel/uncore.h       |  41 ++-
 arch/x86/events/intel/uncore_snb.c   |  16 +-
 arch/x86/events/intel/uncore_snbep.c | 601 +++++++++++++++++++++++++++++++++++
 4 files changed, 737 insertions(+), 43 deletions(-)

-- 
2.7.4

