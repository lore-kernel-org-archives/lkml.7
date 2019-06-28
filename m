Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DDDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E4B2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfF1WJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:09:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:54543 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfF1WJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:09:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 15:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; 
   d="scan'208";a="361651775"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2019 15:09:01 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C2EE53015ED; Fri, 28 Jun 2019 15:09:01 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf tools: Fix typos / broken sentences
Date:   Fri, 28 Jun 2019 15:09:00 -0700
Message-Id: <20190628220900.13741-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

- Fix a typo in the man page
- Fix a tip that doesn't make any sense.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt | 2 +-
 tools/perf/Documentation/tips.txt        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8c4372819e11..987261d158d4 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -89,7 +89,7 @@ OPTIONS
 	- socket: processor socket number the task ran at the time of sample
 	- srcline: filename and line number executed at the time of sample.  The
 	DWARF debugging info must be provided.
-	- srcfile: file name of the source file of the same. Requires dwarf
+	- srcfile: file name of the source file of the samples. Requires dwarf
 	information.
 	- weight: Event specific weight, e.g. memory latency or transaction
 	abort cost. This is the global weight.
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 869965d629ce..825745a645c1 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -38,6 +38,6 @@ To report cacheline events from previous recording: perf c2c report
 To browse sample contexts use perf report --sample 10 and select in context menu
 To separate samples by time use perf report --sort time,overhead,sym
 To set sample time separation other than 100ms with --sort time use --time-quantum
-Add -I to perf report to sample register values visible in perf report context.
+Add -I to perf record to sample register values, which will be visible in perf report sample context.
 To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
 To show context switches in perf report sample context add --switch-events to perf record.
-- 
2.20.1

