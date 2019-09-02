Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F8C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C00D22CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfIBISL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:18:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56316 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbfIBIQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW3-00089w-9T; Mon, 02 Sep 2019 10:16:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9648F1C0DF5;
        Mon,  2 Sep 2019 10:16:37 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:37 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove needless thread.h include directives
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-kh333ivjbw05wsggckpziu86@git.kernel.org>
References: <tip-kh333ivjbw05wsggckpziu86@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219749.17360.14527466607072463669.tip-bot2@tip-bot2>
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

Commit-ID:     4becb2395f9166b11d68817ed4af8fc06b840908
Gitweb:        https://git.kernel.org/tip/4becb2395f9166b11d68817ed4af8fc06b840908
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 12:13:45 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf tools: Remove needless thread.h include directives

Now that thread.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-kh333ivjbw05wsggckpziu86@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c   | 1 -
 tools/perf/builtin-stat.c       | 1 -
 tools/perf/builtin-top.c        | 1 -
 tools/perf/tests/hists_filter.c | 1 -
 tools/perf/tests/hists_link.c   | 1 -
 tools/perf/util/arm-spe.c       | 1 -
 tools/perf/util/probe-event.c   | 1 -
 tools/perf/util/probe-file.c    | 1 -
 tools/perf/util/s390-cpumsf.c   | 1 -
 9 files changed, 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 738471a..7135b77 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -24,7 +24,6 @@
 #include "util/event.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
-#include "util/thread.h"
 #include "util/sort.h"
 #include "util/hist.h"
 #include "util/dso.h"
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fa4212d..7e17bf9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -54,7 +54,6 @@
 #include "util/stat.h"
 #include "util/header.h"
 #include "util/cpumap.h"
-#include "util/thread.h"
 #include "util/thread_map.h"
 #include "util/counts.h"
 #include "util/group.h"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0f0d962..eb94121 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -32,7 +32,6 @@
 #include "util/map.h"
 #include "util/session.h"
 #include "util/symbol.h"
-#include "util/thread.h"
 #include "util/thread_map.h"
 #include "util/top.h"
 #include "util/util.h"
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 41dede2..618b51f 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -7,7 +7,6 @@
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/machine.h"
-#include "util/thread.h"
 #include "util/parse-events.h"
 #include "tests/tests.h"
 #include "tests/hists_common.h"
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 012fe8a..8be4d0b 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -6,7 +6,6 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "machine.h"
-#include "thread.h"
 #include "parse-events.h"
 #include "hists_common.h"
 #include <errno.h>
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d7c3fbb..6bee599 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -20,7 +20,6 @@
 #include "evlist.h"
 #include "machine.h"
 #include "session.h"
-#include "thread.h"
 #include "debug.h"
 #include "auxtrace.h"
 #include "arm-spe.h"
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 5d12a78..e90faa6 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -31,7 +31,6 @@
 #include "map.h"
 #include "map_groups.h"
 #include "symbol.h"
-#include "thread.h"
 #include <api/fs/fs.h>
 #include "trace-event.h"	/* For __maybe_unused */
 #include "probe-event.h"
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 10d2ab1..adc949e 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -20,7 +20,6 @@
 #include "cache.h"
 #include "color.h"
 #include "symbol.h"
-#include "thread.h"
 #include <api/fs/tracing_path.h>
 #include "probe-event.h"
 #include "probe-file.h"
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 2ba4baa..24a9990 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -158,7 +158,6 @@
 #include "machine.h"
 #include "session.h"
 #include "tool.h"
-#include "thread.h"
 #include "debug.h"
 #include "auxtrace.h"
 #include "s390-cpumsf.h"
