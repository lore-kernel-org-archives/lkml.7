Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87D3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CC62082E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfK2GEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:04:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfK2GDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMm-0008IM-Mb; Fri, 29 Nov 2019 07:02:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5FDD11C1D25;
        Fri, 29 Nov 2019 07:02:51 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tests: Rename tests/map_groups.c to tests/maps.c
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-bw6aagubqxc47m54k2maezfu@git.kernel.org>
References: <tip-bw6aagubqxc47m54k2maezfu@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737129.21853.5454737946825912101.tip-bot2@tip-bot2>
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

Commit-ID:     a5732681e0e6ea0c3024f9d23bcf99b9237189ee
Gitweb:        https://git.kernel.org/tip/a5732681e0e6ea0c3024f9d23bcf99b9237189ee
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 25 Nov 2019 22:33:02 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

perf tests: Rename tests/map_groups.c to tests/maps.c

One more step in mergint the maps and map_groups structs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bw6aagubqxc47m54k2maezfu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |   2 +-
 tools/perf/tests/builtin-test.c |   4 +-
 tools/perf/tests/map_groups.c   | 120 +-------------------------------
 tools/perf/tests/maps.c         | 120 +++++++++++++++++++++++++++++++-
 tools/perf/tests/tests.h        |   2 +-
 5 files changed, 124 insertions(+), 124 deletions(-)
 delete mode 100644 tools/perf/tests/map_groups.c
 create mode 100644 tools/perf/tests/maps.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5b9b0a8..a3c595f 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -52,7 +52,7 @@ perf-y += perf-hooks.o
 perf-y += clang.o
 perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
