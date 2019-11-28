Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE91EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABFE216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948486;
	bh=xsR6tF/LxKIaQ043g+ny47WVZx0E16iDscB9VAN2eWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z58Izm9yBCgXui2bnIFsAoEQgo+QxtHO5Fe/qTed6bstcIXYKjTgmhEi2wN9I2BUv
	 zZmYm8ykeeNFXsCQBDEAHDgpJ+LSyfS1mGSBFzWxqwPqW1CrpFzRfrro/uNI2N2Up/
	 aAfi7IUPEo+H9xEqj78wS9PoXlMOSgDdHgyONA8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfK1NlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfK1NlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E567421789;
        Thu, 28 Nov 2019 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948476;
        bh=xsR6tF/LxKIaQ043g+ny47WVZx0E16iDscB9VAN2eWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBpeEKXmPFLLynWIzG6fBrkEx0pQKTj1YBzusA6ENncrCmRw7idPw6wmHIA8NzTji
         KP766KNbdWsrsHKA/dzM94VvSIOgfOlRHaJd7/g/DeAcZx/VBsBTiqiS75T52jdyTx
         NyPE8v0xbTSV96Tm3Yqa1l+VZ+QVcvjLbd6lpOBg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 13/22] perf tests: Rename thread-mg-share to thread-maps-share
Date:   Thu, 28 Nov 2019 10:40:18 -0300
Message-Id: <20191128134027.23726-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step in merging 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-naxsl3g4ou3fyxb8l8e0pn5e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build                        |  2 +-
 tools/perf/tests/builtin-test.c               |  4 ++--
 tools/perf/tests/tests.h                      |  2 +-
 ...{thread-mg-share.c => thread-maps-share.c} | 22 +++++++++----------
 4 files changed, 15 insertions(+), 15 deletions(-)
 rename tools/perf/tests/{thread-mg-share.c => thread-maps-share.c} (77%)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index e72accefd669..5b9b0a813916 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -27,7 +27,7 @@ perf-y += wp.o
 perf-y += task-exit.o
 perf-y += sw-clock.o
 perf-y += mmap-thread-lookup.o
-perf-y += thread-mg-share.o
+perf-y += thread-maps-share.o
 perf-y += switch-tracking.o
 perf-y += keep-tracking.o
 perf-y += code-reading.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8b286e9b7549..3a4b9837b54d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -166,8 +166,8 @@ static struct test generic_tests[] = {
 		.func = test__mmap_thread_lookup,
 	},
 	{
-		.desc = "Share thread mg",
-		.func = test__thread_mg_share,
+		.desc = "Share thread maps",
+		.func = test__thread_maps_share,
 	},
 	{
 		.desc = "Sort output of hist entries",
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9837b6e93023..f2b9bb024746 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -73,7 +73,7 @@ int test__dwarf_unwind(struct test *test, int subtest);
 int test__expr(struct test *test, int subtest);
 int test__hists_filter(struct test *test, int subtest);
 int test__mmap_thread_lookup(struct test *test, int subtest);
-int test__thread_mg_share(struct test *test, int subtest);
+int test__thread_maps_share(struct test *test, int subtest);
 int test__hists_output(struct test *test, int subtest);
 int test__hists_cumulate(struct test *test, int subtest);
 int test__switch_tracking(struct test *test, int subtest);
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-maps-share.c
similarity index 77%
rename from tools/perf/tests/thread-mg-share.c
rename to tools/perf/tests/thread-maps-share.c
index e3b0d692d565..9371484973f2 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -4,7 +4,7 @@
 #include "thread.h"
 #include "debug.h"
 
-int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_unused)
+int test__thread_maps_share(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machines machines;
 	struct machine *machine;
@@ -16,7 +16,7 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 
 	/* other process */
 	struct thread *other, *other_leader;
-	struct maps *other_mg;
+	struct maps *other_maps;
 
 	/*
 	 * This test create 2 processes abstractions (struct thread)
@@ -45,14 +45,14 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	maps = leader->maps;
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 4);
 
-	/* test the map groups pointer is shared */
-	TEST_ASSERT_VAL("map groups don't match", maps == t1->maps);
-	TEST_ASSERT_VAL("map groups don't match", maps == t2->maps);
-	TEST_ASSERT_VAL("map groups don't match", maps == t3->maps);
+	/* test the maps pointer is shared */
+	TEST_ASSERT_VAL("maps don't match", maps == t1->maps);
+	TEST_ASSERT_VAL("maps don't match", maps == t2->maps);
+	TEST_ASSERT_VAL("maps don't match", maps == t3->maps);
 
 	/*
 	 * Verify the other leader was created by previous call.
-	 * It should have shared map groups with no change in
+	 * It should have shared maps with no change in
 	 * refcnt.
 	 */
 	other_leader = machine__find_thread(machine, 4, 4);
@@ -70,10 +70,10 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	machine__remove_thread(machine, other);
 	machine__remove_thread(machine, other_leader);
 
-	other_mg = other->maps;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 2);
+	other_maps = other->maps;
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_maps->refcnt), 2);
 
-	TEST_ASSERT_VAL("map groups don't match", other_mg == other_leader->maps);
+	TEST_ASSERT_VAL("maps don't match", other_maps == other_leader->maps);
 
 	/* release thread group */
 	thread__put(leader);
@@ -89,7 +89,7 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 
 	/* release other group  */
 	thread__put(other_leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_maps->refcnt), 1);
 
 	thread__put(other);
 
-- 
2.21.0

