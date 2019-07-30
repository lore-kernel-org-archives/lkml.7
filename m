Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B77C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2029720578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455763;
	bh=GMWlZKacnbVZnWuH0eM0T8EIRgGVRyMxCmgFVZfLAXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snqKbpQmetWUOtIfi0MPj34eB8wrf/O/HlFZ/eFPIeHeVB0JjLJPfYX8nNIXYFyPi
	 h/N0kPAUkFRnnAusLLzyfrPVayqBJ4XgVm6bnU/Fwkv1oHtdWloq3/GcOaBlQqGCsn
	 cSZ/CtEnL9MGZnM3M7aIFiI0Utbx6ZF1QIb5vMow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbfG3DCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732717AbfG3DB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7365220578;
        Tue, 30 Jul 2019 03:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455718;
        bh=GMWlZKacnbVZnWuH0eM0T8EIRgGVRyMxCmgFVZfLAXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bitCf5dib7XnImzrx6v2m+gw1dnkeWopPEgVRBQaWKZ0S2aQtTa9+FsaRsC1vlF76
         PIiu5opyQMyCsxX3Xj321CCnAfwNg3zur/f/IZyZQATcRrriGygQIjRm2nCMLWqieB
         atJVa9IsOQqhTmhiWT0Idu9dL1k1AUBkjr4hXxJ8=
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
Subject: [PATCH 099/107] libperf: Add tests support
Date:   Mon, 29 Jul 2019 23:56:02 -0300
Message-Id: <20190730025610.22603-100-acme@kernel.org>
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
 tools/perf/lib/Makefile                 |  7 ++++-
 tools/perf/lib/include/internal/tests.h | 19 +++++++++++++
 tools/perf/lib/tests/Makefile           | 38 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/lib/include/internal/tests.h
 create mode 100644 tools/perf/lib/tests/Makefile

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
-- 
2.21.0

