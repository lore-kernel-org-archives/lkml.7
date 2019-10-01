Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A4C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C2E21D79
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928391;
	bh=2qTrljZG4gv/baf3MYyIMPUOlj1gwhYKCnEdAXvSfMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SJMmE+C+g6U2CP7E5h2onpO35kppBLMfSqivLYn1bFy3YJZJ3S81CP92Iw1/zvCUy
	 o74OC1Zu/rr6KqKbTMJZQUA1yYZjNuKRY8D+53cWs1RifkPss10VldgKECg9DFGNau
	 qem47Hkcw3nNIocHMD4KnRBpvdvbohbB9J0lt4ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbfJALNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbfJALNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:09 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810AB21D71;
        Tue,  1 Oct 2019 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928388;
        bh=2qTrljZG4gv/baf3MYyIMPUOlj1gwhYKCnEdAXvSfMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0krk+gyQmY0V47ShvTcHLTkuVP/ESfMtFtPdlY/SxrPBuAjlW+Y3gWHwNjEGoJ8r
         EfdyCcguWdh2r+RQsqkpHY8DfGgUAtciuGR/0kC2UTPTvw5RVgME3LB3QYNrw0tB5m
         5UTL7fvsuJS5Fo0Ub7Suj7Ee78+BVGXMeh3cwsLc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/24] perf vendor events s390: Add JSON transaction for machine type 8561
Date:   Tue,  1 Oct 2019 08:12:02 -0300
Message-Id: <20191001111216.7208-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Add s390 transaction counter definition for machine 8561. This is the
same file as for the predecessor machine.

Fixes: 6e67d77d673d ("perf vendor events s390: Add JSON files for machine type 8561")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20190927081147.18345-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json b/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
-- 
2.21.0

