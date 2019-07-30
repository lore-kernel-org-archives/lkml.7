Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A807C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E012089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MSGDSldp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfG3SLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:11:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58209 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3SLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:11:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIBKll3325304
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:11:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIBKll3325304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510281;
        bh=tfk6NxHdKb2Big0TlwsrgGKV555HRIFH3DpMa/M042E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MSGDSldppWUc66o3Xii7uKknm0VzOLSqUeMp4MatNPTO2Rs0L5hJq1tDv1xQVO5ej
         zxWwDgMkcFe2vRYRC1hS5eiPNbJN3lWTUNQF3n4hKMYIfwUZce/e7E9db+qLuGlNQC
         sHo4QjblFu55LzwBLhOm8KX0XIQGCGaIiaWl/OGZ1UobpKM6exRPzZY9hbCuT3FwkQ
         5lj31BM13B7d4IimiB/Z12//oHMbJGzRLhMEaNviVOr09EKkVsi/T5j7wFunCFBu25
         LPNQLgP3cXIhQs6DhO93xKtByR67agCSNpD0QZSsIYrIBlpKQ4hhb53qBuzN0XTNz9
         aSpLqoypZRrHA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIBJlW3325293;
        Tue, 30 Jul 2019 11:11:19 -0700
Date:   Tue, 30 Jul 2019 11:11:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b4b62ee688eb39151c9d8182c3e2f12c9d34602d@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, mpetlan@redhat.com, hpa@zytor.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          ak@linux.intel.com, namhyung@kernel.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, acme@redhat.com, alexey.budankov@linux.intel.com,
          mpetlan@redhat.com
In-Reply-To: <20190721112506.12306-7-jolsa@kernel.org>
References: <20190721112506.12306-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Rename perf_evsel__init() to
 evsel__init()
Git-Commit-ID: b4b62ee688eb39151c9d8182c3e2f12c9d34602d
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

Commit-ID:  b4b62ee688eb39151c9d8182c3e2f12c9d34602d
Gitweb:     https://git.kernel.org/tip/b4b62ee688eb39151c9d8182c3e2f12c9d34602d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:23:53 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf evsel: Rename perf_evsel__init() to evsel__init()

Rename perf_evsel__init() to evsel__init(), so we don't have a name
clash when we add perf_evsel__init() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 8 ++++----
 tools/perf/util/evsel.h  | 3 +--
 tools/perf/util/python.c | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f7f97ca6e96d..97bee83f0f98 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -223,8 +223,8 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 #undef FUNCTION_EVENT
 }
 
-void perf_evsel__init(struct evsel *evsel,
-		      struct perf_event_attr *attr, int idx)
+void evsel__init(struct evsel *evsel,
+		 struct perf_event_attr *attr, int idx)
 {
 	evsel->idx	   = idx;
 	evsel->tracking	   = !idx;
@@ -255,7 +255,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 	if (!evsel)
 		return NULL;
-	perf_evsel__init(evsel, attr, idx);
+	evsel__init(evsel, attr, idx);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
@@ -350,7 +350,7 @@ struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
 		event_attr_init(&attr);
 		attr.config = evsel->tp_format->id;
 		attr.sample_period = 1;
-		perf_evsel__init(evsel, &attr, idx);
+		evsel__init(evsel, &attr, idx);
 	}
 
 	return evsel;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3caabd8a4aa6..af230d92fbef 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -238,8 +238,7 @@ struct evsel *perf_evsel__new_cycles(bool precise);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-void perf_evsel__init(struct evsel *evsel,
-		      struct perf_event_attr *attr, int idx);
+void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
 void perf_evsel__exit(struct evsel *evsel);
 void perf_evsel__delete(struct evsel *evsel);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ed57b6b5ed91..f6fe3c90828f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -782,7 +782,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.sample_id_all  = sample_id_all;
 	attr.size	    = sizeof(attr);
 
-	perf_evsel__init(&pevsel->evsel, &attr, idx);
+	evsel__init(&pevsel->evsel, &attr, idx);
 	return 0;
 }
 
