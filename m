Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A0DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB63208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF0GUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:20:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:39130 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfF0GUM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:20:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 23:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="156135578"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2019 23:20:10 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 7/7] perf diff: Documentation -c cycles option
Date:   Thu, 27 Jun 2019 22:09:29 +0800
Message-Id: <1561644569-22306-8-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
References: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation the new computation selection 'cycles'.

 v4:
 ---
 Change the column 'Block cycles diff [start:end]' to
 '[Program Block Range] Cycles Diff'

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index facd91e..d5cc15e 100644
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
@@ -280,6 +281,16 @@ If specified the 'Weighted diff' column is displayed with value 'd' computed as:
     - WEIGHT-A being the weight of the data file
     - WEIGHT-B being the weight of the baseline data file
 
+cycles
+~~~~~~
+If specified the '[Program Block Range] Cycles Diff' column is displayed.
+It displays the cycles difference of same program basic block amongst
+two perf.data. The program basic block is the code between two branches.
+
+'[Program Block Range]' indicates the range of a program basic block.
+Source line is reported if it can be found otherwise uses symbol+offset
+instead.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
-- 
2.7.4

