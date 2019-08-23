Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0E4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F6521848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394601AbfHWMYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:24:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35251 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732669AbfHWMYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:24:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18bw-0001pf-Gv; Fri, 23 Aug 2019 14:24:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2B2391C089A;
        Fri, 23 Aug 2019 14:24:08 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:24:07 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf script: Add missing counts.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-q4shpvlxyjqz7val1hyrdak9@git.kernel.org>
References: <tip-q4shpvlxyjqz7val1hyrdak9@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656304788.32107.3827521293276224992.tip-bot2@tip-bot2>
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

Commit-ID:     0f31c0195c14cc37b2f2a08e3f4219d69faa1b34
Gitweb:        https://git.kernel.org/tip/0f31c0195c14cc37b2f2a08e3f4219d69faa1b34
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 21 Aug 2019 14:00:17 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:56 -03:00

perf script: Add missing counts.h

It is getting this via evsel.h, that don't strictly need counts.h, just
forward declarations for some structs, so add it here before we remove
it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q4shpvlxyjqz7val1hyrdak9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1764efd..e957b87 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3,6 +3,7 @@
 
 #include "perf.h"
 #include "util/cache.h"
+#include "util/counts.h"
 #include "util/debug.h"
 #include <subcmd/exec-cmd.h>
 #include "util/header.h"
