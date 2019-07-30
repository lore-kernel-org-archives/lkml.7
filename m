Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF27C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9842F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f68eZCcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbfG3SSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:18:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbfG3SSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:18:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIHw4m3326404
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:17:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIHw4m3326404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510679;
        bh=ET6K1jG5TCHqj2/cbkRQGBp30EitV7XrqE0z3OlVrt0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=f68eZCcOeowJQFzmmu4bihumnj1vKW9cw8HZVJdGNRqEvpCIqESls1FwTrT0OdRO1
         wwDo+hA/QJR5FlEi7JFoAEFyVaBsc1hc/Up5j8C07ymrE2l+gyW7Pu20fzlcb0145s
         tPnsHhBnAayUuYFNw8mXQ9vpYYsaZrQhhwiJZaGI3/2/eiiOaXi+hlaq1sPTZ+RBvG
         mM41fnYHkHbPk+WfWtELE7QobCPouO2FYplG/i5rKpri1/a1nJFNK33PO07wezpofR
         zylhKA8EdCF7Ogp2sE09pAW+kViwpLJRPoYRZGsqKe3sqXnyG2NCPFTpNAxie+f7nD
         +rSRNNdfCY8mA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIHwnU3326401;
        Tue, 30 Jul 2019 11:17:58 -0700
Date:   Tue, 30 Jul 2019 11:17:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ec7f24ef44fc5a4eb5cb71658c33db538ed66003@git.kernel.org>
Cc:     peterz@infradead.org, mpetlan@redhat.com,
        alexey.budankov@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        mingo@kernel.org, namhyung@kernel.org, ak@linux.intel.com
Reply-To: tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com, jolsa@kernel.org, mpetlan@redhat.com,
          alexey.budankov@linux.intel.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, ak@linux.intel.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190721112506.12306-16-jolsa@kernel.org>
References: <20190721112506.12306-16-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Rename perf_evsel__enable() to
 evsel__enable()
Git-Commit-ID: ec7f24ef44fc5a4eb5cb71658c33db538ed66003
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

Commit-ID:  ec7f24ef44fc5a4eb5cb71658c33db538ed66003
Gitweb:     https://git.kernel.org/tip/ec7f24ef44fc5a4eb5cb71658c33db538ed66003
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evsel: Rename perf_evsel__enable() to evsel__enable()

Rename perf_evsel__enable() to evsel__enable(), so we don't have a name
clash when we add perf_evsel__enable() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 91c64daa4487..4b70b9504603 100644
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
