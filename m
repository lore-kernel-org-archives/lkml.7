Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F015C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510E322CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfIDP50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:57:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730355AbfIDP5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:57:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F16B82703DC2392BF6E5;
        Wed,  4 Sep 2019 23:57:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 23:57:11 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/4] perf jevents: Add some missing events for Hisi hip08 DDRC PMU
Date:   Wed, 4 Sep 2019 23:54:42 +0800
Message-ID: <1567612484-195727-3-git-send-email-john.garry@huawei.com>
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
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
index 99f4fc425564..7da86942dae2 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
@@ -1,4 +1,18 @@
 [
+   {
+	    "EventCode": "0x00",
+	    "EventName": "uncore_hisi_ddrc.flux_wr",
+	    "BriefDescription": "DDRC total write operations",
+	    "PublicDescription": "DDRC total write operations",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x01",
+	    "EventName": "uncore_hisi_ddrc.flux_rd",
+	    "BriefDescription": "DDRC total read operations",
+	    "PublicDescription": "DDRC total read operations",
+	    "Unit": "hisi_sccl,ddrc",
+   },
    {
 	    "EventCode": "0x02",
 	    "EventName": "uncore_hisi_ddrc.flux_wcmd",
-- 
2.17.1

