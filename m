Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EF1C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105CA215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfIBISg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:18:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56286 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfIBIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVz-0008Ad-JT; Mon, 02 Sep 2019 10:16:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ACC4A1C0DFB;
        Mon,  2 Sep 2019 10:16:38 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:38 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove needless evlist.h include directives
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-6d7kape36m94a266md0d3xbh@git.kernel.org>
References: <tip-6d7kape36m94a266md0d3xbh@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219852.17366.4503206627494928621.tip-bot2@tip-bot2>
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

Commit-ID:     7ae811b12e419fd70b7d7159f20ed8519bbe18cc
Gitweb:        https://git.kernel.org/tip/7ae811b12e419fd70b7d7159f20ed8519bbe18cc
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 12:29:03 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf tools: Remove needless evlist.h include directives

Now that evlist.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6d7kape36m94a266md0d3xbh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-lock.c       | 2 +-
 tools/perf/builtin-timechart.c  | 2 +-
 tools/perf/tests/hists_common.c | 1 -
 tools/perf/tests/sdt.c          | 3 ++-
 tools/perf/ui/gtk/browser.c     | 1 -
 tools/perf/util/arm-spe.c       | 3 ++-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 38500bf..b0ff952 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 #include "perf.h"
 
-#include "util/evlist.h"
+#include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
 #include "util/cache.h"
 #include "util/symbol.h"
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1a74499..65560a8 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -15,7 +15,7 @@
 #include "util/color.h"
 #include <linux/list.h>
 #include "util/cache.h"
-#include "util/evlist.h"
+#include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index cdde41c..de110d8 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -6,7 +6,6 @@
 #include "util/symbol.h"
 #include "util/sort.h"
 #include "util/evsel.h"
-#include "util/evlist.h"
 #include "util/machine.h"
 #include "util/thread.h"
 #include "tests/hists_common.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index dbc35a8..cf1bd57 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <limits.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/epoll.h>
-#include <util/evlist.h>
 #include <util/symbol.h>
 #include <linux/filter.h>
 #include "tests.h"
diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index 4820e25..06a6a1e 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../evlist.h"
 #include "../cache.h"
 #include "../evsel.h"
 #include "../sort.h"
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 6bee599..8a7340f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -8,6 +8,8 @@
 #include <errno.h>
 #include <byteswap.h>
 #include <inttypes.h>
+#include <unistd.h>
+#include <stdlib.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
@@ -17,7 +19,6 @@
 #include "cpumap.h"
 #include "color.h"
 #include "evsel.h"
-#include "evlist.h"
 #include "machine.h"
 #include "session.h"
 #include "debug.h"
