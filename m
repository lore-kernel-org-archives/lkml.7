Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2261CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D832820869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfK2GDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48053 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfK2GDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMk-0008Js-1E; Fri, 29 Nov 2019 07:02:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E99D31C2105;
        Fri, 29 Nov 2019 07:02:51 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf maps: Rename 'mg' variables to 'maps'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-z8d14wrw393a0fbvmnk1bqd9@git.kernel.org>
References: <tip-z8d14wrw393a0fbvmnk1bqd9@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737185.21853.2558503036961855494.tip-bot2@tip-bot2>
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

Commit-ID:     9a29ceee6bb14aeb58ab2222c8e792576fe90fb8
Gitweb:        https://git.kernel.org/tip/9a29ceee6bb14aeb58ab2222c8e792576fe90fb8
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 25 Nov 2019 22:21:28 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

perf maps: Rename 'mg' variables to 'maps'

Continuing the merge of 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-z8d14wrw393a0fbvmnk1bqd9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/map_groups.c            | 18 ++---
 tools/perf/tests/thread-mg-share.c       | 18 ++---
 tools/perf/util/event.c                  | 12 +--
 tools/perf/util/machine.c                | 10 +--
 tools/perf/util/map.c                    | 89 +++++++++++------------
 tools/perf/util/map_groups.h             | 36 ++++-----
 tools/perf/util/symbol.c                 | 44 +++++------
 tools/perf/util/symbol.h                 |  2 +-
 tools/perf/util/unwind-libunwind-local.c | 16 ++--
 tools/perf/util/unwind-libunwind.c       | 30 ++++----
 10 files changed, 135 insertions(+), 140 deletions(-)

diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index db806e5..9df1d14 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -35,7 +35,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 
 int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
-	struct maps mg;
+	struct maps maps;
 	unsigned int i;
 	struct map_def bpf_progs[] = {
 		{ "bpf_prog_1", 200, 300 },
@@ -64,7 +64,7 @@ int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __mayb
 	struct map *map_kcore1, *map_kcore2, *map_kcore3;
 	int ret;
 
-	maps__init(&mg, NULL);
+	maps__init(&maps, NULL);
 
 	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
 		struct map *map;
@@ -74,7 +74,7 @@ int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __mayb
 
 		map->start = bpf_progs[i].start;
 		map->end   = bpf_progs[i].end;
-		maps__insert(&mg, map);
+		maps__insert(&maps, map);
 		map__put(map);
 	}
 
@@ -99,22 +99,22 @@ int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __mayb
 	map_kcore3->start = 880;
 	map_kcore3->end   = 1100;
 
-	ret = maps__merge_in(&mg, map_kcore1);
+	ret = maps__merge_in(&maps, map_kcore1);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
-	ret = check_maps(merged12, ARRAY_SIZE(merged12), &mg);
+	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	ret = maps__merge_in(&mg, map_kcore2);
+	ret = maps__merge_in(&maps, map_kcore2);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
-	ret = check_maps(merged12, ARRAY_SIZE(merged12), &mg);
+	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	ret = maps__merge_in(&mg, map_kcore3);
+	ret = maps__merge_in(&maps, map_kcore3);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
-	ret = check_maps(merged3, ARRAY_SIZE(merged3), &mg);
+	ret = check_maps(merged3, ARRAY_SIZE(merged3), &maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 	return TEST_OK;
 }
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
index 6032061..e3b0d69 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-mg-share.c
@@ -12,7 +12,7 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	/* thread group */
 	struct thread *leader;
 	struct thread *t1, *t2, *t3;
-	struct maps *mg;
+	struct maps *maps;
 
 	/* other process */
 	struct thread *other, *other_leader;
@@ -42,13 +42,13 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	TEST_ASSERT_VAL("failed to create threads",
 			leader && t1 && t2 && t3 && other);
 
-	mg = leader->maps;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 4);
+	maps = leader->maps;
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 4);
 
 	/* test the map groups pointer is shared */
