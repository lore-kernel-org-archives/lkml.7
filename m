Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2AFC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B5A2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708335;
	bh=rQ6qS1cOrPtpmbCtjjSNvb6zh/kqUDpK9ZCe32Pv60Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kl3VdcpFzBY7is+HUFGsTVxGZtm680E+3GgM+F6EC8LRJ5xbYFpspiYSp2mlKCAxs
	 JG3CRp+i2Xdgvq9NOsGZSzTQGg7695GJpt2HsrLfIzEj5V0Pdtd/2SEgJX4yXbGV1u
	 aQDDMgQttTqeW8nwUZMW2xg8VhZKPywUdYRTut4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfGULZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGULZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:25:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D91B30842B5;
        Sun, 21 Jul 2019 11:25:33 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 445F05D9D3;
        Sun, 21 Jul 2019 11:25:24 +0000 (UTC)
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
Subject: [PATCH 02/79] perf tools: Rename struct cpu_map to struct perf_cpu_map
Date:   Sun, 21 Jul 2019 13:23:49 +0200
Message-Id: <20190721112506.12306-3-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 21 Jul 2019 11:25:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming struct cpu_map to struct perf_cpu_map,
so it could be part of libperf.

Link: http://lkml.kernel.org/n/tip-isi1dlub7s0kf5wacvgpotdu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c  |  2 +-
 tools/perf/arch/x86/util/intel-bts.c          |  2 +-
 tools/perf/arch/x86/util/intel-pt.c           |  2 +-
 tools/perf/bench/epoll-ctl.c                  |  4 +-
 tools/perf/bench/epoll-wait.c                 |  4 +-
 tools/perf/bench/futex-hash.c                 |  2 +-
 tools/perf/bench/futex-lock-pi.c              |  4 +-
 tools/perf/bench/futex-requeue.c              |  4 +-
 tools/perf/bench/futex-wake-parallel.c        |  4 +-
 tools/perf/bench/futex-wake.c                 |  4 +-
 tools/perf/builtin-c2c.c                      |  2 +-
 tools/perf/builtin-ftrace.c                   |  6 +-
 tools/perf/builtin-sched.c                    |  8 +-
 tools/perf/builtin-script.c                   |  2 +-
 tools/perf/builtin-stat.c                     | 46 +++++------
 tools/perf/tests/bitmap.c                     |  2 +-
 tools/perf/tests/code-reading.c               |  2 +-
 tools/perf/tests/cpumap.c                     |  8 +-
 tools/perf/tests/event-times.c                |  4 +-
 tools/perf/tests/event_update.c               |  2 +-
 tools/perf/tests/keep-tracking.c              |  2 +-
 tools/perf/tests/mem2node.c                   |  2 +-
 tools/perf/tests/mmap-basic.c                 |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |  2 +-
 tools/perf/tests/sw-clock.c                   |  2 +-
 tools/perf/tests/switch-tracking.c            |  2 +-
 tools/perf/tests/task-exit.c                  |  2 +-
 tools/perf/tests/topology.c                   |  4 +-
 tools/perf/util/cpumap.c                      | 78 +++++++++----------
 tools/perf/util/cpumap.h                      | 52 ++++++-------
 tools/perf/util/cputopo.c                     |  4 +-
 tools/perf/util/env.h                         |  2 +-
 tools/perf/util/event.c                       | 18 ++---
 tools/perf/util/event.h                       |  8 +-
 tools/perf/util/evlist.c                      | 10 +--
 tools/perf/util/evlist.h                      |  8 +-
 tools/perf/util/evsel.c                       |  8 +-
 tools/perf/util/evsel.h                       | 12 +--
 tools/perf/util/header.c                      |  4 +-
 tools/perf/util/mmap.c                        |  2 +-
 tools/perf/util/parse-events.c                |  2 +-
 tools/perf/util/pmu.c                         | 10 +--
 tools/perf/util/pmu.h                         |  2 +-
 tools/perf/util/python.c                      |  6 +-
 tools/perf/util/record.c                      |  6 +-
 .../scripting-engines/trace-event-python.c    |  2 +-
 tools/perf/util/session.c                     |  2 +-
 tools/perf/util/stat.c                        |  2 +-
 tools/perf/util/stat.h                        |  6 +-
 tools/perf/util/svghelper.c                   |  2 +-
 50 files changed, 189 insertions(+), 189 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 7a7721604b86..4676fd967dc6 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -50,7 +50,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 		.sample_time	     = true,
 	};
 	struct thread_map *threads = NULL;
-	struct cpu_map *cpus = NULL;
+	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
 	struct perf_evsel *evsel = NULL;
 	int err = -1, ret, i;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index ec5c1bb84095..da1583d27efd 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -106,7 +106,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct intel_bts_recording, itr);
 	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
 	struct perf_evsel *evsel, *intel_bts_evsel = NULL;
-	const struct cpu_map *cpus = evlist->cpus;
+	const struct perf_cpu_map *cpus = evlist->cpus;
 	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
 
 	btsr->evlist = evlist;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 609088c01e3a..69a23e40abc9 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -557,7 +557,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *intel_pt_pmu = ptr->intel_pt_pmu;
 	bool have_timing_info, need_immediate = false;
 	struct perf_evsel *evsel, *intel_pt_evsel = NULL;
-	const struct cpu_map *cpus = evlist->cpus;
+	const struct perf_cpu_map *cpus = evlist->cpus;
 	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
 	u64 tsc_bit;
 	int err;
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 2af067859966..1fd724f1d48b 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -219,7 +219,7 @@ static void init_fdmaps(struct worker *w, int pct)
 	}
 }
 
-static int do_threads(struct worker *worker, struct cpu_map *cpu)
+static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 {
 	pthread_attr_t thread_attr, *attrp = NULL;
 	cpu_set_t cpuset;
@@ -301,7 +301,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 	int j, ret = 0;
 	struct sigaction act;
 	struct worker *worker = NULL;
-	struct cpu_map *cpu;
+	struct perf_cpu_map *cpu;
 	struct rlimit rl, prevrl;
 	unsigned int i;
 
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index fe85448abd45..79a254fff2d1 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -288,7 +288,7 @@ static void print_summary(void)
 	       (int) runtime.tv_sec);
 }
 
