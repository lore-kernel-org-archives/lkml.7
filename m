Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8E1C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E242064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ugx3OLSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfG3SeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:34:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46423 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfG3SeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:34:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIY85p3331130
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:34:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIY85p3331130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511649;
        bh=CvdT+2Dm2d8FTyn57UqIzYu2/qRTpPFMFFVWZctZ408=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ugx3OLSk96OlNwNMUaz5PMUVyi+7mXkcN/5Qlwrpzfbln80xYCxJtEGee3Oedi02X
         U+nGZ5h1NUPvYdoqhS295bEtwCVr1LqNw1RH+qKKmjqLxz3PT6zjztaWGdcHhe2TPO
         LodkfQQr1Q3lFcnBjH56R92R+bMhMFZToV0cOlrrr4Pmy9LS6sqTsaIm48MagGEfDD
         e4haEP3Jy9+DfzPYjzWHBf2/MrEaw9eRfgPArbJQlkGwR40XZmEZhA63IoNxGFnjqj
         Wek+7eP+lWgpfUZHD40XOY5SRWkuS58QyPV1zsCyWEej+uKYohFkxfx0fQ0me6JffT
         XLR9JO3v8tB0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIY7wN3331124;
        Tue, 30 Jul 2019 11:34:07 -0700
Date:   Tue, 30 Jul 2019 11:34:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ce9036a6e3bdfac6c7ccf8221aec9bcf9c2d355e@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mpetlan@redhat.com, ak@linux.intel.com, acme@redhat.com,
        jolsa@kernel.org, alexey.budankov@linux.intel.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, tglx@linutronix.de, jolsa@kernel.org,
          alexey.budankov@linux.intel.com, acme@redhat.com,
          ak@linux.intel.com, namhyung@kernel.org, mpetlan@redhat.com
In-Reply-To: <20190721112506.12306-37-jolsa@kernel.org>
References: <20190721112506.12306-37-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Include perf_evlist in evlist object
Git-Commit-ID: ce9036a6e3bdfac6c7ccf8221aec9bcf9c2d355e
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

Commit-ID:  ce9036a6e3bdfac6c7ccf8221aec9bcf9c2d355e
Gitweb:     https://git.kernel.org/tip/ce9036a6e3bdfac6c7ccf8221aec9bcf9c2d355e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:23 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Include perf_evlist in evlist object

Include perf_evlist in the evlist object, will continue to move other
generic things into libperf's perf_evlist.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-37-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c    |  4 ++--
 tools/perf/builtin-sched.c     |  2 +-
 tools/perf/builtin-trace.c     |  2 +-
 tools/perf/ui/browsers/hists.c |  6 +++---
 tools/perf/util/cgroup.c       |  2 +-
 tools/perf/util/evlist.c       |  8 ++++----
 tools/perf/util/evlist.h       | 17 +++++++++--------
 tools/perf/util/header.c       |  4 ++--
 tools/perf/util/parse-events.c |  2 +-
 tools/perf/util/stat-display.c |  4 ++--
 10 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 03fbe4600ca0..17bb0a536da3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1002,7 +1002,7 @@ static void record__init_features(struct record *rec)
 	if (rec->no_buildid)
 		perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 
-	if (!have_tracepoints(&rec->evlist->entries))
+	if (!have_tracepoints(&rec->evlist->core.entries))
 		perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
 
 	if (!rec->opts.branch_stack)
@@ -1218,7 +1218,7 @@ static int record__synthesize(struct record *rec, bool tail)
 			return err;
 		}
 