-	TEST_ASSERT_VAL("map groups don't match", mg == t1->maps);
-	TEST_ASSERT_VAL("map groups don't match", mg == t2->maps);
-	TEST_ASSERT_VAL("map groups don't match", mg == t3->maps);
+	TEST_ASSERT_VAL("map groups don't match", maps == t1->maps);
+	TEST_ASSERT_VAL("map groups don't match", maps == t2->maps);
+	TEST_ASSERT_VAL("map groups don't match", maps == t3->maps);
 
 	/*
 	 * Verify the other leader was created by previous call.
@@ -77,13 +77,13 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 
 	/* release thread group */
 	thread__put(leader);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 3);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 3);
 
 	thread__put(t1);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 2);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 2);
 
 	thread__put(t2);
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 1);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&maps->refcnt), 1);
 
 	thread__put(t3);
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fc3da38..c5447ff 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -457,11 +457,11 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al)
 {
-	struct maps *mg = thread->maps;
-	struct machine *machine = mg->machine;
+	struct maps *maps = thread->maps;
+	struct machine *machine = maps->machine;
 	bool load_map = false;
 
-	al->maps = mg;
+	al->maps = maps;
 	al->thread = thread;
 	al->addr = addr;
 	al->cpumode = cpumode;
@@ -474,13 +474,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
-		al->maps = mg = &machine->kmaps;
+		al->maps = maps = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
-		al->maps = mg = &machine->kmaps;
+		al->maps = maps = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
@@ -500,7 +500,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		return NULL;
 	}
 
-	al->map = maps__find(mg, al->addr);
+	al->map = maps__find(maps, al->addr);
 	if (al->map != NULL) {
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c1ae5e6..416d174 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1259,10 +1259,10 @@ static bool is_kmod_dso(struct dso *dso)
 	       dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE;
 }
 