-static int do_threads(struct worker *worker, struct cpu_map *cpu)
+static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 {
 	pthread_attr_t thread_attr, *attrp = NULL;
 	cpu_set_t cpuset;
@@ -415,7 +415,7 @@ int bench_epoll_wait(int argc, const char **argv)
 	struct sigaction act;
 	unsigned int i;
 	struct worker *worker = NULL;
-	struct cpu_map *cpu;
+	struct perf_cpu_map *cpu;
 	pthread_t wthread;
 	struct rlimit rl, prevrl;
 
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index a80797763e1f..b4fea8e3a368 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -124,7 +124,7 @@ int bench_futex_hash(int argc, const char **argv)
 	unsigned int i;
 	pthread_attr_t thread_attr;
 	struct worker *worker = NULL;
-	struct cpu_map *cpu;
+	struct perf_cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_hash_usage, 0);
 	if (argc) {
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index d02330a69745..596769924709 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -116,7 +116,7 @@ static void *workerfn(void *arg)
 }
 
 static void create_threads(struct worker *w, pthread_attr_t thread_attr,
-			   struct cpu_map *cpu)
+			   struct perf_cpu_map *cpu)
 {
 	cpu_set_t cpuset;
 	unsigned int i;
@@ -150,7 +150,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	unsigned int i;
 	struct sigaction act;
 	pthread_attr_t thread_attr;
-	struct cpu_map *cpu;
+	struct perf_cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_lock_pi_usage, 0);
 	if (argc)
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index fc692efa0c05..1fd32a4f9c14 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -84,7 +84,7 @@ static void *workerfn(void *arg __maybe_unused)
 }
 
 static void block_threads(pthread_t *w,
-			  pthread_attr_t thread_attr, struct cpu_map *cpu)
+			  pthread_attr_t thread_attr, struct perf_cpu_map *cpu)
 {
 	cpu_set_t cpuset;
 	unsigned int i;
@@ -117,7 +117,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	unsigned int i, j;
 	struct sigaction act;
 	pthread_attr_t thread_attr;
-	struct cpu_map *cpu;
+	struct perf_cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_requeue_usage, 0);
 	if (argc)
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 69d8fdc87315..884c73e5bd1b 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -138,7 +138,7 @@ static void *blocked_workerfn(void *arg __maybe_unused)
 }
 
 static void block_threads(pthread_t *w, pthread_attr_t thread_attr,
-			  struct cpu_map *cpu)
+			  struct perf_cpu_map *cpu)
 {
 	cpu_set_t cpuset;
 	unsigned int i;
@@ -224,7 +224,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	struct sigaction act;
 	pthread_attr_t thread_attr;
 	struct thread_data *waking_worker;
-	struct cpu_map *cpu;
+	struct perf_cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options,
 			     bench_futex_wake_parallel_usage, 0);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index e8181ad7d088..2288fa8412ff 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -90,7 +90,7 @@ static void print_summary(void)
 }
 
 static void block_threads(pthread_t *w,
-			  pthread_attr_t thread_attr, struct cpu_map *cpu)
+			  pthread_attr_t thread_attr, struct perf_cpu_map *cpu)
 {
 	cpu_set_t cpuset;
 	unsigned int i;
@@ -123,7 +123,7 @@ int bench_futex_wake(int argc, const char **argv)
 	unsigned int i, j;
 	struct sigaction act;
 	pthread_attr_t thread_attr;
-	struct cpu_map *cpu;
+	struct perf_cpu_map *cpu;
 
 	argc = parse_options(argc, argv, options, bench_futex_wake_usage, 0);
 	if (argc) {
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e3776f5c2e01..52035dacf253 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2049,7 +2049,7 @@ static int setup_nodes(struct perf_session *session)
 	c2c.cpu2node = cpu2node;
 
 	for (node = 0; node < c2c.nodes_cnt; node++) {
-		struct cpu_map *map = n[node].map;
+		struct perf_cpu_map *map = n[node].map;
 		unsigned long *set;
 
 		set = bitmap_alloc(c2c.cpus_cnt);
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 66d5a6658daf..3e81e0b6628f 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -165,7 +165,7 @@ static int set_tracing_pid(struct perf_ftrace *ftrace)
 	return 0;
 }
 
-static int set_tracing_cpumask(struct cpu_map *cpumap)
+static int set_tracing_cpumask(struct perf_cpu_map *cpumap)
 {
 	char *cpumask;
 	size_t mask_size;
@@ -192,7 +192,7 @@ static int set_tracing_cpumask(struct cpu_map *cpumap)
 
 static int set_tracing_cpu(struct perf_ftrace *ftrace)
 {
-	struct cpu_map *cpumap = ftrace->evlist->cpus;
+	struct perf_cpu_map *cpumap = ftrace->evlist->cpus;
 
 	if (!target__has_cpu(&ftrace->target))
 		return 0;
@@ -202,7 +202,7 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
 
 static int reset_tracing_cpu(void)
 {
-	struct cpu_map *cpumap = cpu_map__new(NULL);
+	struct perf_cpu_map *cpumap = cpu_map__new(NULL);
 	int ret;
 
 	ret = set_tracing_cpumask(cpumap);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 56d1907b1215..51dd48f20972 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -161,9 +161,9 @@ struct perf_sched_map {
 	bool			 comp;
 	struct thread_map	*color_pids;
 	const char		*color_pids_str;
-	struct cpu_map		*color_cpus;
+	struct perf_cpu_map	*color_cpus;
 	const char		*color_cpus_str;
-	struct cpu_map		*cpus;
+	struct perf_cpu_map	*cpus;
 	const char		*cpus_str;
 };
 
@@ -3170,7 +3170,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 
 static int setup_map_cpus(struct perf_sched *sched)
 {
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 
 	sched->max_cpu  = sysconf(_SC_NPROCESSORS_CONF);
 
@@ -3212,7 +3212,7 @@ static int setup_color_pids(struct perf_sched *sched)
 
 static int setup_color_cpus(struct perf_sched *sched)
 {
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 
 	if (!sched->map.color_cpus_str)
 		return 0;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0140ddb8dd0b..0109c8710b93 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1627,7 +1627,7 @@ struct perf_script {
 	bool			show_bpf_events;
 	bool			allocated;
 	bool			per_event_dump;
-	struct cpu_map		*cpus;
+	struct perf_cpu_map	*cpus;
 	struct thread_map	*threads;
 	int			name_width;
 	const char              *time_str;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7b9c26f9cf34..d68738b5bd0c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -164,7 +164,7 @@ struct perf_stat {
 	u64			 bytes_written;
 	struct perf_tool	 tool;
 	bool			 maps_allocated;
-	struct cpu_map		*cpus;
+	struct perf_cpu_map	*cpus;
 	struct thread_map	*threads;
 	enum aggr_mode		 aggr_mode;
 };
@@ -803,24 +803,24 @@ static struct option stat_options[] = {
 };
 
 static int perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
-				 struct cpu_map *map, int cpu)
+				 struct perf_cpu_map *map, int cpu)
 {
 	return cpu_map__get_socket(map, cpu, NULL);
 }
 
 static int perf_stat__get_die(struct perf_stat_config *config __maybe_unused,
-			      struct cpu_map *map, int cpu)
+			      struct perf_cpu_map *map, int cpu)
 {
 	return cpu_map__get_die(map, cpu, NULL);
 }
 
 static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
-			       struct cpu_map *map, int cpu)
+			       struct perf_cpu_map *map, int cpu)
 {
 	return cpu_map__get_core(map, cpu, NULL);
 }
 
-static int cpu_map__get_max(struct cpu_map *map)
+static int cpu_map__get_max(struct perf_cpu_map *map)
 {
 	int i, max = -1;
 
@@ -833,7 +833,7 @@ static int cpu_map__get_max(struct cpu_map *map)
 }
 
 static int perf_stat__get_aggr(struct perf_stat_config *config,
-			       aggr_get_id_t get_id, struct cpu_map *map, int idx)
+			       aggr_get_id_t get_id, struct perf_cpu_map *map, int idx)
 {
 	int cpu;
 
@@ -849,19 +849,19 @@ static int perf_stat__get_aggr(struct perf_stat_config *config,
 }
 
 static int perf_stat__get_socket_cached(struct perf_stat_config *config,
-					struct cpu_map *map, int idx)
+					struct perf_cpu_map *map, int idx)
 {
 	return perf_stat__get_aggr(config, perf_stat__get_socket, map, idx);
 }
 
 static int perf_stat__get_die_cached(struct perf_stat_config *config,
-					struct cpu_map *map, int idx)
+					struct perf_cpu_map *map, int idx)
 {
 	return perf_stat__get_aggr(config, perf_stat__get_die, map, idx);
 }
 
 static int perf_stat__get_core_cached(struct perf_stat_config *config,
-				      struct cpu_map *map, int idx)
+				      struct perf_cpu_map *map, int idx)
 {
 	return perf_stat__get_aggr(config, perf_stat__get_core, map, idx);
 }
