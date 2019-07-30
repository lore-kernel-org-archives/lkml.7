Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47052C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150E720659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="n9KfG1qG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfG3TFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:05:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfG3TFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:05:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ4nil3339797
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:04:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ4nil3339797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513490;
        bh=seLcXPfEsR+vXTuWWvwbh7YQgP0yONLgPSNXSUOpugk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=n9KfG1qGc67dLQb03glfT6RP+NaqjCqHDwjW6YmtmeeylxeycCrBZ1bRnxS0UTMg0
         WXM6VVWZ6UH63zoEA3zQsDjtcDbak7+KO+GrkRSBXGvtI03XfCuDt+Vq0TLpmMPdLZ
         GLqNrBp+IkTUr4SI9G47hjFK7MwuVTqhfyExUAs0m/YmD4GdzNDufwZFeE4NmTtDWf
         VD4uEyoB+1oUErKF16FT3gl1fRLDsPiX8QYeWeZnJ+qOGRI+M0+Ig+zKZMtPwdlrve
         Rht2c7qmhEJBNQbGidoYcVcQDgZinaIvf2a2ZtJypErOCA2d/wbD3li5MtMdzcdF4U
         7H8y9URmV9d/Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ4mGR3339793;
        Tue, 30 Jul 2019 12:04:48 -0700
Date:   Tue, 30 Jul 2019 12:04:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bb5133ae4d404a8a08d8a94dfdea1c477c93e842@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, ak@linux.intel.com,
        jolsa@kernel.org, mingo@kernel.org, peterz@infradead.org,
        acme@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com
Reply-To: mingo@kernel.org, jolsa@kernel.org, mpetlan@redhat.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          ak@linux.intel.com, hpa@zytor.com,
          alexey.budankov@linux.intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          acme@redhat.com
In-Reply-To: <20190721112506.12306-77-jolsa@kernel.org>
References: <20190721112506.12306-77-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evsel tests
Git-Commit-ID: bb5133ae4d404a8a08d8a94dfdea1c477c93e842
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

Commit-ID:  bb5133ae4d404a8a08d8a94dfdea1c477c93e842
Gitweb:     https://git.kernel.org/tip/bb5133ae4d404a8a08d8a94dfdea1c477c93e842
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:25:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:47 -0300

libperf: Add perf_evsel tests

Add 2 simple perf_evsel tests to test counters reading interface through
the struct evsel object.

Committer testing:

  # make -C tools/perf/lib tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
    LINK     test-threadmap-a
    LINK     test-evlist-a
    LINK     test-evsel-a
    LINK     test-cpumap-so
    LINK     test-threadmap-so
    LINK     test-evlist-so
    LINK     test-evsel-so
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  - running test-evsel.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  - running test-evsel.c...OK
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-77-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/Makefile     |  2 +-
 tools/perf/lib/tests/test-evsel.c | 82 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index e66ed090f08e..1ee4e9ba848b 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
-TESTS = test-cpumap test-threadmap test-evlist
+TESTS = test-cpumap test-threadmap test-evlist test-evsel
 
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
new file mode 100644
index 000000000000..268712292f60
--- /dev/null
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/perf_event.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/evsel.h>
+#include <internal/tests.h>
+
+static int test_stat_cpu(void)
+{
+	struct perf_cpu_map *cpus;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_CPU_CLOCK,
+	};
+	int err, cpu, tmp;
+
+	cpus = perf_cpu_map__new(NULL);
+	__T("failed to create cpus", cpus);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, cpus, NULL);
+	__T("failed to open evsel", err == 0);
+
+	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+		struct perf_counts_values counts = { .val = 0 };
+
+		perf_evsel__read(evsel, cpu, 0, &counts);
+		__T("failed to read value for evsel", counts.val != 0);
+	}
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_cpu_map__put(cpus);
+	return 0;
+}
+
+static int test_stat_thread(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val != 0);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	__T_START;
+
+	test_stat_cpu();
+	test_stat_thread();
+
+	__T_OK;
+	return 0;
+}
