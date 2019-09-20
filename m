Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF777C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AA220882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989661;
	bh=3J5wac/rahe28jHoGn9pmTv4WzTqKg0kU8cqewNX+5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MFqjYwAmG2lF2X+VS2inFj2dbQDBni5DIt5YvRtvcllqxGcIria+RKlqYhcHLfDm3
	 Xo1EByOexMbV5a8NtUfTp8PyDrwN3r5jHmUccMVKsCySJv0tI0i5K2yKfflPyZfI7+
	 EmBOI8QT0cUvmmx/rImxK67iYu/TMzCZY/Ve2FZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbfITO1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389636AbfITO1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:27:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B614A2080F;
        Fri, 20 Sep 2019 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989631;
        bh=3J5wac/rahe28jHoGn9pmTv4WzTqKg0kU8cqewNX+5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBNwxBAh9WJshZJAM/G/EJUeYDuLc8U20duLM0GBYIONZNZXJGtY0W0eGiLorwWUP
         iHH+uA/h3+kr00fsSUSUQwknIYTE79sC5cR0g1MUbB5CQJU3gNqmp2XJqFRocBD0v9
         iL8pvaJM+L1yJn9zHLl1C6AbMNHH3VQDxjkjpldg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/31] perf test: Fix spelling mistake "allos" -> "allocate"
Date:   Fri, 20 Sep 2019 11:25:39 -0300
Message-Id: <20190920142542.12047-29-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

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
index 4bb772e2b73d..0497d900ced2 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -94,7 +94,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	evsel = perf_evlist__first(evlist);
 
-	TEST_ASSERT_VAL("failed to allos ids",
+	TEST_ASSERT_VAL("failed to allocate ids",
 			!perf_evsel__alloc_id(evsel, 1, 1));
 
 	perf_evlist__id_add(evlist, evsel, 0, 0, 123);
-- 
2.21.0

