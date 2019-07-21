Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01804C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00D52147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708456;
	bh=s5gfTInFTF+TlE4rGBWpWnXUXyg1WUBGeVvFYjpd0bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FKAza3kQrM1O0eFeq5+plMHIFeV4QuBasL20WgigRp5azP1GtWadSDToD+B136fgh
	 Jf0oA8uwx/+PbFNddtOWUs7pbFqu1czM7/HSCf7S7p5ldw7VAj7/VGUrd4QePyPSli
	 gf+n1UAoF2/J3N2YhUQozIWV3Kn05+BFLREbYARs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfGUL1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 360FC308425C;
        Sun, 21 Jul 2019 11:27:34 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 982CA5DD80;
        Sun, 21 Jul 2019 11:27:29 +0000 (UTC)
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
Subject: [PATCH 16/79] perf tools: Rename perf_evsel__disable to evsel__disable
Date:   Sun, 21 Jul 2019 13:24:03 +0200
Message-Id: <20190721112506.12306-17-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 21 Jul 2019 11:27:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evsel__disable to evsel__disable, so we don't
have a name clash when we add perf_evsel__disable in libperf.

Link: http://lkml.kernel.org/n/tip-39471ej79lohwjen50um9qwv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 1ff1d9dd432e..84d8e8caadf6 100644
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
index 8e2a0c08e0a3..2ea87cb1c7d0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2412,7 +2412,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
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
-- 
2.21.0

