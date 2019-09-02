Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F3C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE5B215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfIBITT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:19:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729839AbfIBIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVo-00082u-Ap; Mon, 02 Sep 2019 10:16:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D02501C0DF6;
        Mon,  2 Sep 2019 10:16:30 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:30 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf event: Remove needless include directives from event.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-rdm3dgtlrndmmnlc4bafsg3b@git.kernel.org>
References: <tip-rdm3dgtlrndmmnlc4bafsg3b@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219076.17317.2594853837833146533.tip-bot2@tip-bot2>
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

Commit-ID:     4cb3c6d546aa5493a960d05eb73bad8e69a58574
Gitweb:        https://git.kernel.org/tip/4cb3c6d546aa5493a960d05eb73bad8e69a58574
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 17:19:02 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:19:24 -03:00

perf event: Remove needless include directives from event.h

bpf.h and build-id.h are not needed at all in event.h, remove them.

And fixup the fallout of files that were getting needed stuff from this
now pruned include.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rdm3dgtlrndmmnlc4bafsg3b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/unwind-libdw.c |  1 +
 tools/perf/arch/x86/util/perf_regs.c        |  1 +
 tools/perf/perf.c                           |  1 +
 tools/perf/util/bpf-event.h                 |  1 +
 tools/perf/util/callchain.h                 |  1 +
 tools/perf/util/config.c                    |  2 ++
 tools/perf/util/debug.c                     |  1 +
 tools/perf/util/event.h                     | 18 ++++++++++++------
 8 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/arch/powerpc/util/unwind-libdw.c
index 7a1f05e..abf2dbc 100644
--- a/tools/perf/arch/powerpc/util/unwind-libdw.c
+++ b/tools/perf/arch/powerpc/util/unwind-libdw.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <elfutils/libdwfl.h>
+#include <linux/kernel.h>
 #include "../../util/unwind-libdw.h"
 #include "../../util/perf_regs.h"
 #include "../../util/event.h"
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 99ea602..c218b83 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <string.h>
 #include <regex.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 
 #include "../../perf-sys.h"
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index e091063..8763b2c 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include "util/build-id.h"
 #include "util/cache.h"
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 417b788..a01c2fd 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -13,6 +13,7 @@ struct machine;
 union perf_event;
 struct perf_env;
 struct perf_sample;
+struct perf_session;
 struct record_opts;
 struct evlist;
 struct target;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 45b9ed4..b042cee 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -8,6 +8,7 @@
 #include "map_symbol.h"
 #include "branch.h"
 
+struct evsel;
 struct map;
 
 #define HELP_PAD "\t\t\t\t"
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index eb5308c..7ebf9e3 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -17,6 +17,8 @@
 #include "util/event.h"  /* proc_map_timeout */
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/llvm-utils.h"   /* perf_llvm_config */
+#include "build-id.h"
+#include "debug.h"
 #include "config.h"
 #include "debug.h"
 #include <sys/types.h>
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 522887e..143d379 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <sys/wait.h>
 #include <api/debug.h>
+#include <linux/kernel.h>
 #include <linux/time64.h>
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f56d268..006aa43 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -1,17 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PERF_RECORD_H
 #define __PERF_RECORD_H
-
-#include <limits.h>
+/*
+ * The linux/stddef.h isn't need here, but is needed for __always_inline used
+ * in files included from uapi/linux/perf_event.h such as
+ * /usr/include/linux/swab.h and /usr/include/linux/byteorder/little_endian.h,
+ * detected in at least musl libc, used in Alpine Linux. -acme
+ */
 #include <stdio.h>
-#include <linux/kernel.h>
-#include <linux/bpf.h>
-#include <linux/perf_event.h>
+#include <linux/stddef.h>
 #include <perf/event.h>
+#include <linux/types.h>
 
-#include "build-id.h"
 #include "perf_regs.h"
 
+struct dso;
+struct machine;
+struct perf_event_attr;
+
 #ifdef __LP64__
 /*
  * /usr/include/inttypes.h uses just 'lu' for PRIu64, but we end up defining
