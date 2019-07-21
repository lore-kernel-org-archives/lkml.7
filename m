Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B0AC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEB92085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708341;
	bh=hG/cSdTkT24vh2751en9cqJt+Zkvi2Gf9IwX0IEjJWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eWeGxEQtBuodXxMv00/6vl09gNSUY4wnEYtCf6S/VnYXqZkUcSdTDGxWhxDt2awlz
	 NRZl7tnD4Az0A8w0x5mUhyta3fC0yJ16fYaJ8QuiJaQGdXFGkuFk7W1HtxzF2Ckudi
	 0DnXx6dr+eHSyxtQgVc9AT11qzX28g9Hy8RRwD8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfGULZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbfGULZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:25:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBA1E3083363;
        Sun, 21 Jul 2019 11:25:38 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3B9E5D9D3;
        Sun, 21 Jul 2019 11:25:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 03/79] perf tools: Rename struct thread_map to struct perf_thread_map
Date:   Sun, 21 Jul 2019 13:23:50 +0200
Message-Id: <20190721112506.12306-4-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 21 Jul 2019 11:25:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming struct thread_map to struct perf_thread_map,
so it could be part of libperf.

Link: http://lkml.kernel.org/n/tip-9cgc4auwc7ifg8zycnd67rnw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c  |  2 +-
 tools/perf/builtin-record.c                   |  2 +-
 tools/perf/builtin-sched.c                    |  4 +-
 tools/perf/builtin-script.c                   |  2 +-
 tools/perf/builtin-stat.c                     |  4 +-
 tools/perf/tests/code-reading.c               |  2 +-
 tools/perf/tests/event-times.c                |  4 +-
 tools/perf/tests/keep-tracking.c              |  2 +-
 tools/perf/tests/mmap-basic.c                 |  2 +-
 tools/perf/tests/mmap-thread-lookup.c         |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |  2 +-
 tools/perf/tests/openat-syscall.c             |  2 +-
 tools/perf/tests/sw-clock.c                   |  2 +-
 tools/perf/tests/switch-tracking.c            |  2 +-
 tools/perf/tests/task-exit.c                  |  2 +-
 tools/perf/tests/thread-map.c                 |  8 +--
 tools/perf/util/event.c                       |  6 +-
 tools/perf/util/event.h                       |  6 +-
 tools/perf/util/evlist.c                      | 10 ++--
 tools/perf/util/evlist.h                      |  6 +-
 tools/perf/util/evsel.c                       | 10 ++--
 tools/perf/util/evsel.h                       |  6 +-
 tools/perf/util/machine.c                     |  2 +-
 tools/perf/util/machine.h                     |  4 +-
 tools/perf/util/parse-events.c                |  2 +-
 tools/perf/util/python.c                      |  6 +-
 .../scripting-engines/trace-event-python.c    |  2 +-
 tools/perf/util/thread_map.c                  | 60 +++++++++----------
 tools/perf/util/thread_map.h                  | 40 ++++++-------
 29 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 4676fd967dc6..f542b878bdb5 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -49,7 +49,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 		},
 		.sample_time	     = true,
 	};
