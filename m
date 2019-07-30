Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C6C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2909820659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DXYuyUYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbfG3TBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:01:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54095 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbfG3TBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:01:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ1bt43337693
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:01:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ1bt43337693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513298;
        bh=sNM9a0HIgEL0XoWMXgXg+kpFhCbwXuXneIQN0Sb5LG4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DXYuyUYp9Nt0w41JbDppKr24/eH5BVq6YRpMCkbRyi+461fnysYpUx5c/1TkKuZIJ
         ETi51dbIZiEXEpSrqimgvZCevYsYgWgfWbA3D+4w07jKT4pP1eurlGOafhk62Pqewv
         iAMnblVaCdaj1c5dMsZGgCaM8grn3pogw0Wh0gF/Xfdz9JjZBmea2OkJPtnIswHVc7
         OsG6EUjBpxdcFVnpDKRVs81ecYc1W299moMOTllp3Jl++GzAoSb+Ul+fBQOf+W38RP
         eCT3cA+26Eew1wkDLKb5zxkFukTlTPb6+/8mnM7zKMxTMBWb3op0OfaJdSyD3lLX1N
         DGr8dNAZJfZIw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ1bSP3337690;
        Tue, 30 Jul 2019 12:01:37 -0700
Date:   Tue, 30 Jul 2019 12:01:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6a94b52a71b7d3ca3ec47c194f7916b306cb26ef@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, mpetlan@redhat.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, jolsa@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mingo@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          mingo@kernel.org, tglx@linutronix.de, ak@linux.intel.com,
          jolsa@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mpetlan@redhat.com,
          acme@redhat.com, alexey.budankov@linux.intel.com
In-Reply-To: <20190721112506.12306-73-jolsa@kernel.org>
References: <20190721112506.12306-73-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add tests support
Git-Commit-ID: 6a94b52a71b7d3ca3ec47c194f7916b306cb26ef
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

Commit-ID:  6a94b52a71b7d3ca3ec47c194f7916b306cb26ef
Gitweb:     https://git.kernel.org/tip/6a94b52a71b7d3ca3ec47c194f7916b306cb26ef
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:59 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Add tests support

Adding simple test framework, now empty.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-73-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile                 |  7 +++++-
 tools/perf/lib/include/internal/tests.h | 19 +++++++++++++++++
 tools/perf/lib/tests/Makefile           | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index f1b3d4c6d5f0..8a9ae50818e4 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -109,6 +109,11 @@ all: fixdep
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
+	$(Q)$(MAKE) -C tests clean
+
+tests:
+	$(Q)$(MAKE) -C tests
+	$(Q)$(MAKE) -C tests run
 
 $(LIBPERF_PC):
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
@@ -150,4 +155,4 @@ install: install_lib install_headers install_pkgconfig
 
 FORCE:
 
-.PHONY: all install clean FORCE
+.PHONY: all install clean tests FORCE
diff --git a/tools/perf/lib/include/internal/tests.h b/tools/perf/lib/include/internal/tests.h
new file mode 100644
index 000000000000..b7a20cd24ee1
--- /dev/null
+++ b/tools/perf/lib/include/internal/tests.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_TESTS_H
+#define __LIBPERF_INTERNAL_TESTS_H
+
+#include <stdio.h>
+
+#define __T_START fprintf(stdout, "- running %s...", __FILE__)
+#define __T_OK    fprintf(stdout, "OK\n")
+#define __T_FAIL  fprintf(stdout, "FAIL\n")
+
+#define __T(text, cond)                                                          \
+do {                                                                             \
+	if (!(cond)) {                                                           \
+		fprintf(stderr, "FAILED %s:%d %s\n", __FILE__, __LINE__, text);  \
+		return -1;                                                       \
+	}                                                                        \
+} while (0)
+
+#endif /* __LIBPERF_INTERNAL_TESTS_H */
diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
new file mode 100644
index 000000000000..de951ae38dea
--- /dev/null
+++ b/tools/perf/lib/tests/Makefile
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+TESTS =
+
+TESTS_SO := $(addsuffix -so,$(TESTS))
+TESTS_A  := $(addsuffix -a,$(TESTS))
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+all:
+
+include $(srctree)/tools/scripts/Makefile.include
+
+INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include
+
+$(TESTS_A): FORCE
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a
+
+$(TESTS_SO): FORCE
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) -lperf
+
+all: $(TESTS_A) $(TESTS_SO)
+
+run:
+	@echo "running static:"
+	@for i in $(TESTS_A); do ./$$i; done
+	@echo "running dynamic:"
+	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
+
+clean:
+	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
+
+.PHONY: all clean FORCE
