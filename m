Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44673C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158E820872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OSK7gWVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfERIrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:47:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46157 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:47:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8l4Nl1731520
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:47:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8l4Nl1731520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169225;
        bh=MzG24w1Ds+qwd5+emzRQrCGqRSwsQ3w+jPWHYI92HcY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OSK7gWVWaXXBD4dTbdEvleaRFACHKTkJOeShxl82LwoaV/43K+JSoUDfIDZng/iaz
         nxvk0iE171IjSIQN4u2PaGVatp+xN/L+tLSd3gxlY33afuyZMy3928KYh3YnW0RrE2
         KqzJI2rNzRyNL4Br+0gkbGjS7r/FrZuB+H6+gsLvtRoJYqfPPqiACJ/mZ6jOqBOlGu
         De5bzjMEv0/PXErW0FSqNO3jPblypasApucWTL2cbwx/rBXnTh1j+NDd1TW2KEFkU7
         wgZWIRvJyDiXf0QMGE1OiEvknYYo3wsKjqCOJiYo7Lobm7xTlYmrBYl51vRxOHxk/7
         jHftBLJZSEsZw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8l3Io1731517;
        Sat, 18 May 2019 01:47:03 -0700
Date:   Sat, 18 May 2019 01:47:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-1455ea2391be5a5bf0a53258af94fa2abbd73cca@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        hpa@zytor.com, namhyung@kernel.org, peterz@infradead.org,
        acme@redhat.com, colin.king@canonical.com, mojha@codeaurora.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org
Reply-To: jolsa@redhat.com, tglx@linutronix.de, mojha@codeaurora.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, acme@redhat.com, colin.king@canonical.com,
          namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190417105539.5902-1-colin.king@canonical.com>
References: <20190417105539.5902-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Fix spelling mistake "leadking" ->
 "leaking"
Git-Commit-ID: 1455ea2391be5a5bf0a53258af94fa2abbd73cca
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1455ea2391be5a5bf0a53258af94fa2abbd73cca
Gitweb:     https://git.kernel.org/tip/1455ea2391be5a5bf0a53258af94fa2abbd73cca
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Wed, 17 Apr 2019 11:55:39 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

perf test: Fix spelling mistake "leadking" -> "leaking"

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
