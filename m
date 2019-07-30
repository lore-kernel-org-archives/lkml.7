Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA313C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734BD217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Vz1Qa64x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfG3S3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:29:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfG3S3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:29:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UISmfi3330222
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:28:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UISmfi3330222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511329;
        bh=pToQUPfldVvvefI/KcPWfo05CJpusqv4Ul6tFXsdEIU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Vz1Qa64xm4i/fMOGjUPpr5HmJXJfVRp1sckXmGgoXeTp9JjnJ74M/iKGeTDd2Aclq
         qFe3mymR7b5nA9c7+IV2K60OI3EwBBQ2YgsCiDT/ncFSB4GAc2eK9O3/ZxSthTVO4S
         TV9KMgvpWcakKpqc4p2gc9MRb+piKI9Zdv24EHfUd+tTo79bD5bo7W/y7g0BzXAvAd
         xyljbpUd8BYmQZ651RmfpeFJPIZkKaHR/m0VLr9w4CvcXB26ymeBwI7qe5/A6tDvRM
         jDvqcA7AbcrcFdYkKD8qUuOSF1xKctKGv/i0YweTd/9jQBjgJRxznmIltug9UDOOxB
         iEzexLJgf17Iw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UISm1K3330219;
        Tue, 30 Jul 2019 11:28:48 -0700
Date:   Tue, 30 Jul 2019 11:28:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-397721e06e52d017cfdd403f63284ed0995d4caf@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        namhyung@kernel.org, alexey.budankov@linux.intel.com,
        jolsa@kernel.org, peterz@infradead.org, acme@redhat.com,
        mpetlan@redhat.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Reply-To: alexey.budankov@linux.intel.com, jolsa@kernel.org,
          peterz@infradead.org, acme@redhat.com, mpetlan@redhat.com,
          ak@linux.intel.com, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, namhyung@kernel.org
In-Reply-To: <20190721112506.12306-30-jolsa@kernel.org>
References: <20190721112506.12306-30-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_cpu_map__dummy_new() function
Git-Commit-ID: 397721e06e52d017cfdd403f63284ed0995d4caf
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

Commit-ID:  397721e06e52d017cfdd403f63284ed0995d4caf
Gitweb:     https://git.kernel.org/tip/397721e06e52d017cfdd403f63284ed0995d4caf
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:16 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_cpu_map__dummy_new() function

Move cpu_map__dummy_new() to libperf as perf_cpu_map__dummy_new() function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-30-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c              | 13 +++++++++++++
 tools/perf/lib/include/perf/cpumap.h |  4 ++++
 tools/perf/lib/libperf.map           |  1 +
 tools/perf/tests/sw-clock.c          |  2 +-
 tools/perf/tests/task-exit.c         |  2 +-
 tools/perf/util/cpumap.c             | 15 +--------------
 tools/perf/util/cpumap.h             |  2 +-
 tools/perf/util/evlist.c             |  2 +-
 tools/perf/util/evsel.c              |  2 +-
 9 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 86a199c26f20..80d587ab95aa 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -3,3 +3,16 @@
 #include <stdlib.h>
 #include <linux/refcount.h>
 #include <internal/cpumap.h>
+
+struct perf_cpu_map *perf_cpu_map__dummy_new(void)
+{
+	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
+
+	if (cpus != NULL) {
+		cpus->nr = 1;
+		cpus->map[0] = -1;
+		refcount_set(&cpus->refcnt, 1);
+	}
+
+	return cpus;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index 8355d3ce7d0c..fa1e5aa9d662 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -2,6 +2,10 @@
 #ifndef __LIBPERF_CPUMAP_H
 #define __LIBPERF_CPUMAP_H
 
+#include <perf/core.h>
+
 struct perf_cpu_map;
 
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+
 #endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 3536242c545c..65201c6cbe7e 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -1,6 +1,7 @@
 LIBPERF_0.0.1 {
 	global:
 		libperf_set_print;
+		perf_cpu_map__dummy_new;
 	local:
 		*;
 };
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index ba033a6e6c0f..c6d3f4488b73 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -56,7 +56,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	}
 	evlist__add(evlist, evsel);
 
-	cpus = cpu_map__dummy_new();
+	cpus = perf_cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(getpid());
 	if (!cpus || !threads) {
 		err = -ENOMEM;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index d17effdd55c8..c094fb8cc877 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -63,7 +63,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	 * perf_evlist__prepare_workload we'll fill in the only thread
 	 * we're monitoring, the one forked there.
 	 */
-	cpus = cpu_map__dummy_new();
+	cpus = perf_cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(-1);
 	if (!cpus || !threads) {
 		err = -ENOMEM;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 5eb4e1fbb877..acda9bfb4002 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -189,7 +189,7 @@ struct perf_cpu_map *cpu_map__new(const char *cpu_list)
 	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
 	else
-		cpus = cpu_map__dummy_new();
+		cpus = perf_cpu_map__dummy_new();
 invalid:
 	free(tmp_cpus);
 out:
@@ -256,19 +256,6 @@ size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 #undef BUFSIZE
 }
 
-struct perf_cpu_map *cpu_map__dummy_new(void)
-{
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
-
-	if (cpus != NULL) {
-		cpus->nr = 1;
-		cpus->map[0] = -1;
-		refcount_set(&cpus->refcnt, 1);
-	}
-
-	return cpus;
-}
-
 struct perf_cpu_map *cpu_map__empty_new(int nr)
 {
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c2ba9ae195f7..0ce3f6bd9449 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -6,13 +6,13 @@
 #include <stdbool.h>
 #include <linux/refcount.h>
 #include <internal/cpumap.h>
+#include <perf/cpumap.h>
 
 #include "perf.h"
 #include "util/debug.h"
 
 struct perf_cpu_map *cpu_map__new(const char *cpu_list);
 struct perf_cpu_map *cpu_map__empty_new(int nr);
-struct perf_cpu_map *cpu_map__dummy_new(void);
 struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data);
 struct perf_cpu_map *cpu_map__read(FILE *file);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1bedec28e58f..461c1e68e9e7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1086,7 +1086,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 		return -1;
 
 	if (target__uses_dummy_map(target))
-		cpus = cpu_map__dummy_new();
+		cpus = perf_cpu_map__dummy_new();
 	else
 		cpus = cpu_map__new(target->cpu_list);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5aeb7260c8e1..a389752840a9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1840,7 +1840,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		static struct perf_cpu_map *empty_cpu_map;
 
 		if (empty_cpu_map == NULL) {
-			empty_cpu_map = cpu_map__dummy_new();
+			empty_cpu_map = perf_cpu_map__dummy_new();
 			if (empty_cpu_map == NULL)
 				return -ENOMEM;
 		}
