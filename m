Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5979320882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbfJVAEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbfJVAEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxC-00046Q-Pl; Tue, 22 Oct 2019 01:19:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4892B1C0489;
        Tue, 22 Oct 2019 01:19:08 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:07 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf vendor events arm64: Add some missing events
 for Hisi hip08 HHA PMU
Cc:     John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1567612484-195727-5-git-send-email-john.garry@huawei.com>
References: <1567612484-195727-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <157169994783.29376.4450201190536915731.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2b7847158120136c4b23684c768a82d571ee59bf
Gitweb:        https://git.kernel.org/tip/2b7847158120136c4b23684c768a82d571ee59bf
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Wed, 04 Sep 2019 23:54:44 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 13:03:58 -03:00

perf vendor events arm64: Add some missing events for Hisi hip08 HHA PMU

Add some more missing events.

A trivial typo is also fixed.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1567612484-195727-5-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
index 447d306..3be418a 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
@@ -21,6 +21,13 @@
 	    "Unit": "hisi_sccl,hha",
    },
    {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_hha.rx_ccix",
+	    "BriefDescription": "Count of the number of operations that HHA has received from CCIX",
+	    "PublicDescription": "Count of the number of operations that HHA has received from CCIX",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
 	    "EventCode": "0x1c",
 	    "EventName": "uncore_hisi_hha.rd_ddr_64b",
 	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 64 bytes",
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
