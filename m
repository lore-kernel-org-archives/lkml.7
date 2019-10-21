Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62571CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB0C2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbfJVAEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbfJVAEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxG-00047j-0j; Tue, 22 Oct 2019 01:19:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 254511C0086;
        Tue, 22 Oct 2019 01:19:10 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:09 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf vendor events arm64: Fix Hisi hip08 DDRC PMU eventname
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
In-Reply-To: <1567612484-195727-2-git-send-email-john.garry@huawei.com>
References: <1567612484-195727-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <157169994968.29376.4973868554962242542.tip-bot2@tip-bot2>
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

Commit-ID:     84b0975f4853ba32d2d9b3c19ffa2b947f023fb3
Gitweb:        https://git.kernel.org/tip/84b0975f4853ba32d2d9b3c19ffa2b947f023fb3
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Wed, 04 Sep 2019 23:54:41 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 13:03:58 -03:00

perf vendor events arm64: Fix Hisi hip08 DDRC PMU eventname

The "EventName" for the DDRC precharge command event is incorrect, so
fix it.

Fixes: 57cc732479ba ("perf jevents: Add support for Hisi hip08 DDRC PMU aliasing")
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1567612484-195727-2-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
index 0d1556f..99f4fc4 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
@@ -15,7 +15,7 @@
    },
    {
 	    "EventCode": "0x04",
-	    "EventName": "uncore_hisi_ddrc.flux_wr",
+	    "EventName": "uncore_hisi_ddrc.pre_cmd",
 	    "BriefDescription": "DDRC precharge commands",
 	    "PublicDescription": "DDRC precharge commands",
 	    "Unit": "hisi_sccl,ddrc",
