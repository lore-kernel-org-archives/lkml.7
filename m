Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DFBCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8EC2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665375;
	bh=OJ45aNISZct2ZDJvxP7I899FNuLrsSm4dUJUusunFsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jV6qq5W72CyssSXFX+F5KENTO3RCQp4qQzzCq54ICJX09xsI3Gxe/lF+iOHEgyR9q
	 CIE+mAb0zRS/2Avh70zFV8n4o2xNjSLeidV+IC3uVxM2JX1Pd7RGHMnNxxaSA1ry7V
	 rv7pf1nQtAA3tenhS3hY9ZikOv7laCr82GzpfELE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfJUNmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbfJUNj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 612C721929;
        Mon, 21 Oct 2019 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665195;
        bh=OJ45aNISZct2ZDJvxP7I899FNuLrsSm4dUJUusunFsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tr3KUjunfENlxz7TuWlJloSyBHNZZMTdtBHzw3JxGNzXPcOTETQYAjEPPQLvAxw4C
         aBsWR9zybTn3VCHIALyJGtYMQCleUKWpGGpSaeIUUFuIvHfDnvvyfbq0vnajLaKVNW
         lAdlqDEuxhRwk9qMRo6a9w+O3kp8QZ1G/9ZNg0oU=
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
Subject: [PATCH 22/57] perf vendor events arm64: Add some missing events for Hisi hip08 HHA PMU
Date:   Mon, 21 Oct 2019 10:37:59 -0300
Message-Id: <20191021133834.25998-23-acme@kernel.org>
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
2.21.0

