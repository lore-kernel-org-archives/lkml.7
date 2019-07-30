Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ED6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433D520578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455750;
	bh=TAmtjVIxnGKIiPzSvqwQ8rHggbcGopauzW/xbeQ/b4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HGqQn4DBrYbf0ju8vi2zAii8EP/d+S7jHrhsK7zB1s4kOs3ERqoaF9DOcxfcdYfVf
	 bd+RQRXCa2HimouRs/X9ZIuK0zaieovbXgN+Juv0O8SfSLeH3TA1Ch87R2l7rz5n+X
	 KSm7QD2I9AcbtO9/YCyeRVbGp6E8/RacYfyo/Lqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbfG3DC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732808AbfG3DCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:02:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B337208E3;
        Tue, 30 Jul 2019 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455743;
        bh=TAmtjVIxnGKIiPzSvqwQ8rHggbcGopauzW/xbeQ/b4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0cOoD2H/vFAYfCMFL+YH5Hts4z3NkKYE/w1LKMK9fsUngF4g1x4hLavkoMkobKyjj
         fuvS8O/VtqzIsiiCD8HFNJnhCxvzzzjSm/tRJhpGww/SWLSzPu60pVFmejzXm77Wti
         KOFWItYMaAKGF0TWYzbjISmuJ0onT/QOwTzOKSjI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 106/107] libperf: Initial documentation
Date:   Mon, 29 Jul 2019 23:56:09 -0300
Message-Id: <20190730025610.22603-107-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add initial drafts of documentation files, hugely unfinished.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-80-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Documentation/Makefile         |   7 +
 tools/perf/lib/Documentation/man/libperf.rst  | 100 ++++++++++++++
 .../lib/Documentation/tutorial/tutorial.rst   | 123 ++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 tools/perf/lib/Documentation/Makefile
 create mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 create mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst

