Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DBC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB9E215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfIBIQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:16:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56190 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfIBIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVp-000815-PV; Mon, 02 Sep 2019 10:16:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 65F241C0DF3;
        Mon,  2 Sep 2019 10:16:28 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:28 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove needless perf.h include directive
 from headers
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-5yulx1u16vyd0zmrbg1tjhju@git.kernel.org>
References: <tip-5yulx1u16vyd0zmrbg1tjhju@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741218832.17302.18398178569391369734.tip-bot2@tip-bot2>
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

Commit-ID:     c1a604dff486399ae0be95e6396e0158df95ad5d
Gitweb:        https://git.kernel.org/tip/c1a604dff486399ae0be95e6396e0158df95ad5d
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 15:20:59 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf tools: Remove needless perf.h include directive from headers

Its not needed there, add it to the places that need it and were getting
it via those headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5yulx1u16vyd0zmrbg1tjhju@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c            | 1 +
 tools/perf/builtin-diff.c           | 1 +
 tools/perf/builtin-record.c         | 1 +
 tools/perf/builtin-script.c         | 1 +
 tools/perf/builtin-stat.c           | 1 +
 tools/perf/builtin-trace.c          | 1 +
 tools/perf/perf.c                   | 1 +
 tools/perf/ui/browsers/hists.c      | 1 +
 tools/perf/ui/browsers/res_sample.c | 1 +
 tools/perf/ui/browsers/scripts.c    | 1 +
 tools/perf/ui/hist.c                | 1 +
 tools/perf/ui/tui/setup.c           | 1 +
 tools/perf/util/auxtrace.h          | 1 -
 tools/perf/util/callchain.c         | 1 +
 tools/perf/util/event.c             | 1 +
 tools/perf/util/event.h             | 1 -
 tools/perf/util/evlist.c            | 1 +
 tools/perf/util/evlist.h            | 1 -
 tools/perf/util/mmap.c              | 1 +
 tools/perf/util/session.c           | 1 +
 tools/perf/util/top.c               | 1 +
 21 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 8335a40..25a5f18 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -35,6 +35,7 @@
 #include "thread.h"
 #include "mem2node.h"
 #include "symbol.h"
+#include "../perf.h"
 
 struct c2c_hists {
 	struct hists		hists;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 51c37e5..ae4a8eb 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -6,6 +6,7 @@
  * DSOs and symbol information, sort them and produce a diff.
  */
 #include "builtin.h"
+#include "perf.h"
 
 #include "util/debug.h"
 #include "util/event.h"
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bd2a0cc..56705d2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -42,6 +42,7 @@
 #include "util/units.h"
 #include "util/bpf-event.h"
 #include "asm/bug.h"
+#include "perf.h"
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37297b6..f3b31c6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -53,6 +53,7 @@
 #include <perf/evlist.h>
 #include "util/record.h"
 #include "util/util.h"
+#include "perf.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2741bcb..fa4212d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -41,6 +41,7 @@
  */
 
 #include "builtin.h"
+#include "perf.h"
 #include "util/cgroup.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6d9805a..1056950 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -51,6 +51,7 @@
 #include "string2.h"
 #include "syscalltbl.h"
 #include "rb_resort.h"
+#include "../perf.h"
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index a95a248..237b9b3 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -8,6 +8,7 @@
  * perf top, perf record, perf report, etc.) are started.
  */
 #include "builtin.h"
+#include "perf.h"
 
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 30547fd..ccc3728 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -22,6 +22,7 @@
 #include "../../util/top.h"
 #include "../../util/thread.h"
 #include "../../arch/common.h"
+#include "../../perf.h"
 
 #include "../browsers/hists.h"
 #include "../helpline.h"
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 41a9d89..db3954f 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -8,6 +8,7 @@
 #include "time-utils.h"
 #include "../util.h"
 #include "../../util/util.h"
+#include "../../perf.h"
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 50e0c03..e63f377 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../../builtin.h"
+#include "../../perf.h"
 #include "../../util/sort.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e5fb643..ae29f16 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -9,6 +9,7 @@
 #include "../util/sort.h"
 #include "../util/evsel.h"
 #include "../util/evlist.h"
+#include "../perf.h"
 
 /* hist period print (hpp) functions */
 
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index 3ad0d33..2881982 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -11,6 +11,7 @@
 #include "../../util/cache.h"
 #include "../../util/debug.h"
 #include "../../util/util.h"
+#include "../../perf.h"
 #include "../browser.h"
 #include "../helpline.h"
 #include "../ui.h"
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 1fa8a96..bc39cc5 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -17,7 +17,6 @@
 #include <asm/bitsperlong.h>
 #include <asm/barrier.h>
 
-#include "../perf.h"
 #include "event.h"
 #include "session.h"
 #include "debug.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index dd6e010..a47d0e8 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -28,6 +28,7 @@
 #include "callchain.h"
 #include "branch.h"
 #include "symbol.h"
+#include "../perf.h"
 
 #define CALLCHAIN_PARAM_DEFAULT			\
 	.mode		= CHAIN_GRAPH_ABS,	\
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 7fa7a30..ef7fc57 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -30,6 +30,7 @@
 #include "stat.h"
 #include "session.h"
 #include "bpf-event.h"
+#include "../perf.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4c0c523..f56d268 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -9,7 +9,6 @@
 #include <linux/perf_event.h>
 #include <perf/event.h>
 
-#include "../perf.h"
 #include "build-id.h"
 #include "perf_regs.h"
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 253dd8d..71b231c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -17,6 +17,7 @@
 #include "debug.h"
 #include "units.h"
 #include "util.h"
+#include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <signal.h>
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 16796de..ee28864 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -9,7 +9,6 @@
 #include <api/fd/array.h>
 #include <stdio.h>
 #include <internal/evlist.h>
-#include "../perf.h"
 #include "event.h"
 #include "evsel.h"
 #include "mmap.h"
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5f3532e..28477ff 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -16,6 +16,7 @@
 #include "debug.h"
 #include "event.h"
 #include "mmap.h"
+#include "../perf.h"
 #include "util.h" /* page_size */
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9eb843e..82bd5d4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,7 @@
 #include "sample-raw.h"
 #include "stat.h"
 #include "util.h"
+#include "../perf.h"
 #include "arch/common.h"
 
 #ifdef HAVE_ZSTD_SUPPORT
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index e5b690c..51fb574 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -12,6 +12,7 @@
 #include "parse-events.h"
 #include "symbol.h"
 #include "top.h"
+#include "../perf.h"
 #include <inttypes.h>
 
 #define SNPRINTF(buf, size, fmt, args...) \
