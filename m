Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F2AC06510
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFFE218B6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124534;
	bh=Plu9U6ueul03auEN0QTfkhS37kiDWNeJYTsAoO0iz0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HuIe0ZJaosqGO6cG8I4me+CzWibeRHt1dt6tyopqwu+4TugJ83+qBDyy6UIk+yOC6
	 hCr3ThOy6w9EAY9lr/ZnWjl8x6cpu/SKDxU/fgsddFO6d0vuQJ/Njhn2ZNkUHec1w3
	 HzzEHIF6svlfz7O+BxxyqKhEilnZ+m0Y7Tql4BzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfGCD2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfGCD2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 800B2205C9;
        Wed,  3 Jul 2019 03:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124530;
        bh=Plu9U6ueul03auEN0QTfkhS37kiDWNeJYTsAoO0iz0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pn4V0SFQOcbKAXSX445b/qePEpdPy48XtI7g6yjOdW5+VhxUshNDem2moADamXAZq
         8aWPzWBWAR+DhgBOlcVHSXEByzrrVCuSl2bHnYDEwHQs06NPEvGDQyV+fGho1Ku235
         qbk2l3iRo3mIDrZPVi38RCsvXQsGfmkk5PiPRIoo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/18] perf tools: Fix typos / broken sentences
Date:   Wed,  3 Jul 2019 00:27:41 -0300
Message-Id: <20190703032746.21692-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

- Fix a typo in the man page
- Fix a tip that doesn't make any sense.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190628220900.13741-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 2 +-
 tools/perf/Documentation/tips.txt        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8c4372819e11..987261d158d4 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -89,7 +89,7 @@ OPTIONS
 	- socket: processor socket number the task ran at the time of sample
 	- srcline: filename and line number executed at the time of sample.  The
 	DWARF debugging info must be provided.
-	- srcfile: file name of the source file of the same. Requires dwarf
+	- srcfile: file name of the source file of the samples. Requires dwarf
 	information.
 	- weight: Event specific weight, e.g. memory latency or transaction
 	abort cost. This is the global weight.
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 869965d629ce..825745a645c1 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -38,6 +38,6 @@ To report cacheline events from previous recording: perf c2c report
 To browse sample contexts use perf report --sample 10 and select in context menu
 To separate samples by time use perf report --sort time,overhead,sym
 To set sample time separation other than 100ms with --sort time use --time-quantum
-Add -I to perf report to sample register values visible in perf report context.
+Add -I to perf record to sample register values, which will be visible in perf report sample context.
 To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
 To show context switches in perf report sample context add --switch-events to perf record.
-- 
2.20.1

