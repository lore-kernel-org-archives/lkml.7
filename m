Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED449C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57652082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbfFJKBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:01:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389020AbfFJKBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:01:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E6281F61A87CED15321F;
        Mon, 10 Jun 2019 18:01:10 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 10 Jun 2019 18:00:51 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] Perf uncore PMU event alias support for Hisi hip08 ARM64 platform
Date:   Mon, 10 Jun 2019 17:59:27 +0800
Message-ID: <1560160772-210844-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for uncore PMU event aliasing for HiSilicon
hip08 ARM64 platform.

We can now get proper event description for uncore events for the
perf tool.

For HHA, DDRC, and L3C JSONs, we don't have all the event info yet, so
I will seek it out to update the JSONs later.

John Garry (5):
  perf pmu: Fix uncore PMU alias list for ARM64
  perf pmu: Support more complex PMU event aliasing
  perf jevents: Add support for Hisi hip08 DDRC PMU aliasing
  perf jevents: Add support for Hisi hip08 HHA PMU aliasing
  perf jevents: Add support for Hisi hip08 L3C PMU aliasing

 .../arm64/hisilicon/hip08/uncore-ddrc.json    | 44 +++++++++++++
 .../arm64/hisilicon/hip08/uncore-hha.json     | 51 ++++++++++++++++
 .../arm64/hisilicon/hip08/uncore-l3c.json     | 37 +++++++++++
 tools/perf/pmu-events/jevents.c               |  3 +
 tools/perf/util/pmu.c                         | 61 ++++++++++++++-----
 5 files changed, 181 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json

-- 
2.17.1

