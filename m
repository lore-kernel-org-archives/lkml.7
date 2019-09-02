Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09241C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5894215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfIBITZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:19:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfIBIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVl-00081S-Aj; Mon, 02 Sep 2019 10:16:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA4AD1C0DE7;
        Mon,  2 Sep 2019 10:16:28 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:28 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove perf.h from source files not needing it
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-c718m0sxxwp73lp9d8vpihb4@git.kernel.org>
References: <tip-c718m0sxxwp73lp9d8vpihb4@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741218878.17305.9178017771787195203.tip-bot2@tip-bot2>
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

Commit-ID:     0ac25fd0a04d8bd52ceac2476e71a4e497489987
Gitweb:        https://git.kernel.org/tip/0ac25fd0a04d8bd52ceac2476e71a4e497489987
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 15:42:40 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf tools: Remove perf.h from source files not needing it

With the movement of lots of stuff out of perf.h to other headers we
ended up not needing it in lots of places, remove it from those places.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c718m0sxxwp73lp9d8vpihb4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/perf_regs.c               | 1 -
 tools/perf/arch/x86/tests/intel-cqm.c                  | 1 -
 tools/perf/arch/x86/util/archinsn.c                    | 1 -
 tools/perf/arch/x86/util/tsc.c                         | 1 -
 tools/perf/bench/numa.c                                | 1 -
 tools/perf/bench/sched-messaging.c                     | 1 -
 tools/perf/bench/sched-pipe.c                          | 1 -
 tools/perf/builtin-bench.c                             | 1 -
 tools/perf/builtin-buildid-cache.c                     | 1 -
 tools/perf/builtin-buildid-list.c                      | 1 -
 tools/perf/builtin-config.c                            | 2 --
 tools/perf/builtin-ftrace.c                            | 1 -
 tools/perf/builtin-help.c                              | 1 -
 tools/perf/builtin-inject.c                            | 1 -
 tools/perf/builtin-list.c                              | 2 --
 tools/perf/builtin-probe.c                             | 1 -
 tools/perf/scripts/perl/Perf-Trace-Util/Context.c      | 1 -
 tools/perf/scripts/python/Perf-Trace-Util/Context.c    | 1 -
 tools/perf/tests/hists_common.c                        | 1 -
 tools/perf/tests/hists_cumulate.c                      | 1 -
 tools/perf/tests/hists_filter.c                        | 1 -
 tools/perf/tests/hists_link.c                          | 1 -
 tools/perf/tests/hists_output.c                        | 1 -
 tools/perf/ui/browser.c                                | 1 -
 tools/perf/util/bpf-loader.c                           | 1 -
 tools/perf/util/bpf-prologue.c                         | 1 -
 tools/perf/util/branch.c                               | 1 -
 tools/perf/util/cacheline.c                            | 1 -
 tools/perf/util/cgroup.c                               | 1 -
 tools/perf/util/cpumap.c                               | 1 -
 tools/perf/util/debug.c                                | 2 --
 tools/perf/util/event.c                                | 1 -
 tools/perf/util/genelf.c                               | 1 -
 tools/perf/util/genelf_debug.c                         | 1 -
 tools/perf/util/header.c                               | 1 -
 tools/perf/util/intel-pt.c                             | 1 -
 tools/perf/util/parse-branch-options.c                 | 1 -
 tools/perf/util/parse-events.c                         | 1 -
 tools/perf/util/scripting-engines/trace-event-perl.c   | 1 -
 tools/perf/util/scripting-engines/trace-event-python.c | 1 -
 tools/perf/util/svghelper.c                            | 1 -
 tools/perf/util/thread.c                               | 1 -
 tools/perf/util/time-utils.c                           | 1 -
 tools/perf/util/trace-event-info.c                     | 1 -
 tools/perf/util/trace-event-parse.c                    | 1 -
 tools/perf/util/trace-event-read.c                     | 1 -
 tools/perf/util/trace-event-scripting.c                | 1 -
 tools/perf/util/util.c                                 | 1 -
 48 files changed, 51 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index f14102b..e9c436e 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -4,7 +4,6 @@
 #include <regex.h>
 #include <linux/zalloc.h>
 
