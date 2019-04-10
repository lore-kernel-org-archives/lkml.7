Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1592DC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94142084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDJBKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:10:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:13855 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfDJBKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:10:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 18:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="134419247"
Received: from otc-lr-04.jf.intel.com ([10.54.39.19])
  by orsmga006.jf.intel.com with ESMTP; 09 Apr 2019 18:10:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, acme@kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/2] perf: Add Tremont support
Date:   Tue,  9 Apr 2019 18:09:58 -0700
Message-Id: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The patch series intends to add Tremont support for Linux perf.

The patch series is on top of Icelake V5 patch series (with Peter's cleanup patch).
https://lkml.org/lkml/2019/4/8/630

PATCH 1: The feature is for both Icelake and Tremont. It missed the
         Icelake patch series.
PATCH 2: Tremont core PMU support.

Kan Liang (2):
  perf/x86/intel: Support adaptive PEBS for fixed counters
  perf/x86/intel: Add Tremont core PMU support

 arch/x86/events/intel/core.c      | 93 +++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 94 insertions(+)

-- 
2.7.4

