Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E237C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE962070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f82mC+EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfFVGq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:46:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:46:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6kXAJ2009101
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:46:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6kXAJ2009101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185994;
        bh=Tj9dSxVaTrPbVwKx9pgj2HBONo6budDBkKwji7sxoR8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=f82mC+EU2LmzOF0MfZYWCgi378iNqfY378+D2uBfB16hjoF6gtD3nZ+zngdO/2hm6
         aipk2N7dfqBoiVHG/Ck6cYYb4+XGIUirZkz9KwFC/Fc3pplGkLc5RsOEF9RTl8v6QY
         MfHBi/BUJtiIq1ZJgTlm4f+E51wu0mx9CzJQ9osEhTKYAR8VOa5Wc3fyYVE4pRjC6E
         Z7V8JtiYGHv2ylnwc+Errx26sJ6ZrRaZxVhTVBAsfyi3WxB1POn3iMUCKL2vjPFNZV
         /g5/yt6G/3r45QxxSYc3DN8A4AIlf+3UHyPKBWOYNBP9FyY/U9Hr6GHmF346RJvS/o
         LprL7bvITbNYw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6kWAX2009090;
        Fri, 21 Jun 2019 23:46:32 -0700
Date:   Fri, 21 Jun 2019 23:46:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p0kg493z2m8qizjbdefzip1i@git.kernel.org>
Cc:     tglx@linutronix.de, adrian.hunter@intel.com, ak@linux.intel.com,
        mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
        wangnan0@huawei.com, namhyung@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, wangnan0@huawei.com, hpa@zytor.com,
          acme@redhat.com, mingo@kernel.org, ak@linux.intel.com,
          adrian.hunter@intel.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Add missing SPDX headers
Git-Commit-ID: 5875cf4cd32ea08d0d6abb82091f2d1f7cd6889f
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

Commit-ID:  5875cf4cd32ea08d0d6abb82091f2d1f7cd6889f
Gitweb:     https://git.kernel.org/tip/5875cf4cd32ea08d0d6abb82091f2d1f7cd6889f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 13 Jun 2019 18:29:05 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:19 -0300

perf tests: Add missing SPDX headers

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p0kg493z2m8qizjbdefzip1i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build                                    | 2 ++
 tools/perf/tests/bp_account.c                             | 1 +
 tools/perf/tests/bpf-script-example.c                     | 1 +
 tools/perf/tests/bpf-script-test-kbuild.c                 | 1 +
 tools/perf/tests/bpf-script-test-prologue.c               | 1 +
 tools/perf/tests/bpf-script-test-relocation.c             | 1 +
 tools/perf/tests/bpf.c                                    | 1 +
 tools/perf/tests/map_groups.c                             | 1 +
 tools/perf/tests/mem.c                                    | 1 +
 tools/perf/tests/mem2node.c                               | 1 +
 tools/perf/tests/shell/lib/probe.sh                       | 1 +
 tools/perf/tests/shell/probe_vfs_getname.sh               | 3 ++-
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 1 +
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 1 +
 tools/perf/tests/shell/record+zstd_comp_decomp.sh         | 2 ++
 tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 1 +
 16 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index e3ba63cef01e..e72accefd669 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 perf-y += builtin-test.o
 perf-y += parse-events.o
 perf-y += dso-data.o
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 57fc544aedb0..153624e2d0f5 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Powerpc needs __SANE_USERSPACE_TYPES__ before <linux/types.h> to select
  * 'int-ll64.h' and avoid compile warnings when printing __u64 with %llu.
diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index 1ca5106df5f1..ab4b98b3165d 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bpf-script-example.c
  * Test basic LLVM building
diff --git a/tools/perf/tests/bpf-script-test-kbuild.c b/tools/perf/tests/bpf-script-test-kbuild.c
index ff3ec8337f0a..219673aa278f 100644
--- a/tools/perf/tests/bpf-script-test-kbuild.c
+++ b/tools/perf/tests/bpf-script-test-kbuild.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bpf-script-test-kbuild.c
  * Test include from kernel header
diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
index 43f1e16486f4..bd83d364cf30 100644
--- a/tools/perf/tests/bpf-script-test-prologue.c
+++ b/tools/perf/tests/bpf-script-test-prologue.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bpf-script-test-prologue.c
  * Test BPF prologue
diff --git a/tools/perf/tests/bpf-script-test-relocation.c b/tools/perf/tests/bpf-script-test-relocation.c
index 93af77421816..74006e4b2d24 100644
--- a/tools/perf/tests/bpf-script-test-relocation.c
+++ b/tools/perf/tests/bpf-script-test-relocation.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bpf-script-test-relocation.c
  * Test BPF loader checking relocation
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 79b54f8ddebf..c9e4cdc4c9c8 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <stdio.h>
 #include <sys/epoll.h>
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index 70d96acc6dcf..594fdaca4f71 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include "tests.h"
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index 0f82ee9fd3f7..efe3397824d2 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include "util/mem-events.h"
 #include "util/symbol.h"
 #include "linux/perf_event.h"
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 9e9e4d37cc77..d23ff1b68eba 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/bitmap.h>
 #include "cpumap.h"
diff --git a/tools/perf/tests/shell/lib/probe.sh b/tools/perf/tests/shell/lib/probe.sh
index e37787be672b..51e3f60baba0 100644
--- a/tools/perf/tests/shell/lib/probe.sh
+++ b/tools/perf/tests/shell/lib/probe.sh
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 skip_if_no_perf_probe() {
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 46e076e3c537..5d1b63d3f3e1 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # Add vfs_getname probe to get syscall args filenames
-#
+
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 61c9f8fc6fa1..9b7632ff70aa 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -7,6 +7,7 @@
 # This needs no debuginfo package, all is done using the libc ELF symtab
 # and the CFI info in the binaries.
 
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 9b073e7fa88c..54030c18bfc2 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -6,6 +6,7 @@
 # checks that that was captured by the vfs_getname probe in the generated
 # perf.data file, with the temp file name as the pathname argument.
 
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 5dcba800109f..899604d17b85 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # Zstd perf.data compression/decompression
 
+# SPDX-License-Identifier: GPL-2.0
+
 trace_file=$(mktemp /tmp/perf.data.XXX)
 perf_tool=perf
 
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 147efeb6b195..45d269b0157e 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -7,6 +7,7 @@
 # that already handles "probe:vfs_getname" if present, and used in the
 # "open" syscall "filename" argument beautifier.
 
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
