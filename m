Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B33BC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1792339E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFCGql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:46:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:39148 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfFCGqh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:46:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 23:46:36 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 23:46:35 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 7/7] perf diff: Documentation -c cycles option
Date:   Mon,  3 Jun 2019 22:36:17 +0800
Message-Id: <1559572577-25436-8-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation the new computation selection 'cycles'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index da7809b..198119b 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -90,9 +90,10 @@ OPTIONS
 
 -c::
 --compute::
-        Differential computation selection - delta, ratio, wdiff, delta-abs
-        (default is delta-abs).  Default can be changed using diff.compute
-        config option.  See COMPARISON METHODS section for more info.
+        Differential computation selection - delta, ratio, wdiff, cycles,
+        delta-abs (default is delta-abs).  Default can be changed using
+        diff.compute config option.  See COMPARISON METHODS section for
+        more info.
 
 -p::
 --period::
@@ -278,6 +279,13 @@ If specified the 'Weighted diff' column is displayed with value 'd' computed as:
     - WEIGHT-A being the weight of the data file
     - WEIGHT-B being the weight of the baseline data file
 
+cycles
+~~~~~~
+If specified the 'Block cycles diff [start:end]' column is displayed.
+It displays the cycles difference of same program basic block amongst
+two perf.data. The program basic block is the code block between
+two branches in a function (indicated by [start:end]).
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
-- 
2.7.4

