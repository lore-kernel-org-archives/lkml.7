Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1906CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D0A21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394565AbfHWMWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:22:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394481AbfHWMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:21:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18Za-0001i2-Co; Fri, 23 Aug 2019 14:21:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 003711C04F3;
        Fri, 23 Aug 2019 14:21:42 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:21:41 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf metricgroup: Remove needless includes from metricgroup.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-1fkskjws6imir2hhztqhdyb0@git.kernel.org>
References: <tip-1fkskjws6imir2hhztqhdyb0@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656290171.31557.15667824727533281070.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0b8026e8fb0ea3893caa2f1924a2c15fcf6760b3
Gitweb:        https://git.kernel.org/tip/0b8026e8fb0ea3893caa2f1924a2c15fcf6760b3
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 21 Aug 2019 10:54:14 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:56 -03:00

perf metricgroup: Remove needless includes from metricgroup.h

There we need just some struct forward declarations, do that instead and
add the includes needed by metricgroup.c.

That should help with needless rebuilds when changing the removed
headers from metricgroup.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1fkskjws6imir2hhztqhdyb0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c |  3 ++-
 tools/perf/util/metricgroup.h | 13 ++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fdb0d1c..aaf5544 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -7,18 +7,19 @@
 
 #include "metricgroup.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "strbuf.h"
 #include "pmu.h"
 #include "expr.h"
 #include "rblist.h"
 #include <string.h>
-#include <stdbool.h>
 #include <errno.h>
 #include "pmu-events/pmu-events.h"
 #include "strlist.h"
 #include <assert.h>
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
+#include <subcmd/parse-options.h>
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 500e828..e5092f6 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -1,11 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef METRICGROUP_H
 #define METRICGROUP_H 1
 
-#include "linux/list.h"
-#include "rblist.h"
-#include <subcmd/parse-options.h>
-#include "evlist.h"
-#include "strbuf.h"
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <stdbool.h>
+
+struct evsel;
+struct option;
+struct rblist;
 
 struct metric_event {
 	struct rb_node nd;
