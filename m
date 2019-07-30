Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340FCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7E720693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DUKZmHoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfG3SP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:15:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3SP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:15:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIFkVv3326129
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:15:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIFkVv3326129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510547;
        bh=rWWuZWd+gCCf/y+2pz4EwVs65ydrzSEpjWQkKKSo/JY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DUKZmHoiGf7J3+au+6s663ZGn++1UH4MtIDvEzt4masCO1WxgdcBfDMhJttAcBBLv
         fqqLq0x8mgS1sZykqeI+HbbMtfge9nJAE0dY2fvldA+8P/nKp0oePCmHlScWM1OnUj
         sAYfiyVn6FkVenAXz7LN7fKS+3ViEoUcdYJKcUvHgvdGVRTR11n4F42ltl6YCy8Exr
         43kjENBHAOashLZFmPznXniXi0ASx5fkcKXHRZ9RMXeoT/1ibWroFeCeRukNZaGTh5
         T6XcuCjeBGRcVYJTMSThFfdcKYTXZDN8MEbIrscqtC5bg9Eiwg7fg2qZ6Cx72LR0aV
         gnLKDRijfIC0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIFjJ53326126;
        Tue, 30 Jul 2019 11:15:45 -0700
Date:   Tue, 30 Jul 2019 11:15:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a1cf3a75d3317ed893d453c222d220ca4d5f4c4e@git.kernel.org>
Cc:     peterz@infradead.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, mpetlan@redhat.com,
        ak@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Reply-To: alexey.budankov@linux.intel.com, mpetlan@redhat.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          acme@redhat.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          hpa@zytor.com, ak@linux.intel.com, mingo@kernel.org,
          jolsa@kernel.org
In-Reply-To: <20190721112506.12306-13-jolsa@kernel.org>
References: <20190721112506.12306-13-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evlist: Rename perf_evlist__add() to
 evlist__add()
Git-Commit-ID: a1cf3a75d3317ed893d453c222d220ca4d5f4c4e
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

Commit-ID:  a1cf3a75d3317ed893d453c222d220ca4d5f4c4e
Gitweb:     https://git.kernel.org/tip/a1cf3a75d3317ed893d453c222d220ca4d5f4c4e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:23:59 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evlist: Rename perf_evlist__add() to evlist__add()