@@ -939,7 +939,7 @@ static void perf_stat__exit_aggr_mode(void)
 	stat_config.cpus_aggr_map = NULL;
 }
 
-static inline int perf_env__get_cpu(struct perf_env *env, struct cpu_map *map, int idx)
+static inline int perf_env__get_cpu(struct perf_env *env, struct perf_cpu_map *map, int idx)
 {
 	int cpu;
 
@@ -954,7 +954,7 @@ static inline int perf_env__get_cpu(struct perf_env *env, struct cpu_map *map, i
 	return cpu;
 }
 
-static int perf_env__get_socket(struct cpu_map *map, int idx, void *data)
+static int perf_env__get_socket(struct perf_cpu_map *map, int idx, void *data)
 {
 	struct perf_env *env = data;
 	int cpu = perf_env__get_cpu(env, map, idx);
@@ -962,7 +962,7 @@ static int perf_env__get_socket(struct cpu_map *map, int idx, void *data)
 	return cpu == -1 ? -1 : env->cpu[cpu].socket_id;
 }
 
-static int perf_env__get_die(struct cpu_map *map, int idx, void *data)
+static int perf_env__get_die(struct perf_cpu_map *map, int idx, void *data)
 {
 	struct perf_env *env = data;
 	int die_id = -1, cpu = perf_env__get_cpu(env, map, idx);
@@ -986,7 +986,7 @@ static int perf_env__get_die(struct cpu_map *map, int idx, void *data)
 	return die_id;
 }
 
-static int perf_env__get_core(struct cpu_map *map, int idx, void *data)
+static int perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
 {
 	struct perf_env *env = data;
 	int core = -1, cpu = perf_env__get_cpu(env, map, idx);
@@ -1016,37 +1016,37 @@ static int perf_env__get_core(struct cpu_map *map, int idx, void *data)
 	return core;
 }
 
-static int perf_env__build_socket_map(struct perf_env *env, struct cpu_map *cpus,
-				      struct cpu_map **sockp)
+static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
+				      struct perf_cpu_map **sockp)
 {
 	return cpu_map__build_map(cpus, sockp, perf_env__get_socket, env);
 }
 
-static int perf_env__build_die_map(struct perf_env *env, struct cpu_map *cpus,
-				   struct cpu_map **diep)
+static int perf_env__build_die_map(struct perf_env *env, struct perf_cpu_map *cpus,
+				   struct perf_cpu_map **diep)
 {
 	return cpu_map__build_map(cpus, diep, perf_env__get_die, env);
 }
 
-static int perf_env__build_core_map(struct perf_env *env, struct cpu_map *cpus,
-				    struct cpu_map **corep)
+static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *cpus,
+				    struct perf_cpu_map **corep)
 {
 	return cpu_map__build_map(cpus, corep, perf_env__get_core, env);
 }
 
 static int perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
-				      struct cpu_map *map, int idx)
+				      struct perf_cpu_map *map, int idx)
 {
 	return perf_env__get_socket(map, idx, &perf_stat.session->header.env);
 }
 static int perf_stat__get_die_file(struct perf_stat_config *config __maybe_unused,
-				   struct cpu_map *map, int idx)
+				   struct perf_cpu_map *map, int idx)
 {
 	return perf_env__get_die(map, idx, &perf_stat.session->header.env);
 }
 
 static int perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
-				    struct cpu_map *map, int idx)
+				    struct perf_cpu_map *map, int idx)
 {
 	return perf_env__get_core(map, idx, &perf_stat.session->header.env);
 }
