Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CFDC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607172064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wDHM0oEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfG3THQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:07:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33667 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfG3THQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:07:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ73fw3340402
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:07:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ73fw3340402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513624;
        bh=tMX8kpm2ip7uhZYOQjC4RDCfdHAPtGwN6agP6KB1xf0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wDHM0oExdoMIGC5zfMiwPZbS96aTZaCRi9mp/+zKIRAjBwcCP5Fci2FCbEqq4H7QD
         V/wbBG1doXLWQjPvGxd2O5Muipaz6inbRvz2s3oHWqZ0iLSDMnJpHGqRX6TyOL90jJ
         DVZ+o1nng8QV4jqpUSgW7PTIw11kdSOyPWGVdiV0bMd4uX9qwe5wU2VgsizqmPZHdH
         510f4+2UV5z9iFjzUuF/E0VZsHv3yyks/UAX6UHJPPbUiwaULZPPKGnIkwQ6KFHeKf
         s7zGMw26/6ArXx6W2ngL/RxyhSbfC3X4e4jQr+NfYuzUCaoxYsDWN9qMu3mTsfYQf1
         TcndxQIcpg6cg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ727E3340397;
        Tue, 30 Jul 2019 12:07:02 -0700
Date:   Tue, 30 Jul 2019 12:07:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f4f48e9c1adb49f732ac0abc4b2513f2b62a10cb@git.kernel.org>
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
        alexey.budankov@linux.intel.com, tglx@linutronix.de,
        mpetlan@redhat.com, ak@linux.intel.com, jolsa@kernel.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: jolsa@kernel.org, mpetlan@redhat.com, ak@linux.intel.com,
          namhyung@kernel.org, alexey.budankov@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, acme@redhat.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org
In-Reply-To: <20190721112506.12306-80-jolsa@kernel.org>
References: <20190721112506.12306-80-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Initial documentation
Git-Commit-ID: f4f48e9c1adb49f732ac0abc4b2513f2b62a10cb
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

Commit-ID:  f4f48e9c1adb49f732ac0abc4b2513f2b62a10cb
Gitweb:     https://git.kernel.org/tip/f4f48e9c1adb49f732ac0abc4b2513f2b62a10cb
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:25:06 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:47 -0300

libperf: Initial documentation

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
 tools/perf/lib/Documentation/Makefile              |   7 ++
 tools/perf/lib/Documentation/man/libperf.rst       | 100 +++++++++++++++++
 tools/perf/lib/Documentation/tutorial/tutorial.rst | 123 +++++++++++++++++++++
 3 files changed, 230 insertions(+)

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
