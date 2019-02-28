Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5753CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C51E20643
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfB1Hlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:41:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1Hlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:41:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7fH0D2947716
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:41:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7fHkU2947713;
        Wed, 27 Feb 2019 23:41:17 -0800
Date:   Wed, 27 Feb 2019 23:41:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jonas Rabenstein <tipbot@zytor.com>
Message-ID: <tip-7a663c0ff330a068c088ad46bb0130e651a9fec3@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, jolsa@kernel.org,
        eranian@google.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        hpa@zytor.com, jonas.rabenstein@studium.uni-erlangen.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com, acme@redhat.com
Reply-To: namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
          eranian@google.com, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com,
          jonas.rabenstein@studium.uni-erlangen.de,
          linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
          acme@redhat.com
In-Reply-To: <20190219154515.3954-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190219154515.3954-1-jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf doc: Fix HEADER_CMDLINE description in
 perf.data documentation
Git-Commit-ID: 7a663c0ff330a068c088ad46bb0130e651a9fec3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7a663c0ff330a068c088ad46bb0130e651a9fec3
Gitweb:     https://git.kernel.org/tip/7a663c0ff330a068c088ad46bb0130e651a9fec3
Author:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
AuthorDate: Tue, 19 Feb 2019 16:45:14 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Feb 2019 13:39:08 -0300

perf doc: Fix HEADER_CMDLINE description in perf.data documentation

The content of the HEADER_CMDLINE feature header is a perf_header_string_list
of the argument vector and not a perf_header_string of the commandline.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190219154515.3954-1-jonas.rabenstein@studium.uni-erlangen.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index dfb218feaad9..5f9a3924830b 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -131,7 +131,7 @@ An uint64_t with the total memory in bytes.
 
 	HEADER_CMDLINE = 11,
 
-A perf_header_string with the perf command line used to collect the data.
+A perf_header_string_list with the perf arg-vector used to collect the data.
 
 	HEADER_EVENT_DESC = 12,
 
