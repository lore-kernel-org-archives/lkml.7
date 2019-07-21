Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F58C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796FF2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708487;
	bh=7OaZoQffvI2YpxR+acrU66uoo8gedo3taMnG9MmbuY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LMN7NdPdPq2Udaq+4NhSSCGs2IqtchirWuVOaxXi5KbFYNUb2ZrMkr6xl+fiqVJ4R
	 kPmZDCQ+hQOO+JuKYKDIFcdxedGsCDKk9ikTkEhg0dVK8qEhzwGTdigSPp9tdMEJW5
	 JsClWY1/APvEsxW89+BdtGvqk84svAKlKr4hT35E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfGUL2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:28:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGUL2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C04493082B5F;
        Sun, 21 Jul 2019 11:28:04 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A27935D9D3;
        Sun, 21 Jul 2019 11:28:00 +0000 (UTC)
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
Subject: [PATCH 22/79] perf tools: Rename perf_evlist__disable to evlist__disable
Date:   Sun, 21 Jul 2019 13:24:09 +0200
Message-Id: <20190721112506.12306-23-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 21 Jul 2019 11:28:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evlist__disable to evlist__disable, so we don't
have a name clash when we add perf_evlist__disable in libperf.

Link: http://lkml.kernel.org/n/tip-vn0lz359acxl89cq6fm54iox@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-kvm.c                     | 2 +-
 tools/perf/builtin-record.c                  | 2 +-
 tools/perf/builtin-stat.c                    | 2 +-
 tools/perf/builtin-trace.c                   | 4 ++--
 tools/perf/tests/backward-ring-buffer.c      | 2 +-
 tools/perf/tests/bpf.c                       | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/keep-tracking.c             | 6 +++---
 tools/perf/tests/sw-clock.c                  | 2 +-
 tools/perf/tests/switch-tracking.c           | 4 ++--
 tools/perf/util/evlist.c                     | 4 ++--
 tools/perf/util/evlist.h                     | 2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index aa5a5c972ce5..8b70e9ee341a 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -107,7 +107,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	comm2 = "Test COMM 2";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm2, 0, 0, 0));
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		md = &evlist->mmap[i];
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 9207bd49583e..3370eba0d3f3 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -993,7 +993,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 			err = fdarray__poll(fda, 100);
 	}
 
-	perf_evlist__disable(kvm->evlist);
+	evlist__disable(kvm->evlist);
 
 	if (err == 0) {
 		sort_result(kvm);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8e20ead0ddbe..c0962ddfad04 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1605,7 +1605,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		 */
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
-			perf_evlist__disable(rec->evlist);
+			evlist__disable(rec->evlist);
 			disabled = true;
 		}
 	}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c0e9d94b6dd5..36e66a4f3c57 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -373,7 +373,7 @@ static void disable_counters(void)
 	 * from counting before reading their constituent counters.
 	 */
 	if (!target__none(&target))
-		perf_evlist__disable(evsel_list);
+		evlist__disable(evsel_list);
 }
 
 static volatile int workload_exec_errno;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b0e840a6906b..0fa6f0530d0f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3450,7 +3450,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 				goto out_disable;
 
 			if (done && !draining) {
-				perf_evlist__disable(evlist);
+				evlist__disable(evlist);
 				draining = true;
 			}
 		}
@@ -3476,7 +3476,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 out_disable:
 	thread__zput(trace->current);
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	if (trace->sort_events)
 		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index f4b45702821d..9bdf66139099 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -70,7 +70,7 @@ static int do_test(struct evlist *evlist, int mmap_pages,
 
 	evlist__enable(evlist);
 	testcase();
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	err = count_samples(evlist, sample_count, comm_count);
 	perf_evlist__munmap(evlist);
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 92fed94f4b6c..e16f927f38b6 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -173,7 +173,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 
 	evlist__enable(evlist);
 	(*func)();
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 8d38e001160d..ec4b0bf28270 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -684,7 +684,7 @@ static int do_test_code_reading(bool try_kcore)
 
 	do_something();
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	ret = process_events(machine, evlist, &state);
 	if (ret < 0)
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index c333b9c765e8..7bfc859971e5 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -112,7 +112,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	comm = "Test COMM 1";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0));
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	found = find_comm(evlist, comm);
 	if (found != 1) {
@@ -134,7 +134,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	comm = "Test COMM 2";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0));
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	found = find_comm(evlist, comm);
 	if (found != 1) {
@@ -146,7 +146,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 out_err:
 	if (evlist) {
-		perf_evlist__disable(evlist);
+		evlist__disable(evlist);
 		evlist__delete(evlist);
 	} else {
 		cpu_map__put(cpus);
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 4ab316c04ce7..ba033a6e6c0f 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -92,7 +92,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	for (i = 0; i < NR_LOOPS; i++)
 		tmp++;
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	md = &evlist->mmap[0];
 	if (perf_mmap__read_init(md) < 0)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index ea214313f22b..d5537edb47db 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -528,7 +528,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	perf_evlist__disable(evlist);
+	evlist__disable(evlist);
 
 	switch_tracking.switch_evsel = switch_evsel;
 	switch_tracking.cycles_evsel = cycles_evsel;
@@ -566,7 +566,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	}
 out:
 	if (evlist) {
-		perf_evlist__disable(evlist);
+		evlist__disable(evlist);
 		evlist__delete(evlist);
 	} else {
 		cpu_map__put(cpus);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 94825c37a35f..1bedec28e58f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -343,7 +343,7 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
 		return thread_map__nr(evlist->threads);
 }
 
-void perf_evlist__disable(struct evlist *evlist)
+void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
 
@@ -371,7 +371,7 @@ void evlist__enable(struct evlist *evlist)
 
 void perf_evlist__toggle_enable(struct evlist *evlist)
 {
-	(evlist->enabled ? perf_evlist__disable : evlist__enable)(evlist);
+	(evlist->enabled ? evlist__disable : evlist__enable)(evlist);
 }
 
 static int perf_evlist__enable_event_cpu(struct evlist *evlist,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index ab48bbfbca41..99621c056d09 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -184,7 +184,7 @@ void perf_evlist__munmap(struct evlist *evlist);
 
 size_t perf_evlist__mmap_size(unsigned long pages);
 
-void perf_evlist__disable(struct evlist *evlist);
+void evlist__disable(struct evlist *evlist);
 void evlist__enable(struct evlist *evlist);
 void perf_evlist__toggle_enable(struct evlist *evlist);
 
-- 
2.21.0