-		if (have_tracepoints(&rec->evlist->entries)) {
+		if (have_tracepoints(&rec->evlist->core.entries)) {
 			/*
 			 * FIXME err <= 0 here actually means that
 			 * there were no tracepoints so its not really
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 70247f1b23da..897d11c8ca2e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2929,7 +2929,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 	struct evsel *evsel;
 	struct evsel_runtime *er;
 
-	list_for_each_entry(evsel, &evlist->entries, core.node) {
+	list_for_each_entry(evsel, &evlist->core.entries, core.node) {
 		er = perf_evsel__get_runtime(evsel);
 		if (er == NULL) {
 			pr_err("Failed to allocate memory for evsel runtime data\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 29dbf99f6081..bcd033e91de4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3980,7 +3980,7 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 {
 	struct trace *trace = opt->value;
 
-	if (!list_empty(&trace->evlist->entries))
+	if (!list_empty(&trace->evlist->core.entries))
 		return parse_cgroups(opt, str, unset);
 
 	trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 280347499c50..ed5406ff9fe4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3309,13 +3309,13 @@ browse_hists:
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
-				if (pos->core.node.next == &evlist->entries)
+				if (pos->core.node.next == &evlist->core.entries)
 					pos = perf_evlist__first(evlist);
 				else
 					pos = perf_evsel__next(pos);
 				goto browse_hists;
 			case K_UNTAB:
-				if (pos->core.node.prev == &evlist->entries)
+				if (pos->core.node.prev == &evlist->core.entries)
 					pos = perf_evlist__last(evlist);
 				else
 					pos = perf_evsel__prev(pos);
@@ -3370,7 +3370,7 @@ static int __perf_evlist__tui_browse_hists(struct evlist *evlist,
 	struct evsel *pos;
 	struct evsel_menu menu = {
 		.b = {
-			.entries    = &evlist->entries,
+			.entries    = &evlist->core.entries,
 			.refresh    = ui_browser__list_head_refresh,
 			.seek	    = ui_browser__list_head_seek,
 			.write	    = perf_evsel_menu__write,
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index deb87ecd3671..f73599f271ff 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -208,7 +208,7 @@ int parse_cgroups(const struct option *opt, const char *str,
 	char *s;
 	int ret, i;
 
-	if (list_empty(&evlist->entries)) {
+	if (list_empty(&evlist->core.entries)) {
 		fprintf(stderr, "must define events before cgroups\n");
 		return -1;
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 227576bf16c0..faf3ffd81d4c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -48,7 +48,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 
 	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
-	INIT_LIST_HEAD(&evlist->entries);
+	INIT_LIST_HEAD(&evlist->core.entries);
 	perf_evlist__set_maps(evlist, cpus, threads);
 	fdarray__init(&evlist->pollfd, 64);
 	evlist->workload.pid = -1;
@@ -180,7 +180,7 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
-	list_add_tail(&entry->core.node, &evlist->entries);
+	list_add_tail(&entry->core.node, &evlist->core.entries);
 	entry->idx = evlist->nr_entries;
 	entry->tracking = !entry->idx;
 
@@ -226,7 +226,7 @@ void perf_evlist__set_leader(struct evlist *evlist)
 {
 	if (evlist->nr_entries) {
 		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
-		__perf_evlist__set_leader(&evlist->entries);
+		__perf_evlist__set_leader(&evlist->core.entries);
 	}
 }
 
@@ -1683,7 +1683,7 @@ void perf_evlist__to_front(struct evlist *evlist,
 			list_move_tail(&evsel->core.node, &move);
 	}
 
-	list_splice(&move, &evlist->entries);
+	list_splice(&move, &evlist->core.entries);
 }
 
 void perf_evlist__set_tracking_event(struct evlist *evlist,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1315e64ad69e..7117378a08e3 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <api/fd/array.h>
 #include <stdio.h>
+#include <internal/evlist.h>
 #include "../perf.h"
 #include "event.h"
 #include "evsel.h"
@@ -25,7 +26,7 @@ struct record_opts;
 #define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
 
 struct evlist {
-	struct list_head entries;
+	struct perf_evlist core;
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_entries;
 	int		 nr_groups;
@@ -225,17 +226,17 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
 
 static inline bool perf_evlist__empty(struct evlist *evlist)
 {
-	return list_empty(&evlist->entries);
+	return list_empty(&evlist->core.entries);
 }
 
 static inline struct evsel *perf_evlist__first(struct evlist *evlist)
 {
-	return list_entry(evlist->entries.next, struct evsel, core.node);
+	return list_entry(evlist->core.entries.next, struct evsel, core.node);
 }
 
 static inline struct evsel *perf_evlist__last(struct evlist *evlist)
 {
-	return list_entry(evlist->entries.prev, struct evsel, core.node);
+	return list_entry(evlist->core.entries.prev, struct evsel, core.node);
 }
 
 size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp);
@@ -261,7 +262,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define evlist__for_each_entry(evlist, evsel) \
-	__evlist__for_each_entry(&(evlist)->entries, evsel)
+	__evlist__for_each_entry(&(evlist)->core.entries, evsel)
 
 /**
  * __evlist__for_each_entry_continue - continue iteration thru all the evsels
@@ -277,7 +278,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define evlist__for_each_entry_continue(evlist, evsel) \
-	__evlist__for_each_entry_continue(&(evlist)->entries, evsel)
+	__evlist__for_each_entry_continue(&(evlist)->core.entries, evsel)
 
 /**
  * __evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
@@ -293,7 +294,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define evlist__for_each_entry_reverse(evlist, evsel) \
-	__evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
+	__evlist__for_each_entry_reverse(&(evlist)->core.entries, evsel)
 
 /**
  * __evlist__for_each_entry_safe - safely iterate thru all the evsels
@@ -311,7 +312,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @tmp: struct evsel temp iterator
  */
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
-	__evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
+	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
 
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 5e0093251f26..70ab6b8c715b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -304,7 +304,7 @@ static int write_tracing_data(struct feat_fd *ff,
 	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
 		return -1;
 
-	return read_tracing_data(ff->fd, &evlist->entries);
+	return read_tracing_data(ff->fd, &evlist->core.entries);
 }
 
 static int write_build_id(struct feat_fd *ff,
@@ -4112,7 +4112,7 @@ int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd,
 	 * - write the tracing data from the temp file
 	 *   to the pipe
 	 */
-	tdata = tracing_data_get(&evlist->entries, fd, true);
+	tdata = tracing_data_get(&evlist->core.entries, fd, true);
 	if (!tdata)
 		return -1;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e111c0e0a5ac..a0b7d68d2f8e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2050,7 +2050,7 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 		if (!last)
 			return 0;
 
-		if (last->core.node.prev == &evlist->entries)
+		if (last->core.node.prev == &evlist->core.entries)
 			return 0;
 		last = list_entry(last->core.node.prev, struct evsel, core.node);
 	} while (!last->cmdline_group_boundary);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 17b7d3b55b5f..b1a2571f7c8f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -548,8 +548,8 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 	struct evlist *evlist = counter->evlist;
 	struct evsel *alias;
 
-	alias = list_prepare_entry(counter, &(evlist->entries), core.node);
-	list_for_each_entry_continue (alias, &evlist->entries, core.node) {
+	alias = list_prepare_entry(counter, &(evlist->core.entries), core.node);
+	list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
 		if (strcmp(perf_evsel__name(alias), perf_evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
