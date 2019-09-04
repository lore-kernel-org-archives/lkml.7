Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F638C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4622CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfIDP5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:57:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730355AbfIDP5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:57:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF4B2B991A52B475A137;
        Wed,  4 Sep 2019 23:57:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 23:57:12 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/4] perf jevents: Add some missing events for Hisi hip08 HHA PMU
Date:   Wed, 4 Sep 2019 23:54:44 +0800
Message-ID: <1567612484-195727-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some more missing events.

A trivial typo is also fixed.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arm64/hisilicon/hip08/uncore-hha.json     | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
index 447d3064de90..3be418a248ea 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
@@ -20,6 +20,13 @@
 	    "PublicDescription": "The number of all operations received by the HHA from another SCCL in this socket",
 	    "Unit": "hisi_sccl,hha",
    },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_hha.rx_ccix",
+	    "BriefDescription": "Count of the number of operations that HHA has received from CCIX",
+	    "PublicDescription": "Count of the number of operations that HHA has received from CCIX",
+	    "Unit": "hisi_sccl,hha",
+   },
    {
 	    "EventCode": "0x1c",
 	    "EventName": "uncore_hisi_hha.rd_ddr_64b",
@@ -29,7 +36,7 @@
    },
    {
 	    "EventCode": "0x1d",
-	    "EventName": "uncore_hisi_hha.wr_dr_64b",
+	    "EventName": "uncore_hisi_hha.wr_ddr_64b",
 	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
 	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
 	    "Unit": "hisi_sccl,hha",
@@ -48,4 +55,18 @@
 	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
 	    "Unit": "hisi_sccl,hha",
    },
+   {
+	    "EventCode": "0x20",
+	    "EventName": "uncore_hisi_hha.spill_num",
+	    "BriefDescription": "Count of the number of spill operations that the HHA has sent",
+	    "PublicDescription": "Count of the number of spill operations that the HHA has sent",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x21",
+	    "EventName": "uncore_hisi_hha.spill_success",
+	    "BriefDescription": "Count of the number of successful spill operations that the HHA has sent",
+	    "PublicDescription": "Count of the number of successful spill operations that the HHA has sent",
+	    "Unit": "hisi_sccl,hha",
+   },
 ]
-- 
2.17.1

