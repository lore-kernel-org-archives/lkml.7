Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C37C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B69B2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121799;
	bh=/jikZdqg9KRirWSKO1FieiI4jJaKPP4l9tb8U2nvelY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f5vBpwJFS3u9XargD8xqQqs7paiXg3OmcaokaWy670FJwv01WFXftVDu+tbeBGGoN
	 HhSpKAoWCoZTxcq284vzwhMJr60SAKpOJ2Y5nzypz8Cga0aaO/oAzLXw/lVuec5mLX
	 8y1yO4wpBClEr7rx/hDyY51Dl593AeG/7rD0lg7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfEQTgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfEQTgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:36:37 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5CA21734;
        Fri, 17 May 2019 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121796;
        bh=/jikZdqg9KRirWSKO1FieiI4jJaKPP4l9tb8U2nvelY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SB0CMCTL0KdycgrtezMqxWd+PlBpMRM4bSygOYA+Uo6VIidIvfW2AqpqQm7j+d5DS
         0RuaBPGHM3KzN3wKqI8r42FoRP5w3N7aAXxwn0Z8vtkFvAANP/gWxorfiVbwNr4CxO
         oOglZHunxq2TajcwZMLVsV79R0QC7CcPzFcuu+ak=
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
Subject: [PATCH 02/73] perf test: Fix spelling mistake "leadking" -> "leaking"
Date:   Fri, 17 May 2019 16:35:00 -0300
Message-Id: <20190517193611.4974-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes in test assert messages. Fix them.

Signed-off-by: Colin King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/20190417105539.5902-1-colin.king@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/dso-data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 7f6c52021e41..946ab4b63acd 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -304,7 +304,7 @@ int test__dso_data_cache(struct test *test __maybe_unused, int subtest __maybe_u
 	/* Make sure we did not leak any file descriptor. */
 	nr_end = open_files_cnt();
 	pr_debug("nr start %ld, nr stop %ld\n", nr, nr_end);
-	TEST_ASSERT_VAL("failed leadking files", nr == nr_end);
+	TEST_ASSERT_VAL("failed leaking files", nr == nr_end);
 	return 0;
 }
 
@@ -380,6 +380,6 @@ int test__dso_data_reopen(struct test *test __maybe_unused, int subtest __maybe_
 	/* Make sure we did not leak any file descriptor. */
 	nr_end = open_files_cnt();
 	pr_debug("nr start %ld, nr stop %ld\n", nr, nr_end);
-	TEST_ASSERT_VAL("failed leadking files", nr == nr_end);
+	TEST_ASSERT_VAL("failed leaking files", nr == nr_end);
 	return 0;
 }
-- 
2.20.1