Rename perf_evlist__add() to evlist__add(), so we don't have a name
clash when we add perf_evlist__add() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                  | 12 ++++++------
 tools/perf/tests/mmap-basic.c               |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/tests/sw-clock.c                 |  2 +-
 tools/perf/util/evlist.c                    | 16 ++++++++--------
 tools/perf/util/evlist.h                    |  2 +-
 tools/perf/util/header.c                    |  4 ++--
 tools/perf/util/python.c                    |  2 +-
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c5eb47f4e42e..89ae4737ef74 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2616,7 +2616,7 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
-static bool perf_evlist__add_vfs_getname(struct evlist *evlist)
+static bool evlist__add_vfs_getname(struct evlist *evlist)
 {
 	bool found = false;
 	struct evsel *evsel, *tmp;
@@ -2719,8 +2719,8 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	perf_evsel__config_callchain(sys_enter, &trace->opts, &callchain_param);
 	perf_evsel__config_callchain(sys_exit, &trace->opts, &callchain_param);
 
-	perf_evlist__add(evlist, sys_enter);
-	perf_evlist__add(evlist, sys_exit);
+	evlist__add(evlist, sys_enter);
+	evlist__add(evlist, sys_exit);
 
 	if (callchain_param.enabled && !trace->kernel_syscallchains) {
 		/*
@@ -3264,7 +3264,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 			goto out_error_raw_syscalls;
 
 		if (trace->trace_syscalls)
-			trace->vfs_getname = perf_evlist__add_vfs_getname(evlist);
+			trace->vfs_getname = evlist__add_vfs_getname(evlist);
 	}
 
 	if ((trace->trace_pgfaults & TRACE_PFMAJ)) {
@@ -3272,7 +3272,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (pgfault_maj == NULL)
 			goto out_error_mem;
 		perf_evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
-		perf_evlist__add(evlist, pgfault_maj);
+		evlist__add(evlist, pgfault_maj);
 	}
 
 	if ((trace->trace_pgfaults & TRACE_PFMIN)) {
@@ -3280,7 +3280,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (pgfault_min == NULL)
 			goto out_error_mem;
 		perf_evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
-		perf_evlist__add(evlist, pgfault_min);
+		evlist__add(evlist, pgfault_min);
 	}
 
 	if (trace->sched &&
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 7f96bb72f7e5..16b8a4e5de8f 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -82,7 +82,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		evsels[i]->attr.wakeup_events = 1;
 		perf_evsel__set_sample_id(evsels[i], false);
 
-		perf_evlist__add(evlist, evsels[i]);
+		evlist__add(evlist, evsels[i]);
 
 		if (perf_evsel__open(evsels[i], cpus, threads) < 0) {
 			pr_debug("failed to open counter: %s, "
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 0263420f4495..f822c3c181f3 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -48,7 +48,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 
 	err = perf_evlist__create_maps(evlist, &opts.target);
 	if (err < 0) {
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 247d3734686e..3ab11291174c 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -54,7 +54,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		pr_debug("perf_evsel__new\n");
 		goto out_delete_evlist;
 	}
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 
 	cpus = cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(getpid());
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 986d20c15778..7741e12bdcb0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -177,7 +177,7 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
-void perf_evlist__add(struct evlist *evlist, struct evsel *entry)
+void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
 	list_add_tail(&entry->node, &evlist->entries);
@@ -204,7 +204,7 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
 
 	__evlist__for_each_entry_safe(list, temp, evsel) {
 		list_del_init(&evsel->node);
-		perf_evlist__add(evlist, evsel);
+		evlist__add(evlist, evsel);
 	}
 }
 
@@ -237,7 +237,7 @@ int __perf_evlist__add_default(struct evlist *evlist, bool precise)
 	if (evsel == NULL)
 		return -ENOMEM;
 
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 	return 0;
 }
 
@@ -253,11 +253,11 @@ int perf_evlist__add_dummy(struct evlist *evlist)
 	if (evsel == NULL)
 		return -ENOMEM;
 
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 	return 0;
 }
 
-static int perf_evlist__add_attrs(struct evlist *evlist,
+static int evlist__add_attrs(struct evlist *evlist,
 				  struct perf_event_attr *attrs, size_t nr_attrs)
 {
 	struct evsel *evsel, *n;
@@ -289,7 +289,7 @@ int __perf_evlist__add_default_attrs(struct evlist *evlist,
 	for (i = 0; i < nr_attrs; i++)
 		event_attr_init(attrs + i);
 
-	return perf_evlist__add_attrs(evlist, attrs, nr_attrs);
+	return evlist__add_attrs(evlist, attrs, nr_attrs);
 }
 
 struct evsel *
@@ -330,7 +330,7 @@ int perf_evlist__add_newtp(struct evlist *evlist,
 		return -1;
 
 	evsel->handler = handler;
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 	return 0;
 }
 
@@ -1854,7 +1854,7 @@ int perf_evlist__add_sb_event(struct evlist **evlist,
 
 	evsel->side_band.cb = cb;
 	evsel->side_band.data = data;
-	perf_evlist__add(*evlist, evsel);
+	evlist__add(*evlist, evsel);
 	return 0;
 
 out_err:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 12a5fd6972df..d52b29a1d852 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -73,7 +73,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 void perf_evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
-void perf_evlist__add(struct evlist *evlist, struct evsel *entry);
+void evlist__add(struct evlist *evlist, struct evsel *entry);
 void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
 int __perf_evlist__add_default(struct evlist *evlist, bool precise);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7760ddc4bc18..5e0093251f26 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3593,7 +3593,7 @@ int perf_session__read_header(struct perf_session *session)
 		 * Do it before so that if perf_evsel__alloc_id fails, this
 		 * entry gets purged too at evlist__delete().
 		 */
-		perf_evlist__add(session->evlist, evsel);
+		evlist__add(session->evlist, evsel);
 
 		nr_ids = f_attr.ids.size / sizeof(u64);
 		/*
@@ -4025,7 +4025,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	if (evsel == NULL)
 		return -ENOMEM;
 
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 
 	ids = event->header.size;
 	ids -= (void *)&event->attr.id - (void *)event;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ade4e85c6d81..48c951a4a76b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -974,7 +974,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	Py_INCREF(pevsel);
 	evsel = &((struct pyrf_evsel *)pevsel)->evsel;
 	evsel->idx = evlist->nr_entries;
-	perf_evlist__add(evlist, evsel);
+	evlist__add(evlist, evsel);
 
 	return Py_BuildValue("i", evlist->nr_entries);
 }