-static int maps__set_module_path(struct maps *mg, const char *path, struct kmod_path *m)
+static int maps__set_module_path(struct maps *maps, const char *path, struct kmod_path *m)
 {
 	char *long_name;
-	struct map *map = maps__find_by_name(mg, m->name);
+	struct map *map = maps__find_by_name(maps, m->name);
 
 	if (map == NULL)
 		return 0;
@@ -1286,7 +1286,7 @@ static int maps__set_module_path(struct maps *mg, const char *path, struct kmod_
 	return 0;
 }
 
-static int maps__set_modules_path_dir(struct maps *mg, const char *dir_name, int depth)
+static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, int depth)
 {
 	struct dirent *dent;
 	DIR *dir = opendir(dir_name);
@@ -1318,7 +1318,7 @@ static int maps__set_modules_path_dir(struct maps *mg, const char *dir_name, int
 					continue;
 			}
 
-			ret = maps__set_modules_path_dir(mg, path, depth + 1);
+			ret = maps__set_modules_path_dir(maps, path, depth + 1);
 			if (ret < 0)
 				goto out;
 		} else {
@@ -1329,7 +1329,7 @@ static int maps__set_modules_path_dir(struct maps *mg, const char *dir_name, int
 				goto out;
 
 			if (m.kmod)
-				ret = maps__set_module_path(mg, path, &m);
+				ret = maps__set_module_path(maps, path, &m);
 
 			zfree(&m.name);
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 39bfed4..fdd5bdd 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -512,52 +512,50 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	return ip + map->reloc;
 }
 
-void maps__init(struct maps *mg, struct machine *machine)
+void maps__init(struct maps *maps, struct machine *machine)
 {
-	mg->entries = RB_ROOT;
-	init_rwsem(&mg->lock);
-	mg->machine = machine;
-	mg->last_search_by_name = NULL;
-	mg->nr_maps = 0;
-	mg->maps_by_name = NULL;
-	refcount_set(&mg->refcnt, 1);
+	maps->entries = RB_ROOT;
+	init_rwsem(&maps->lock);
+	maps->machine = machine;
+	maps->last_search_by_name = NULL;
+	maps->nr_maps = 0;
+	maps->maps_by_name = NULL;
+	refcount_set(&maps->refcnt, 1);
 }
 
-static void __maps__free_maps_by_name(struct maps *mg)
+static void __maps__free_maps_by_name(struct maps *maps)
 {
 	/*
 	 * Free everything to try to do it from the rbtree in the next search
 	 */
-	zfree(&mg->maps_by_name);
-	mg->nr_maps_allocated = 0;
+	zfree(&maps->maps_by_name);
+	maps->nr_maps_allocated = 0;
 }
 
-void maps__insert(struct maps *mg, struct map *map)
+void maps__insert(struct maps *maps, struct map *map)
 {
-	struct maps *maps = mg;
-
 	down_write(&maps->lock);
 	__maps__insert(maps, map);
-	++mg->nr_maps;
+	++maps->nr_maps;
 
 	/*
 	 * If we already performed some search by name, then we need to add the just
 	 * inserted map and resort.
 	 */
-	if (mg->maps_by_name) {
-		if (mg->nr_maps > mg->nr_maps_allocated) {
-			int nr_allocate = mg->nr_maps * 2;
-			struct map **maps_by_name = realloc(mg->maps_by_name, nr_allocate * sizeof(map));
+	if (maps->maps_by_name) {
+		if (maps->nr_maps > maps->nr_maps_allocated) {
+			int nr_allocate = maps->nr_maps * 2;
+			struct map **maps_by_name = realloc(maps->maps_by_name, nr_allocate * sizeof(map));
 
 			if (maps_by_name == NULL) {
 				__maps__free_maps_by_name(maps);
 				return;
 			}
 
-			mg->maps_by_name = maps_by_name;
-			mg->nr_maps_allocated = nr_allocate;
+			maps->maps_by_name = maps_by_name;
+			maps->nr_maps_allocated = nr_allocate;
 		}
-		mg->maps_by_name[mg->nr_maps - 1] = map;
+		maps->maps_by_name[maps->nr_maps - 1] = map;
 		__maps__sort_by_name(maps);
 	}
 	up_write(&maps->lock);
@@ -569,16 +567,15 @@ static void __maps__remove(struct maps *maps, struct map *map)
 	map__put(map);
 }
 
-void maps__remove(struct maps *mg, struct map *map)
+void maps__remove(struct maps *maps, struct map *map)
 {
-	struct maps *maps = mg;
 	down_write(&maps->lock);
-	if (mg->last_search_by_name == map)
-		mg->last_search_by_name = NULL;
+	if (maps->last_search_by_name == map)
+		maps->last_search_by_name = NULL;
 
 	__maps__remove(maps, map);
-	--mg->nr_maps;
-	if (mg->maps_by_name)
+	--maps->nr_maps;
+	if (maps->maps_by_name)
 		__maps__free_maps_by_name(maps);
 	up_write(&maps->lock);
 }
@@ -607,30 +604,30 @@ bool maps__empty(struct maps *maps)
 
 struct maps *maps__new(struct machine *machine)
 {
-	struct maps *mg = zalloc(sizeof(*mg)), *maps = mg;
+	struct maps *maps = zalloc(sizeof(*maps));
 
-	if (mg != NULL)
+	if (maps != NULL)
 		maps__init(maps, machine);
 
-	return mg;
+	return maps;
 }
 
-void maps__delete(struct maps *mg)
+void maps__delete(struct maps *maps)
 {
-	maps__exit(mg);
-	unwind__finish_access(mg);
-	free(mg);
+	maps__exit(maps);
+	unwind__finish_access(maps);
+	free(maps);
 }
 
-void maps__put(struct maps *mg)
+void maps__put(struct maps *maps)
 {
-	if (mg && refcount_dec_and_test(&mg->refcnt))
-		maps__delete(mg);
+	if (maps && refcount_dec_and_test(&maps->refcnt))
+		maps__delete(maps);
 }
 
-struct symbol *maps__find_symbol(struct maps *mg, u64 addr, struct map **mapp)
+struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
-	struct map *map = maps__find(mg, addr);
+	struct map *map = maps__find(maps, addr);
 
 	/* Ensure map is loaded before using map->map_ip */
 	if (map != NULL && map__load(map) >= 0) {
@@ -676,12 +673,12 @@ out:
 	return sym;
 }
 
-int maps__find_ams(struct maps *mg, struct addr_map_symbol *ams)
+int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 {
 	if (ams->addr < ams->ms.map->start || ams->addr >= ams->ms.map->end) {
-		if (mg == NULL)
+		if (maps == NULL)
 			return -1;
-		ams->ms.map = maps__find(mg, ams->addr);
+		ams->ms.map = maps__find(maps, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
 	}
@@ -819,7 +816,7 @@ out:
  */
 int maps__clone(struct thread *thread, struct maps *parent)
 {
-	struct maps *mg = thread->maps;
+	struct maps *maps = thread->maps;
 	int err = -ENOMEM;
 	struct map *map;
 
@@ -830,11 +827,11 @@ int maps__clone(struct thread *thread, struct maps *parent)
 		if (new == NULL)
 			goto out_unlock;
 
-		err = unwind__prepare_access(mg, new, NULL);
+		err = unwind__prepare_access(maps, new, NULL);
 		if (err)
 			goto out_unlock;
 
-		maps__insert(mg, new);
+		maps__insert(maps, new);
 		map__put(new);
 	}
 
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 8a45994..ada2f40 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -49,39 +49,39 @@ struct kmap {
 };
 
 struct maps *maps__new(struct machine *machine);
-void maps__delete(struct maps *mg);
-bool maps__empty(struct maps *mg);
+void maps__delete(struct maps *maps);
+bool maps__empty(struct maps *maps);
 
-static inline struct maps *maps__get(struct maps *mg)
+static inline struct maps *maps__get(struct maps *maps)
 {
-	if (mg)
-		refcount_inc(&mg->refcnt);
-	return mg;
+	if (maps)
+		refcount_inc(&maps->refcnt);
+	return maps;
 }
 
-void maps__put(struct maps *mg);
-void maps__init(struct maps *mg, struct machine *machine);
-void maps__exit(struct maps *mg);
+void maps__put(struct maps *maps);
+void maps__init(struct maps *maps, struct machine *machine);
+void maps__exit(struct maps *maps);
 int maps__clone(struct thread *thread, struct maps *parent);
-size_t maps__fprintf(struct maps *mg, FILE *fp);
+size_t maps__fprintf(struct maps *maps, FILE *fp);
 
-void maps__insert(struct maps *mg, struct map *map);
+void maps__insert(struct maps *maps, struct map *map);
 
-void maps__remove(struct maps *mg, struct map *map);
+void maps__remove(struct maps *maps, struct map *map);
 
-struct symbol *maps__find_symbol(struct maps *mg, u64 addr, struct map **mapp);
-struct symbol *maps__find_symbol_by_name(struct maps *mg, const char *name, struct map **mapp);
+struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp);
+struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
 
 struct addr_map_symbol;
 
-int maps__find_ams(struct maps *mg, struct addr_map_symbol *ams);
+int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
 
-int maps__fixup_overlappings(struct maps *mg, struct map *map, FILE *fp);
+int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp);
 
-struct map *maps__find_by_name(struct maps *mg, const char *name);
+struct map *maps__find_by_name(struct maps *maps, const char *name);
 
 int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
-void __maps__sort_by_name(struct maps *mg);
+void __maps__sort_by_name(struct maps *maps);
 
 #endif // __PERF_MAP_GROUPS_H
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index c705636..3b379b1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -239,9 +239,8 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 		curr->end = roundup(curr->start, 4096) + 4096;
 }
 
-void maps__fixup_end(struct maps *mg)
+void maps__fixup_end(struct maps *maps)
 {
-	struct maps *maps = mg;
 	struct map *prev = NULL, *curr;
 
 	down_write(&maps->lock);
@@ -1771,68 +1770,67 @@ static int map__strcmp_name(const void *name, const void *b)
 	return strcmp(name, map->dso->short_name);
 }
 
-void __maps__sort_by_name(struct maps *mg)
+void __maps__sort_by_name(struct maps *maps)
 {
-	qsort(mg->maps_by_name, mg->nr_maps, sizeof(struct map *), map__strcmp);
+	qsort(maps->maps_by_name, maps->nr_maps, sizeof(struct map *), map__strcmp);
 }
 
-static int map__groups__sort_by_name_from_rbtree(struct maps *mg)
+static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 {
 	struct map *map;
-	struct map **maps_by_name = realloc(mg->maps_by_name, mg->nr_maps * sizeof(map));
+	struct map **maps_by_name = realloc(maps->maps_by_name, maps->nr_maps * sizeof(map));
 	int i = 0;
 
 	if (maps_by_name == NULL)
 		return -1;
 
-	mg->maps_by_name = maps_by_name;
-	mg->nr_maps_allocated = mg->nr_maps;
+	maps->maps_by_name = maps_by_name;
+	maps->nr_maps_allocated = maps->nr_maps;
 
-	maps__for_each_entry(mg, map)
+	maps__for_each_entry(maps, map)
 		maps_by_name[i++] = map;
 
-	__maps__sort_by_name(mg);
+	__maps__sort_by_name(maps);
 	return 0;
 }
 
-static struct map *__maps__find_by_name(struct maps *mg, const char *name)
+static struct map *__maps__find_by_name(struct maps *maps, const char *name)
 {
 	struct map **mapp;
 
-	if (mg->maps_by_name == NULL &&
-	    map__groups__sort_by_name_from_rbtree(mg))
+	if (maps->maps_by_name == NULL &&
+	    map__groups__sort_by_name_from_rbtree(maps))
 		return NULL;
 
-	mapp = bsearch(name, mg->maps_by_name, mg->nr_maps, sizeof(*mapp), map__strcmp_name);
+	mapp = bsearch(name, maps->maps_by_name, maps->nr_maps, sizeof(*mapp), map__strcmp_name);
 	if (mapp)
 		return *mapp;
 	return NULL;
 }
 
-struct map *maps__find_by_name(struct maps *mg, const char *name)
+struct map *maps__find_by_name(struct maps *maps, const char *name)
 {
-	struct maps *maps = mg;
 	struct map *map;
 
 	down_read(&maps->lock);
 
-	if (mg->last_search_by_name && strcmp(mg->last_search_by_name->dso->short_name, name) == 0) {
-		map = mg->last_search_by_name;
+	if (maps->last_search_by_name && strcmp(maps->last_search_by_name->dso->short_name, name) == 0) {
+		map = maps->last_search_by_name;
 		goto out_unlock;
 	}
 	/*
-	 * If we have mg->maps_by_name, then the name isn't in the rbtree,
-	 * as mg->maps_by_name mirrors the rbtree when lookups by name are
+	 * If we have maps->maps_by_name, then the name isn't in the rbtree,
+	 * as maps->maps_by_name mirrors the rbtree when lookups by name are
 	 * made.
 	 */
-	map = __maps__find_by_name(mg, name);
-	if (map || mg->maps_by_name != NULL)
+	map = __maps__find_by_name(maps, name);
+	if (map || maps->maps_by_name != NULL)
 		goto out_unlock;
 
 	/* Fallback to traversing the rbtree... */
 	maps__for_each_entry(maps, map)
 		if (strcmp(map->dso->short_name, name) == 0) {
-			mg->last_search_by_name = map;
+			maps->last_search_by_name = map;
 			goto out_unlock;
 		}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 29c4ea4..93fc43d 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -186,7 +186,7 @@ void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols);
-void maps__fixup_end(struct maps *mg);
+void maps__fixup_end(struct maps *maps);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
 int file__read_maps(int fd, bool exe, mapfn_t mapfn, void *data,
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 515131e..b4649f5 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -616,26 +616,26 @@ static unw_accessors_t accessors = {
 	.get_proc_name		= get_proc_name,
 };
 
-static int _unwind__prepare_access(struct maps *mg)
+static int _unwind__prepare_access(struct maps *maps)
 {
-	mg->addr_space = unw_create_addr_space(&accessors, 0);
-	if (!mg->addr_space) {
+	maps->addr_space = unw_create_addr_space(&accessors, 0);
+	if (!maps->addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
 		return -ENOMEM;
 	}
 
-	unw_set_caching_policy(mg->addr_space, UNW_CACHE_GLOBAL);
+	unw_set_caching_policy(maps->addr_space, UNW_CACHE_GLOBAL);
 	return 0;
 }
 
-static void _unwind__flush_access(struct maps *mg)
+static void _unwind__flush_access(struct maps *maps)
 {
-	unw_flush_cache(mg->addr_space, 0, 0);
+	unw_flush_cache(maps->addr_space, 0, 0);
 }
 
-static void _unwind__finish_access(struct maps *mg)
+static void _unwind__finish_access(struct maps *maps)
 {
-	unw_destroy_addr_space(mg->addr_space);
+	unw_destroy_addr_space(maps->addr_space);
 }
 
 static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 4003ae8..e89a547 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -12,12 +12,12 @@ struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
 
-static void unwind__register_ops(struct maps *mg, struct unwind_libunwind_ops *ops)
+static void unwind__register_ops(struct maps *maps, struct unwind_libunwind_ops *ops)
 {
-	mg->unwind_libunwind_ops = ops;
+	maps->unwind_libunwind_ops = ops;
 }
 
-int unwind__prepare_access(struct maps *mg, struct map *map, bool *initialized)
+int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized)
 {
 	const char *arch;
 	enum dso_type dso_type;
@@ -27,7 +27,7 @@ int unwind__prepare_access(struct maps *mg, struct map *map, bool *initialized)
 	if (!dwarf_callchain_users)
 		return 0;
 
-	if (mg->addr_space) {
+	if (maps->addr_space) {
 		pr_debug("unwind: thread map already set, dso=%s\n",
 			 map->dso->name);
 		if (initialized)
@@ -36,14 +36,14 @@ int unwind__prepare_access(struct maps *mg, struct map *map, bool *initialized)
 	}
 
 	/* env->arch is NULL for live-mode (i.e. perf top) */
-	if (!mg->machine->env || !mg->machine->env->arch)
+	if (!maps->machine->env || !maps->machine->env->arch)
 		goto out_register;
 
-	dso_type = dso__type(map->dso, mg->machine);
+	dso_type = dso__type(map->dso, maps->machine);
 	if (dso_type == DSO__TYPE_UNKNOWN)
 		return 0;
 
-	arch = perf_env__arch(mg->machine->env);
+	arch = perf_env__arch(maps->machine->env);
 
 	if (!strcmp(arch, "x86")) {
 		if (dso_type != DSO__TYPE_64BIT)
@@ -58,24 +58,24 @@ int unwind__prepare_access(struct maps *mg, struct map *map, bool *initialized)
 		return 0;
 	}
 out_register:
-	unwind__register_ops(mg, ops);
+	unwind__register_ops(maps, ops);
 
-	err = mg->unwind_libunwind_ops->prepare_access(mg);
+	err = maps->unwind_libunwind_ops->prepare_access(maps);
 	if (initialized)
 		*initialized = err ? false : true;
 	return err;
 }
 
-void unwind__flush_access(struct maps *mg)
+void unwind__flush_access(struct maps *maps)
 {
-	if (mg->unwind_libunwind_ops)
-		mg->unwind_libunwind_ops->flush_access(mg);
+	if (maps->unwind_libunwind_ops)
+		maps->unwind_libunwind_ops->flush_access(maps);
 }
 
-void unwind__finish_access(struct maps *mg)
+void unwind__finish_access(struct maps *maps)
 {
-	if (mg->unwind_libunwind_ops)
-		mg->unwind_libunwind_ops->finish_access(mg);
+	if (maps->unwind_libunwind_ops)
+		maps->unwind_libunwind_ops->finish_access(maps);
 }
 
 int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
