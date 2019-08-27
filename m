Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE5EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6732173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfH0I0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfH0I0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wnr-0007lr-7i; Tue, 27 Aug 2019 10:26:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DA5611C07DC;
        Tue, 27 Aug 2019 10:26:10 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:10 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf srcline: Add missing srcline.h header to files
 needing its defs
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-shuebppedtye8hrgxk15qe3x@git.kernel.org>
References: <tip-shuebppedtye8hrgxk15qe3x@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689437078.24482.15111214239349858410.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     97b9d866a66cf9884cea623cde3300073815873d
Gitweb:        https://git.kernel.org/tip/97b9d866a66cf9884cea623cde3300073815873d
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 22 Aug 2019 17:10:08 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:29 -03:00

perf srcline: Add missing srcline.h header to files needing its defs

When srcline was introduced it wrongly added the include to util/sort.h,
even with that header not needing the definitions it provides, fix it by
adding it to the places that need it as a pre patch to remove srcline.h
from sort.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-shuebppedtye8hrgxk15qe3x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c   | 2 ++
 tools/perf/builtin-report.c | 1 +
 tools/perf/builtin-script.c | 1 +
 tools/perf/util/annotate.c  | 2 ++
 tools/perf/util/machine.c   | 2 ++
 tools/perf/util/sort.c      | 1 +
 6 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index e91c0d7..51c37e5 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -15,6 +15,7 @@
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/sort.h"
+#include "util/srcline.h"
 #include "util/symbol.h"
 #include "util/data.h"
 #include "util/config.h"
@@ -22,6 +23,7 @@
 #include "util/annotate.h"
 #include "util/map.h"
 #include <linux/zalloc.h>
+#include <subcmd/parse-options.h>
 
 #include <errno.h>
 #include <inttypes.h>
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 79dfb11..318b0b9 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -28,6 +28,7 @@
 #include "util/evswitch.h"
 #include "util/header.h"
 #include "util/session.h"
+#include "util/srcline.h"
 #include "util/tool.h"
 
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ee05621..6f389b3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -11,6 +11,7 @@
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/map.h"
+#include "util/srcline.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/trace-event.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e0518dc..3bd1691 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -22,6 +22,7 @@
 #include "cache.h"
 #include "map.h"
 #include "symbol.h"
+#include "srcline.h"
 #include "units.h"
 #include "debug.h"
 #include "annotate.h"
@@ -37,6 +38,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <bpf/libbpf.h>
+#include <subcmd/parse-options.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f7c1a7e..47430af 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -10,11 +10,13 @@
 #include "hist.h"
 #include "machine.h"
 #include "map.h"
+#include "srcline.h"
 #include "symbol.h"
 #include "sort.h"
 #include "strlist.h"
 #include "target.h"
 #include "thread.h"
+#include "util.h"
 #include "vdso.h"
 #include <stdbool.h>
 #include <sys/types.h>
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 904ff4b..c522bdd 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -13,6 +13,7 @@
 #include "thread.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "srcline.h"
 #include "strlist.h"
 #include "strbuf.h"
 #include <traceevent/event-parse.h>
