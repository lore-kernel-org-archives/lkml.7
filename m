Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC01BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A306F21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394545AbfHWMWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:22:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394488AbfHWMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:21:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18ZX-0001gV-7y; Fri, 23 Aug 2019 14:21:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D59401C08AE;
        Fri, 23 Aug 2019 14:21:38 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:21:38 -0000
From:   tip-bot2 for Jiri Olsa <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Move perf's cpu_map__empty() to
 perf_cpu_map__empty()
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190822111141.25823-4-jolsa@kernel.org>
References: <20190822111141.25823-4-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156656289877.31542.9839754581157515122.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     315c0a1f0ccdd44c65f80ccbc62202fed8a23050
Gitweb:        https://git.kernel.org/tip/315c0a1f0ccdd44c65f80ccbc62202fed8a23050
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 22 Aug 2019 13:11:39 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 11:17:03 -03:00

libperf: Move perf's cpu_map__empty() to perf_cpu_map__empty()

So it's part of the libperf library as one of basic functions operating
on the perf_cpu_map class.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190822111141.25823-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c    |  8 ++++----
 tools/perf/arch/x86/util/intel-bts.c |  4 ++--
 tools/perf/arch/x86/util/intel-pt.c  | 10 +++++-----
 tools/perf/builtin-c2c.c             |  2 +-
 tools/perf/builtin-stat.c            |  4 ++--
 tools/perf/lib/cpumap.c              |  5 +++++
 tools/perf/lib/include/perf/cpumap.h |  2 ++
 tools/perf/lib/libperf.map           |  1 +
 tools/perf/util/cpumap.c             |  6 +++---
 tools/perf/util/cpumap.h             |  7 +------
 tools/perf/util/event.c              |  2 +-
 tools/perf/util/evlist.c             |  6 +++---
 tools/perf/util/record.c             |  2 +-
 tools/perf/util/stat.c               |  2 +-
 14 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c786ab0..c73da32 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -396,7 +396,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * AUX event.  We also need the contextID in order to be notified
 	 * when a context switch happened.
 	 */
