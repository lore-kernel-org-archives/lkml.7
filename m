Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A68CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4580420882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfJVAF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbfJVAFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwu-0003sg-Cc; Tue, 22 Oct 2019 01:18:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D95351C03AB;
        Tue, 22 Oct 2019 01:18:51 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:51 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Link static tests with libapi.a
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191017105918.20873-5-jolsa@kernel.org>
References: <20191017105918.20873-5-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157169993154.29376.8877690079613356165.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     395e62cde10df64122d708c68baee64b1d1622fc
Gitweb:        https://git.kernel.org/tip/395e62cde10df64122d708c68baee64b1d1622fc
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 17 Oct 2019 12:59:12 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

libperf: Link static tests with libapi.a

Both static and dynamic tests needs to link with libapi.a, because it's
using its functions. Also include path for libapi includes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile       | 1 +
 tools/perf/lib/tests/Makefile | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 0889c9c..0f23363 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -107,6 +107,7 @@ else
 endif
 
 LIBAPI = $(API_PATH)libapi.a
+export LIBAPI
 
 $(LIBAPI): FORCE
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index 1ee4e9b..a43cd08 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -16,13 +16,13 @@ all:
 
 include $(srctree)/tools/scripts/Makefile.include
 
-INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include
+INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
 
 $(TESTS_A): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a $(LIBAPI)
 
 $(TESTS_SO): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) -lperf
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) $(LIBAPI) -lperf
 
 all: $(TESTS_A) $(TESTS_SO)
 