-perf-y += map_groups.o
+perf-y += maps.o
 perf-y += time-utils-test.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3a4b983..7115aa3 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -297,8 +297,8 @@ static struct test generic_tests[] = {
 		.func = test__time_utils,
 	},
 	{
-		.desc = "map_groups__merge_in",
-		.func = test__map_groups__merge_in,
+		.desc = "maps__merge_in",
+		.func = test__maps__merge_in,
 	},
 	{
 		.func = NULL,
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
deleted file mode 100644
index 7febd02..0000000
--- a/tools/perf/tests/map_groups.c
+++ /dev/null
@@ -1,120 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include "tests.h"
-#include "map.h"
-#include "maps.h"
-#include "dso.h"
-#include "debug.h"
-
-struct map_def {
-	const char *name;
-	u64 start;
-	u64 end;
-};
-
-static int check_maps(struct map_def *merged, unsigned int size, struct maps *maps)
-{
-	struct map *map;
-	unsigned int i = 0;
-
-	maps__for_each_entry(maps, map) {
-		if (i > 0)
-			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
-
-		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
-		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
-		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
-		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
-
-		i++;
-	}
-
-	return TEST_OK;
-}
-
-int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
-{
-	struct maps maps;
-	unsigned int i;
-	struct map_def bpf_progs[] = {
-		{ "bpf_prog_1", 200, 300 },
-		{ "bpf_prog_2", 500, 600 },
-		{ "bpf_prog_3", 800, 900 },
-	};
-	struct map_def merged12[] = {
-		{ "kcore1",     100,  200 },
-		{ "bpf_prog_1", 200,  300 },
-		{ "kcore1",     300,  500 },
-		{ "bpf_prog_2", 500,  600 },
-		{ "kcore1",     600,  800 },
-		{ "bpf_prog_3", 800,  900 },
-		{ "kcore1",     900, 1000 },
-	};
-	struct map_def merged3[] = {
-		{ "kcore1",      100,  200 },
-		{ "bpf_prog_1",  200,  300 },
-		{ "kcore1",      300,  500 },
-		{ "bpf_prog_2",  500,  600 },
-		{ "kcore1",      600,  800 },
-		{ "bpf_prog_3",  800,  900 },
-		{ "kcore1",      900, 1000 },
-		{ "kcore3",     1000, 1100 },
-	};
-	struct map *map_kcore1, *map_kcore2, *map_kcore3;
-	int ret;
-
-	maps__init(&maps, NULL);
-
-	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
-		struct map *map;
-
-		map = dso__new_map(bpf_progs[i].name);
-		TEST_ASSERT_VAL("failed to create map", map);
-
-		map->start = bpf_progs[i].start;
-		map->end   = bpf_progs[i].end;
-		maps__insert(&maps, map);
-		map__put(map);
-	}
-
-	map_kcore1 = dso__new_map("kcore1");
-	TEST_ASSERT_VAL("failed to create map", map_kcore1);
-
-	map_kcore2 = dso__new_map("kcore2");
-	TEST_ASSERT_VAL("failed to create map", map_kcore2);
-
-	map_kcore3 = dso__new_map("kcore3");
-	TEST_ASSERT_VAL("failed to create map", map_kcore3);
-
-	/* kcore1 map overlaps over all bpf maps */
-	map_kcore1->start = 100;
-	map_kcore1->end   = 1000;
-
-	/* kcore2 map hides behind bpf_prog_2 */
-	map_kcore2->start = 550;
-	map_kcore2->end   = 570;
-
-	/* kcore3 map hides behind bpf_prog_3, kcore1 and adds new map */
-	map_kcore3->start = 880;
-	map_kcore3->end   = 1100;
-
-	ret = maps__merge_in(&maps, map_kcore1);
-	TEST_ASSERT_VAL("failed to merge map", !ret);
-
-	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
-	TEST_ASSERT_VAL("merge check failed", !ret);
-
-	ret = maps__merge_in(&maps, map_kcore2);
-	TEST_ASSERT_VAL("failed to merge map", !ret);
-
-	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
-	TEST_ASSERT_VAL("merge check failed", !ret);
-
-	ret = maps__merge_in(&maps, map_kcore3);
-	TEST_ASSERT_VAL("failed to merge map", !ret);
-
-	ret = check_maps(merged3, ARRAY_SIZE(merged3), &maps);
-	TEST_ASSERT_VAL("merge check failed", !ret);
-	return TEST_OK;
-}
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
new file mode 100644
index 0000000..edcbc70
--- /dev/null
+++ b/tools/perf/tests/maps.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include "tests.h"
+#include "map.h"
+#include "maps.h"
+#include "dso.h"
+#include "debug.h"
+
+struct map_def {
+	const char *name;
+	u64 start;
+	u64 end;
+};
+
+static int check_maps(struct map_def *merged, unsigned int size, struct maps *maps)
+{
+	struct map *map;
+	unsigned int i = 0;
+
+	maps__for_each_entry(maps, map) {
+		if (i > 0)
+			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
+
+		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
+		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
+		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
+		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
+
+		i++;
+	}
+
+	return TEST_OK;
+}
+
+int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
+{
+	struct maps maps;
+	unsigned int i;
+	struct map_def bpf_progs[] = {
+		{ "bpf_prog_1", 200, 300 },
+		{ "bpf_prog_2", 500, 600 },
+		{ "bpf_prog_3", 800, 900 },
+	};
+	struct map_def merged12[] = {
+		{ "kcore1",     100,  200 },
+		{ "bpf_prog_1", 200,  300 },
+		{ "kcore1",     300,  500 },
+		{ "bpf_prog_2", 500,  600 },
+		{ "kcore1",     600,  800 },
+		{ "bpf_prog_3", 800,  900 },
+		{ "kcore1",     900, 1000 },
+	};
+	struct map_def merged3[] = {
+		{ "kcore1",      100,  200 },
+		{ "bpf_prog_1",  200,  300 },
+		{ "kcore1",      300,  500 },
+		{ "bpf_prog_2",  500,  600 },
+		{ "kcore1",      600,  800 },
+		{ "bpf_prog_3",  800,  900 },
+		{ "kcore1",      900, 1000 },
+		{ "kcore3",     1000, 1100 },
+	};
+	struct map *map_kcore1, *map_kcore2, *map_kcore3;
+	int ret;
+
+	maps__init(&maps, NULL);
+
+	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
+		struct map *map;
+
+		map = dso__new_map(bpf_progs[i].name);
+		TEST_ASSERT_VAL("failed to create map", map);
+
+		map->start = bpf_progs[i].start;
+		map->end   = bpf_progs[i].end;
+		maps__insert(&maps, map);
+		map__put(map);
+	}
+
+	map_kcore1 = dso__new_map("kcore1");
+	TEST_ASSERT_VAL("failed to create map", map_kcore1);
+
+	map_kcore2 = dso__new_map("kcore2");
+	TEST_ASSERT_VAL("failed to create map", map_kcore2);
+
+	map_kcore3 = dso__new_map("kcore3");
+	TEST_ASSERT_VAL("failed to create map", map_kcore3);
+
+	/* kcore1 map overlaps over all bpf maps */
+	map_kcore1->start = 100;
+	map_kcore1->end   = 1000;
+
+	/* kcore2 map hides behind bpf_prog_2 */
+	map_kcore2->start = 550;
+	map_kcore2->end   = 570;
+
+	/* kcore3 map hides behind bpf_prog_3, kcore1 and adds new map */
+	map_kcore3->start = 880;
+	map_kcore3->end   = 1100;
+
+	ret = maps__merge_in(&maps, map_kcore1);
+	TEST_ASSERT_VAL("failed to merge map", !ret);
+
+	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
+	TEST_ASSERT_VAL("merge check failed", !ret);
+
+	ret = maps__merge_in(&maps, map_kcore2);
+	TEST_ASSERT_VAL("failed to merge map", !ret);
+
+	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
+	TEST_ASSERT_VAL("merge check failed", !ret);
+
+	ret = maps__merge_in(&maps, map_kcore3);
+	TEST_ASSERT_VAL("failed to merge map", !ret);
+
+	ret = check_maps(merged3, ARRAY_SIZE(merged3), &maps);
+	TEST_ASSERT_VAL("merge check failed", !ret);
+	return TEST_OK;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f2b9bb0..25aea38 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -107,7 +107,7 @@ const char *test__clang_subtest_get_desc(int subtest);
 int test__clang_subtest_get_nr(void);
 int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
-int test__map_groups__merge_in(struct test *t, int subtest);
+int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
