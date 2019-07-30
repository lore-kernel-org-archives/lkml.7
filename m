Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A629C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88632089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fh2jPihT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfG3SU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:20:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfG3SU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:20:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIKE7D3327091
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:20:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIKE7D3327091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510815;
        bh=IyGSCTQjOMP0dyD72UQSVjRFtqr3vZse+I55qYaueJc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Fh2jPihT3WVRvNE67E24/9daF9CYIpwlcrS7cOr5a45KoKjo23qJFj++Nk8xy9zow
         DpOdCKy80JX7gJy/9OikLSfEEK0aBfg4VwgvOLjLl6DNp4oTMLRRdDRZOGgK7mfXwn
         02EDlfQKV4Nh9lnLZFf2bx1SiKaaL1NWqmIukWBqkxBIsTVmaIZD6Gfv893LWVX/hg
         UPb1OmS2ZF54tbB33hZn5SoOSwTE2V1b8snGK0D1t1uJkoJlmKtxUXrvZejSEhMOL7
         M9rJkL9/Ty5aDobhCK1SgRaYgdLnczNc8QM5amrOpuSXXWOgBTDv7dKQXzuaH6xtwt
         e43Ssxc0UnLCw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIKEmq3327088;
        Tue, 30 Jul 2019 11:20:14 -0700
Date:   Tue, 30 Jul 2019 11:20:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b49aca3e9ce60d00e5bf0694b2ff4c2cd40809e5@git.kernel.org>
Cc:     mpetlan@redhat.com, ak@linux.intel.com, namhyung@kernel.org,
        peterz@infradead.org, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, alexey.budankov@linux.intel.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: alexey.budankov@linux.intel.com, mpetlan@redhat.com,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, ak@linux.intel.com, hpa@zytor.com,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org
In-Reply-To: <20190721112506.12306-19-jolsa@kernel.org>
References: <20190721112506.12306-19-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Rename perf_evsel__cpus() to
 evsel__cpus()
Git-Commit-ID: b49aca3e9ce60d00e5bf0694b2ff4c2cd40809e5
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

Commit-ID:  b49aca3e9ce60d00e5bf0694b2ff4c2cd40809e5
Gitweb:     https://git.kernel.org/tip/b49aca3e9ce60d00e5bf0694b2ff4c2cd40809e5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:05 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evsel: Rename perf_evsel__cpus() to evsel__cpus()

Rename perf_evsel__cpus() to evsel__cpus(), so we don't have a name
clash when we add perf_evsel__cpus() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h        | 4 ++--
 tools/perf/util/stat-display.c | 6 +++---
 tools/perf/util/stat.c         | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35f7e7ff3c5e..5fec1ca64f58 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -197,14 +197,14 @@ struct target;
 struct thread_map;
 struct record_opts;
 
-static inline struct perf_cpu_map *perf_evsel__cpus(struct evsel *evsel)
+static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
 	return evsel->cpus;
 }
 
 static inline int perf_evsel__nr_cpus(struct evsel *evsel)
 {
-	return perf_evsel__cpus(evsel)->nr;
+	return evsel__cpus(evsel)->nr;
 }
 
 void perf_counts_values__scale(struct perf_counts_values *count,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index cdfceb5b4d72..f7666d2e6e0c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -109,7 +109,7 @@ static void aggr_printout(struct perf_stat_config *config,
 		} else {
 			fprintf(config->output, "CPU%*d%s ",
 				config->csv_output ? 0 : -5,
-				perf_evsel__cpus(evsel)->map[id],
+				evsel__cpus(evsel)->map[id],
 				config->csv_sep);
 		}
 		break;
@@ -325,7 +325,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 		return 0;
 
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
-		int cpu2 = perf_evsel__cpus(evsel)->map[i];
+		int cpu2 = evsel__cpus(evsel)->map[i];
 
 		if (config->aggr_get_id(config, evlist->cpus, cpu2) == id)
 			return cpu2;
@@ -593,7 +593,7 @@ static void aggr_cb(struct perf_stat_config *config,
 	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
 		struct perf_counts_values *counts;
 
-		s2 = config->aggr_get_id(config, perf_evsel__cpus(counter), cpu);
+		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
 		if (s2 != ad->id)
 			continue;
 		if (first)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index efd934ec02c3..63f7815ceb4f 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -215,7 +215,7 @@ static int check_per_pkg(struct evsel *counter,
 			 struct perf_counts_values *vals, int cpu, bool *skip)
 {
 	unsigned long *mask = counter->per_pkg_mask;
-	struct perf_cpu_map *cpus = perf_evsel__cpus(counter);
+	struct perf_cpu_map *cpus = evsel__cpus(counter);
 	int s;
 
 	*skip = false;
@@ -483,7 +483,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
+		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
 
 	return perf_evsel__open_per_thread(evsel, evsel->threads);
 }