-#include "../../perf.h"
 #include "../../util/perf_regs.h"
 #include "../../util/debug.h"
 
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 2a105e3..3b5cc33 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tests/tests.h"
-#include "perf.h"
 #include "cloexec.h"
 #include "debug.h"
 #include "evlist.h"
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
index 4237bb2..62e8e18 100644
--- a/tools/perf/arch/x86/util/archinsn.c
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "archinsn.h"
 #include "util/intel-pt-decoder/insn.h"
 #include "machine.h"
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index a6ba45d..c5197a1 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -5,7 +5,6 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../../perf.h"
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include "../../../util/debug.h"
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 513cb2f..62b8ef4 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -9,7 +9,6 @@
 /* For the CLR_() macros */
 #include <pthread.h>
 
-#include "../perf.h"
 #include "../builtin.h"
 #include <subcmd/parse-options.h>
 #include "../util/cloexec.h"
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index f9d7641..c63eb9a 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -10,7 +10,6 @@
  *
  */
 
-#include "../perf.h"
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
 #include "../builtin.h"
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 0591be0..35b07f1 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -9,7 +9,6 @@
  *  http://people.redhat.com/mingo/cfs-scheduler/tools/pipe-test-1m.c
  * Ported to perf by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
  */
-#include "../perf.h"
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
 #include "../builtin.h"
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index b8e7c38..c06fe21 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -16,7 +16,6 @@
  *  futex ... Futex performance
  *  epoll ... Event poll performance
  */
-#include "perf.h"
 #include <subcmd/parse-options.h>
 #include "builtin.h"
 #include "bench/bench.h"
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 7dde3ef..9e75600 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -14,7 +14,6 @@
 #include <errno.h>
 #include <unistd.h>
 #include "builtin.h"
-#include "perf.h"
 #include "namespaces.h"
 #include "util/cache.h"
 #include "util/debug.h"
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index f403e19..72bdc0e 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 /*
  * builtin-buildid-list.c
  *
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 6c1284c..edfc8f7 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -7,8 +7,6 @@
  */
 #include "builtin.h"
 
-#include "perf.h"
-
 #include "util/cache.h"
 #include <subcmd/parse-options.h>
 #include "util/util.h"
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 565db78..7374f86 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -6,7 +6,6 @@
  */
 
 #include "builtin.h"
-#include "perf.h"
 
 #include <errno.h>
 #include <unistd.h>
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index a83af92..641d4a3 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -4,7 +4,6 @@
  *
  * Builtin help command
  */
-#include "perf.h"
 #include "util/config.h"
 #include "builtin.h"
 #include <subcmd/exec-cmd.h>
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0401425..ae46de4 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -8,7 +8,6 @@
  */
 #include "builtin.h"
 
-#include "perf.h"
 #include "util/color.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e0312a1..dca0d33 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -10,8 +10,6 @@
  */
 #include "builtin.h"
 
-#include "perf.h"
-
 #include "util/parse-events.h"
 #include "util/cache.h"
 #include "util/pmu.h"
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 3d0ffd4..f45fd7e 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -16,7 +16,6 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "perf.h"
 #include "builtin.h"
 #include "namespaces.h"
 #include "util/strlist.h"
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Context.c b/tools/perf/scripts/perl/Perf-Trace-Util/Context.c
index ead521d..25c47d2 100644
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/perl/Perf-Trace-Util/Context.c
@@ -19,7 +19,6 @@
 #include "EXTERN.h"
 #include "perl.h"
 #include "XSUB.h"
-#include "../../../perf.h"
 #include "../../../util/trace-event.h"
 
 #ifndef PERL_UNUSED_VAR
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 217568b..0b70968 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -6,7 +6,6 @@
  */
 
 #include <Python.h>
-#include "../../../perf.h"
 #include "../../../util/trace-event.h"
 
 #if PY_MAJOR_VERSION < 3
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index 469958c..96ad95d 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
-#include "perf.h"
 #include "util/debug.h"
 #include "util/map.h"
 #include "util/symbol.h"
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 1f3de85..93af420 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/map.h"
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index a274716..41dede2 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "util/debug.h"
 #include "util/map.h"
 #include "util/symbol.h"
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index b25383a..012fe8a 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "tests.h"
 #include "debug.h"
 #include "symbol.h"
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 009888a..07f4ca0 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/map.h"
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index c797a85..f93d40b 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -2,7 +2,6 @@
 #include "../util/util.h"
 #include "../util/string2.h"
 #include "../util/config.h"
