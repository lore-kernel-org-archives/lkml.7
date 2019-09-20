Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF62C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE152086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390468AbfITQWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:22:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52871 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404976AbfITQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLeT-00040f-PG; Fri, 20 Sep 2019 18:20:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 18B9A1C0E29;
        Fri, 20 Sep 2019 18:20:57 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:57 -0000
From:   "tip-bot2 for Anju T Sudhakar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf kvm: Move kvm-stat header file from
 conditional inclusion to common include section
Cc:     Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190718181749.30612-1-anju@linux.vnet.ibm.com>
References: <20190718181749.30612-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <156899645704.24167.11929677984675527670.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8067b3da970baa12e6045400fdf009673b8dd3c2
Gitweb:        https://git.kernel.org/tip/8067b3da970baa12e6045400fdf009673b8dd3c2
Author:        Anju T Sudhakar <anju@linux.vnet.ibm.com>
AuthorDate:    Thu, 18 Jul 2019 23:47:47 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 10:28:26 -03:00

perf kvm: Move kvm-stat header file from conditional inclusion to common include section

Move kvm-stat header file to the common include section, and make the
definitions in the header file under the conditional inclusion `#ifdef
HAVE_KVM_STAT_SUPPORT`.

This helps to define other 'perf kvm' related function prototypes in
kvm-stat header file, which may not need kvm-stat support.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-By: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20190718181749.30612-1-anju@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c   | 2 +-
 tools/perf/util/kvm-stat.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ac6d6e0..2b822be 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -21,6 +21,7 @@
 #include "util/top.h"
 #include "util/data.h"
 #include "util/ordered-events.h"
+#include "util/kvm-stat.h"
 #include "ui/ui.h"
 
 #include <sys/prctl.h>
@@ -59,7 +60,6 @@ static const char *get_filename_for_perf_kvm(void)
 }
 
 #ifdef HAVE_KVM_STAT_SUPPORT
-#include "util/kvm-stat.h"
 
 void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 4691363..8fd6ec2 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -2,6 +2,8 @@
 #ifndef __PERF_KVM_STAT_H
 #define __PERF_KVM_STAT_H
 
+#ifdef HAVE_KVM_STAT_SUPPORT
+
 #include "tool.h"
 #include "stat.h"
 #include "record.h"
@@ -144,5 +146,6 @@ extern const int decode_str_len;
 extern const char *kvm_exit_reason;
 extern const char *kvm_entry_trace;
 extern const char *kvm_exit_trace;
+#endif /* HAVE_KVM_STAT_SUPPORT */
 
 #endif /* __PERF_KVM_STAT_H */
