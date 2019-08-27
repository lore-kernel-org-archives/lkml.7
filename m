Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56406C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371EB2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfH0I0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42706 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfH0I0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wnt-0007nU-Su; Tue, 27 Aug 2019 10:26:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 86C021C07DC;
        Tue, 27 Aug 2019 10:26:13 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:13 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf sort: Remove needless headers from sort.h,
 provide fwd struct decls
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-u63el2vqsovsmnhebx1rcixo@git.kernel.org>
References: <tip-u63el2vqsovsmnhebx1rcixo@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689437339.24487.57241566156068084.tip-bot2@tip-bot2>
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

Commit-ID:     185bcb92c80eae2d85ec834ea76a144fd163e2af
Gitweb:        https://git.kernel.org/tip/185bcb92c80eae2d85ec834ea76a144fd163e2af
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 22 Aug 2019 17:11:39 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:29 -03:00

perf sort: Remove needless headers from sort.h, provide fwd struct decls

Reducing the includes hell a bit more, speeding up the build and
avoiding needless rebuilds when just one of those files gets updated.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-u63el2vqsovsmnhebx1rcixo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/res_sample.c |  2 ++
 tools/perf/ui/browsers/scripts.c    |  2 ++
 tools/perf/ui/stdio/hist.c          |  1 +
 tools/perf/util/callchain.c         |  1 +
 tools/perf/util/sort.h              | 15 ++-------------
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 08897bd..41a9d89 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -6,6 +6,8 @@
 #include "sort.h"
 #include "config.h"
 #include "time-utils.h"
+#include "../util.h"
+#include "../../util/util.h"
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 04f9aff..f2fd9f0 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "../../builtin.h"
 #include "../../util/sort.h"
+#include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index ee7ea6d..51ed675 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -3,6 +3,7 @@
 #include <linux/string.h>
 
 #include "../../util/callchain.h"
+#include "../../util/debug.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/map_groups.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d077704..dd6e010 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -20,6 +20,7 @@
 
 #include "asm/bug.h"
 
+#include "debug.h"
 #include "hist.h"
 #include "sort.h"
 #include "machine.h"
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 4ae155c..3d7cef7 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -1,29 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PERF_SORT_H
 #define __PERF_SORT_H
-#include "../builtin.h"
-
 #include <regex.h>
-
-#include "color.h"
+#include <stdbool.h>
 #include <linux/list.h>
-#include "cache.h"
 #include <linux/rbtree.h>
 #include "map_symbol.h"
 #include "symbol_conf.h"
-#include "string.h"
 #include "callchain.h"
 #include "values.h"
 
-#include "../perf.h"
-#include "debug.h"
-#include "header.h"
-
-#include <subcmd/parse-options.h>
-#include "parse-events.h"
 #include "hist.h"
-#include "srcline.h"
 
+struct option;
 struct thread;
 
 extern regex_t parent_regex;
