Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1677C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9FC215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfIBISv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:18:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56244 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbfIBIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVv-00087j-I4; Mon, 02 Sep 2019 10:16:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 133F11C0DFA;
        Mon,  2 Sep 2019 10:16:35 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:34 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf hist: Remove needless ui/progress.h from hist.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-84a90o9jdxybffxo9jmouokw@git.kernel.org>
References: <tip-84a90o9jdxybffxo9jmouokw@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219494.17345.18106486618368202258.tip-bot2@tip-bot2>
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

Commit-ID:     171f7474b6bb6c7074431f76c28ea87d625c68fd
Gitweb:        https://git.kernel.org/tip/171f7474b6bb6c7074431f76c28ea87d625c68fd
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 11:28:14 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf hist: Remove needless ui/progress.h from hist.h

We only need a forward declaration, add it and fixup all the files that
need ui_progress definitions but were wrongly getting it from hist.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-84a90o9jdxybffxo9jmouokw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c    | 1 +
 tools/perf/builtin-report.c | 1 +
 tools/perf/util/hist.h      | 2 +-
 tools/perf/util/session.c   | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d1ad694..0d76b2c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -37,6 +37,7 @@
 #include "mem2node.h"
 #include "symbol.h"
 #include "ui/ui.h"
+#include "ui/progress.h"
 #include "../perf.h"
 
 struct c2c_hists {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ba419ee..d7a3456 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,6 +47,7 @@
 #include "util/branch.h"
 #include "util/util.h"
 #include "ui/ui.h"
+#include "ui/progress.h"
 
 #include <dlfcn.h>
 #include <errno.h>
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 7b9267e..1c0a635 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,7 +8,6 @@
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
-#include "ui/progress.h"
 
 struct hist_entry;
 struct hist_entry_ops;
@@ -18,6 +17,7 @@ struct mem_info;
 struct branch_info;
 struct block_info;
 struct symbol;
+struct ui_progress;
 
 enum hist_filter {
 	HIST_FILTER__DSO,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a72774e..f166da7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -30,6 +30,7 @@
 #include "sample-raw.h"
 #include "stat.h"
 #include "util.h"
+#include "ui/progress.h"
 #include "../perf.h"
 #include "arch/common.h"
 