-#include "../perf.h"
 #include "libslang.h"
 #include "ui.h"
 #include "util.h"
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 80a828e..c1a5732 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <errno.h>
-#include "perf.h"
 #include "debug.h"
 #include "evlist.h"
 #include "bpf-loader.h"
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 77e4891..09e6c76 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -8,7 +8,6 @@
  */
 
 #include <bpf/libbpf.h>
-#include "perf.h"
 #include "debug.h"
 #include "bpf-loader.h"
 #include "bpf-prologue.h"
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index a4fce27..02d6d83 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,4 +1,3 @@
-#include "perf.h"
 #include "util/util.h"
 #include "util/debug.h"
 #include "util/branch.h"
diff --git a/tools/perf/util/cacheline.c b/tools/perf/util/cacheline.c
index 9361d3f..e98b525 100644
--- a/tools/perf/util/cacheline.c
+++ b/tools/perf/util/cacheline.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "cacheline.h"
-#include "../perf.h"
 #include <unistd.h>
 
 #ifdef _SC_LEVEL1_DCACHE_LINESIZE
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index f73599f..96a931c 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../perf.h"
 #include <subcmd/parse-options.h>
 #include "evsel.h"
 #include "cgroup.h"
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b9301e7..a22c111 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <api/fs/fs.h>
-#include "../perf.h"
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 3780fe4..c822c59 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* For general debugging purposes */
 
-#include "../perf.h"
-
 #include <inttypes.h>
 #include <string.h>
 #include <stdarg.h>
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index ef7fc57..54169ad 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index bc32f40..f9f18b8 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -23,7 +23,6 @@
 #include <dwarf.h>
 #endif
 
-#include "perf.h"
 #include "genelf.h"
 #include "../util/jitdump.h"
 #include <linux/compiler.h>
diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index 995e490..30e9f61 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -24,7 +24,6 @@
 #include <err.h>
 #include <dwarf.h>
 
-#include "perf.h"
 #include "genelf.h"
 #include "../util/jitdump.h"
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d252124..20fb061 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -26,7 +26,6 @@
 #include "evsel.h"
 #include "header.h"
 #include "memswap.h"
-#include "../perf.h"
 #include "trace-event.h"
 #include "session.h"
 #include "symbol.h"
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 825a6a3..825e369 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
-#include "../perf.h"
 #include "session.h"
 #include "machine.h"
 #include "memswap.h"
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 4ed20c8..1430437 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-branch-options.h"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9101568..5f1ba68 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -10,7 +10,6 @@
 #include <fcntl.h>
 #include <sys/param.h>
 #include "term.h"
-#include "../perf.h"
 #include "evlist.h"
 #include "evsel.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 01ebf10..800e82d 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -34,7 +34,6 @@
 #include <EXTERN.h>
 #include <perl.h>
 
-#include "../../perf.h"
 #include "../callchain.h"
 #include "../machine.h"
 #include "../map.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 78c8bc9..abfde35 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -31,7 +31,6 @@
 #include <linux/compiler.h>
 #include <linux/time64.h>
 
-#include "../../perf.h"
 #include "../counts.h"
 #include "../debug.h"
 #include "../callchain.h"
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index fef0f8a..582f4a6 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -20,7 +20,6 @@
 #include <perf/cpumap.h>
 
 #include "env.h"
-#include "perf.h"
 #include "svghelper.h"
 #include "cpumap.h"
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index dbcb9cf..5ba1601 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../perf.h"
 #include <errno.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index c2abc25..9796a2e 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -10,7 +10,6 @@
 #include <math.h>
 #include <linux/ctype.h>
 
-#include "perf.h"
 #include "debug.h"
 #include "time-utils.h"
 #include "session.h"
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 2f8a060..d63d542 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
-#include "../perf.h"
 #include "trace-event.h"
 #include <api/fs/tracing_path.h>
 #include "evsel.h"
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index b3982e1..8e31a63 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -7,7 +7,6 @@
 #include <string.h>
 #include <errno.h>
 
-#include "../perf.h"
 #include "debug.h"
 #include "trace-event.h"
 
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 13c1cf6..b6c0db0 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <errno.h>
 
-#include "../perf.h"
 #include "util.h"
 #include "trace-event.h"
 #include "debug.h"
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index dfd2640..714581b 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -10,7 +10,6 @@
 #include <string.h>
 #include <errno.h>
 
-#include "../perf.h"
 #include "debug.h"
 #include "trace-event.h"
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 44211e4..607daec 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../perf.h"
 #include "util.h"
 #include "debug.h"
 #include "namespaces.h"
