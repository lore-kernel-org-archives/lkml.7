Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C522C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF499215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfIBISp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:18:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56273 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbfIBIQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVy-00089O-N4; Mon, 02 Sep 2019 10:16:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 260F21C0793;
        Mon,  2 Sep 2019 10:16:37 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:37 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove needless map.h include directives
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-iu8ylqky7g1i9i54v3y7qovw@git.kernel.org>
References: <tip-iu8ylqky7g1i9i54v3y7qovw@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219704.17357.3613300071249261568.tip-bot2@tip-bot2>
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

Commit-ID:     df1a0a110c2c0138665f6d8ec96812ea14c2d818
Gitweb:        https://git.kernel.org/tip/df1a0a110c2c0138665f6d8ec96812ea14c2d818
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 12:07:23 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf tools: Remove needless map.h include directives

Now that map.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-iu8ylqky7g1i9i54v3y7qovw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/sym-handling.c | 8 +++-----
 tools/perf/tests/thread-mg-share.c        | 1 -
 tools/perf/util/intel-bts.c               | 1 -
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
index 27fcf24..5df7889 100644
--- a/tools/perf/arch/arm64/util/sym-handling.c
+++ b/tools/perf/arch/arm64/util/sym-handling.c
@@ -4,11 +4,9 @@
  * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
  */
 
-#include "debug.h"
-#include "symbol.h"
-#include "map.h"
-#include "probe-event.h"
-#include "probe-file.h"
+#include "symbol.h" // for the elf__needs_adjust_symbols() prototype
+#include <stdbool.h>
+#include <gelf.h>
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
index b1d1bba..cbac717 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-mg-share.c
@@ -2,7 +2,6 @@
 #include "tests.h"
 #include "machine.h"
 #include "thread.h"
-#include "map.h"
 #include "debug.h"
 
 int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_unused)
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index a30427a..aacffa2 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -19,7 +19,6 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "machine.h"
-#include "map.h"
 #include "symbol.h"
 #include "session.h"
 #include "tool.h"
