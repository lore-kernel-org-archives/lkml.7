Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E58CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAB120882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfJVAEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbfJVAEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxE-000478-Rw; Tue, 22 Oct 2019 01:19:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA22E1C04D4;
        Tue, 22 Oct 2019 01:19:08 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:08 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf vendor events arm64: Add some missing events
 for Hisi hip08 L3C PMU
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
In-Reply-To: <1567612484-195727-4-git-send-email-john.garry@huawei.com>
References: <1567612484-195727-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <157169994853.29376.14939514341259795265.tip-bot2@tip-bot2>
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

Commit-ID:     e3ae569541802a6c9e89ab1f0f3ff613a5a1237b
Gitweb:        https://git.kernel.org/tip/e3ae569541802a6c9e89ab1f0f3ff613a5a1237b
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Wed, 04 Sep 2019 23:54:43 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 13:03:58 -03:00

perf vendor events arm64: Add some missing events for Hisi hip08 L3C PMU

Add some more missing events.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1567612484-195727-4-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
index ca48747..f463d0a 100644
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