@@ -1551,7 +1551,7 @@ int process_cpu_map_event(struct perf_session *session,
 {
 	struct perf_tool *tool = session->tool;
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 
 	if (st->cpus) {
 		pr_warning("Extra cpu map event, ignoring.\n");
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 96e7fc1ad3f9..74d0cd32a5c4 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -9,7 +9,7 @@
 
 static unsigned long *get_bitmap(const char *str, int nbits)
 {
-	struct cpu_map *map = cpu_map__new(str);
+	struct perf_cpu_map *map = cpu_map__new(str);
 	unsigned long *bm = NULL;
 	int i;
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index aa6df122b175..948ec278ad06 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -553,7 +553,7 @@ static int do_test_code_reading(bool try_kcore)
 		.done_cnt = 0,
 	};
 	struct thread_map *threads = NULL;
-	struct cpu_map *cpus = NULL;
+	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
 	struct perf_evsel *evsel = NULL;
 	int err = -1, ret;
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index e78b897677bd..10da4400493d 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -17,7 +17,7 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 	struct cpu_map_event *map_event = &event->cpu_map;
 	struct cpu_map_mask *mask;
 	struct cpu_map_data *data;
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 	int i;
 
 	data = &map_event->data;
@@ -51,7 +51,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	struct cpu_map_event *map_event = &event->cpu_map;
 	struct cpu_map_entries *cpus;
 	struct cpu_map_data *data;
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 
 	data = &map_event->data;
 
@@ -75,7 +75,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 
 int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 
 	/* This one is better stores in mask. */
 	cpus = cpu_map__new("0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19");
@@ -97,7 +97,7 @@ int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __may
 
 static int cpu_map_print(const char *str)
 {
-	struct cpu_map *map = cpu_map__new(str);
+	struct perf_cpu_map *map = cpu_map__new(str);
 	char buf[100];
 
 	if (!map)
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 1a2686f1fcf0..ed90b62bf048 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -110,7 +110,7 @@ static int detach__disable(struct perf_evlist *evlist)
 static int attach__cpu_disabled(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__last(evlist);
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	int err;
 
 	pr_debug("attaching to CPU 0 as enabled\n");
@@ -139,7 +139,7 @@ static int attach__cpu_disabled(struct perf_evlist *evlist)
 static int attach__cpu_enabled(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__last(evlist);
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	int err;
 
 	pr_debug("attaching to CPU 0 as enabled\n");
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index f14dcd613438..b5042f019ec4 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -61,7 +61,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 {
 	struct event_update_event *ev = (struct event_update_event*) event;
 	struct event_update_event_cpus *ev_data;
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 
 	ev_data = (struct event_update_event_cpus*) ev->data;
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 17c46f3e6f1e..68331a81bcdd 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -66,7 +66,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 		},
 	};
 	struct thread_map *threads = NULL;
-	struct cpu_map *cpus = NULL;
+	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
 	struct perf_evsel *evsel = NULL;
 	int found, err = -1;
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 520cc91af256..e12eedfba781 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -19,7 +19,7 @@ static struct node {
 
 static unsigned long *get_bitmap(const char *str, int nbits)
 {
-	struct cpu_map *map = cpu_map__new(str);
+	struct perf_cpu_map *map = cpu_map__new(str);
 	unsigned long *bm = NULL;
 	int i;
 
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 0919b0793e5b..1bc8fd3ea510 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -28,7 +28,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	int err = -1;
 	union perf_event *event;
 	struct thread_map *threads;
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	struct perf_evlist *evlist;
 	cpu_set_t cpu_set;
 	const char *syscall_names[] = { "getsid", "getppid", "getpgid", };
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 493ecb611540..f393aa836dfb 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -20,7 +20,7 @@
 int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1, fd, cpu;
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	struct perf_evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
 	cpu_set_t cpu_set;
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index f9490b237893..d9121b5033b7 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -37,7 +37,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		.disabled = 1,
 		.freq = 1,
 	};
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	struct thread_map *threads;
 	struct perf_mmap *md;
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 6cdab5f4812a..826f20a4cb51 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -328,7 +328,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		},
 	};
 	struct thread_map *threads = NULL;
-	struct cpu_map *cpus = NULL;
+	struct perf_cpu_map *cpus = NULL;
 	struct perf_evlist *evlist = NULL;
 	struct perf_evsel *evsel, *cpu_clocks_evsel, *cycles_evsel;
 	struct perf_evsel *switch_evsel, *tracking_evsel;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index e92fa6029ac7..d66767be4c45 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -45,7 +45,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	};
 	const char *argv[] = { "true", NULL };
 	char sbuf[STRERR_BUFSIZE];
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	struct thread_map *threads;
 	struct perf_mmap *md;
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 9497d02f69e6..443d0272ebbd 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -57,7 +57,7 @@ static int session_write_header(char *path)
 	return 0;
 }
 
-static int check_cpu_topology(char *path, struct cpu_map *map)
+static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 {
 	struct perf_session *session;
 	struct perf_data data = {
@@ -116,7 +116,7 @@ static int check_cpu_topology(char *path, struct cpu_map *map)
 int test__session_topology(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char path[PATH_MAX];
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 	int ret = TEST_FAIL;
 
 	TEST_ASSERT_VAL("can't get templ file", !get_temp(path));
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 3acfbe34ebaf..5eb4e1fbb877 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -17,9 +17,9 @@ static int max_present_cpu_num;
 static int max_node_num;
 static int *cpunode_map;
 
-static struct cpu_map *cpu_map__default_new(void)
+static struct perf_cpu_map *cpu_map__default_new(void)
 {
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	int nr_cpus;
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
@@ -39,10 +39,10 @@ static struct cpu_map *cpu_map__default_new(void)
 	return cpus;
 }
 
-static struct cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
+static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 {
 	size_t payload_size = nr_cpus * sizeof(int);
-	struct cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
+	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
 
 	if (cpus != NULL) {
 		cpus->nr = nr_cpus;
@@ -53,9 +53,9 @@ static struct cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 	return cpus;
 }
 
-struct cpu_map *cpu_map__read(FILE *file)
+struct perf_cpu_map *cpu_map__read(FILE *file)
 {
-	struct cpu_map *cpus = NULL;
+	struct perf_cpu_map *cpus = NULL;
 	int nr_cpus = 0;
 	int *tmp_cpus = NULL, *tmp;
 	int max_entries = 0;
@@ -108,9 +108,9 @@ struct cpu_map *cpu_map__read(FILE *file)
 	return cpus;
 }
 
-static struct cpu_map *cpu_map__read_all_cpu_map(void)
+static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
 {
-	struct cpu_map *cpus = NULL;
+	struct perf_cpu_map *cpus = NULL;
 	FILE *onlnf;
 
 	onlnf = fopen("/sys/devices/system/cpu/online", "r");
@@ -122,9 +122,9 @@ static struct cpu_map *cpu_map__read_all_cpu_map(void)
 	return cpus;
 }
 
-struct cpu_map *cpu_map__new(const char *cpu_list)
+struct perf_cpu_map *cpu_map__new(const char *cpu_list)
 {
-	struct cpu_map *cpus = NULL;
+	struct perf_cpu_map *cpus = NULL;
 	unsigned long start_cpu, end_cpu = 0;
 	char *p = NULL;
 	int i, nr_cpus = 0;
@@ -196,9 +196,9 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 	return cpus;
 }
 
-static struct cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
+static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
 {
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 
 	map = cpu_map__empty_new(cpus->nr);
 	if (map) {
@@ -220,9 +220,9 @@ static struct cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
 	return map;
 }
 
-static struct cpu_map *cpu_map__from_mask(struct cpu_map_mask *mask)
+static struct perf_cpu_map *cpu_map__from_mask(struct cpu_map_mask *mask)
 {
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 	int nr, nbits = mask->nr * mask->long_size * BITS_PER_BYTE;
 
 	nr = bitmap_weight(mask->mask, nbits);
@@ -238,7 +238,7 @@ static struct cpu_map *cpu_map__from_mask(struct cpu_map_mask *mask)
 
 }
 
-struct cpu_map *cpu_map__new_data(struct cpu_map_data *data)
+struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data)
 {
 	if (data->type == PERF_CPU_MAP__CPUS)
 		return cpu_map__from_entries((struct cpu_map_entries *)data->data);
@@ -246,7 +246,7 @@ struct cpu_map *cpu_map__new_data(struct cpu_map_data *data)
 		return cpu_map__from_mask((struct cpu_map_mask *)data->data);
 }
 
-size_t cpu_map__fprintf(struct cpu_map *map, FILE *fp)
+size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 {
 #define BUFSIZE 1024
 	char buf[BUFSIZE];
@@ -256,9 +256,9 @@ size_t cpu_map__fprintf(struct cpu_map *map, FILE *fp)
 #undef BUFSIZE
 }
 
-struct cpu_map *cpu_map__dummy_new(void)
+struct perf_cpu_map *cpu_map__dummy_new(void)
 {
-	struct cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
+	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
 
 	if (cpus != NULL) {
 		cpus->nr = 1;
@@ -269,9 +269,9 @@ struct cpu_map *cpu_map__dummy_new(void)
 	return cpus;
 }
 
-struct cpu_map *cpu_map__empty_new(int nr)
+struct perf_cpu_map *cpu_map__empty_new(int nr)
 {
-	struct cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
+	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
 
 	if (cpus != NULL) {
 		int i;
@@ -286,7 +286,7 @@ struct cpu_map *cpu_map__empty_new(int nr)
 	return cpus;
 }
 
-static void cpu_map__delete(struct cpu_map *map)
+static void cpu_map__delete(struct perf_cpu_map *map)
 {
 	if (map) {
 		WARN_ONCE(refcount_read(&map->refcnt) != 0,
@@ -295,14 +295,14 @@ static void cpu_map__delete(struct cpu_map *map)
 	}
 }
 
-struct cpu_map *cpu_map__get(struct cpu_map *map)
+struct perf_cpu_map *cpu_map__get(struct perf_cpu_map *map)
 {
 	if (map)
 		refcount_inc(&map->refcnt);
 	return map;
 }
 
-void cpu_map__put(struct cpu_map *map)
+void cpu_map__put(struct perf_cpu_map *map)
 {
 	if (map && refcount_dec_and_test(&map->refcnt))
 		cpu_map__delete(map);
@@ -324,7 +324,7 @@ int cpu_map__get_socket_id(int cpu)
 	return ret ?: value;
 }
 
-int cpu_map__get_socket(struct cpu_map *map, int idx, void *data __maybe_unused)
+int cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data __maybe_unused)
 {
 	int cpu;
 
@@ -341,11 +341,11 @@ static int cmp_ids(const void *a, const void *b)
 	return *(int *)a - *(int *)b;
 }
 
-int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
-		       int (*f)(struct cpu_map *map, int cpu, void *data),
+int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
+		       int (*f)(struct perf_cpu_map *map, int cpu, void *data),
 		       void *data)
 {
-	struct cpu_map *c;
+	struct perf_cpu_map *c;
 	int nr = cpus->nr;
 	int cpu, s1, s2;
 
@@ -380,7 +380,7 @@ int cpu_map__get_die_id(int cpu)
 	return ret ?: value;
 }
 
-int cpu_map__get_die(struct cpu_map *map, int idx, void *data)
+int cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
 {
 	int cpu, die_id, s;
 
@@ -419,7 +419,7 @@ int cpu_map__get_core_id(int cpu)
 	return ret ?: value;
 }
 
-int cpu_map__get_core(struct cpu_map *map, int idx, void *data)
+int cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
 {
 	int cpu, s_die;
 
@@ -448,17 +448,17 @@ int cpu_map__get_core(struct cpu_map *map, int idx, void *data)
 	return (s_die << 16) | (cpu & 0xffff);
 }
 
-int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp)
+int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct perf_cpu_map **sockp)
 {
 	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
 }
 
-int cpu_map__build_die_map(struct cpu_map *cpus, struct cpu_map **diep)
+int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct perf_cpu_map **diep)
 {
 	return cpu_map__build_map(cpus, diep, cpu_map__get_die, NULL);
 }
 
-int cpu_map__build_core_map(struct cpu_map *cpus, struct cpu_map **corep)
+int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct perf_cpu_map **corep)
 {
 	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
 }
@@ -670,12 +670,12 @@ int cpu__setup_cpunode_map(void)
 	return 0;
 }
 
-bool cpu_map__has(struct cpu_map *cpus, int cpu)
+bool cpu_map__has(struct perf_cpu_map *cpus, int cpu)
 {
 	return cpu_map__idx(cpus, cpu) != -1;
 }
 
-int cpu_map__idx(struct cpu_map *cpus, int cpu)
+int cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
 {
 	int i;
 
@@ -687,12 +687,12 @@ int cpu_map__idx(struct cpu_map *cpus, int cpu)
 	return -1;
 }
 
-int cpu_map__cpu(struct cpu_map *cpus, int idx)
+int cpu_map__cpu(struct perf_cpu_map *cpus, int idx)
 {
 	return cpus->map[idx];
 }
 
-size_t cpu_map__snprint(struct cpu_map *map, char *buf, size_t size)
+size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 {
 	int i, cpu, start = -1;
 	bool first = true;
@@ -744,7 +744,7 @@ static char hex_char(unsigned char val)
 	return '?';
 }
 
-size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
+size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 {
 	int i, cpu;
 	char *ptr = buf;
@@ -781,9 +781,9 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
 	return ptr - buf;
 }
 
-const struct cpu_map *cpu_map__online(void) /* thread unsafe */
+const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 {
-	static const struct cpu_map *online = NULL;
+	static const struct perf_cpu_map *online = NULL;
 
 	if (!online)
 		online = cpu_map__new(NULL); /* from /sys/devices/system/cpu/online */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 1265f0e33920..22729beae959 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -9,35 +9,35 @@
 #include "perf.h"
 #include "util/debug.h"
 
-struct cpu_map {
+struct perf_cpu_map {
 	refcount_t refcnt;
 	int nr;
 	int map[];
 };
 
-struct cpu_map *cpu_map__new(const char *cpu_list);
-struct cpu_map *cpu_map__empty_new(int nr);
-struct cpu_map *cpu_map__dummy_new(void);
-struct cpu_map *cpu_map__new_data(struct cpu_map_data *data);
-struct cpu_map *cpu_map__read(FILE *file);
-size_t cpu_map__snprint(struct cpu_map *map, char *buf, size_t size);
-size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size);
-size_t cpu_map__fprintf(struct cpu_map *map, FILE *fp);
+struct perf_cpu_map *cpu_map__new(const char *cpu_list);
+struct perf_cpu_map *cpu_map__empty_new(int nr);
+struct perf_cpu_map *cpu_map__dummy_new(void);
+struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data);
+struct perf_cpu_map *cpu_map__read(FILE *file);
+size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
+size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
+size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
 int cpu_map__get_socket_id(int cpu);
-int cpu_map__get_socket(struct cpu_map *map, int idx, void *data);
+int cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_die_id(int cpu);
-int cpu_map__get_die(struct cpu_map *map, int idx, void *data);
+int cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_core_id(int cpu);
-int cpu_map__get_core(struct cpu_map *map, int idx, void *data);
-int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp);
-int cpu_map__build_die_map(struct cpu_map *cpus, struct cpu_map **diep);
-int cpu_map__build_core_map(struct cpu_map *cpus, struct cpu_map **corep);
-const struct cpu_map *cpu_map__online(void); /* thread unsafe */
+int cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
+int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct perf_cpu_map **sockp);
+int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct perf_cpu_map **diep);
+int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct perf_cpu_map **corep);
+const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
-struct cpu_map *cpu_map__get(struct cpu_map *map);
-void cpu_map__put(struct cpu_map *map);
+struct perf_cpu_map *cpu_map__get(struct perf_cpu_map *map);
+void cpu_map__put(struct perf_cpu_map *map);
 
