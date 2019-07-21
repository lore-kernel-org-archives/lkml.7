Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9999BC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562F72171F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708472;
	bh=7J24bhRBUOVBSpBwADtgt9+IWD0gFNfQ23VaHS5ORV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kZs/rwc/ZFx9r9Azo1ku5Ry6IoVBpctvn3q3tq2FNK+uQrWmPZwG1wtyX2QxfgQL5
	 8Bw62YS3UgSmhao65OuN3u5VBtFa+PN41ScGMM+TvUIkF3HWQFCCxA6/nTUqcK728/
	 aFoKPDa3yJWOzCBmjPZXyfiipkSNC+e0PExZDHM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfGUL1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95B7C86663;
        Sun, 21 Jul 2019 11:27:49 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 706605D9D3;
        Sun, 21 Jul 2019 11:27:44 +0000 (UTC)
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
Subject: [PATCH 19/79] perf tools: Rename perf_evlist__open to evlist__open
Date:   Sun, 21 Jul 2019 13:24:06 +0200
Message-Id: <20190721112506.12306-20-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 21 Jul 2019 11:27:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evlist__open to evlist__open, so we don't
have a name clash when we add perf_evlist__open in libperf.

Link: http://lkml.kernel.org/n/tip-7b8seckx0anm4xgqhglae7p9@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-kvm.c                     | 2 +-
 tools/perf/builtin-trace.c                   | 2 +-
 tools/perf/tests/backward-ring-buffer.c      | 2 +-
 tools/perf/tests/bpf.c                       | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/event-times.c               | 2 +-
 tools/perf/tests/keep-tracking.c             | 2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  | 2 +-
 tools/perf/tests/perf-record.c               | 2 +-
 tools/perf/tests/sw-clock.c                  | 2 +-
 tools/perf/tests/switch-tracking.c           | 2 +-
 tools/perf/tests/task-exit.c                 | 2 +-
 tools/perf/util/evlist.c                     | 2 +-
 tools/perf/util/evlist.h                     | 2 +-
 tools/perf/util/python.c                     | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 09b6cef76f5b..ea4cf1d367a6 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -83,7 +83,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	evsel->attr.disabled = 1;
 	evsel->attr.enable_on_exec = 0;
 
-	CHECK__(perf_evlist__open(evlist));
+	CHECK__(evlist__open(evlist));
 
 	CHECK__(perf_evlist__mmap(evlist, UINT_MAX));
 
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 8f54bdfb5743..85604d117558 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1048,7 +1048,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 		attr->disabled = 1;
 	}
 
-	err = perf_evlist__open(evlist);
+	err = evlist__open(evlist);
 	if (err < 0) {
 		printf("Couldn't create the events: %s\n",
 		       str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2ea87cb1c7d0..26ece6b446f0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3341,7 +3341,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		}
 	}
 
-	err = perf_evlist__open(evlist);
+	err = evlist__open(evlist);
 	if (err < 0)
 		goto out_error_open;
 
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index ef3c6db2fae4..8de2d6ad93ce 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -125,7 +125,7 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
 
 	perf_evlist__config(evlist, &opts, NULL);
 
-	err = perf_evlist__open(evlist);
+	err = evlist__open(evlist);
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 313ff1aadd9c..b41c41482283 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -157,7 +157,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 
 	perf_evlist__config(evlist, &opts, NULL);
 
-	err = perf_evlist__open(evlist);
+	err = evlist__open(evlist);
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 1c7f092a7388..23abc775a69c 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -646,7 +646,7 @@ static int do_test_code_reading(bool try_kcore)
 		evsel->attr.disabled = 1;
 		evsel->attr.enable_on_exec = 0;
 
-		ret = perf_evlist__open(evlist);
+		ret = evlist__open(evlist);
 		if (ret < 0) {
 			if (!excl_kernel) {
 				excl_kernel = true;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 6f9995df2c27..bf00d3d792fb 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -38,7 +38,7 @@ static int attach__enable_on_exec(struct evlist *evlist)
 
 	evsel->attr.enable_on_exec = 1;
 
-	err = perf_evlist__open(evlist);
+	err = evlist__open(evlist);
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 1976ccb3c812..c55bc062e200 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -94,7 +94,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	evsel->attr.disabled = 1;
 	evsel->attr.enable_on_exec = 0;
 
-	if (perf_evlist__open(evlist) < 0) {
+	if (evlist__open(evlist) < 0) {
 		pr_debug("Unable to open dummy and cycles event\n");
 		err = TEST_SKIP;
 		goto out_err;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index f822c3c181f3..233447af9d03 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -60,7 +60,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 	thread_map__set_pid(evlist->threads, 0, getpid());
 
-	err = perf_evlist__open(evlist);
+	err = evlist__open(evlist);
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 779d5996428b..f5d1e7f1b58b 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -130,7 +130,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	 * Call sys_perf_event_open on all the fds on all the evsels,
 	 * grouping them if asked to.
 	 */
-	err = perf_evlist__open(evlist);
+	err = evlist__open(evlist);
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 3ab11291174c..528a2dff06e0 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -69,7 +69,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	cpus	= NULL;
 	threads = NULL;
 
-	if (perf_evlist__open(evlist)) {
+	if (evlist__open(evlist)) {
 		const char *knob = "/proc/sys/kernel/perf_event_max_sample_rate";
 
 		err = -errno;
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 5662dc1c6bd3..47f9895ba807 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -450,7 +450,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		}
 	}
 
-	if (perf_evlist__open(evlist) < 0) {
+	if (evlist__open(evlist) < 0) {
 		pr_debug("Not supported\n");
 		err = 0;
 		goto out;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 698ee5369c02..d17effdd55c8 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -95,7 +95,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	evsel->attr.wakeup_events = 1;
 	evsel->attr.exclude_kernel = 1;
 
-	err = perf_evlist__open(evlist);
+	err = evlist__open(evlist);
 	if (err < 0) {
 		pr_debug("Couldn't open the evlist: %s\n",
 			 str_error_r(-err, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e71c3cc93924..7d44e05dfaa4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1387,7 +1387,7 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
 	goto out;
 }
 
-int perf_evlist__open(struct evlist *evlist)
+int evlist__open(struct evlist *evlist)
 {
 	struct evsel *evsel;
 	int err;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b3a44e2eed08..f4b3152c879e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -146,7 +146,7 @@ void perf_evlist__toggle_bkw_mmap(struct evlist *evlist, enum bkw_mmap_state sta
 
 void perf_evlist__mmap_consume(struct evlist *evlist, int idx);
 
-int perf_evlist__open(struct evlist *evlist);
+int evlist__open(struct evlist *evlist);
 void perf_evlist__close(struct evlist *evlist);
 
 struct callchain_param;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3eb7348d29f8..cc4af99ab190 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1059,7 +1059,7 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 	if (group)
 		perf_evlist__set_leader(evlist);
 
-	if (perf_evlist__open(evlist) < 0) {
+	if (evlist__open(evlist) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
 	}
-- 
2.21.0

