Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B5AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F094A2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c/Eb6AsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfG3SS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:18:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfG3SSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:18:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIIgrV3326787
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:18:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIIgrV3326787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510723;
        bh=9q1ANxLLGirwIn9gcyATJsNx3oJ4QsGskdhYaoHp+e8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=c/Eb6AsBTbf9lkoBbdFiouDZpd96oB5im+53tgih85MYLMJOd+ivweFNL/ntIsDDq
         7eUg+dLYLjuwyboNuFnmmBRb2kKZgzUkaVjkiNLF8JGNi7GKAw9PMQ3guby702oOHP
         YZCtKEyG+XZlrSgek6aZwOkqpYU1yr3NiEC92B9itTEfRxJle8S8WUw8nXLttajHvx
         6OkEY/0eaZvNd7tUFVFtKOCluXHhIirUcaUTvZ9vqLigzEqZtdFZFcKsJ+70kcuj29
         cgowAXPSYpQavlSLBQMii/SrvgOs0Gwj1DwdzfLMkhuhwdQAVo7ptATWxWE+zw+FfH
         TPNN770Cj+L/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIIgrh3326784;
        Tue, 30 Jul 2019 11:18:42 -0700
Date:   Tue, 30 Jul 2019 11:18:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-9a10bb22897ae9c2aa0ac9c2071f539f406ef942@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@kernel.org, alexey.budankov@linux.intel.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          namhyung@kernel.org, mpetlan@redhat.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          ak@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190721112506.12306-17-jolsa@kernel.org>
References: <20190721112506.12306-17-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Rename perf_evsel__disable() to
 evsel__disable()
Git-Commit-ID: 9a10bb22897ae9c2aa0ac9c2071f539f406ef942
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

Commit-ID:  9a10bb22897ae9c2aa0ac9c2071f539f406ef942
Gitweb:     https://git.kernel.org/tip/9a10bb22897ae9c2aa0ac9c2071f539f406ef942
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evsel: Rename perf_evsel__disable() to evsel__disable()

Renaming perf_evsel__disable() to evsel__disable(), so we don't have a
name clash when we add perf_evsel__disable() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 2 +-
 tools/perf/arch/x86/util/intel-bts.c | 2 +-
 tools/perf/arch/x86/util/intel-pt.c  | 2 +-
 tools/perf/builtin-trace.c           | 2 +-
 tools/perf/tests/keep-tracking.c     | 2 +-
 tools/perf/tests/switch-tracking.c   | 4 ++--
 tools/perf/util/evlist.c             | 2 +-
 tools/perf/util/evsel.c              | 2 +-
 tools/perf/util/evsel.h              | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4b70b9504603..268fcb31cd53 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -821,7 +821,7 @@ static int cs_etm_snapshot_start(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->cs_etm_pmu->type)
-			return perf_evsel__disable(evsel);
+			return evsel__disable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d27832fcb34c..8b0a53d748c9 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -317,7 +317,7 @@ static int intel_bts_snapshot_start(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(btsr->evlist, evsel) {
 		if (evsel->attr.type == btsr->intel_bts_pmu->type)
-			return perf_evsel__disable(evsel);
+			return evsel__disable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index e3dacb2bf01b..4ce157a4e5e2 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -788,7 +788,7 @@ static int intel_pt_snapshot_start(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->intel_pt_pmu->type)
-			return perf_evsel__disable(evsel);
+			return evsel__disable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 89ae4737ef74..95ecefa9ff7e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2400,7 +2400,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 			++trace->nr_events_printed;
 
 			if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
-				perf_evsel__disable(evsel);
+				evsel__disable(evsel);
 				perf_evsel__close(evsel);
 			}
 		}
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index cdc19bcc7523..1976ccb3c812 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -129,7 +129,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 	evsel = perf_evlist__last(evlist);
 
-	CHECK__(perf_evsel__disable(evsel));
+	CHECK__(evsel__disable(evsel));
 
 	comm = "Test COMM 2";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0));
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index acc4b5ff0cea..5662dc1c6bd3 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -464,7 +464,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 
 	perf_evlist__enable(evlist);
 
-	err = perf_evsel__disable(cpu_clocks_evsel);
+	err = evsel__disable(cpu_clocks_evsel);
 	if (err) {
 		pr_debug("perf_evlist__disable_event failed!\n");
 		goto out_err;
@@ -483,7 +483,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	err = perf_evsel__disable(cycles_evsel);
+	err = evsel__disable(cycles_evsel);
 	if (err) {
 		pr_debug("perf_evlist__disable_event failed!\n");
 		goto out_err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e87c43e339d0..9461583c53d9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -350,7 +350,7 @@ void perf_evlist__disable(struct evlist *evlist)
 	evlist__for_each_entry(evlist, pos) {
 		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->fd)
 			continue;
-		perf_evsel__disable(pos);
+		evsel__disable(pos);
 	}
 
 	evlist->enabled = false;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7adae1736191..855d286298eb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1244,7 +1244,7 @@ int evsel__enable(struct evsel *evsel)
 	return err;
 }
 
-int perf_evsel__disable(struct evsel *evsel)
+int evsel__disable(struct evsel *evsel)
 {
 	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
 	/*
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index fa26c583a606..c338ce14e8aa 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -296,7 +296,7 @@ int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct evsel *evsel, const char *filter);
 int evsel__enable(struct evsel *evsel);
-int perf_evsel__disable(struct evsel *evsel);
+int evsel__disable(struct evsel *evsel);
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus);