-static inline int cpu_map__socket(struct cpu_map *sock, int s)
+static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
 {
 	if (!sock || s > sock->nr || s < 0)
 		return 0;
@@ -59,12 +59,12 @@ static inline int cpu_map__id_to_cpu(int id)
 	return id & 0xffff;
 }
 
-static inline int cpu_map__nr(const struct cpu_map *map)
+static inline int cpu_map__nr(const struct perf_cpu_map *map)
 {
 	return map ? map->nr : 1;
 }
 
-static inline bool cpu_map__empty(const struct cpu_map *map)
+static inline bool cpu_map__empty(const struct perf_cpu_map *map)
 {
 	return map ? map->map[0] == -1 : true;
 }
@@ -76,11 +76,11 @@ int cpu__max_cpu(void);
 int cpu__max_present_cpu(void);
 int cpu__get_node(int cpu);
 
-int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
-		       int (*f)(struct cpu_map *map, int cpu, void *data),
+int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
+		       int (*f)(struct perf_cpu_map *map, int cpu, void *data),
 		       void *data);
 
-int cpu_map__cpu(struct cpu_map *cpus, int idx);
-bool cpu_map__has(struct cpu_map *cpus, int cpu);
-int cpu_map__idx(struct cpu_map *cpus, int cpu);
+int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
+bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
+int cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 64336a280967..157b0988435e 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -176,7 +176,7 @@ struct cpu_topology *cpu_topology__new(void)
 	size_t sz;
 	long ncpus;
 	int ret = -1;
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 	bool has_die = has_die_topology();
 
 	ncpus = cpu__max_present_cpu();
