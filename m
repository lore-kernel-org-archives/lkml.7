Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32375C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C1A20C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405318AbfITQVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:21:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52886 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405006AbfITQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLeT-00040h-PV; Fri, 20 Sep 2019 18:20:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 382C41C0E2A;
        Fri, 20 Sep 2019 18:20:57 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:57 -0000
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf test: Fix spelling mistake "allos" -> "allocate"
Cc:     Colin King <colin.king@canonical.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190911152148.17031-1-colin.king@canonical.com>
References: <20190911152148.17031-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <156899645716.24167.3109929081723398408.tip-bot2@tip-bot2>
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

Commit-ID:     ce095c9ac293d1683f9fedb214811727dff0d508
Gitweb:        https://git.kernel.org/tip/ce095c9ac293d1683f9fedb214811727dff0d508
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Wed, 11 Sep 2019 16:21:48 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 10:28:26 -03:00

perf test: Fix spelling mistake "allos" -> "allocate"

There is a spelling mistake in a TEST_ASSERT_VAL message. Fix it.

Signed-off-by: Colin King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lore.kernel.org/lkml/20190911152148.17031-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/event_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 4bb772e..0497d90 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -94,7 +94,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("failed to allos ids",
+	TEST_ASSERT_VAL("failed to allocate ids",
 			!perf_evsel__alloc_id(evsel, 1, 1));
 
 	perf_evlist__id_add(evlist, evsel, 0, 0, 123);