-	if (!cpu_map__empty(cpus)) {
+	if (!perf_cpu_map__empty(cpus)) {
 		perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
 
 		err = cs_etm_set_option(itr, cs_etm_evsel,
@@ -420,7 +420,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		tracking_evsel->core.attr.sample_period = 1;
 
 		/* In per-cpu case, always need the time of mmap events etc */
-		if (!cpu_map__empty(cpus))
+		if (!perf_cpu_map__empty(cpus))
 			perf_evsel__set_sample_bit(tracking_evsel, TIME);
 	}
 
@@ -493,7 +493,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
 
 	/* cpu map is not empty, we have specific CPUs to work with */
-	if (!cpu_map__empty(event_cpus)) {
+	if (!perf_cpu_map__empty(event_cpus)) {
 		for (i = 0; i < cpu__max_cpu(); i++) {
 			if (!cpu_map__has(event_cpus, i) ||
 			    !cpu_map__has(online_cpus, i))
@@ -649,7 +649,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 		return -EINVAL;
 
 	/* If the cpu_map is empty all online CPUs are involved */
-	if (cpu_map__empty(event_cpus)) {
+	if (perf_cpu_map__empty(event_cpus)) {
 		cpu_map = online_cpus;
 	} else {
 		/* Make sure all specified CPUs are online */
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 7b23318..2d5d8a1 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -133,7 +133,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	if (!opts->full_auxtrace)
 		return 0;
 
-	if (opts->full_auxtrace && !cpu_map__empty(cpus)) {
+	if (opts->full_auxtrace && !perf_cpu_map__empty(cpus)) {
 		pr_err(INTEL_BTS_PMU_NAME " does not support per-cpu recording\n");
 		return -EINVAL;
 	}
@@ -214,7 +214,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!cpu_map__empty(cpus))
+		if (!perf_cpu_map__empty(cpus))
 			perf_evsel__set_sample_bit(intel_bts_evsel, CPU);
 	}
 
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index a8e633a..c72a77a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -365,7 +365,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 			ui__warning("Intel Processor Trace: TSC not available\n");
 	}
 
-	per_cpu_mmaps = !cpu_map__empty(session->evlist->core.cpus);
+	per_cpu_mmaps = !perf_cpu_map__empty(session->evlist->core.cpus);
 
 	auxtrace_info->type = PERF_AUXTRACE_INTEL_PT;
 	auxtrace_info->priv[INTEL_PT_PMU_TYPE] = intel_pt_pmu->type;
@@ -702,7 +702,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Per-cpu recording needs sched_switch events to distinguish different
 	 * threads.
 	 */
-	if (have_timing_info && !cpu_map__empty(cpus)) {
+	if (have_timing_info && !perf_cpu_map__empty(cpus)) {
 		if (perf_can_record_switch_events()) {
 			bool cpu_wide = !target__none(&opts->target) &&
 					!target__has_task(&opts->target);
@@ -760,7 +760,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!cpu_map__empty(cpus))
+		if (!perf_cpu_map__empty(cpus))
 			perf_evsel__set_sample_bit(intel_pt_evsel, CPU);
 	}
 
@@ -784,7 +784,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			tracking_evsel->immediate = true;
 
 		/* In per-cpu case, always need the time of mmap events etc */
-		if (!cpu_map__empty(cpus)) {
+		if (!perf_cpu_map__empty(cpus)) {
 			perf_evsel__set_sample_bit(tracking_evsel, TIME);
 			/* And the CPU for switch events */
 			perf_evsel__set_sample_bit(tracking_evsel, CPU);
@@ -796,7 +796,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Warn the user when we do not have enough information to decode i.e.
 	 * per-cpu with no sched_switch (except workload-only).
 	 */
-	if (!ptr->have_sched_switch && !cpu_map__empty(cpus) &&
+	if (!ptr->have_sched_switch && !perf_cpu_map__empty(cpus) &&
 	    !target__none(&opts->target))
 		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
 
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f0aae6e..01629f5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2059,7 +2059,7 @@ static int setup_nodes(struct perf_session *session)
 		nodes[node] = set;
 
 		/* empty node, skip */
-		if (cpu_map__empty(map))
+		if (perf_cpu_map__empty(map))
 			continue;
 
 		for (cpu = 0; cpu < map->nr; cpu++) {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b19df67..90636a8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -928,7 +928,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * the aggregation translate cpumap.
 	 */
 	nr = cpu_map__get_max(evsel_list->core.cpus);
-	stat_config.cpus_aggr_map = cpu_map__empty_new(nr + 1);
+	stat_config.cpus_aggr_map = perf_cpu_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
 
@@ -1493,7 +1493,7 @@ int process_stat_config_event(struct perf_session *session,
 
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
 
-	if (cpu_map__empty(st->cpus)) {
+	if (perf_cpu_map__empty(st->cpus)) {
 		if (st->aggr_mode != AGGR_UNSET)
 			pr_warning("warning: processing task data, aggregation mode not set\n");
 		return 0;
diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 1ddb69e..63f7df7 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -237,3 +237,8 @@ int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
 	return cpus ? cpus->nr : 1;
 }
+
+bool perf_cpu_map__empty(const struct perf_cpu_map *map)
+{
+	return map ? map->map[0] == -1 : true;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index 1b6e7db..8aa995c 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -4,6 +4,7 @@
 
 #include <perf/core.h>
 #include <stdio.h>
+#include <stdbool.h>
 
 struct perf_cpu_map;
 
@@ -14,6 +15,7 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
+LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index e24d3ce..3373dd5 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -8,6 +8,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__read;
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
+		perf_cpu_map__empty;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index beb3525..4402e67 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -21,7 +21,7 @@ static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
 {
 	struct perf_cpu_map *map;
 
-	map = cpu_map__empty_new(cpus->nr);
+	map = perf_cpu_map__empty_new(cpus->nr);
 	if (map) {
 		unsigned i;
 
@@ -48,7 +48,7 @@ static struct perf_cpu_map *cpu_map__from_mask(struct cpu_map_mask *mask)
 
 	nr = bitmap_weight(mask->mask, nbits);
 
-	map = cpu_map__empty_new(nr);
+	map = perf_cpu_map__empty_new(nr);
 	if (map) {
 		int cpu, i = 0;
 
@@ -77,7 +77,7 @@ size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 #undef BUFSIZE
 }
 
-struct perf_cpu_map *cpu_map__empty_new(int nr)
+struct perf_cpu_map *perf_cpu_map__empty_new(int nr)
 {
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 77f85e9..3e06809 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -11,7 +11,7 @@
 #include "perf.h"
 #include "util/debug.h"
 
-struct perf_cpu_map *cpu_map__empty_new(int nr);
+struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
 struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
@@ -49,11 +49,6 @@ static inline int cpu_map__id_to_cpu(int id)
 	return id & 0xffff;
 }
 
-static inline bool cpu_map__empty(const struct perf_cpu_map *map)
-{
-	return map ? map->map[0] == -1 : true;
-}
-
 int cpu__setup_cpunode_map(void);
 
 int cpu__max_node(void);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f440fdc..f433da8 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1055,7 +1055,7 @@ static size_t mask_size(struct perf_cpu_map *map, int *max)
 void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max)
 {
 	size_t size_cpus, size_mask;
-	bool is_dummy = cpu_map__empty(map);
+	bool is_dummy = perf_cpu_map__empty(map);
 
 	/*
 	 * Both array and mask data have variable size based
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 15d1046..ba49b5e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -386,7 +386,7 @@ static int perf_evlist__enable_event_thread(struct evlist *evlist,
 int perf_evlist__enable_event_idx(struct evlist *evlist,
 				  struct evsel *evsel, int idx)
 {
-	bool per_cpu_mmaps = !cpu_map__empty(evlist->core.cpus);
+	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.cpus);
 
 	if (per_cpu_mmaps)
 		return perf_evlist__enable_event_cpu(evlist, evsel, idx);
@@ -693,7 +693,7 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
 	struct perf_mmap *map;
 
 	evlist->nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
-	if (cpu_map__empty(evlist->core.cpus))
+	if (perf_cpu_map__empty(evlist->core.cpus))
 		evlist->nr_mmaps = thread_map__nr(evlist->core.threads);
 	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
 	if (!map)
@@ -1018,7 +1018,7 @@ int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			return -ENOMEM;
 	}
 
-	if (cpu_map__empty(cpus))
+	if (perf_cpu_map__empty(cpus))
 		return perf_evlist__mmap_per_thread(evlist, &mp);
 
 	return perf_evlist__mmap_per_cpu(evlist, &mp);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index e59382d..51bbd07 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -275,7 +275,7 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
 
 	evsel = perf_evlist__last(temp_evlist);
 
-	if (!evlist || cpu_map__empty(evlist->core.cpus)) {
+	if (!evlist || perf_cpu_map__empty(evlist->core.cpus)) {
 		struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
 
 		cpu =  cpus ? cpus->map[0] : 0;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index e4e4e3b..2715112 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -223,7 +223,7 @@ static int check_per_pkg(struct evsel *counter,
 	if (!counter->per_pkg)
 		return 0;
 
-	if (cpu_map__empty(cpus))
+	if (perf_cpu_map__empty(cpus))
 		return 0;
 
 	if (!mask) {