@@ -289,7 +289,7 @@ static int load_numa_node(struct numa_topology_node *node, int nr)
 
 struct numa_topology *numa_topology__new(void)
 {
-	struct cpu_map *node_map = NULL;
+	struct perf_cpu_map *node_map = NULL;
 	struct numa_topology *tp = NULL;
 	char path[MAXPATHLEN];
 	char *buf = NULL;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d5d9865aa812..d8e083d42610 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -27,7 +27,7 @@ struct numa_node {
 	u32		 node;
 	u64		 mem_total;
 	u64		 mem_free;
-	struct cpu_map	*map;
+	struct perf_cpu_map	*map;
 };
 
 struct memory_node {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f1f4848947ce..406ad8772907 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1008,7 +1008,7 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 }
 
 static void synthesize_cpus(struct cpu_map_entries *cpus,
-			    struct cpu_map *map)
+			    struct perf_cpu_map *map)
 {
 	int i;
 
@@ -1019,7 +1019,7 @@ static void synthesize_cpus(struct cpu_map_entries *cpus,
 }
 
 static void synthesize_mask(struct cpu_map_mask *mask,
-			    struct cpu_map *map, int max)
+			    struct perf_cpu_map *map, int max)
 {
 	int i;
 
@@ -1030,12 +1030,12 @@ static void synthesize_mask(struct cpu_map_mask *mask,
 		set_bit(map->map[i], mask->mask);
 }
 
-static size_t cpus_size(struct cpu_map *map)
+static size_t cpus_size(struct perf_cpu_map *map)
 {
 	return sizeof(struct cpu_map_entries) + map->nr * sizeof(u16);
 }
 
-static size_t mask_size(struct cpu_map *map, int *max)
+static size_t mask_size(struct perf_cpu_map *map, int *max)
 {
 	int i;
 
@@ -1052,7 +1052,7 @@ static size_t mask_size(struct cpu_map *map, int *max)
 	return sizeof(struct cpu_map_mask) + BITS_TO_LONGS(*max) * sizeof(long);
 }
 
-void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max)
+void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max)
 {
 	size_t size_cpus, size_mask;
 	bool is_dummy = cpu_map__empty(map);
@@ -1086,7 +1086,7 @@ void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max
 	return zalloc(*size);
 }
 
