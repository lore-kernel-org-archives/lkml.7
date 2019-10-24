Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FEACA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731B72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502585AbfJXOBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:01:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391060AbfJXOBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:01:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 857F3925DBB38C36DD5D;
        Thu, 24 Oct 2019 22:01:12 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 24 Oct 2019
 22:00:57 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>, <James.Clark@arm.com>,
        <jeremy.linton@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [RFC v2 3/4] perf report: Add --spe options for arm-spe
Date:   Thu, 24 Oct 2019 22:48:29 +0800
Message-ID: <20191024144830.16534-4-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024144830.16534-1-tanxiaojun@huawei.com>
References: <20191024144830.16534-1-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch added support in "perf report" for some arm-spe
events(llc-miss, tlb-miss, branch-miss). This patch adds their help
instructions.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/Documentation/perf-report.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 7315f155803f..a3628dde3be7 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -462,6 +462,15 @@ include::itrace.txt[]
 
 	To disable decoding entirely, use --no-itrace.
 
+--spe::
+	Options for decoding arm-spe tracing data. The options are:
+
+		l	synthesize llc miss events
+		t	synthesize tlb miss events
+		b	synthesize branch miss events
+
+	The default is all events i.e. the same as --spe=ltb
+
 --full-source-path::
 	Show the full path for source files for srcline output.
 
-- 
2.17.1

