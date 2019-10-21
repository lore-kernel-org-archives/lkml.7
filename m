Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF45BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896AA20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfJUXUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:20:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38297 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbfJUXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:19:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwr-0003qQ-5O; Tue, 22 Oct 2019 01:18:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8606E1C0086;
        Tue, 22 Oct 2019 01:18:48 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:47 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add pr_err() macro
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191017105918.20873-11-jolsa@kernel.org>
References: <20191017105918.20873-11-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157169992791.29376.3655092802607172757.tip-bot2@tip-bot2>
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

Commit-ID:     dcc6854215f115efcbd79368bc07099c41de0b6c
Gitweb:        https://git.kernel.org/tip/dcc6854215f115efcbd79368bc07099c41de0b6c
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 17 Oct 2019 12:59:18 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

libperf: Add pr_err() macro

And missing include for "perf/core.h" header, which provides LIBPERF_*
debug levels and add missing pr_err() support.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/core.h | 1 +
 tools/perf/lib/internal.h          | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
index 2a80e4b..a3f6d68 100644
--- a/tools/perf/lib/include/perf/core.h
+++ b/tools/perf/lib/include/perf/core.h
@@ -9,6 +9,7 @@
 #endif
 
 enum libperf_print_level {
+	LIBPERF_ERR,
 	LIBPERF_WARN,
 	LIBPERF_INFO,
 	LIBPERF_DEBUG,
diff --git a/tools/perf/lib/internal.h b/tools/perf/lib/internal.h
index 37db745..2c27e15 100644
--- a/tools/perf/lib/internal.h
+++ b/tools/perf/lib/internal.h
@@ -2,6 +2,8 @@
 #ifndef __LIBPERF_INTERNAL_H
 #define __LIBPERF_INTERNAL_H
 
+#include <perf/core.h>
+
 void libperf_print(enum libperf_print_level level,
 		   const char *format, ...)
 	__attribute__((format(printf, 2, 3)));
@@ -11,6 +13,7 @@ do {                            \
 	libperf_print(level, "libperf: " fmt, ##__VA_ARGS__);     \
 } while (0)
 
+#define pr_err(fmt, ...)        __pr(LIBPERF_ERR, fmt, ##__VA_ARGS__)
 #define pr_warning(fmt, ...)    __pr(LIBPERF_WARN, fmt, ##__VA_ARGS__)
 #define pr_info(fmt, ...)       __pr(LIBPERF_INFO, fmt, ##__VA_ARGS__)
 #define pr_debug(fmt, ...)      __pr(LIBPERF_DEBUG, fmt, ##__VA_ARGS__)