-void cpu_map_data__synthesize(struct cpu_map_data *data, struct cpu_map *map,
+void cpu_map_data__synthesize(struct cpu_map_data *data, struct perf_cpu_map *map,
 			      u16 type, int max)
 {
 	data->type = type;
@@ -1102,7 +1102,7 @@ void cpu_map_data__synthesize(struct cpu_map_data *data, struct cpu_map *map,
 	};
 }
 
-static struct cpu_map_event* cpu_map_event__new(struct cpu_map *map)
+static struct cpu_map_event* cpu_map_event__new(struct perf_cpu_map *map)
 {
 	size_t size = sizeof(struct cpu_map_event);
 	struct cpu_map_event *event;
@@ -1122,7 +1122,7 @@ static struct cpu_map_event* cpu_map_event__new(struct cpu_map *map)
 }
 
 int perf_event__synthesize_cpu_map(struct perf_tool *tool,
-				   struct cpu_map *map,
+				   struct perf_cpu_map *map,
 				   perf_event__handler_t process,
 				   struct machine *machine)
 {
@@ -1393,7 +1393,7 @@ size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp)
 {
-	struct cpu_map *cpus = cpu_map__new_data(&event->cpu_map.data);
+	struct perf_cpu_map *cpus = cpu_map__new_data(&event->cpu_map.data);
 	size_t ret;
 
 	ret = fprintf(fp, ": ");
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 1f1da6082806..cafaac5128ab 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -675,7 +675,7 @@ void perf_event__print_totals(void);
 
 struct perf_tool;
 struct thread_map;
-struct cpu_map;
+struct perf_cpu_map;
 struct perf_stat_config;
 struct perf_counts_values;
 
@@ -693,7 +693,7 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 				      perf_event__handler_t process,
 				      struct machine *machine);
 int perf_event__synthesize_cpu_map(struct perf_tool *tool,
-				   struct cpu_map *cpus,
+				   struct perf_cpu_map *cpus,
 				   perf_event__handler_t process,
 				   struct machine *machine);
 int perf_event__synthesize_threads(struct perf_tool *tool,
@@ -844,8 +844,8 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 int kallsyms__get_function_start(const char *kallsyms_filename,
 				 const char *symbol_name, u64 *addr);
 
-void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max);
-void  cpu_map_data__synthesize(struct cpu_map_data *data, struct cpu_map *map,
+void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max);
+void  cpu_map_data__synthesize(struct cpu_map_data *data, struct perf_cpu_map *map,
 			       u16 type, int max);
 
 void event_attr_init(struct perf_event_attr *attr);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b0364d923f76..bce883eaf0dc 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -41,7 +41,7 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
-void perf_evlist__init(struct perf_evlist *evlist, struct cpu_map *cpus,
+void perf_evlist__init(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
 		       struct thread_map *threads)
 {
 	int i;
@@ -1012,7 +1012,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 int comp_level)
 {
 	struct perf_evsel *evsel;
-	const struct cpu_map *cpus = evlist->cpus;
+	const struct perf_cpu_map *cpus = evlist->cpus;
 	const struct thread_map *threads = evlist->threads;
 	/*
 	 * Delay setting mp.prot: set it before calling perf_mmap__mmap.
@@ -1058,7 +1058,7 @@ int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
 {
 	bool all_threads = (target->per_thread && target->system_wide);
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	struct thread_map *threads;
 
 	/*
@@ -1104,7 +1104,7 @@ int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
 	return -1;
 }
 
-void perf_evlist__set_maps(struct perf_evlist *evlist, struct cpu_map *cpus,
+void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
 			   struct thread_map *threads)
 {
 	/*
@@ -1358,7 +1358,7 @@ void perf_evlist__close(struct perf_evlist *evlist)
 
 static int perf_evlist__create_syswide_maps(struct perf_evlist *evlist)
 {
-	struct cpu_map	  *cpus;
+	struct perf_cpu_map *cpus;
 	struct thread_map *threads;
 	int err = -ENOMEM;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 49354fe24d5f..c8cda300b584 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -18,7 +18,7 @@
 
 struct pollfd;
 struct thread_map;
-struct cpu_map;
+struct perf_cpu_map;
 struct record_opts;
 
 #define PERF_EVLIST__HLIST_BITS 8
@@ -45,7 +45,7 @@ struct perf_evlist {
 	struct perf_mmap *mmap;
 	struct perf_mmap *overwrite_mmap;
 	struct thread_map *threads;
-	struct cpu_map	  *cpus;
+	struct perf_cpu_map *cpus;
 	struct perf_evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
@@ -68,7 +68,7 @@ struct perf_evsel_str_handler {
 struct perf_evlist *perf_evlist__new(void);
 struct perf_evlist *perf_evlist__new_default(void);
 struct perf_evlist *perf_evlist__new_dummy(void);
-void perf_evlist__init(struct perf_evlist *evlist, struct cpu_map *cpus,
+void perf_evlist__init(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
 		       struct thread_map *threads);
 void perf_evlist__exit(struct perf_evlist *evlist);
 void perf_evlist__delete(struct perf_evlist *evlist);
@@ -194,7 +194,7 @@ int perf_evlist__enable_event_idx(struct perf_evlist *evlist,
 void perf_evlist__set_selected(struct perf_evlist *evlist,
 			       struct perf_evsel *evsel);
 
-void perf_evlist__set_maps(struct perf_evlist *evlist, struct cpu_map *cpus,
+void perf_evlist__set_maps(struct perf_evlist *evlist, struct perf_cpu_map *cpus,
 			   struct thread_map *threads);
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target);
 int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **err_evsel);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d23b9574f793..958206c538c3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1825,7 +1825,7 @@ static int perf_event_open(struct perf_evsel *evsel,
 	return fd;
 }
 
-int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
+int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 		     struct thread_map *threads)
 {
 	int cpu, thread, nthreads;
@@ -1837,7 +1837,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		return -EINVAL;
 
 	if (cpus == NULL) {
-		static struct cpu_map *empty_cpu_map;
+		static struct perf_cpu_map *empty_cpu_map;
 
 		if (empty_cpu_map == NULL) {
 			empty_cpu_map = cpu_map__dummy_new();
@@ -2084,7 +2084,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
 }
 
 int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
-			     struct cpu_map *cpus)
+			     struct perf_cpu_map *cpus)
 {
 	return perf_evsel__open(evsel, cpus, NULL);
 }
@@ -3064,7 +3064,7 @@ static int store_evsel_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
 
 int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
 {
-	struct cpu_map *cpus = evsel->cpus;
+	struct perf_cpu_map *cpus = evsel->cpus;
 	struct thread_map *threads = evsel->threads;
 
 	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b27935a6d36c..76b14037f260 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -124,8 +124,8 @@ struct perf_evsel {
 	u64			db_id;
 	struct cgroup		*cgrp;
 	void			*handler;
-	struct cpu_map		*cpus;
-	struct cpu_map		*own_cpus;
+	struct perf_cpu_map	*cpus;
+	struct perf_cpu_map	*own_cpus;
 	struct thread_map	*threads;
 	unsigned int		sample_size;
 	int			id_pos;
@@ -192,12 +192,12 @@ struct perf_missing_features {
 
 extern struct perf_missing_features perf_missing_features;
 
-struct cpu_map;
+struct perf_cpu_map;
 struct target;
 struct thread_map;
 struct record_opts;
 
-static inline struct cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
+static inline struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
 {
 	return evsel->cpus;
 }
@@ -300,10 +300,10 @@ int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
 int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
-			     struct cpu_map *cpus);
+			     struct perf_cpu_map *cpus);
 int perf_evsel__open_per_thread(struct perf_evsel *evsel,
 				struct thread_map *threads);
-int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
+int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 		     struct thread_map *threads);
 void perf_evsel__close(struct perf_evsel *evsel);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 20111f8da5cb..496c0ab851ca 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3879,7 +3879,7 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 	struct event_update_event *ev = &event->event_update;
 	struct event_update_event_scale *ev_scale;
 	struct event_update_event_cpus *ev_cpus;
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 	size_t ret;
 
 	ret = fprintf(fp, "\n... id:    %" PRIu64 "\n", ev->id);
@@ -4047,7 +4047,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 	struct event_update_event_cpus *ev_cpus;
 	struct perf_evlist *evlist;
 	struct perf_evsel *evsel;
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 
 	if (!pevlist || *pevlist == NULL)
 		return -EINVAL;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 9f0b6391af33..177c41fc9842 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -325,7 +325,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 static void build_node_mask(int node, cpu_set_t *mask)
 {
 	int c, cpu, nr_cpus;
-	const struct cpu_map *cpu_map = NULL;
+	const struct perf_cpu_map *cpu_map = NULL;
 
 	cpu_map = cpu_map__online();
 	if (!cpu_map)
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0540303e5e97..077509609d03 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -322,7 +322,7 @@ __add_event(struct list_head *list, int *idx,
 	    const char *cpu_list)
 {
 	struct perf_evsel *evsel;
-	struct cpu_map *cpus = pmu ? pmu->cpus :
+	struct perf_cpu_map *cpus = pmu ? pmu->cpus :
 			       cpu_list ? cpu_map__new(cpu_list) : NULL;
 
 	event_attr_init(attr);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f32b710347db..4929a50c0973 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -572,10 +572,10 @@ static void pmu_read_sysfs(void)
 	closedir(dir);
 }
 
-static struct cpu_map *__pmu_cpumask(const char *path)
+static struct perf_cpu_map *__pmu_cpumask(const char *path)
 {
 	FILE *file;
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 
 	file = fopen(path, "r");
 	if (!file)
@@ -593,10 +593,10 @@ static struct cpu_map *__pmu_cpumask(const char *path)
 #define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
 #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
 
-static struct cpu_map *pmu_cpumask(const char *name)
+static struct perf_cpu_map *pmu_cpumask(const char *name)
 {
 	char path[PATH_MAX];
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	const char *sysfs = sysfs__mountpoint();
 	const char *templates[] = {
 		CPUS_TEMPLATE_UNCORE,
@@ -621,7 +621,7 @@ static struct cpu_map *pmu_cpumask(const char *name)
 static bool pmu_is_uncore(const char *name)
 {
 	char path[PATH_MAX];
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	const char *sysfs = sysfs__mountpoint();
 
 	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index bd9ec2704a57..3f8b79b1dd85 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -28,7 +28,7 @@ struct perf_pmu {
 	bool is_uncore;
 	int max_precise;
 	struct perf_event_attr *default_config;
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1e5b6718dcea..be27956ae080 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -536,7 +536,7 @@ static PyObject *pyrf_event__new(union perf_event *event)
 struct pyrf_cpu_map {
 	PyObject_HEAD
 
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 };
 
 static int pyrf_cpu_map__init(struct pyrf_cpu_map *pcpus,
@@ -796,7 +796,7 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
 	struct perf_evsel *evsel = &pevsel->evsel;
-	struct cpu_map *cpus = NULL;
+	struct perf_cpu_map *cpus = NULL;
 	struct thread_map *threads = NULL;
 	PyObject *pcpus = NULL, *pthreads = NULL;
 	int group = 0, inherit = 0;
@@ -865,7 +865,7 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 			     PyObject *args, PyObject *kwargs __maybe_unused)
 {
 	PyObject *pcpus = NULL, *pthreads = NULL;
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	struct thread_map *threads;
 
 	if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads))
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 9cfc7bf16531..051c67f82548 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -60,7 +60,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 static bool perf_probe_api(setup_probe_fn_t fn)
 {
 	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	int cpu, ret, i = 0;
 
 	cpus = cpu_map__new(NULL);
@@ -115,7 +115,7 @@ bool perf_can_record_cpu_wide(void)
 		.config = PERF_COUNT_SW_CPU_CLOCK,
 		.exclude_kernel = 1,
 	};
-	struct cpu_map *cpus;
+	struct perf_cpu_map *cpus;
 	int cpu, fd;
 
 	cpus = cpu_map__new(NULL);
@@ -275,7 +275,7 @@ bool perf_evlist__can_select_event(struct perf_evlist *evlist, const char *str)
 	evsel = perf_evlist__last(temp_evlist);
 
 	if (!evlist || cpu_map__empty(evlist->cpus)) {
-		struct cpu_map *cpus = cpu_map__new(NULL);
+		struct perf_cpu_map *cpus = cpu_map__new(NULL);
 
 		cpu =  cpus ? cpus->map[0] : 0;
 		cpu_map__put(cpus);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 25dc1d765553..a53b30b8819b 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1393,7 +1393,7 @@ static void python_process_stat(struct perf_stat_config *config,
 				struct perf_evsel *counter, u64 tstamp)
 {
 	struct thread_map *threads = counter->threads;
-	struct cpu_map *cpus = counter->cpus;
+	struct perf_cpu_map *cpus = counter->cpus;
 	int cpu, thread;
 
 	if (config->aggr_mode == AGGR_GLOBAL) {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 37efa1f43d8b..69d1d158a610 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2273,7 +2273,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 			     const char *cpu_list, unsigned long *cpu_bitmap)
 {
 	int i, err = -1;
-	struct cpu_map *map;
+	struct perf_cpu_map *map;
 
 	for (i = 0; i < PERF_TYPE_MAX; ++i) {
 		struct perf_evsel *evsel;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index db8a6cf336be..62791c063f7a 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -215,7 +215,7 @@ static int check_per_pkg(struct perf_evsel *counter,
 			 struct perf_counts_values *vals, int cpu, bool *skip)
 {
 	unsigned long *mask = counter->per_pkg_mask;
-	struct cpu_map *cpus = perf_evsel__cpus(counter);
+	struct perf_cpu_map *cpus = perf_evsel__cpus(counter);
 	int s;
 
 	*skip = false;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 7032dd1eeac2..fa675d09febd 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -92,7 +92,7 @@ struct runtime_stat {
 };
 
 typedef int (*aggr_get_id_t)(struct perf_stat_config *config,
-			     struct cpu_map *m, int cpu);
+			     struct perf_cpu_map *m, int cpu);
 
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
@@ -122,9 +122,9 @@ struct perf_stat_config {
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
-	struct cpu_map		*aggr_map;
+	struct perf_cpu_map		*aggr_map;
 	aggr_get_id_t		 aggr_get_id;
-	struct cpu_map		*cpus_aggr_map;
+	struct perf_cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
 };
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 76cc54000483..99132c6a30a6 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -728,7 +728,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 {
 	int i;
 	int ret = 0;
-	struct cpu_map *m;
+	struct perf_cpu_map *m;
 	int c;
 
 	m = cpu_map__new(s);
-- 
2.21.0

