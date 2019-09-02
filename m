Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A9AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BAC2339D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfIBIQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:16:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfIBIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVr-00081r-5Z; Mon, 02 Sep 2019 10:16:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 723F61C0DF4;
        Mon,  2 Sep 2019 10:16:29 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:29 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove debug.h from header files not needing it
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-1s3jel4i26chq2g0lydoz7i3@git.kernel.org>
References: <tip-1s3jel4i26chq2g0lydoz7i3@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741218934.17308.810983168777502780.tip-bot2@tip-bot2>
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

Commit-ID:     b42090256fba05dce1a0482a4ccd9bb6464cc499
Gitweb:        https://git.kernel.org/tip/b42090256fba05dce1a0482a4ccd9bb6464cc499
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 15:56:40 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf tools: Remove debug.h from header files not needing it

And fix the fallout, adding it to places that must have it since they
use its definitions.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1s3jel4i26chq2g0lydoz7i3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/auxtrace.c          | 1 +
 tools/perf/arch/arm/util/cs-etm.c            | 1 +
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 1 +
 tools/perf/tests/code-reading.c              | 1 +
 tools/perf/tests/keep-tracking.c             | 1 +
 tools/perf/tests/mmap-basic.c                | 1 +
 tools/perf/tests/sw-clock.c                  | 2 ++
 tools/perf/tests/switch-tracking.c           | 1 +
 tools/perf/tests/task-exit.c                 | 1 +
 tools/perf/ui/browsers/annotate.c            | 1 +
 tools/perf/ui/browsers/hists.c               | 1 +
 tools/perf/ui/hist.c                         | 1 +
 tools/perf/util/auxtrace.h                   | 2 +-
 tools/perf/util/config.c                     | 1 +
 tools/perf/util/hist.c                       | 1 +
 tools/perf/util/llvm-utils.h                 | 2 +-
 tools/perf/util/metricgroup.c                | 2 ++
 tools/perf/util/python.c                     | 1 +
 tools/perf/util/record.c                     | 1 +
 tools/perf/util/session.c                    | 1 +
 tools/perf/util/sort.c                       | 1 +
 tools/perf/util/stat.c                       | 1 +
 tools/perf/util/trigger.h                    | 1 -
 23 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 41b78f7..0a6e75b 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -9,6 +9,7 @@
 #include <linux/zalloc.h>
 
 #include "../../util/auxtrace.h"
+#include "../../util/debug.h"
 #include "../../util/evlist.h"
 #include "../../util/pmu.h"
 #include "cs-etm.h"
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 9644e2d..b74fd40 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -15,6 +15,7 @@
 #include <linux/zalloc.h>
 
 #include "cs-etm.h"
+#include "../../util/debug.h"
 #include "../../util/record.h"
 #include "../../util/auxtrace.h"
 #include "../../util/cpumap.h"
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 0277610..2d1f471 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -9,6 +9,7 @@
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 
+#include "debug.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index fe671b8..c4b73bb 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -11,6 +11,7 @@
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 
+#include "debug.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 2af6faf..c758798 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -5,6 +5,7 @@
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 
+#include "debug.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 7327694..fe91350 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -5,6 +5,7 @@
 #include <pthread.h>
 #include <perf/cpumap.h>
 
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index c5f1a9f..97694a0 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -5,8 +5,10 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <sys/mman.h>
+#include <linux/string.h>
 
 #include "tests.h"
+#include "util/debug.h"
 #include "util/evsel.h"
 #include "util/evlist.h"
 #include "util/cpumap.h"
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index b63f027..4bed15a 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -8,6 +8,7 @@
 #include <perf/cpumap.h>
 #include <perf/evlist.h>
 
+#include "debug.h"
 #include "parse-events.h"
 #include "evlist.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index d79a22e..0e0e062 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "target.h"
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e633eb4..715601f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -4,6 +4,7 @@
 #include "../ui.h"
 #include "../util.h"
 #include "../../util/annotate.h"
+#include "../../util/debug.h"
 #include "../../util/hist.h"
 #include "../../util/sort.h"
 #include "../../util/map.h"
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ccc3728..a14dda7 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -11,6 +11,7 @@
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
+#include "../../util/debug.h"
 #include "../../util/callchain.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index ae29f16..bf90ce5 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -4,6 +4,7 @@
 #include <linux/compiler.h>
 
 #include "../util/callchain.h"
+#include "../util/debug.h"
 #include "../util/hist.h"
 #include "../util/util.h"
 #include "../util/sort.h"
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index bc39cc5..b5ac24c 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -19,7 +19,6 @@
 
 #include "event.h"
 #include "session.h"
-#include "debug.h"
 
 union perf_event;
 struct perf_session;
@@ -614,6 +613,7 @@ void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts)
 }
 
 #else
+#include "debug.h"
 
 static inline struct auxtrace_record *
 auxtrace_record__init(struct evlist *evlist __maybe_unused,
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 042ffbc..eb5308c 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -18,6 +18,7 @@
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/llvm-utils.h"   /* perf_llvm_config */
 #include "config.h"
+#include "debug.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index e0b1496..adae413 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "callchain.h"
+#include "debug.h"
 #include "build-id.h"
 #include "hist.h"
 #include "map.h"
diff --git a/tools/perf/util/llvm-utils.h b/tools/perf/util/llvm-utils.h
index bf3f3f4..7878a0e 100644
--- a/tools/perf/util/llvm-utils.h
+++ b/tools/perf/util/llvm-utils.h
@@ -6,7 +6,7 @@
 #ifndef __LLVM_UTILS_H
 #define __LLVM_UTILS_H
 
-#include "debug.h"
+#include <stdbool.h>
 
 struct llvm_param {
 	/* Path of clang executable */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index aaf5544..33f5e21 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -6,6 +6,7 @@
 /* Manage metrics and groups of metrics from JSON files */
 
 #include "metricgroup.h"
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "strbuf.h"
@@ -18,6 +19,7 @@
 #include "strlist.h"
 #include <assert.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <subcmd/parse-options.h>
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9dd8387..9b35048 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -5,6 +5,7 @@
 #include <poll.h>
 #include <linux/err.h>
 #include <perf/cpumap.h>
+#include "debug.h"
 #include "evlist.h"
 #include "callchain.h"
 #include "evsel.h"
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index c67a513..ccad796 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "cpumap.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 82bd5d4..a72774e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -12,6 +12,7 @@
 #include <sys/mman.h>
 #include <perf/cpumap.h>
 
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "memswap.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 83eb3fa..23d0ab7 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -4,6 +4,7 @@
 #include <regex.h>
 #include <linux/mman.h>
 #include <linux/time64.h>
+#include "debug.h"
 #include "sort.h"
 #include "hist.h"
 #include "cacheline.h"
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f6eb6af..f4a1edc 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <math.h>
 #include "counts.h"
+#include "debug.h"
 #include "stat.h"
 #include "target.h"
 #include "evlist.h"
diff --git a/tools/perf/util/trigger.h b/tools/perf/util/trigger.h
index 88223bc..33e997f 100644
--- a/tools/perf/util/trigger.h
+++ b/tools/perf/util/trigger.h
@@ -2,7 +2,6 @@
 #ifndef __TRIGGER_H_
 #define __TRIGGER_H_ 1
 
-#include "util/debug.h"
 #include "asm/bug.h"
 
 /*
