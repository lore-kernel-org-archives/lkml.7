Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1441EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C54215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfIBIQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:16:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56220 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbfIBIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVn-0007za-OR; Mon, 02 Sep 2019 10:16:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 687B11C0793;
        Mon,  2 Sep 2019 10:16:26 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:26 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove needless libtraceevent include directives
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-26hn75jn9rdealn4uqtzend6@git.kernel.org>
References: <tip-26hn75jn9rdealn4uqtzend6@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741218634.17290.2486045734312080490.tip-bot2@tip-bot2>
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

Commit-ID:     108a1bb9d1d88bff47d5eccd2cf18dc09a04fb9f
Gitweb:        https://git.kernel.org/tip/108a1bb9d1d88bff47d5eccd2cf18dc09a04fb9f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 13:00:28 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf tools: Remove needless libtraceevent include directives

Remove traceevent/event-parse.h and traceevent/trace-seq.h from places
where it is not needed.

Should avoid rebuilding those files when these traceevent headers get
changed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: https://lkml.kernel.org/n/tip-26hn75jn9rdealn4uqtzend6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c | 1 -
 tools/perf/util/session.c      | 1 -
 tools/perf/util/trace-event.h  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1ff81a7..1a74499 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -10,7 +10,6 @@
 
 #include <errno.h>
 #include <inttypes.h>
-#include <traceevent/event-parse.h>
 
 #include "builtin.h"
 #include "util/color.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 13486bc..9eb843e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4,7 +4,6 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
-#include <traceevent/event-parse.h>
 #include <api/fs/fs.h>
 
 #include <byteswap.h>
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 258d790..2e15838 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -3,7 +3,6 @@
 #define _PERF_UTIL_TRACE_EVENT_H
 
 #include <traceevent/event-parse.h>
-#include <traceevent/trace-seq.h>
 #include "parse-events.h"
 
 struct machine;
