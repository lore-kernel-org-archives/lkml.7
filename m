Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38526C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178AB2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfIBIST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:18:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56304 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbfIBIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW2-00088c-0N; Mon, 02 Sep 2019 10:16:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 38E011C0DEC;
        Mon,  2 Sep 2019 10:16:36 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:36 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove needless sort.h include directives
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-tom8k0lbsxd9joprr8zpu6w1@git.kernel.org>
References: <tip-tom8k0lbsxd9joprr8zpu6w1@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219610.17351.15207644585939549590.tip-bot2@tip-bot2>
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

Commit-ID:     5c9dbe6da13398d09efc9ec479194afa6d9ec9e6
Gitweb:        https://git.kernel.org/tip/5c9dbe6da13398d09efc9ec479194afa6d9ec9e6
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 11:54:00 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf tools: Remove needless sort.h include directives

Now that sort.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tom8k0lbsxd9joprr8zpu6w1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c         | 1 +
 tools/perf/ui/browsers/scripts.c | 1 -
 tools/perf/util/hist.c           | 1 +
 tools/perf/util/mem-events.c     | 1 -
 tools/perf/util/session.c        | 1 -
 5 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0b7b12c..0f0d962 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -39,6 +39,7 @@
 #include <linux/rbtree.h>
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
+#include "util/callchain.h"
 #include "util/cpumap.h"
 #include "util/sort.h"
 #include "util/string2.h"
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 77809c0..bf1d9f9 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../../builtin.h"
 #include "../../perf.h"
-#include "../../util/sort.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b526ef3..0978dc4 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -20,6 +20,7 @@
 #include <math.h>
 #include <inttypes.h>
 #include <sys/param.h>
+#include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 42c3e5a..3a8d38c 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -11,7 +11,6 @@
 #include "mem-events.h"
 #include "debug.h"
 #include "symbol.h"
-#include "sort.h"
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f166da7..e5ac5f3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -20,7 +20,6 @@
 #include "symbol.h"
 #include "session.h"
 #include "tool.h"
-#include "sort.h"
 #include "cpumap.h"
 #include "perf_regs.h"
 #include "asm/bug.h"
