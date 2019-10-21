Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBA2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6F2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665192;
	bh=cM1MTKb+ph4LOAQACBfuPjtegnhcj+XVjswRcu3Ugtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POZcAdvx8DFVwudtwuLBMeKlAJH7hVzmRLDds3gxDVIP6Eeq9t97XbzgDN4YnNN1l
	 jBfRiWlXHQnopw8JltsgSz8CPLRkySPTV6K9gm9mUddXjIQqL0zmDZ3mqFW4j8wyVr
	 DBrYM32tT0bkaivZFNuTEZPnuC7YJyeEMJGhhvr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfJUNjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJUNjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04454214B2;
        Mon, 21 Oct 2019 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665188;
        bh=cM1MTKb+ph4LOAQACBfuPjtegnhcj+XVjswRcu3Ugtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eK5kZcdVadXPgtGJhWT/fHORb8/DXKE4uTeo8cP3kfZ/es7pXGmOieicpRiyG6Zsf
         e71WOvI2v3pz0N2G8rV3reh9e7hjQ1OiuLddoGOALN/3ixan5zZIDQr7QL9n3TEWcj
         dlYZjQAuAdo6EpbA5iwHVojo5CGRrOyNaQ7CtQog=
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
Subject: [PATCH 20/57] perf vendor events arm64: Add some missing events for Hisi hip08 DDRC PMU
Date:   Mon, 21 Oct 2019 10:37:57 -0300
Message-Id: <20191021133834.25998-21-acme@kernel.org>
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
Link: http://lore.kernel.org/lkml/1567612484-195727-3-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0