-	struct thread_map *threads = NULL;
+	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
 	struct perf_evsel *evsel = NULL;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8779cee58185..bcfc16450608 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1047,7 +1047,7 @@ record__finish_output(struct record *rec)
 static int record__synthesize_workload(struct record *rec, bool tail)
 {
 	int err;
-	struct thread_map *thread_map;
+	struct perf_thread_map *thread_map;
 
 	if (rec->opts.tail_synthesize != tail)
 		return 0;
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 51dd48f20972..ac6a0c5d6d6b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -159,7 +159,7 @@ struct perf_sched_map {
 	DECLARE_BITMAP(comp_cpus_mask, MAX_CPUS);
 	int			*comp_cpus;
 	bool			 comp;
-	struct thread_map	*color_pids;
+	struct perf_thread_map *color_pids;
 	const char		*color_pids_str;
 	struct perf_cpu_map	*color_cpus;
 	const char		*color_cpus_str;
@@ -3195,7 +3195,7 @@ static int setup_map_cpus(struct perf_sched *sched)
 
 static int setup_color_pids(struct perf_sched *sched)
 {
-	struct thread_map *map;
+	struct perf_thread_map *map;
 
 	if (!sched->map.color_pids_str)
 		return 0;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0109c8710b93..fccc960df92b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1628,7 +1628,7 @@ struct perf_script {
 	bool			allocated;
 	bool			per_event_dump;
 	struct perf_cpu_map	*cpus;
-	struct thread_map	*threads;
+	struct perf_thread_map *threads;
 	int			name_width;
 	const char              *time_str;
 	struct perf_time_interval *ptime_range;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d68738b5bd0c..2b9518a38baf 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -165,7 +165,7 @@ struct perf_stat {
 	struct perf_tool	 tool;
 	bool			 maps_allocated;
 	struct perf_cpu_map	*cpus;
-	struct thread_map	*threads;
+	struct perf_thread_map *threads;
 	enum aggr_mode		 aggr_mode;
 };
 
@@ -395,7 +395,7 @@ static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 }
 
 static bool is_target_alive(struct target *_target,
-			    struct thread_map *threads)
+			    struct perf_thread_map *threads)
 {
 	struct stat st;
 	int i;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 948ec278ad06..88c218eacc43 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -552,7 +552,7 @@ static int do_test_code_reading(bool try_kcore)
 	struct state state = {
 		.done_cnt = 0,
 	};
-	struct thread_map *threads = NULL;
+	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
 	struct perf_evsel *evsel = NULL;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index ed90b62bf048..684ad56f7b0f 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -57,7 +57,7 @@ static int detach__enable_on_exec(struct perf_evlist *evlist)
 static int attach__current_disabled(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__last(evlist);
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	int err;
 
 	pr_debug("attaching to current thread as disabled\n");
@@ -83,7 +83,7 @@ static int attach__current_disabled(struct perf_evlist *evlist)
 static int attach__current_enabled(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__last(evlist);
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	int err;
 
 	pr_debug("attaching to current thread as enabled\n");
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 68331a81bcdd..e1e5e32cbb53 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -65,7 +65,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 			.uses_mmap   = true,
 		},
 	};
-	struct thread_map *threads = NULL;
+	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
 	struct perf_evsel *evsel = NULL;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 1bc8fd3ea510..c1e2fe087b67 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -27,7 +27,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 {
 	int err = -1;
 	union perf_event *event;
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	struct perf_cpu_map *cpus;
 	struct perf_evlist *evlist;
 	cpu_set_t cpu_set;
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 0a4301a5155c..ad6ca943e568 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -138,7 +138,7 @@ static int synth_all(struct machine *machine)
 
 static int synth_process(struct machine *machine)
 {
-	struct thread_map *map;
+	struct perf_thread_map *map;
 	int err;
 
 	map = thread_map__new_by_pid(getpid());
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index f393aa836dfb..9cd5bf63bec1 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -24,7 +24,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 	struct perf_evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
 	cpu_set_t cpu_set;
-	struct thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
+	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
 	char sbuf[STRERR_BUFSIZE];
 	char errbuf[BUFSIZ];
 
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 00cd63f90b92..652b8328ca93 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -16,7 +16,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 	int err = -1, fd;
 	struct perf_evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
-	struct thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
+	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
 	char sbuf[STRERR_BUFSIZE];
 	char errbuf[BUFSIZ];
 
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index d9121b5033b7..d57b8d9c1575 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -38,7 +38,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		.freq = 1,
 	};
 	struct perf_cpu_map *cpus;
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	struct perf_mmap *md;
 
 	attr.sample_freq = 500;
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 826f20a4cb51..3652c548cc22 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -327,7 +327,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 			.uses_mmap   = true,
 		},
 	};
-	struct thread_map *threads = NULL;
+	struct perf_thread_map *threads = NULL;
 	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
 	struct perf_evsel *evsel, *cpu_clocks_evsel, *cycles_evsel;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index d66767be4c45..9602ff91a3c7 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -46,7 +46,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	const char *argv[] = { "true", NULL };
 	char sbuf[STRERR_BUFSIZE];
 	struct perf_cpu_map *cpus;
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	struct perf_mmap *md;
 
 	signal(SIGCHLD, sig_handler);
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index ccc17aced49e..367dfe708e4c 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -13,7 +13,7 @@
 
 int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct thread_map *map;
+	struct perf_thread_map *map;
 
 	TEST_ASSERT_VAL("failed to set process name",
 			!prctl(PR_SET_NAME, NAMEUL, 0, 0, 0));
@@ -57,7 +57,7 @@ static int process_event(struct perf_tool *tool __maybe_unused,
 			 struct machine *machine __maybe_unused)
 {
 	struct thread_map_event *map = &event->thread_map;
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 
 	TEST_ASSERT_VAL("wrong nr",   map->nr == 1);
 	TEST_ASSERT_VAL("wrong pid",  map->entries[0].pid == (u64) getpid());
@@ -80,7 +80,7 @@ static int process_event(struct perf_tool *tool __maybe_unused,
 
 int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 
 	TEST_ASSERT_VAL("failed to set process name",
 			!prctl(PR_SET_NAME, NAMEUL, 0, 0, 0));
@@ -99,7 +99,7 @@ int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __
 
 int test__thread_map_remove(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	char *str;
 	int i;
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 406ad8772907..f78837788b14 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -616,7 +616,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 }
 
 int perf_event__synthesize_thread_map(struct perf_tool *tool,
-				      struct thread_map *threads,
+				      struct perf_thread_map *threads,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      bool mmap_data)
@@ -972,7 +972,7 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 }
 
 int perf_event__synthesize_thread_map2(struct perf_tool *tool,
-				      struct thread_map *threads,
+				      struct perf_thread_map *threads,
 				      perf_event__handler_t process,
 				      struct machine *machine)
 {
@@ -1377,7 +1377,7 @@ size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp)
 {
-	struct thread_map *threads = thread_map__new_event(&event->thread_map);
+	struct perf_thread_map *threads = thread_map__new_event(&event->thread_map);
 	size_t ret;
 
 	ret = fprintf(fp, " nr: ");
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index cafaac5128ab..70841d115349 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -674,7 +674,7 @@ union perf_event {
 void perf_event__print_totals(void);
 
 struct perf_tool;
-struct thread_map;
+struct perf_thread_map;
 struct perf_cpu_map;
 struct perf_stat_config;
 struct perf_counts_values;
@@ -685,11 +685,11 @@ typedef int (*perf_event__handler_t)(struct perf_tool *tool,
 				     struct machine *machine);
 
 int perf_event__synthesize_thread_map(struct perf_tool *tool,
-				      struct thread_map *threads,
+				      struct perf_thread_map *threads,
 				      perf_event__handler_t process,
 				      struct machine *machine, bool mmap_data);
 int perf_event__synthesize_thread_map2(struct perf_tool *tool,
-				      struct thread_map *threads,
+				      struct perf_thread_map *threads,
 				      perf_event__handler_t process,
 				      struct machine *machine);
 int perf_event__synthesize_cpu_map(struct perf_tool *tool,
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index bce883eaf0dc..a95d0461f718 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -42,7 +42,7 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
 void perf_evlist__init(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
-		       struct thread_map *threads)
+		       struct perf_thread_map *threads)
 {
 	int i;
 
@@ -1013,7 +1013,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 {
 	struct perf_evsel *evsel;
 	const struct perf_cpu_map *cpus = evlist->cpus;
-	const struct thread_map *threads = evlist->threads;
+	const struct perf_thread_map *threads = evlist->threads;
 	/*
 	 * Delay setting mp.prot: set it before calling perf_mmap__mmap.
 	 * Its value is decided by evsel's write_backward.
@@ -1059,7 +1059,7 @@ int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
 {
 	bool all_threads = (target->per_thread && target->system_wide);
 	struct perf_cpu_map *cpus;
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 
 	/*
 	 * If specify '-a' and '--per-thread' to perf record, perf record
@@ -1105,7 +1105,7 @@ int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
 }
 
 void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
-			   struct thread_map *threads)
+			   struct perf_thread_map *threads)
 {
 	/*
 	 * Allow for the possibility that one or another of the maps isn't being
@@ -1359,7 +1359,7 @@ void perf_evlist__close(struct perf_evlist *evlist)
 static int perf_evlist__create_syswide_maps(struct perf_evlist *evlist)
 {
 	struct perf_cpu_map *cpus;
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	int err = -ENOMEM;
 
 	/*
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c8cda300b584..ab2f0b6c7640 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -44,7 +44,7 @@ struct perf_evlist {
 	struct fdarray	 pollfd;
 	struct perf_mmap *mmap;
 	struct perf_mmap *overwrite_mmap;
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	struct perf_cpu_map *cpus;
 	struct perf_evsel *selected;
 	struct events_stats stats;
@@ -69,7 +69,7 @@ struct perf_evlist *perf_evlist__new(void);
 struct perf_evlist *perf_evlist__new_default(void);
 struct perf_evlist *perf_evlist__new_dummy(void);
 void perf_evlist__init(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
-		       struct thread_map *threads);
+		       struct perf_thread_map *threads);
 void perf_evlist__exit(struct perf_evlist *evlist);
 void perf_evlist__delete(struct perf_evlist *evlist);
 
@@ -195,7 +195,7 @@ void perf_evlist__set_selected(struct perf_evlist *evlist,
 			       struct perf_evsel *evsel);
 
 void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
-			   struct thread_map *threads);
+			   struct perf_thread_map *threads);
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target);
 int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **err_evsel);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 958206c538c3..ab66d65b7968 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1743,7 +1743,7 @@ static int update_fds(struct perf_evsel *evsel,
 
 static bool ignore_missing_thread(struct perf_evsel *evsel,
 				  int nr_cpus, int cpu,
-				  struct thread_map *threads,
+				  struct perf_thread_map *threads,
 				  int thread, int err)
 {
 	pid_t ignore_pid = thread_map__pid(threads, thread);
@@ -1826,7 +1826,7 @@ static int perf_event_open(struct perf_evsel *evsel,
 }
 
 int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
-		     struct thread_map *threads)
+		     struct perf_thread_map *threads)
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
@@ -1849,7 +1849,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	}
 
 	if (threads == NULL) {
-		static struct thread_map *empty_thread_map;
+		static struct perf_thread_map *empty_thread_map;
 
 		if (empty_thread_map == NULL) {
 			empty_thread_map = thread_map__new_by_tid(-1);
@@ -2090,7 +2090,7 @@ int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
 }
 
 int perf_evsel__open_per_thread(struct perf_evsel *evsel,
-				struct thread_map *threads)
+				struct perf_thread_map *threads)
 {
 	return perf_evsel__open(evsel, NULL, threads);
 }
@@ -3065,7 +3065,7 @@ static int store_evsel_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
 int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
 {
 	struct perf_cpu_map *cpus = evsel->cpus;
-	struct thread_map *threads = evsel->threads;
+	struct perf_thread_map *threads = evsel->threads;
 
 	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
 		return -ENOMEM;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 76b14037f260..ba2385f22e28 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -126,7 +126,7 @@ struct perf_evsel {
 	void			*handler;
 	struct perf_cpu_map	*cpus;
 	struct perf_cpu_map	*own_cpus;
-	struct thread_map	*threads;
+	struct perf_thread_map *threads;
 	unsigned int		sample_size;
 	int			id_pos;
 	int			is_pos;
@@ -302,9 +302,9 @@ int perf_evsel__disable(struct perf_evsel *evsel);
 int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
 			     struct perf_cpu_map *cpus);
 int perf_evsel__open_per_thread(struct perf_evsel *evsel,
-				struct thread_map *threads);
+				struct perf_thread_map *threads);
 int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
-		     struct thread_map *threads);
+		     struct perf_thread_map *threads);
 void perf_evsel__close(struct perf_evsel *evsel);
 
 struct perf_sample;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index cf826eca3aaf..a2359a33c748 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2599,7 +2599,7 @@ int machines__for_each_thread(struct machines *machines,
 }
 
 int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
-				  struct target *target, struct thread_map *threads,
+				  struct target *target, struct perf_thread_map *threads,
 				  perf_event__handler_t process, bool data_mmap,
 				  unsigned int nr_threads_synthesize)
 {
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index f70ab98a7bde..7f64016758e0 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -251,12 +251,12 @@ int machines__for_each_thread(struct machines *machines,
 			      void *priv);
 
 int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
-				  struct target *target, struct thread_map *threads,
+				  struct target *target, struct perf_thread_map *threads,
 				  perf_event__handler_t process, bool data_mmap,
 				  unsigned int nr_threads_synthesize);
 static inline
 int machine__synthesize_threads(struct machine *machine, struct target *target,
-				struct thread_map *threads, bool data_mmap,
+				struct perf_thread_map *threads, bool data_mmap,
 				unsigned int nr_threads_synthesize)
 {
 	return __machine__synthesize_threads(machine, NULL, target, threads,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 077509609d03..352c5198b453 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2313,7 +2313,7 @@ static bool is_event_supported(u8 type, unsigned config)
 		.config = config,
 		.disabled = 1,
 	};
-	struct thread_map *tmap = thread_map__new_by_tid(0);
+	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
 
 	if (tmap == NULL)
 		return false;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index be27956ae080..62dda70227e5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -605,7 +605,7 @@ static int pyrf_cpu_map__setup_types(void)
 struct pyrf_thread_map {
 	PyObject_HEAD
 
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 };
 
 static int pyrf_thread_map__init(struct pyrf_thread_map *pthreads,
@@ -797,7 +797,7 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 {
 	struct perf_evsel *evsel = &pevsel->evsel;
 	struct perf_cpu_map *cpus = NULL;
-	struct thread_map *threads = NULL;
+	struct perf_thread_map *threads = NULL;
 	PyObject *pcpus = NULL, *pthreads = NULL;
 	int group = 0, inherit = 0;
 	static char *kwlist[] = { "cpus", "threads", "group", "inherit", NULL };
@@ -866,7 +866,7 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 {
 	PyObject *pcpus = NULL, *pthreads = NULL;
 	struct perf_cpu_map *cpus;
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 
 	if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads))
 		return -1;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index a53b30b8819b..0a7e662036b4 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1392,7 +1392,7 @@ process_stat(struct perf_evsel *counter, int cpu, int thread, u64 tstamp,
 static void python_process_stat(struct perf_stat_config *config,
 				struct perf_evsel *counter, u64 tstamp)
 {
-	struct thread_map *threads = counter->threads;
+	struct perf_thread_map *threads = counter->threads;
 	struct perf_cpu_map *cpus = counter->cpus;
 	int cpu, thread;
 
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 5b3511f2b6b1..e89496c39d58 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -28,7 +28,7 @@ static int filter(const struct dirent *dir)
 		return 1;
 }
 
-static void thread_map__reset(struct thread_map *map, int start, int nr)
+static void thread_map__reset(struct perf_thread_map *map, int start, int nr)
 {
 	size_t size = (nr - start) * sizeof(map->map[0]);
 
@@ -36,7 +36,7 @@ static void thread_map__reset(struct thread_map *map, int start, int nr)
 	map->err_thread = -1;
 }
 
-static struct thread_map *thread_map__realloc(struct thread_map *map, int nr)
+static struct perf_thread_map *thread_map__realloc(struct perf_thread_map *map, int nr)
 {
 	size_t size = sizeof(*map) + sizeof(map->map[0]) * nr;
 	int start = map ? map->nr : 0;
@@ -53,9 +53,9 @@ static struct thread_map *thread_map__realloc(struct thread_map *map, int nr)
 
 #define thread_map__alloc(__nr) thread_map__realloc(NULL, __nr)
 
-struct thread_map *thread_map__new_by_pid(pid_t pid)
+struct perf_thread_map *thread_map__new_by_pid(pid_t pid)
 {
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 	char name[256];
 	int items;
 	struct dirent **namelist = NULL;
@@ -81,9 +81,9 @@ struct thread_map *thread_map__new_by_pid(pid_t pid)
 	return threads;
 }
 
-struct thread_map *thread_map__new_by_tid(pid_t tid)
+struct perf_thread_map *thread_map__new_by_tid(pid_t tid)
 {
-	struct thread_map *threads = thread_map__alloc(1);
+	struct perf_thread_map *threads = thread_map__alloc(1);
 
 	if (threads != NULL) {
 		thread_map__set_pid(threads, 0, tid);
@@ -94,13 +94,13 @@ struct thread_map *thread_map__new_by_tid(pid_t tid)
 	return threads;
 }
 
-static struct thread_map *__thread_map__new_all_cpus(uid_t uid)
+static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 {
 	DIR *proc;
 	int max_threads = 32, items, i;
 	char path[NAME_MAX + 1 + 6];
 	struct dirent *dirent, **namelist = NULL;
-	struct thread_map *threads = thread_map__alloc(max_threads);
+	struct perf_thread_map *threads = thread_map__alloc(max_threads);
 
 	if (threads == NULL)
 		goto out;
@@ -140,7 +140,7 @@ static struct thread_map *__thread_map__new_all_cpus(uid_t uid)
 		}
 
 		if (grow) {
-			struct thread_map *tmp;
+			struct perf_thread_map *tmp;
 
 			tmp = thread_map__realloc(threads, max_threads);
 			if (tmp == NULL)
@@ -180,17 +180,17 @@ static struct thread_map *__thread_map__new_all_cpus(uid_t uid)
 	goto out_closedir;
 }
 
-struct thread_map *thread_map__new_all_cpus(void)
+struct perf_thread_map *thread_map__new_all_cpus(void)
 {
 	return __thread_map__new_all_cpus(UINT_MAX);
 }
 
-struct thread_map *thread_map__new_by_uid(uid_t uid)
+struct perf_thread_map *thread_map__new_by_uid(uid_t uid)
 {
 	return __thread_map__new_all_cpus(uid);
 }
 
-struct thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid)
+struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid)
 {
 	if (pid != -1)
 		return thread_map__new_by_pid(pid);
@@ -201,9 +201,9 @@ struct thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid)
 	return thread_map__new_by_tid(tid);
 }
 
-static struct thread_map *thread_map__new_by_pid_str(const char *pid_str)
+static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
 {
-	struct thread_map *threads = NULL, *nt;
+	struct perf_thread_map *threads = NULL, *nt;
 	char name[256];
 	int items, total_tasks = 0;
 	struct dirent **namelist = NULL;
@@ -263,9 +263,9 @@ static struct thread_map *thread_map__new_by_pid_str(const char *pid_str)
 	goto out;
 }
 
-struct thread_map *thread_map__new_dummy(void)
+struct perf_thread_map *thread_map__new_dummy(void)
 {
-	struct thread_map *threads = thread_map__alloc(1);
+	struct perf_thread_map *threads = thread_map__alloc(1);
 
 	if (threads != NULL) {
 		thread_map__set_pid(threads, 0, -1);
@@ -275,9 +275,9 @@ struct thread_map *thread_map__new_dummy(void)
 	return threads;
 }
 
-struct thread_map *thread_map__new_by_tid_str(const char *tid_str)
+struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 {
-	struct thread_map *threads = NULL, *nt;
+	struct perf_thread_map *threads = NULL, *nt;
 	int ntasks = 0;
 	pid_t tid, prev_tid = INT_MAX;
 	char *end_ptr;
@@ -324,7 +324,7 @@ struct thread_map *thread_map__new_by_tid_str(const char *tid_str)
 	goto out;
 }
 
-struct thread_map *thread_map__new_str(const char *pid, const char *tid,
+struct perf_thread_map *thread_map__new_str(const char *pid, const char *tid,
 				       uid_t uid, bool all_threads)
 {
 	if (pid)
@@ -339,7 +339,7 @@ struct thread_map *thread_map__new_str(const char *pid, const char *tid,
 	return thread_map__new_by_tid_str(tid);
 }
 
-static void thread_map__delete(struct thread_map *threads)
+static void thread_map__delete(struct perf_thread_map *threads)
 {
 	if (threads) {
 		int i;
@@ -352,20 +352,20 @@ static void thread_map__delete(struct thread_map *threads)
 	}
 }
 
-struct thread_map *thread_map__get(struct thread_map *map)
+struct perf_thread_map *thread_map__get(struct perf_thread_map *map)
 {
 	if (map)
 		refcount_inc(&map->refcnt);
 	return map;
 }
 
-void thread_map__put(struct thread_map *map)
+void thread_map__put(struct perf_thread_map *map)
 {
 	if (map && refcount_dec_and_test(&map->refcnt))
 		thread_map__delete(map);
 }
 
-size_t thread_map__fprintf(struct thread_map *threads, FILE *fp)
+size_t thread_map__fprintf(struct perf_thread_map *threads, FILE *fp)
 {
 	int i;
 	size_t printed = fprintf(fp, "%d thread%s: ",
@@ -400,7 +400,7 @@ static int get_comm(char **comm, pid_t pid)
 	return err;
 }
 
-static void comm_init(struct thread_map *map, int i)
+static void comm_init(struct perf_thread_map *map, int i)
 {
 	pid_t pid = thread_map__pid(map, i);
 	char *comm = NULL;
@@ -421,7 +421,7 @@ static void comm_init(struct thread_map *map, int i)
 	map->map[i].comm = comm;
 }
 
-void thread_map__read_comms(struct thread_map *threads)
+void thread_map__read_comms(struct perf_thread_map *threads)
 {
 	int i;
 
@@ -429,7 +429,7 @@ void thread_map__read_comms(struct thread_map *threads)
 		comm_init(threads, i);
 }
 
-static void thread_map__copy_event(struct thread_map *threads,
+static void thread_map__copy_event(struct perf_thread_map *threads,
 				   struct thread_map_event *event)
 {
 	unsigned i;
@@ -444,9 +444,9 @@ static void thread_map__copy_event(struct thread_map *threads,
 	refcount_set(&threads->refcnt, 1);
 }
 
-struct thread_map *thread_map__new_event(struct thread_map_event *event)
+struct perf_thread_map *thread_map__new_event(struct thread_map_event *event)
 {
-	struct thread_map *threads;
+	struct perf_thread_map *threads;
 
 	threads = thread_map__alloc(event->nr);
 	if (threads)
@@ -455,7 +455,7 @@ struct thread_map *thread_map__new_event(struct thread_map_event *event)
 	return threads;
 }
 
-bool thread_map__has(struct thread_map *threads, pid_t pid)
+bool thread_map__has(struct perf_thread_map *threads, pid_t pid)
 {
 	int i;
 
@@ -467,7 +467,7 @@ bool thread_map__has(struct thread_map *threads, pid_t pid)
 	return false;
 }
 
-int thread_map__remove(struct thread_map *threads, int idx)
+int thread_map__remove(struct perf_thread_map *threads, int idx)
 {
 	int i;
 
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 2f689c90a8c6..9358b1b6e657 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -11,7 +11,7 @@ struct thread_map_data {
 	char	*comm;
 };
 
-struct thread_map {
+struct perf_thread_map {
 	refcount_t refcnt;
 	int nr;
 	int err_thread;
@@ -20,46 +20,46 @@ struct thread_map {
 
 struct thread_map_event;
 
-struct thread_map *thread_map__new_dummy(void);
-struct thread_map *thread_map__new_by_pid(pid_t pid);
-struct thread_map *thread_map__new_by_tid(pid_t tid);
-struct thread_map *thread_map__new_by_uid(uid_t uid);
-struct thread_map *thread_map__new_all_cpus(void);
-struct thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid);
-struct thread_map *thread_map__new_event(struct thread_map_event *event);
+struct perf_thread_map *thread_map__new_dummy(void);
+struct perf_thread_map *thread_map__new_by_pid(pid_t pid);
+struct perf_thread_map *thread_map__new_by_tid(pid_t tid);
+struct perf_thread_map *thread_map__new_by_uid(uid_t uid);
+struct perf_thread_map *thread_map__new_all_cpus(void);
+struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid);
+struct perf_thread_map *thread_map__new_event(struct thread_map_event *event);
 
-struct thread_map *thread_map__get(struct thread_map *map);
-void thread_map__put(struct thread_map *map);
+struct perf_thread_map *thread_map__get(struct perf_thread_map *map);
+void thread_map__put(struct perf_thread_map *map);
 
-struct thread_map *thread_map__new_str(const char *pid,
+struct perf_thread_map *thread_map__new_str(const char *pid,
 		const char *tid, uid_t uid, bool all_threads);
 
-struct thread_map *thread_map__new_by_tid_str(const char *tid_str);
+struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str);
 
-size_t thread_map__fprintf(struct thread_map *threads, FILE *fp);
+size_t thread_map__fprintf(struct perf_thread_map *threads, FILE *fp);
 
-static inline int thread_map__nr(struct thread_map *threads)
+static inline int thread_map__nr(struct perf_thread_map *threads)
 {
 	return threads ? threads->nr : 1;
 }
 
-static inline pid_t thread_map__pid(struct thread_map *map, int thread)
+static inline pid_t thread_map__pid(struct perf_thread_map *map, int thread)
 {
 	return map->map[thread].pid;
 }
 
 static inline void
-thread_map__set_pid(struct thread_map *map, int thread, pid_t pid)
+thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid)
 {
 	map->map[thread].pid = pid;
 }
 
-static inline char *thread_map__comm(struct thread_map *map, int thread)
+static inline char *thread_map__comm(struct perf_thread_map *map, int thread)
 {
 	return map->map[thread].comm;
 }
 
-void thread_map__read_comms(struct thread_map *threads);
-bool thread_map__has(struct thread_map *threads, pid_t pid);
-int thread_map__remove(struct thread_map *threads, int idx);
+void thread_map__read_comms(struct perf_thread_map *threads);
+bool thread_map__has(struct perf_thread_map *threads, pid_t pid);
+int thread_map__remove(struct perf_thread_map *threads, int idx);
 #endif	/* __PERF_THREAD_MAP_H */
-- 
2.21.0

