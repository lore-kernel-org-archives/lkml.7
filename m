Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBDCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D6F21872
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665200;
	bh=QaO8bSHrlGSQLLLS56coI3qNcVX5iG2JZY1zbN6UFqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SU2HUKj8AxsykA1uR+6ijrPxs7QROnBwBv+ci7ItoQTld0ncAOV/wvMI6gDXks6UK
	 xon1yLXM33+IJb0R/r9czKR1mRWZS5yMgIk5v0QS71vJmwzu78zS3Zx38NoWaahynu
	 +H/7cpULfpMRwuNUZRIGJk8A/Mcb/5aDwbHZ0rjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfJUNkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJUNjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB452166E;
        Mon, 21 Oct 2019 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665191;
        bh=QaO8bSHrlGSQLLLS56coI3qNcVX5iG2JZY1zbN6UFqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVTbRLxwqPS9SWbPvrIOmdnGu/X4dTxk0PL6YOYcmMuQ4wtQl/B6Eq+kTWQacyMqj
         C/32aOOJJQ+5WNOC+hokWtaUK75wRIjhZ9WyXr/fF3Rpn70Fj3QzEsIrj1ijiWD2w7
         DER4E1UTjh9lZMTz/JoGscPLcLbeEFoQUJ5SQ9TU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/57] perf vendor events arm64: Add some missing events for Hisi hip08 L3C PMU
Date:   Mon, 21 Oct 2019 10:37:58 -0300
Message-Id: <20191021133834.25998-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

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
2.21.0

