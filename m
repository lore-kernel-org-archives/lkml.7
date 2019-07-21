Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75278C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0092085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708482;
	bh=Bmbh4mmafHIk8c4LgYZw1bfuqu4ZFKD2rnM1fA9rjXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T6VxP08aikbRD4Ek+St8XnQnh48M4OmtC4+9cOTi8DXhuC0boDNSkI+daysrHDBqO
	 ZfpRorPZ2d64a526nveQx2agHMnsKI5NJDQDGh2IdiS1lnPZ1MbroOm9UbpSMqfNGr
	 aoVSST9EKbdUEvS7BcOuHcXanr2Q80Ejs309NtMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfGUL2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DF56C057E29;
        Sun, 21 Jul 2019 11:28:00 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 280215D9D3;
        Sun, 21 Jul 2019 11:27:55 +0000 (UTC)
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
Subject: [PATCH 21/79] perf tools: Rename perf_evlist__enable to evlist__enable
Date:   Sun, 21 Jul 2019 13:24:08 +0200
Message-Id: <20190721112506.12306-22-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 21 Jul 2019 11:28:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evlist__enable to evlist__enable, so we don't
have a name clash when we add perf_evlist__enable in libperf.

Link: http://lkml.kernel.org/n/tip-9q67kqgxx9dv4rkhy8uxpsl0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-kvm.c                     | 2 +-
 tools/perf/builtin-record.c                  | 4 ++--
 tools/perf/builtin-stat.c                    | 2 +-
 tools/perf/builtin-top.c                     | 2 +-
 tools/perf/builtin-trace.c                   | 4 ++--
 tools/perf/tests/backward-ring-buffer.c      | 2 +-
 tools/perf/tests/bpf.c                       | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/keep-tracking.c             | 4 ++--
 tools/perf/tests/openat-syscall-tp-fields.c  | 2 +-
 tools/perf/tests/perf-record.c               | 2 +-
 tools/perf/tests/sw-clock.c                  | 2 +-
 tools/perf/tests/switch-tracking.c           | 2 +-
 tools/perf/util/evlist.c                     | 4 ++--
 tools/perf/util/evlist.h                     | 2 +-
 16 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index ea4cf1d367a6..aa5a5c972ce5 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -97,7 +97,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 		goto out_err;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	comm1 = "Test COMM 1";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm1, 0, 0, 0));
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 6a0573a9c16b..9207bd49583e 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -972,7 +972,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		goto out;
 
 	/* everything is good - enable the events and process */
-	perf_evlist__enable(kvm->evlist);
+	evlist__enable(kvm->evlist);
 
 	while (!done) {
 		struct fdarray *fda = &kvm->evlist->pollfd;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7f933997b6d0..8e20ead0ddbe 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1453,7 +1453,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	 * so don't spoil it by prematurely enabling them.
 	 */
 	if (!target__none(&opts->target) && !opts->initial_delay)
-		perf_evlist__enable(rec->evlist);
+		evlist__enable(rec->evlist);
 
 	/*
 	 * Let the child rip
@@ -1506,7 +1506,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	if (opts->initial_delay) {
 		usleep(opts->initial_delay * USEC_PER_MSEC);
-		perf_evlist__enable(rec->evlist);
+		evlist__enable(rec->evlist);
 	}
 
 	trigger_ready(&auxtrace_snapshot_trigger);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bdfe138f7aed..c0e9d94b6dd5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -362,7 +362,7 @@ static void enable_counters(void)
 	 * - we have initial delay configured
 	 */
 	if (!target__none(&target) || stat_config.initial_delay)
-		perf_evlist__enable(evsel_list);
+		evlist__enable(evsel_list);
 }
 
 static void disable_counters(void)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5886389f6a40..b103f1ba01cb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1255,7 +1255,7 @@ static int __cmd_top(struct perf_top *top)
 	 * so leave the check here.
 	 */
         if (!target__none(&opts->target))
-                perf_evlist__enable(top->evlist);
+		evlist__enable(top->evlist);
 
 	ret = -1;
 	if (pthread_create(&thread_process, NULL, process_thread, top)) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 26ece6b446f0..b0e840a6906b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3401,14 +3401,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_error_mmap;
 
 	if (!target__none(&trace->opts.target) && !trace->opts.initial_delay)
-		perf_evlist__enable(evlist);
+		evlist__enable(evlist);
 
 	if (forks)
 		perf_evlist__start_workload(evlist);
 
 	if (trace->opts.initial_delay) {
 		usleep(trace->opts.initial_delay * 1000);
-		perf_evlist__enable(evlist);
+		evlist__enable(evlist);
 	}
 
 	trace->multiple_threads = thread_map__pid(evlist->threads, 0) == -1 ||
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 8de2d6ad93ce..f4b45702821d 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -68,7 +68,7 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 		return TEST_FAIL;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 	testcase();
 	perf_evlist__disable(evlist);
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index b41c41482283..92fed94f4b6c 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -171,7 +171,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 	(*func)();
 	perf_evlist__disable(evlist);
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 23abc775a69c..8d38e001160d 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -680,7 +680,7 @@ static int do_test_code_reading(bool try_kcore)
 		goto out_put;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	do_something();
 
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index c55bc062e200..c333b9c765e8 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -107,7 +107,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	 * enabled.
 	 */
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	comm = "Test COMM 1";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0));
@@ -125,7 +125,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	 * disabled with the dummy event still enabled.
 	 */
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	evsel = perf_evlist__last(evlist);
 
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 233447af9d03..c7182b7840e5 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -74,7 +74,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	/*
 	 * Generate the event:
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index f5d1e7f1b58b..67b388e92cba 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -153,7 +153,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	 * Now that all is properly set up, enable the events, they will
 	 * count just on workload.pid, which will start...
 	 */
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	/*
 	 * Now!
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 528a2dff06e0..4ab316c04ce7 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -86,7 +86,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	/* collect samples */
 	for (i = 0; i < NR_LOOPS; i++)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 47f9895ba807..ea214313f22b 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -462,7 +462,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	perf_evlist__enable(evlist);
+	evlist__enable(evlist);
 
 	err = evsel__disable(cpu_clocks_evsel);
 	if (err) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 67c288f467f6..94825c37a35f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -356,7 +356,7 @@ void perf_evlist__disable(struct evlist *evlist)
 	evlist->enabled = false;
 }
 
-void perf_evlist__enable(struct evlist *evlist)
+void evlist__enable(struct evlist *evlist)
 {
 	struct evsel *pos;
 
@@ -371,7 +371,7 @@ void perf_evlist__enable(struct evlist *evlist)
 
 void perf_evlist__toggle_enable(struct evlist *evlist)
 {
-	(evlist->enabled ? perf_evlist__disable : perf_evlist__enable)(evlist);
+	(evlist->enabled ? perf_evlist__disable : evlist__enable)(evlist);
 }
 
 static int perf_evlist__enable_event_cpu(struct evlist *evlist,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 47e9d26b6774..ab48bbfbca41 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -185,7 +185,7 @@ void perf_evlist__munmap(struct evlist *evlist);
 size_t perf_evlist__mmap_size(unsigned long pages);
 
 void perf_evlist__disable(struct evlist *evlist);
-void perf_evlist__enable(struct evlist *evlist);
+void evlist__enable(struct evlist *evlist);
 void perf_evlist__toggle_enable(struct evlist *evlist);
 
 int perf_evlist__enable_event_idx(struct evlist *evlist,
-- 
2.21.0

