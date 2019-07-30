Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E051C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E6F20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GTpbXm29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfG3SZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:25:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfG3SZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:25:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIOs903329578
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:24:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIOs903329578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511095;
        bh=3cEHUcuCH+S2gz452vOsoAatPpID/4Q6oBDEFau3ysc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GTpbXm29K1Y74c9H2aa4Tmf0DKrYeavScgVp/w6yldIQqfWtVYxXu6Ts5tJ5c6aKN
         1AvAyuYYwrPwsCCuG5YEddS57ss6mdOCPlMGb9LMFE5CHa5OpygqlKMgepynSEGIu8
         35XTnL+4yG4sJGOU45Rdm+VR7fWP444GbpdGA7YnsAa5xQ5DAMHm2Rhyg9/X7Pm9O5
         7lJ/BF6gMpE9RCPSjamuWl699gd3oOUL1+N0xI9oQFDCZUGw1/gD+14PwLkHyhcU0L
         C5MAkwevCqgXGk3BSfU0WK+s2YCEQ8wUar3pvQmAGG2G3NOlory4T1W8xjoPVOPm9s
         Tb955PBe+h+Ig==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIOsY23329575;
        Tue, 30 Jul 2019 11:24:54 -0700
Date:   Tue, 30 Jul 2019 11:24:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-47f9bccc79cb067103ad5e9790e0d01c94839429@git.kernel.org>
Cc:     jolsa@kernel.org, alexey.budankov@linux.intel.com,
        mpetlan@redhat.com, ak@linux.intel.com, acme@redhat.com,
        peterz@infradead.org, namhyung@kernel.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          mpetlan@redhat.com, ak@linux.intel.com, acme@redhat.com,
          namhyung@kernel.org, peterz@infradead.org
In-Reply-To: <20190721112506.12306-25-jolsa@kernel.org>
References: <20190721112506.12306-25-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add build version support
Git-Commit-ID: 47f9bccc79cb067103ad5e9790e0d01c94839429
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

Commit-ID:  47f9bccc79cb067103ad5e9790e0d01c94839429
Gitweb:     https://git.kernel.org/tip/47f9bccc79cb067103ad5e9790e0d01c94839429
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:11 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

libperf: Add build version support

Add a shared library version, generating the following files:

  $ ll tools/perf/lib/libperf.so*
  libperf.so -> libperf.so.0.0.1
  libperf.so.0 -> libperf.so.0.0.1
  libperf.so.0.0.1

Committer testing:

One has to build just libbperf to get this, building perf so far doesn't
trigger this, i.e. I tried:

  $ make O=/tmp/build/perf -C tools/perf

And the files above were not created, so one has to do:

  $ make O=/tmp/build/perf -C tools/perf/lib/
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     /tmp/build/perf/libperf.so.0.0.1
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $ ls -la /tmp/build/perf/*.so.*
  lrwxrwxrwx. 1 acme acme    16 Jul 22 15:37 /tmp/build/perf/libperf.so.0 -> libperf.so.0.0.1
  -rwxrwxr-x. 1 acme acme 16368 Jul 22 15:37 /tmp/build/perf/libperf.so.0.0.1
  $

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile    | 20 +++++++++++++++++---
 tools/perf/lib/libperf.map |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 33046e7c6a2a..cd571ec648ad 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Most of this file is copied from tools/lib/bpf/Makefile
 
+LIBPERF_VERSION = 0
+LIBPERF_PATCHLEVEL = 0
+LIBPERF_EXTRAVERSION = 1
+
 MAKEFLAGS += --no-print-directory
 
 ifeq ($(srctree),)
@@ -47,7 +51,13 @@ all:
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
-LIBPERF_SO := $(OUTPUT)libperf.so
+VERSION_SCRIPT := libperf.map
+
+PATCHLEVEL    = $(LIBPERF_PATCHLEVEL)
+EXTRAVERSION  = $(LIBPERF_EXTRAVERSION)
+VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
+
+LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
 LIBPERF_A  := $(OUTPUT)libperf.a
 LIBPERF_IN := $(OUTPUT)libperf-in.o
 
@@ -58,7 +68,11 @@ $(LIBPERF_A): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
 
 $(LIBPERF_SO): $(LIBPERF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so $^ -o $@
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
+                                    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libperf.so
+	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
+
 
 libs: $(LIBPERF_A) $(LIBPERF_SO)
 
@@ -67,7 +81,7 @@ all: fixdep
 
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so .*.d .*.cmd LIBPERF-CFLAGS
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS
 
 FORCE:
 
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
new file mode 100644
index 000000000000..a8e913988edf
--- /dev/null
+++ b/tools/perf/lib/libperf.map
@@ -0,0 +1,4 @@
+LIBPERF_0.0.1 {
+	local:
+		*;
+};
