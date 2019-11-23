Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB4C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D917420870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKWIPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfKWIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZI-0002W8-Ce; Sat, 23 Nov 2019 09:15:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E75891C1ACC;
        Sat, 23 Nov 2019 09:14:59 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:14:59 -0000
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Fix spelling mistake "addrees" -> "address"
Cc:     Colin King <colin.king@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121092623.374896-1-colin.king@canonical.com>
References: <20191121092623.374896-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <157449689986.21853.15487968552772349737.tip-bot2@tip-bot2>
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

Commit-ID:     358f98ee8a3578bbf464ac767b726c5de1ce0647
Gitweb:        https://git.kernel.org/tip/358f98ee8a3578bbf464ac767b726c5de1ce0647
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 21 Nov 2019 09:26:23 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:14 -03:00

perf probe: Fix spelling mistake "addrees" -> "address"

There is a spelling mistake in a pr_warning message. Fix it.

Signed-off-by: Colin King <colin.king@canonical.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lore.kernel.org/lkml/20191121092623.374896-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 38d6cd2..c470c49 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -812,7 +812,7 @@ static int verify_representive_line(struct probe_finder *pf, const char *fname,
 	if (strcmp(fname, __fname) || lineno == __lineno)
 		return 0;
 
-	pr_warning("This line is sharing the addrees with other lines.\n");
+	pr_warning("This line is sharing the address with other lines.\n");
 
 	if (pf->pev->point.function) {
 		/* Find best match function name and lines */
