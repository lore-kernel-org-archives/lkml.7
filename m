Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8A4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A6D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393461AbfITQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:22:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404922AbfITQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLeg-0004Aa-LR; Fri, 20 Sep 2019 18:21:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6F4851C0E36;
        Fri, 20 Sep 2019 18:21:01 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:21:01 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tools: Remove needless builtin.h include directives
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-mn7jheex85iw9qo6tlv26hb2@git.kernel.org>
References: <tip-mn7jheex85iw9qo6tlv26hb2@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899646137.24167.13543207693148324753.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8fcbeae44fde9756036147664d1e74fab7c9902c
Gitweb:        https://git.kernel.org/tip/8fcbeae44fde9756036147664d1e74fab7c9902c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 03 Sep 2019 09:47:53 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:20 -03:00

perf tools: Remove needless builtin.h include directives

Now that builtin.h isn't included by any other header, we can check
where it is really needed, i.e. we can remove it and be sure that it
isn't being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mn7jheex85iw9qo6tlv26hb2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c            | 1 -
 tools/perf/bench/sched-messaging.c | 1 -
 tools/perf/bench/sched-pipe.c      | 1 -
 tools/perf/util/jitdump.c          | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 62b8ef4..5797253 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -9,7 +9,6 @@
 /* For the CLR_() macros */
 #include <pthread.h>
 
-#include "../builtin.h"
 #include <subcmd/parse-options.h>
 #include "../util/cloexec.h"
 
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index c63eb9a..6e499b3 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -12,7 +12,6 @@
 
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
-#include "../builtin.h"
 #include "bench.h"
 
 /* Test groups of 20 processes spraying to 20 receivers */
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 35b07f1..edd40aa 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -11,7 +11,6 @@
  */
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
-#include "../builtin.h"
 #include "bench.h"
 
 #include <unistd.h>
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index b80f29b..00db995 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -27,7 +27,6 @@
 #include "jit.h"
 #include "jitdump.h"
 #include "genelf.h"
-#include "../builtin.h"
 
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
