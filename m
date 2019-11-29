Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF01C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DC12176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK2GDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48072 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfK2GDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMm-0008IT-R2; Fri, 29 Nov 2019 07:02:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8B9F51C20BF;
        Fri, 29 Nov 2019 07:02:51 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tests: Rename thread-mg-share to thread-maps-share
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-naxsl3g4ou3fyxb8l8e0pn5e@git.kernel.org>
References: <tip-naxsl3g4ou3fyxb8l8e0pn5e@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737145.21853.15418299552976854211.tip-bot2@tip-bot2>
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

Commit-ID:     6d38267cf996bafdbc99eda6ad8c406fc3dcec93
Gitweb:        https://git.kernel.org/tip/6d38267cf996bafdbc99eda6ad8c406fc3dcec93
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 25 Nov 2019 22:29:18 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

perf tests: Rename thread-mg-share to thread-maps-share

One more step in merging 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-naxsl3g4ou3fyxb8l8e0pn5e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build               |  2 +-
 tools/perf/tests/builtin-test.c      |  4 +-
 tools/perf/tests/tests.h             |  2 +-
 tools/perf/tests/thread-maps-share.c | 98 +++++++++++++++++++++++++++-
 tools/perf/tests/thread-mg-share.c   | 98 +---------------------------
 5 files changed, 102 insertions(+), 102 deletions(-)
 create mode 100644 tools/perf/tests/thread-maps-share.c
 delete mode 100644 tools/perf/tests/thread-mg-share.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index e72acce..5b9b0a8 100644
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
index 8b286e9..3a4b983 100644
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
index 9837b6e..f2b9bb0 100644
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
diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
new file mode 100644
index 0000000..9371484
--- /dev/null
+++ b/tools/perf/tests/thread-maps-share.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests.h"
+#include "machine.h"
+#include "thread.h"
+#include "debug.h"
+
+int test__thread_maps_share(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct machines machines;
+	struct machine *machine;
+
+	/* thread group */
+	struct thread *leader;
+	struct thread *t1, *t2, *t3;
+	struct maps *maps;
+
+	/* other process */
+	struct thread *other, *other_leader;
+	struct maps *other_maps;
+
+	/*
+	 * This test create 2 processes abstractions (struct thread)
+	 * with several threads and checks they properly share and
+	 * maintain maps info (struct maps).
+	 *
+	 * thread group (pid: 0, tids: 0, 1, 2, 3)
+	 * other  group (pid: 4, tids: 4, 5)
+	*/
+
+	machines__init(&machines);
+	machine = &machines.host;
+
+	/* create process with 4 threads */
+	leader = machine__findnew_thread(machine, 0, 0);
+	t1     = machine__findnew_thread(machine, 0, 1);
+	t2     = machine__findnew_thread(machine, 0, 2);
+	t3     = machine__findnew_thread(machine, 0, 3);
+
+	/* and create 1 separated process, without thread leader */
+	other  = machine__findnew_thread(machine, 4, 5);
+
+	TEST_ASSERT_VAL("failed to create threads",
+			leader && t1 && t2 && t3 && other);
+
+	maps = leader->maps;
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 4);
+
+	/* test the maps pointer is shared */
+	TEST_ASSERT_VAL("maps don't match", maps == t1->maps);
+	TEST_ASSERT_VAL("maps don't match", maps == t2->maps);
+	TEST_ASSERT_VAL("maps don't match", maps == t3->maps);
+
+	/*
+	 * Verify the other leader was created by previous call.
+	 * It should have shared maps with no change in
+	 * refcnt.
+	 */
+	other_leader = machine__find_thread(machine, 4, 4);
+	TEST_ASSERT_VAL("failed to find other leader", other_leader);
+
+	/*
+	 * Ok, now that all the rbtree related operations were done,
+	 * lets remove all of them from there so that we can do the
+	 * refcounting tests.
+	 */
+	machine__remove_thread(machine, leader);
+	machine__remove_thread(machine, t1);
+	machine__remove_thread(machine, t2);
+	machine__remove_thread(machine, t3);
+	machine__remove_thread(machine, other);
+	machine__remove_thread(machine, other_leader);
+
+	other_maps = other->maps;
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_maps->refcnt), 2);
+
+	TEST_ASSERT_VAL("maps don't match", other_maps == other_leader->maps);
+
+	/* release thread group */
+	thread__put(leader);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 3);
+
+	thread__put(t1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 2);
+
+	thread__put(t2);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 1);
+
+	thread__put(t3);
+
+	/* release other group  */
+	thread__put(other_leader);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_maps->refcnt), 1);
+
+	thread__put(other);
+
+	machines__exit(&machines);
+	return 0;
+}
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
deleted file mode 100644
index e3b0d69..0000000
--- a/tools/perf/tests/thread-mg-share.c
+++ /dev/null
@@ -1,98 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "tests.h"
-#include "machine.h"
-#include "thread.h"
-#include "debug.h"
-
-int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_unused)
-{
-	struct machines machines;
-	struct machine *machine;
-
-	/* thread group */
-	struct thread *leader;
-	struct thread *t1, *t2, *t3;
-	struct maps *maps;
-
-	/* other process */
-	struct thread *other, *other_leader;
-	struct maps *other_mg;
-
-	/*
-	 * This test create 2 processes abstractions (struct thread)
-	 * with several threads and checks they properly share and
-	 * maintain maps info (struct maps).
-	 *
-	 * thread group (pid: 0, tids: 0, 1, 2, 3)
-	 * other  group (pid: 4, tids: 4, 5)
-	*/
-
-	machines__init(&machines);
-	machine = &machines.host;
-
-	/* create process with 4 threads */
-	leader = machine__findnew_thread(machine, 0, 0);
-	t1     = machine__findnew_thread(machine, 0, 1);
-	t2     = machine__findnew_thread(machine, 0, 2);
-	t3     = machine__findnew_thread(machine, 0, 3);
-
-	/* and create 1 separated process, without thread leader */
-	other  = machine__findnew_thread(machine, 4, 5);
-
-	TEST_ASSERT_VAL("failed to create threads",
-			leader && t1 && t2 && t3 && other);
-
-	maps = leader->maps;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 4);
-
-	/* test the map groups pointer is shared */
-	TEST_ASSERT_VAL("map groups don't match", maps == t1->maps);
-	TEST_ASSERT_VAL("map groups don't match", maps == t2->maps);
-	TEST_ASSERT_VAL("map groups don't match", maps == t3->maps);
-
-	/*
-	 * Verify the other leader was created by previous call.
-	 * It should have shared map groups with no change in
-	 * refcnt.
-	 */
-	other_leader = machine__find_thread(machine, 4, 4);
-	TEST_ASSERT_VAL("failed to find other leader", other_leader);
-
-	/*
-	 * Ok, now that all the rbtree related operations were done,
-	 * lets remove all of them from there so that we can do the
-	 * refcounting tests.
-	 */
-	machine__remove_thread(machine, leader);
-	machine__remove_thread(machine, t1);
-	machine__remove_thread(machine, t2);
-	machine__remove_thread(machine, t3);
-	machine__remove_thread(machine, other);
-	machine__remove_thread(machine, other_leader);
-
-	other_mg = other->maps;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 2);
-
-	TEST_ASSERT_VAL("map groups don't match", other_mg == other_leader->maps);
-
-	/* release thread group */
-	thread__put(leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 3);
-
-	thread__put(t1);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 2);
-
-	thread__put(t2);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 1);
-
-	thread__put(t3);
-
-	/* release other group  */
-	thread__put(other_leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 1);
-
-	thread__put(other);
-
-	machines__exit(&machines);
-	return 0;
-}
