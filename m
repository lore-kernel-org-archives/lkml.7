Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F2C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F54B22D6D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfIBIQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:16:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56166 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbfIBIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVn-00082A-Bd; Mon, 02 Sep 2019 10:16:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EAC5F1C0DE7;
        Mon,  2 Sep 2019 10:16:29 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:29 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf debug: Remove needless include directives from debug.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-7ftk0ztstqub1tirjj8o8xbl@git.kernel.org>
References: <tip-7ftk0ztstqub1tirjj8o8xbl@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741218984.17311.8792802383171382622.tip-bot2@tip-bot2>
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

Commit-ID:     8520a98dbab61e9e340cdfb72dd17ccc8a98961e
Gitweb:        https://git.kernel.org/tip/8520a98dbab61e9e340cdfb72dd17ccc8a98961e
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 16:18:59 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 19:10:19 -03:00

perf debug: Remove needless include directives from debug.h

All we need there is a forward declaration for 'union perf_event', so
remove it from there and add missing header directives in places using
things from this indirect include.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7ftk0ztstqub1tirjj8o8xbl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c           | 1 +
 tools/perf/arch/common.c                    | 2 ++
 tools/perf/arch/x86/tests/bp-modify.c       | 1 +
 tools/perf/arch/x86/tests/insn-x86.c        | 1 +
 tools/perf/arch/x86/tests/rdpmc.c           | 2 ++
 tools/perf/arch/x86/util/perf_regs.c        | 1 +
 tools/perf/builtin-c2c.c                    | 2 ++
 tools/perf/builtin-config.c                 | 1 +
 tools/perf/builtin-data.c                   | 2 ++
 tools/perf/builtin-diff.c                   | 1 +
 tools/perf/builtin-ftrace.c                 | 3 ++-
 tools/perf/builtin-help.c                   | 4 ++++
 tools/perf/builtin-kmem.c                   | 1 +
 tools/perf/builtin-list.c                   | 1 +
 tools/perf/builtin-probe.c                  | 1 +
 tools/perf/builtin-record.c                 | 1 +
 tools/perf/builtin-report.c                 | 2 ++
 tools/perf/builtin-top.c                    | 1 +
 tools/perf/builtin-trace.c                  | 1 +
 tools/perf/perf.c                           | 2 ++
 tools/perf/tests/attr.c                     | 1 +
 tools/perf/tests/backward-ring-buffer.c     | 1 +
 tools/perf/tests/bp_account.c               | 1 +
 tools/perf/tests/bp_signal.c                | 1 +
 tools/perf/tests/bp_signal_overflow.c       | 1 +
 tools/perf/tests/bpf.c                      | 1 +
 tools/perf/tests/event-times.c              | 1 +
 tools/perf/tests/expr.c                     | 1 +
 tools/perf/tests/kmod-path.c                | 2 ++
 tools/perf/tests/mmap-basic.c               | 1 +
 tools/perf/tests/openat-syscall-all-cpus.c  | 1 +
 tools/perf/tests/openat-syscall-tp-fields.c | 1 +
 tools/perf/tests/openat-syscall.c           | 1 +
 tools/perf/tests/perf-record.c              | 1 +
 tools/perf/tests/sample-parsing.c           | 1 +
 tools/perf/tests/task-exit.c                | 1 +
 tools/perf/tests/thread-map.c               | 7 +++++++
 tools/perf/tests/unit_number__scnprintf.c   | 1 +
 tools/perf/tests/wp.c                       | 3 +++
 tools/perf/ui/browsers/scripts.c            | 1 +
 tools/perf/ui/gtk/helpline.c                | 1 +
 tools/perf/ui/gtk/util.c                    | 1 +
 tools/perf/ui/tui/helpline.c                | 1 +
 tools/perf/ui/util.c                        | 2 +-
 tools/perf/util/bpf-prologue.c              | 1 +
 tools/perf/util/branch.c                    | 1 +
 tools/perf/util/callchain.c                 | 1 +
 tools/perf/util/cloexec.c                   | 2 ++
 tools/perf/util/data.c                      | 1 +
 tools/perf/util/debug.c                     | 1 +
 tools/perf/util/debug.h                     | 6 ++----
 tools/perf/util/dwarf-aux.c                 | 1 +
 tools/perf/util/dwarf-aux.h                 | 2 ++
 tools/perf/util/env.c                       | 1 +
 tools/perf/util/evlist.c                    | 1 +
 tools/perf/util/expr.y                      | 2 ++
 tools/perf/util/hist.c                      | 1 +
 tools/perf/util/intel-pt.c                  | 1 +
 tools/perf/util/llvm-utils.c                | 1 +
 tools/perf/util/lzma.c                      | 1 +
 tools/perf/util/machine.c                   | 1 +
 tools/perf/util/map.c                       | 1 +
 tools/perf/util/ordered-events.c            | 1 +
 tools/perf/util/parse-branch-options.c      | 2 ++
 tools/perf/util/perf-hooks.c                | 1 +
 tools/perf/util/probe-finder.c              | 1 +
 tools/perf/util/pstack.c                    | 1 +
 tools/perf/util/sort.c                      | 1 +
 tools/perf/util/strbuf.c                    | 4 ++++
 tools/perf/util/symbol.c                    | 1 +
 tools/perf/util/target.c                    | 3 +++
 tools/perf/util/thread-stack.c              | 1 +
 tools/perf/util/util.c                      | 1 +
 tools/perf/util/values.c                    | 1 +
 tools/perf/util/zlib.c                      | 1 +
 75 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b74fd40..197041f 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -11,6 +11,7 @@
 #include <linux/coresight-pmu.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index a769382..59dd875 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include "common.h"
 #include "../util/env.h"
diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
index f53e440..adcacf1 100644
--- a/tools/perf/arch/x86/tests/bp-modify.c
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/ptrace.h>
 #include <asm/ptrace.h>
 #include <errno.h>
diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index c3e5f4a..d67bc0f 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
+#include <string.h>
 
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 345a6a0..6e67cee 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -6,11 +6,13 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include "perf-sys.h"
 #include "debug.h"
 #include "tests/tests.h"
 #include "cloexec.h"
+#include "event.h"
 #include "util.h"
 #include "arch-tests.h"
 
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 74a606e..99ea602 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -7,6 +7,7 @@
 #include "../../perf-sys.h"
 #include "../../util/perf_regs.h"
 #include "../../util/debug.h"
+#include "../../util/event.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 25a5f18..d1ad694 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -20,6 +20,7 @@
 #include <sys/param.h>
 #include "debug.h"
 #include "builtin.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "mem-events.h"
 #include "session.h"
@@ -35,6 +36,7 @@
 #include "thread.h"
 #include "mem2node.h"
 #include "symbol.h"
+#include "ui/ui.h"
 #include "../perf.h"
 
 struct c2c_hists {
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index edfc8f7..42d8157 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -13,6 +13,7 @@
 #include "util/debug.h"
 #include "util/config.h"
 #include <linux/string.h>
+#include <stdio.h>
 #include <stdlib.h>
 
 static bool use_system_config, use_user_config;
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index dde25d4..ca2fb44 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <stdio.h>
+#include <string.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ae4a8eb..827e480 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -24,6 +24,7 @@
 #include "util/annotate.h"
 #include "util/map.h"
 #include <linux/zalloc.h>
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 
 #include <errno.h>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7374f86..2f8ea44 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -13,8 +13,10 @@
 #include <fcntl.h>
 #include <poll.h>
 #include <linux/capability.h>
+#include <linux/string.h>
 
 #include "debug.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <api/fs/tracing_path.h>
 #include "evlist.h"
@@ -24,7 +26,6 @@
 #include "util/cap.h"
 #include "util/config.h"
 
-
 #define DEFAULT_TRACER  "function_graph"
 
 struct perf_ftrace {
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 641d4a3..3976aeb 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -4,7 +4,9 @@
  *
  * Builtin help command
  */
+#include "util/cache.h"
 #include "util/config.h"
+#include "util/strbuf.h"
 #include "builtin.h"
 #include <subcmd/exec-cmd.h>
 #include "common-cmds.h"
@@ -13,10 +15,12 @@
 #include <subcmd/help.h>
 #include "util/debug.h"
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 46f8289..7eec0da 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -14,6 +14,7 @@
 #include "util/callchain.h"
 #include "util/time-utils.h"
 
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include "util/trace-event.h"
 #include "util/data.h"
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index dca0d33..11afb76 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -16,6 +16,7 @@
 #include "util/debug.h"
 #include "util/metricgroup.h"
 #include <subcmd/parse-options.h>
+#include <stdio.h>
 
 static bool desc_flag = true;
 static bool details_flag;
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index f45fd7e..8950c05 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -26,6 +26,7 @@
 #include "util/probe-finder.h"
 #include "util/probe-event.h"
 #include "util/probe-file.h"
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 #define DEFAULT_VAR_FILTER "!__k???tab_* & !__crc_*"
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 56705d2..1447004 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,7 @@
 #include <signal.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 33c20e2..94e7e35 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -45,6 +45,7 @@
 #include "util/units.h"
 #include "util/branch.h"
 #include "util/util.h"
+#include "ui/ui.h"
 
 #include <dlfcn.h>
 #include <errno.h>
@@ -53,6 +54,7 @@
 #include <linux/ctype.h>
 #include <signal.h>
 #include <linux/bitmap.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <sys/types.h>
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c3f9544..5538b58 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -45,6 +45,7 @@
 #include "util/intlist.h"
 #include "util/parse-branch-options.h"
 #include "arch/common.h"
+#include "ui/ui.h"
 
 #include "util/debug.h"
 #include "util/ordered-events.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1056950..b1ec8ff 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -29,6 +29,7 @@
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/evswitch.h"
+#include <subcmd/pager.h>
 #include <subcmd/exec-cmd.h>
 #include "util/machine.h"
 #include "util/map.h"
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 237b9b3..e091063 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include "util/cache.h"
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
 #include "util/config.h"
@@ -32,6 +33,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 const char perf_usage_string[] =
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 87dc3e1..a9599ab 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -32,6 +32,7 @@
 #include <unistd.h>
 #include "../perf-sys.h"
 #include <subcmd/exec-cmd.h>
+#include "event.h"
 #include "tests.h"
 
 #define ENV "PERF_TEST_ATTR"
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index b6f27ef..512288e 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -10,6 +10,7 @@
 #include "tests.h"
 #include "debug.h"
 #include <errno.h>
+#include <linux/string.h>
 
 #define NR_ITERS 111
 
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index c4a3031..016bba2 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -19,6 +19,7 @@
 
 #include "tests.h"
 #include "debug.h"
+#include "event.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
 
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 2d292f8..c1c2c13 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -25,6 +25,7 @@
 
 #include "tests.h"
 #include "debug.h"
+#include "event.h"
 #include "perf-sys.h"
 #include "cloexec.h"
 
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index 101315a..eb4dbbd 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -24,6 +24,7 @@
 
 #include "tests.h"
 #include "debug.h"
+#include "event.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 9864296..9fc163b 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -12,6 +12,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <api/fs/fs.h>
 #include <bpf/bpf.h>
 #include "tests.h"
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 714e361..228d161 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <string.h>
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index ee1d886..87843af 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -3,6 +3,7 @@
 #include "util/expr.h"
 #include "tests.h"
 #include <stdlib.h>
+#include <string.h>
 #include <linux/zalloc.h>
 
 static int test(struct parse_ctx *ctx, const char *e, double val2)
diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 0579a70..e483210 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
 #include <stdlib.h>
+#include <string.h>
 #include "tests.h"
 #include "dso.h"
 #include "debug.h"
+#include "event.h"
 
 static int test(const char *path, bool alloc_name, bool kmod,
 		int comp, const char *name)
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index fe91350..bdf77bf 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -13,6 +13,7 @@
 #include "tests.h"
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <perf/evlist.h>
 
 /*
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 4ae4dea..9171f77 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -9,6 +9,7 @@
 #include <fcntl.h>
 #include <api/fs/fs.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <api/fs/tracing_path.h>
 #include "evsel.h"
 #include "tests.h"
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 6249210..b71167b 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 58df4bd..5ebffae 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <api/fs/tracing_path.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 3a205f6..e1b4229 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <linux/string.h>
 /* For the CLR_() macros */
 #include <pthread.h>
 
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index a8ca29f..0c09dc1 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -2,6 +2,7 @@
 #include <stdbool.h>
 #include <inttypes.h>
 #include <stdlib.h>
+#include <string.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 0e0e062..f610e8c 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -9,6 +9,7 @@
 
 #include <errno.h>
 #include <signal.h>
+#include <linux/string.h>
 #include <perf/evlist.h>
 
 static int exited;
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index c19ec88..39168c5 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -1,12 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
+#include <string.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/prctl.h>
 #include "tests.h"
 #include "thread_map.h"
 #include "debug.h"
+#include "event.h"
 #include <linux/zalloc.h>
+#include <perf/event.h>
+
+struct perf_sample;
+struct perf_tool;
+struct machine;
 
 #define NAME	(const char *) "perf"
 #define NAMEUL	(unsigned long) NAME
diff --git a/tools/perf/tests/unit_number__scnprintf.c b/tools/perf/tests/unit_number__scnprintf.c
index 2bb8cb0..3721757 100644
--- a/tools/perf/tests/unit_number__scnprintf.c
+++ b/tools/perf/tests/unit_number__scnprintf.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <string.h>
 #include "tests.h"
 #include "units.h"
 #include "debug.h"
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 982ac55..d262d66 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/kernel.h>
 #include "tests.h"
 #include "debug.h"
+#include "event.h"
 #include "cloexec.h"
 #include "../perf-sys.h"
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index e63f377..77809c0 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -9,6 +9,7 @@
 #include "../browser.h"
 #include "../libslang.h"
 #include "config.h"
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 #define SCRIPT_NAMELEN	128
diff --git a/tools/perf/ui/gtk/helpline.c b/tools/perf/ui/gtk/helpline.c
index fbf1ea9..e166da9 100644
--- a/tools/perf/ui/gtk/helpline.c
+++ b/tools/perf/ui/gtk/helpline.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <string.h>
+#include <linux/kernel.h>
 
 #include "gtk.h"
 #include "../ui.h"
diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
index c28bdb7..c2c5589 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -3,6 +3,7 @@
 #include "../../util/debug.h"
 #include "gtk.h"
 
+#include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 93d6b72..1793c98 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <pthread.h>
+#include <linux/kernel.h>
 
 #include "../../util/debug.h"
 #include "../helpline.h"
diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
index 9ed76e8..689b27c 100644
--- a/tools/perf/ui/util.c
+++ b/tools/perf/ui/util.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util.h"
 #include "../util/debug.h"
-
+#include <stdio.h>
 
 /*
  * Default error logging functions
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 09e6c76..b020a86 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -13,6 +13,7 @@
 #include "bpf-prologue.h"
 #include "probe-finder.h"
 #include <errno.h>
+#include <stdlib.h>
 #include <dwarf-regs.h>
 #include <linux/filter.h>
 
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 02d6d83..30642e1 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,6 +1,7 @@
 #include "util/util.h"
 #include "util/debug.h"
 #include "util/branch.h"
+#include <linux/kernel.h>
 
 static bool cross_area(u64 addr1, u64 addr2, int size)
 {
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index a47d0e8..76bf05b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -16,6 +16,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <math.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 #include "asm/bug.h"
diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 92d0819..4e904fc 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -4,10 +4,12 @@
 #include "util.h"
 #include "../perf-sys.h"
 #include "cloexec.h"
+#include "event.h"
 #include "asm/bug.h"
 #include "debug.h"
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <linux/string.h>
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
 
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 74aafe0..e75c3a2 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index c822c59..522887e 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -19,6 +19,7 @@
 #include "print_binary.h"
 #include "util.h"
 #include "target.h"
+#include "ui/helpline.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index 77445df..b2deee9 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -4,11 +4,7 @@
 #define __PERF_DEBUG_H
 
 #include <stdbool.h>
-#include <string.h>
 #include <linux/compiler.h>
-#include "event.h"
-#include "../ui/helpline.h"
-#include "../ui/progress.h"
 #include "../ui/util.h"
 
 extern int verbose;
@@ -42,6 +38,8 @@ extern int debug_data_convert;
 
 #define STRERR_BUFSIZE	128	/* For the buffer size of str_error_r */
 
+union perf_event;
+
 int dump_printf(const char *fmt, ...) __printf(1, 2);
 void trace_event(union perf_event *event);
 
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 03b2de1..df6cee5 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include "debug.h"
 #include "dwarf-aux.h"
+#include "strbuf.h"
 #include "string2.h"
 
 /**
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 0489b0c..f204e58 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -10,6 +10,8 @@
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
 
+struct strbuf;
+
 /* Find the realpath of the target file */
 const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 571efb4..3baca06 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -9,6 +9,7 @@
 #include <sys/utsname.h>
 #include <bpf/libbpf.h>
 #include <stdlib.h>
+#include <string.h>
 
 struct perf_env perf_env;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 71b231c..b5d6d6e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -35,6 +35,7 @@
 #include <linux/hash.h>
 #include <linux/log2.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <perf/evlist.h>
 #include <perf/evsel.h>
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 432b856..f9a20a3 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -2,9 +2,11 @@
 %{
 #include "util.h"
 #include "util/debug.h"
+#include <stdlib.h> // strtod()
 #define IN_EXPR_Y 1
 #include "expr.h"
 #include "smt.h"
+#include <assert.h>
 #include <string.h>
 
 #define MAXIDLEN 256
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index adae413..02ea2ee 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -19,6 +19,7 @@
 #include <math.h>
 #include <inttypes.h>
 #include <sys/param.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 825e369..9b56fb7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 9f0470e..55fb4b3 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/err.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include "debug.h"
 #include "llvm-utils.h"
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index b1dd29a..3974470 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -9,6 +9,7 @@
 #include "compress.h"
 #include "util.h"
 #include "debug.h"
+#include <string.h>
 #include <unistd.h>
 
 #define BUFSIZE 8192
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a1542b4..6e9afe4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -30,6 +30,7 @@
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 27b7b10..c75b20b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -20,6 +20,7 @@
 #include "namespaces.h"
 #include "unwind.h"
 #include "srccode.h"
+#include "ui/ui.h"
 
 static void __maps__insert(struct maps *maps, struct map *map);
 static void __maps__insert_name(struct maps *maps, struct map *map);
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index bb5f34b..359db2b 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -8,6 +8,7 @@
 #include "session.h"
 #include "asm/bug.h"
 #include "debug.h"
+#include "ui/progress.h"
 
 #define pr_N(n, fmt, ...) \
 	eprintf(n, debug_ordered_events, fmt, ##__VA_ARGS__)
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 1430437..bb4aa88 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
+#include "util/event.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-branch-options.h"
 #include <stdlib.h>
+#include <string.h>
 
 #define BRANCH_OPT(n, m) \
 	{ .name = n, .mode = (m) }
diff --git a/tools/perf/util/perf-hooks.c b/tools/perf/util/perf-hooks.c
index 4f3aa8d..e635c59 100644
--- a/tools/perf/util/perf-hooks.c
+++ b/tools/perf/util/perf-hooks.c
@@ -8,6 +8,7 @@
 
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include <setjmp.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 025fc44..505905f 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -24,6 +24,7 @@
 #include "dso.h"
 #include "debug.h"
 #include "intlist.h"
+#include "strbuf.h"
 #include "strlist.h"
 #include "symbol.h"
 #include "probe-finder.h"
diff --git a/tools/perf/util/pstack.c b/tools/perf/util/pstack.c
index 28de8a4..80ff41f 100644
--- a/tools/perf/util/pstack.c
+++ b/tools/perf/util/pstack.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
+#include <string.h>
 
 struct pstack {
 	unsigned short	top;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 23d0ab7..035355a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -22,6 +22,7 @@
 #include "annotate.h"
 #include "time-utils.h"
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 regex_t		parent_regex;
 const char	default_parent_pattern[] = "^sys_|^do_page_fault";
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 0afdbf3..a64a376 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "cache.h"
 #include "debug.h"
+#include "strbuf.h"
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <errno.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 035f2e7..c37cca6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -7,6 +7,7 @@
 #include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 3adc654..565f7ae 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -10,8 +10,11 @@
 #include "debug.h"
 
 #include <pwd.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
 
 enum target_errno target__validate(struct target *target)
 {
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 15134ac..cd8a948 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -10,6 +10,7 @@
 #include <linux/zalloc.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include "thread.h"
 #include "event.h"
 #include "machine.h"
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 607daec..32322a2 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util.h"
 #include "debug.h"
+#include "event.h"
 #include "namespaces.h"
 #include <api/fs/fs.h>
 #include <sys/mman.h>
diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index c59154e..b9823f4 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 512ad7c..59d456f 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <fcntl.h>
 #include <stdio.h>
+#include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
