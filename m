Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8BC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F057822CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfIDP5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:57:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731376AbfIDP5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:57:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D803441410D2DF4E2ED9;
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
Subject: [PATCH 3/4] perf jevents: Add some missing events for Hisi hip08 L3C PMU
Date:   Wed, 4 Sep 2019 23:54:43 +0800
Message-ID: <1567612484-195727-4-git-send-email-john.garry@huawei.com>
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

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arm64/hisilicon/hip08/uncore-l3c.json     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
index ca48747642e1..f463d0acfaef 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
@@ -34,4 +34,60 @@
 	    "PublicDescription": "l3c precharge commands",
 	    "Unit": "hisi_sccl,l3c",
    },
+   {
+	    "EventCode": "0x20",
+	    "EventName": "uncore_hisi_l3c.rd_spipe",
+	    "BriefDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
+	    "PublicDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x21",
+	    "EventName": "uncore_hisi_l3c.wr_spipe",
+	    "BriefDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
+	    "PublicDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x22",
+	    "EventName": "uncore_hisi_l3c.rd_hit_spipe",
+	    "BriefDescription": "Count of the number of read lines that hits in spipe of this L3C",
+	    "PublicDescription": "Count of the number of read lines that hits in spipe of this L3C",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x23",
+	    "EventName": "uncore_hisi_l3c.wr_hit_spipe",
+	    "BriefDescription": "Count of the number of write lines that hits in spipe of this L3C",
+	    "PublicDescription": "Count of the number of write lines that hits in spipe of this L3C",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x29",
+	    "EventName": "uncore_hisi_l3c.back_invalid",
+	    "BriefDescription": "Count of the number of L3C back invalid operations",
+	    "PublicDescription": "Count of the number of L3C back invalid operations",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x40",
+	    "EventName": "uncore_hisi_l3c.retry_cpu",
+	    "BriefDescription": "Count of the number of retry that L3C suppresses the CPU operations",
+	    "PublicDescription": "Count of the number of retry that L3C suppresses the CPU operations",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x41",
+	    "EventName": "uncore_hisi_l3c.retry_ring",
+	    "BriefDescription": "Count of the number of retry that L3C suppresses the ring operations",
+	    "PublicDescription": "Count of the number of retry that L3C suppresses the ring operations",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x42",
+	    "EventName": "uncore_hisi_l3c.prefetch_drop",
+	    "BriefDescription": "Count of the number of prefetch drops from this L3C",
+	    "PublicDescription": "Count of the number of prefetch drops from this L3C",
+	    "Unit": "hisi_sccl,l3c",
+   },
 ]
-- 
2.17.1

