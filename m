Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B07C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DED421738
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708451;
	bh=AhISil8ZT6syRkwwqdbncaVZX0C0IsVREEaoivgc2Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYTwRCZWO4LIKlyIyjZ7VSLhCTpr9JUDV6kSlPAN7vwAYnZfWK/gFczl0TABCtWmi
	 YSWwiD/gklt3RMYscTztv+4JgzvvkETJuhfEYlqKXI51K0PNUUtb45jHdRj5CK42X+
	 aAf4NNXYnApZ0xlgcCMqmgmn+QHwv7Aa9gLIodL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGUL1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3EC630821B3;
        Sun, 21 Jul 2019 11:27:28 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59FC15D9D3;
        Sun, 21 Jul 2019 11:27:24 +0000 (UTC)
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
Subject: [PATCH 15/79] perf tools: Rename perf_evsel__enable to evsel__enable
Date:   Sun, 21 Jul 2019 13:24:02 +0200
Message-Id: <20190721112506.12306-16-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 21 Jul 2019 11:27:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evsel__enable to evsel__enable, so we don't
have a name clash when we add perf_evsel__enable in libperf.

Link: http://lkml.kernel.org/n/tip-mgss0xfbhprdvdai1deobdpz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/cs-etm.c    | 2 +-
 tools/perf/arch/x86/util/intel-bts.c | 2 +-
 tools/perf/arch/x86/util/intel-pt.c  | 2 +-
 tools/perf/tests/event-times.c       | 6 +++---
 tools/perf/tests/switch-tracking.c   | 2 +-
 tools/perf/util/evlist.c             | 4 ++--
 tools/perf/util/evsel.c              | 2 +-
 tools/perf/util/evsel.h              | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 48159b62f651..1ff1d9dd432e 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -834,7 +834,7 @@ static int cs_etm_snapshot_finish(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->cs_etm_pmu->type)
-			return perf_evsel__enable(evsel);
+			return evsel__enable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index c845531d383a..d27832fcb34c 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -330,7 +330,7 @@ static int intel_bts_snapshot_finish(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(btsr->evlist, evsel) {
 		if (evsel->attr.type == btsr->intel_bts_pmu->type)
-			return perf_evsel__enable(evsel);
+			return evsel__enable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index e4dfe8c3d5c3..e3dacb2bf01b 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -801,7 +801,7 @@ static int intel_pt_snapshot_finish(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->intel_pt_pmu->type)
-			return perf_evsel__enable(evsel);
+			return evsel__enable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 0f74ca103c41..6f9995df2c27 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -77,7 +77,7 @@ static int attach__current_disabled(struct evlist *evlist)
 	}
 
 	thread_map__put(threads);
-	return perf_evsel__enable(evsel) == 0 ? TEST_OK : TEST_FAIL;
+	return evsel__enable(evsel) == 0 ? TEST_OK : TEST_FAIL;
 }
 
 static int attach__current_enabled(struct evlist *evlist)
@@ -104,7 +104,7 @@ static int detach__disable(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__last(evlist);
 
-	return perf_evsel__enable(evsel);
+	return evsel__enable(evsel);
 }
 
 static int attach__cpu_disabled(struct evlist *evlist)
@@ -133,7 +133,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 	}
 
 	cpu_map__put(cpus);
-	return perf_evsel__enable(evsel);
+	return evsel__enable(evsel);
 }
 
 static int attach__cpu_enabled(struct evlist *evlist)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index ac5da4fd222f..acc4b5ff0cea 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -509,7 +509,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	err = perf_evsel__enable(cycles_evsel);
+	err = evsel__enable(cycles_evsel);
 	if (err) {
 		pr_debug("perf_evlist__disable_event failed!\n");
 		goto out_err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4627cc47de3e..e87c43e339d0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -363,7 +363,7 @@ void perf_evlist__enable(struct evlist *evlist)
 	evlist__for_each_entry(evlist, pos) {
 		if (!perf_evsel__is_group_leader(pos) || !pos->fd)
 			continue;
-		perf_evsel__enable(pos);
+		evsel__enable(pos);
 	}
 
 	evlist->enabled = true;
@@ -1927,7 +1927,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 		goto out_delete_evlist;
 
 	evlist__for_each_entry(evlist, counter) {
-		if (perf_evsel__enable(counter))
+		if (evsel__enable(counter))
 			goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f365d0685268..7adae1736191 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1234,7 +1234,7 @@ int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 	return perf_evsel__append_filter(evsel, "%s,%s", filter);
 }
 
-int perf_evsel__enable(struct evsel *evsel)
+int evsel__enable(struct evsel *evsel)
 {
 	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d43409bb07c5..fa26c583a606 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -295,7 +295,7 @@ int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct evsel *evsel, const char *filter);
-int perf_evsel__enable(struct evsel *evsel);
+int evsel__enable(struct evsel *evsel);
 int perf_evsel__disable(struct evsel *evsel);
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
-- 
2.21.0

