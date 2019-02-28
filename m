Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5B321850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfB1Hmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:42:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1Hmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:42:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7fveP2947768
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:41:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7fujq2947765;
        Wed, 27 Feb 2019 23:41:56 -0800
Date:   Wed, 27 Feb 2019 23:41:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jonas Rabenstein <tipbot@zytor.com>
Message-ID: <tip-8c23a522388b34cd7bc8473987eda0c75eb37c0e@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, tmricht@linux.ibm.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@kernel.org, jonas.rabenstein@studium.uni-erlangen.de,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, acme@redhat.com,
        eranian@google.com, tglx@linutronix.de, namhyung@kernel.org
Reply-To: peterz@infradead.org, tmricht@linux.ibm.com, jolsa@kernel.org,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          eranian@google.com, acme@redhat.com, namhyung@kernel.org,
          tglx@linutronix.de, mingo@kernel.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org,
          jonas.rabenstein@studium.uni-erlangen.de
In-Reply-To: <20190219154515.3954-2-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190219154515.3954-2-jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf doc: Fix documentation of the Flags section in
 perf.data
Git-Commit-ID: 8c23a522388b34cd7bc8473987eda0c75eb37c0e
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

Commit-ID:  8c23a522388b34cd7bc8473987eda0c75eb37c0e
Gitweb:     https://git.kernel.org/tip/8c23a522388b34cd7bc8473987eda0c75eb37c0e
Author:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
AuthorDate: Tue, 19 Feb 2019 16:45:15 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Feb 2019 13:39:12 -0300

perf doc: Fix documentation of the Flags section in perf.data

According to the current documentation the flags section is placed after
the file header itself but the code assumes to find the flags section
after the data section. This change updates the documentation to that
assumption.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190219154515.3954-2-jonas.rabenstein@studium.uni-erlangen.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 5f9a3924830b..593ef49b273c 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -43,11 +43,10 @@ struct perf_file_section {
 
 Flags section:
 
-The header is followed by different optional headers, described by the bits set
-in flags. Only headers for which the bit is set are included. Each header
-consists of a perf_file_section located after the initial header.
-The respective perf_file_section points to the data of the additional
-header and defines its size.
+For each of the optional features a perf_file_section it placed after the data
+section if the feature bit is set in the perf_header flags bitset. The
+respective perf_file_section points to the data of the additional header and
+defines its size.
 
 Some headers consist of strings, which are defined like this:
 
