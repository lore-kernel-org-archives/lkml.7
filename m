Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888C3C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6221D218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfB1I7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:59:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731557AbfB1I7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:59:18 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 863FF14F7313A7041C7C;
        Thu, 28 Feb 2019 16:59:16 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Feb 2019 16:59:08 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf tools: Fix function name in comment
Date:   Thu, 28 Feb 2019 16:58:23 +0800
Message-ID: <1551344303-4114-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_cpuid_str() is used in tools/perf/arch/xxx/util/header.c,
fix the name in comment.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 tools/perf/pmu-events/pmu-events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 92a4d15ee0b9..9889e4701399 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -24,7 +24,7 @@ struct pmu_event {
  * Map a CPU to its table of PMU events. The CPU is identified by the
  * cpuid field, which is an arch-specific identifier for the CPU.
  * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
- * must match the get_cpustr() in tools/perf/arch/xxx/util/header.c)
+ * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
  *
  * The  cpuid can contain any character other than the comma.
  */
-- 
2.7.4

