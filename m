Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59768C742A3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3462F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfGKSTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:19:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:57793 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfGKSTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:19:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 11:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="168097594"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2019 11:19:30 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 044FB300FEA; Thu, 11 Jul 2019 11:19:30 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/3] perf script: Improve man page description of metrics
Date:   Thu, 11 Jul 2019 11:19:22 -0700
Message-Id: <20190711181922.18765-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711181922.18765-1-andi@firstfloor.org>
References: <20190711181922.18765-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Clarify that a metric is based on events, not referring
to itself. Also some improvements with the sentences.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 042b9e5dcc32..caaab28f8400 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -228,11 +228,11 @@ OPTIONS
 
 	With the metric option perf script can compute metrics for
 	sampling periods, similar to perf stat. This requires
-	specifying a group with multiple metrics with the :S option
+	specifying a group with multiple events defining metrics with the :S option
 	for perf record. perf will sample on the first event, and
-	compute metrics for all the events in the group. Please note
+	print computed metrics for all the events in the group. Please note
 	that the metric computed is averaged over the whole sampling
-	period, not just for the sample point.
+	period (since the last sample), not just for the sample point.
 
 	For sample events it's possible to display misc field with -F +misc option,
 	following letters are displayed for each bit:
-- 
2.20.1

