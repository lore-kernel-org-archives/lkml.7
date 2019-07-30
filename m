Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B980C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4B7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Rnhm8hoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfG3SRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:17:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfG3SR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:17:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIHEgO3326279
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:17:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIHEgO3326279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510635;
        bh=1eAeU/fHywiWnZVdmtHZTeQgZ4kG2ecHxk31YYIvtFs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Rnhm8hoNs35h+0gOAeXodY2mvvj2x+kQja4991QReF28lud3XxMFr73b8SBtzVww2
         iBbFq0RJe7KZ13ujwh1aPsB0QEVacOop+EOM5n4nyJ4OR3gi9FfFraEP3LrZoLmcLc
         v1FgBQIWTW/vL1j/BTvcGV4O25cGVMyfWndIF9KjWkRrfMKDGbpxH0t5APSzP4mpAy
         1b7rREuidnHMyuOhxJgHCwlXutFiyFa76zCBosv13asNVf+g75HdPj8EqFG8WoIdjW
         bbhyK31ooJT1FyxYIJuWTI3wteOFe870VW6GpGZwWkE5K+LmTstyrjggOfwOlgAi3L
         LpmRp9ZouUopQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIHEkh3326272;
        Tue, 30 Jul 2019 11:17:14 -0700
Date:   Tue, 30 Jul 2019 11:17:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5972d1e07bd95c7458e2d7f484391d69008affc7@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
        peterz@infradead.org, mpetlan@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Reply-To: namhyung@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          mingo@kernel.org, acme@redhat.com, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mpetlan@redhat.com
In-Reply-To: <20190721112506.12306-15-jolsa@kernel.org>
References: <20190721112506.12306-15-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Rename perf_evsel__open() to
 evsel__open()
Git-Commit-ID: 5972d1e07bd95c7458e2d7f484391d69008affc7
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

Commit-ID:  5972d1e07bd95c7458e2d7f484391d69008affc7
Gitweb:     https://git.kernel.org/tip/5972d1e07bd95c7458e2d7f484391d69008affc7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:01 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evsel: Rename perf_evsel__open() to evsel__open()

Rename perf_evsel__open() to evsel__open(), so we don't have a name
clash when we add perf_evsel__open() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c                | 2 +-
 tools/perf/builtin-top.c                   | 2 +-
 tools/perf/tests/mmap-basic.c              | 2 +-
 tools/perf/tests/openat-syscall-all-cpus.c | 2 +-
 tools/perf/util/evlist.c                   | 4 ++--
 tools/perf/util/evsel.c                    | 8 ++++----
 tools/perf/util/evsel.h                    | 4 ++--
 tools/perf/util/parse-events.c             | 4 ++--
 tools/perf/util/python.c                   | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 06966a2c2cdd..7f933997b6d0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -739,7 +739,7 @@ static int record__open(struct record *rec)
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
-		if (perf_evsel__open(pos, pos->cpus, pos->threads) < 0) {
+		if (evsel__open(pos, pos->cpus, pos->threads) < 0) {
 			if (perf_evsel__fallback(pos, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6c0c2b78093a..5886389f6a40 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -989,7 +989,7 @@ static int perf_top__start_counters(struct perf_top *top)
 
 	evlist__for_each_entry(evlist, counter) {
 try_again:
-		if (perf_evsel__open(counter, top->evlist->cpus,
+		if (evsel__open(counter, top->evlist->cpus,
 				     top->evlist->threads) < 0) {
 
 			/*
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 16b8a4e5de8f..40511025208f 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -84,7 +84,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 
 		evlist__add(evlist, evsels[i]);
 
-		if (perf_evsel__open(evsels[i], cpus, threads) < 0) {
+		if (evsel__open(evsels[i], cpus, threads) < 0) {
 			pr_debug("failed to open counter: %s, "
 				 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 				 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 001a0e8e6998..f96cbd304024 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -48,7 +48,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 		goto out_cpu_map_delete;
 	}
 
-	if (perf_evsel__open(evsel, cpus, threads) < 0) {
+	if (evsel__open(evsel, cpus, threads) < 0) {
 		pr_debug("failed to open counter: %s, "
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47516db62424..4627cc47de3e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1405,7 +1405,7 @@ int perf_evlist__open(struct evlist *evlist)
 	perf_evlist__update_id_pos(evlist);
 
 	evlist__for_each_entry(evlist, evsel) {
-		err = perf_evsel__open(evsel, evsel->cpus, evsel->threads);
+		err = evsel__open(evsel, evsel->cpus, evsel->threads);
 		if (err < 0)
 			goto out_err;
 	}
@@ -1918,7 +1918,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 		goto out_delete_evlist;
 
 	evlist__for_each_entry(evlist, counter) {
-		if (perf_evsel__open(counter, evlist->cpus,
+		if (evsel__open(counter, evlist->cpus,
 				     evlist->threads) < 0)
 			goto out_delete_evlist;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c9723c2d57c9..f365d0685268 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1825,8 +1825,8 @@ static int perf_event_open(struct evsel *evsel,
 	return fd;
 }
 
-int perf_evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-		     struct perf_thread_map *threads)
+int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads)
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
@@ -2086,13 +2086,13 @@ void perf_evsel__close(struct evsel *evsel)
 int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus)
 {
-	return perf_evsel__open(evsel, cpus, NULL);
+	return evsel__open(evsel, cpus, NULL);
 }
 
 int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads)
 {
-	return perf_evsel__open(evsel, NULL, threads);
+	return evsel__open(evsel, NULL, threads);
 }
 
 static int perf_evsel__parse_id_sample(const struct evsel *evsel,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ecea51a918e0..d43409bb07c5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -302,8 +302,8 @@ int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus);
 int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads);
-int perf_evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-		     struct perf_thread_map *threads);
+int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads);
 void perf_evsel__close(struct evsel *evsel);
 
 struct perf_sample;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 40087cf74dd1..decb66d243ca 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2320,7 +2320,7 @@ static bool is_event_supported(u8 type, unsigned config)
 
 	evsel = evsel__new(&attr);
 	if (evsel) {
-		open_return = perf_evsel__open(evsel, NULL, tmap);
+		open_return = evsel__open(evsel, NULL, tmap);
 		ret = open_return >= 0;
 
 		if (open_return == -EACCES) {
@@ -2332,7 +2332,7 @@ static bool is_event_supported(u8 type, unsigned config)
 			 *
 			 */
 			evsel->attr.exclude_kernel = 1;
-			ret = perf_evsel__open(evsel, NULL, tmap) >= 0;
+			ret = evsel__open(evsel, NULL, tmap) >= 0;
 		}
 		evsel__delete(evsel);
 	}
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 48c951a4a76b..3eb7348d29f8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -817,7 +817,7 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 	 * This will group just the fds for this single evsel, to group
 	 * multiple events, use evlist.open().
 	 */
-	if (perf_evsel__open(evsel, cpus, threads) < 0) {
+	if (evsel__open(evsel, cpus, threads) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
 	}