diff --git a/tools/perf/lib/Documentation/Makefile b/tools/perf/lib/Documentation/Makefile
new file mode 100644
index 000000000000..586425a88795
--- /dev/null
+++ b/tools/perf/lib/Documentation/Makefile
@@ -0,0 +1,7 @@
+all:
+	rst2man man/libperf.rst > man/libperf.7
+	rst2pdf tutorial/tutorial.rst
+
+clean:
+	rm -f man/libperf.7
+	rm -f tutorial/tutorial.pdf
diff --git a/tools/perf/lib/Documentation/man/libperf.rst b/tools/perf/lib/Documentation/man/libperf.rst
new file mode 100644
index 000000000000..09a270fccb9c
--- /dev/null
+++ b/tools/perf/lib/Documentation/man/libperf.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+libperf
+
+The libperf library provides an API to access the linux kernel perf
+events subsystem. It provides the following high level objects:
+
+  - struct perf_cpu_map
+  - struct perf_thread_map
+  - struct perf_evlist
+  - struct perf_evsel
+
+reference
+=========
+Function reference by header files:
+
+perf/core.h
+-----------
+.. code-block:: c
+
+  typedef int (\*libperf_print_fn_t)(enum libperf_print_level level,
+                                     const char \*, va_list ap);
+
+  void libperf_set_print(libperf_print_fn_t fn);
+
+perf/cpumap.h
+-------------
+.. code-block:: c
+
+  struct perf_cpu_map \*perf_cpu_map__dummy_new(void);
+  struct perf_cpu_map \*perf_cpu_map__new(const char \*cpu_list);
+  struct perf_cpu_map \*perf_cpu_map__read(FILE \*file);
+  struct perf_cpu_map \*perf_cpu_map__get(struct perf_cpu_map \*map);
+  void perf_cpu_map__put(struct perf_cpu_map \*map);
+  int perf_cpu_map__cpu(const struct perf_cpu_map \*cpus, int idx);
+  int perf_cpu_map__nr(const struct perf_cpu_map \*cpus);
+  perf_cpu_map__for_each_cpu(cpu, idx, cpus)
+
+perf/threadmap.h
+----------------
+.. code-block:: c
+
+  struct perf_thread_map \*perf_thread_map__new_dummy(void);
+  void perf_thread_map__set_pid(struct perf_thread_map \*map, int thread, pid_t pid);
+  char \*perf_thread_map__comm(struct perf_thread_map \*map, int thread);
+  struct perf_thread_map \*perf_thread_map__get(struct perf_thread_map \*map);
+  void perf_thread_map__put(struct perf_thread_map \*map);
+
+perf/evlist.h
+-------------
+.. code-block::
+
+  void perf_evlist__init(struct perf_evlist \*evlist);
+  void perf_evlist__add(struct perf_evlist \*evlist,
+                      struct perf_evsel \*evsel);
+  void perf_evlist__remove(struct perf_evlist \*evlist,
+                         struct perf_evsel \*evsel);
+  struct perf_evlist \*perf_evlist__new(void);
+  void perf_evlist__delete(struct perf_evlist \*evlist);
+  struct perf_evsel\* perf_evlist__next(struct perf_evlist \*evlist,
+                                     struct perf_evsel \*evsel);
+  int perf_evlist__open(struct perf_evlist \*evlist);
+  void perf_evlist__close(struct perf_evlist \*evlist);
+  void perf_evlist__enable(struct perf_evlist \*evlist);
+  void perf_evlist__disable(struct perf_evlist \*evlist);
+  perf_evlist__for_each_evsel(evlist, pos)
+  void perf_evlist__set_maps(struct perf_evlist \*evlist,
+                           struct perf_cpu_map \*cpus,
+                           struct perf_thread_map \*threads);
+
+perf/evsel.h
+------------
+.. code-block:: c
+
+  struct perf_counts_values {
+        union {
+                struct {
+                        uint64_t val;
+                        uint64_t ena;
+                        uint64_t run;
+                };
+                uint64_t values[3];
+        };
+  };
+
+  void perf_evsel__init(struct perf_evsel \*evsel,
+                      struct perf_event_attr \*attr);
+  struct perf_evsel \*perf_evsel__new(struct perf_event_attr \*attr);
+  void perf_evsel__delete(struct perf_evsel \*evsel);
+  int perf_evsel__open(struct perf_evsel \*evsel, struct perf_cpu_map \*cpus,
+                     struct perf_thread_map \*threads);
+  void perf_evsel__close(struct perf_evsel \*evsel);
+  int perf_evsel__read(struct perf_evsel \*evsel, int cpu, int thread,
+                     struct perf_counts_values \*count);
+  int perf_evsel__enable(struct perf_evsel \*evsel);
+  int perf_evsel__disable(struct perf_evsel \*evsel);
+  int perf_evsel__apply_filter(struct perf_evsel \*evsel, const char \*filter);
+  struct perf_cpu_map \*perf_evsel__cpus(struct perf_evsel \*evsel);
+  struct perf_thread_map \*perf_evsel__threads(struct perf_evsel \*evsel);
+  struct perf_event_attr \*perf_evsel__attr(struct perf_evsel \*evsel);
diff --git a/tools/perf/lib/Documentation/tutorial/tutorial.rst b/tools/perf/lib/Documentation/tutorial/tutorial.rst
new file mode 100644
index 000000000000..7be7bc27b385
--- /dev/null
+++ b/tools/perf/lib/Documentation/tutorial/tutorial.rst
@@ -0,0 +1,123 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+libperf tutorial
+================
+
+Compile and install libperf from kernel sources
+===============================================
+.. code-block:: bash
+
+  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+  cd linux/tools/perf/lib
+  make
+  sudo make install prefix=/usr
+
+Libperf object
+==============
+The libperf library provides several high level objects:
+
+struct perf_cpu_map
+  Provides a cpu list abstraction.
+
+struct perf_thread_map
+  Provides a thread list abstraction.
+
+struct perf_evsel
+  Provides an abstraction for single a perf event.
+
+struct perf_evlist
+  Gathers several struct perf_evsel object and performs functions on all of them.
+
+The exported API binds these objects together,
+for full reference see the libperf.7 man page.
+
+Examples
+========
+Examples aim to explain libperf functionality on simple use cases.
+They are based in on a checked out linux kernel git tree:
+
+.. code-block:: bash
+
+  $ cd tools/perf/lib/Documentation/tutorial/
+  $ ls -d  ex-*
+  ex-1-compile  ex-2-evsel-stat  ex-3-evlist-stat
+
+ex-1-compile example
+====================
+This example shows the basic usage of *struct perf_cpu_map*,
+how to create it and display its cpus:
+
+.. code-block:: bash
+
+  $ cd ex-1-compile/
+  $ make
+  gcc -o test test.c -lperf
+  $ ./test
+  0 1 2 3 4 5 6 7
+
+
+The full code listing is here:
+
+.. code-block:: c
+
+   1 #include <perf/cpumap.h>
+   2
+   3 int main(int argc, char **Argv)
+   4 {
+   5         struct perf_cpu_map *cpus;
+   6         int cpu, tmp;
+   7
+   8         cpus = perf_cpu_map__new(NULL);
+   9
+  10         perf_cpu_map__for_each_cpu(cpu, tmp, cpus)
+  11                 fprintf(stdout, "%d ", cpu);
+  12
+  13         fprintf(stdout, "\n");
+  14
+  15         perf_cpu_map__put(cpus);
+  16         return 0;
+  17 }
+
+
+First you need to include the proper header to have *struct perf_cpumap*
+declaration and functions:
+
+.. code-block:: c
+
+   1 #include <perf/cpumap.h>
+
+
+The *struct perf_cpumap* object is created by *perf_cpu_map__new* call.
+The *NULL* argument asks it to populate the object with the current online CPUs list:
+
+.. code-block:: c
+
+   8         cpus = perf_cpu_map__new(NULL);
+
+This is paired with a *perf_cpu_map__put*, that drops its reference at the end, possibly deleting it.
+
+.. code-block:: c
+
+  15         perf_cpu_map__put(cpus);
+
+The iteration through the *struct perf_cpumap* CPUs is done using the *perf_cpu_map__for_each_cpu*
+macro which requires 3 arguments:
+
+- cpu  - the cpu numer
+- tmp  - iteration helper variable
+- cpus - the *struct perf_cpumap* object
+
+.. code-block:: c
+
+  10         perf_cpu_map__for_each_cpu(cpu, tmp, cpus)
+  11                 fprintf(stdout, "%d ", cpu);
+
+ex-2-evsel-stat example
+=======================
+
+TBD
+
+ex-3-evlist-stat example
+========================
+
+TBD
-- 
2.21.0

