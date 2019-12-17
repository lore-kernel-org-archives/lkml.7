Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE089C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB422082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfLQLcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:32:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfLQLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:32:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihB4z-0007MI-Ry; Tue, 17 Dec 2019 12:31:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F3A6F1C2A34;
        Tue, 17 Dec 2019 12:31:52 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:31:52 -0000
From:   "tip-bot2 for Ed Maste" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf vendor events s390: Remove name from
 L1D_RO_EXCL_WRITES description
Cc:     Ed Maste <emaste@freebsd.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191212145346.5026-1-emaste@freefall.freebsd.org>
References: <20191212145346.5026-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Message-ID: <157658231276.30329.18331050645912292704.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     58b3bafff8257c6946df5d6aeb215b8ac839ed2a
Gitweb:        https://git.kernel.org/tip/58b3bafff8257c6946df5d6aeb215b8ac839ed2a
Author:        Ed Maste <emaste@freebsd.org>
AuthorDate:    Thu, 12 Dec 2019 14:53:46 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 16 Dec 2019 13:40:26 -03:00

perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description

In 7fcfa9a2d9 an unintended prefix "Counter:18 Name:" was removed from
the description for L1D_RO_EXCL_WRITES, but the extra name remained in
the description.  Remove it too.

Fixes: 7fcfa9a2d9a7 ("perf list: Fix s390 counter long description for L1D_RO_EXCL_WRITES")
Signed-off-by: Ed Maste <emaste@freebsd.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Link: http://lore.kernel.org/lkml/20191212145346.5026-1-emaste@freefall.freebsd.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z14/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index 6861815..89e0707 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -4,7 +4,7 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
 		"Unit": "CPU-M-CF",
