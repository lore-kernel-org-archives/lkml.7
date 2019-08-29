Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5550BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7352189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfH2TCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51563 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbfH2TCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3Pg3-00051d-CA; Thu, 29 Aug 2019 21:01:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D07B51C07C3;
        Thu, 29 Aug 2019 21:01:46 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:46 -0000
From:   "tip-bot2 for Igor Lubashev" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Use CAP_SYS_ADMIN with
 perf_event_paranoid checks
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Igor Lubashev <ilubashe@akamai.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1566869956-7154-3-git-send-email-ilubashe@akamai.com>
References: <1566869956-7154-3-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Message-ID: <156710530660.10513.2537710745065079196.tip-bot2@tip-bot2>
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

Commit-ID:     dda1bf8ea78add78739d128a20b555c4a1a19c27
Gitweb:        https://git.kernel.org/tip/dda1bf8ea78add78739d128a20b555c4a1a19c27
Author:        Igor Lubashev <ilubashe@akamai.com>
AuthorDate:    Mon, 26 Aug 2019 21:39:13 -04:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 17:18:08 -03:00

perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks

The kernel is using CAP_SYS_ADMIN instead of euid==0 to override
perf_event_paranoid check. Make perf do the same.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> # coresight part
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1566869956-7154-3-git-send-email-ilubashe@akamai.com
Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 3 ++-
 tools/perf/arch/arm64/util/arm-spe.c | 3 ++-
 tools/perf/arch/x86/util/intel-bts.c | 3 ++-
 tools/perf/arch/x86/util/intel-pt.c  | 2 +-
 tools/perf/util/evsel.c              | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index a185dab..5d856ed 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -18,6 +18,7 @@
 #include "../../util/record.h"
 #include "../../util/auxtrace.h"
 #include "../../util/cpumap.h"
+#include "../../util/event.h"
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
 #include "../../util/pmu.h"
@@ -254,7 +255,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct evsel *evsel, *cs_etm_evsel = NULL;
 	struct perf_cpu_map *cpus = evlist->core.cpus;
-	bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
+	bool privileged = perf_event_paranoid_check(-1);
 	int err = 0;
 
 	ptr->evlist = evlist;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index cdd5c0c..c7b38f0 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -12,6 +12,7 @@
 #include <time.h>
 
 #include "../../util/cpumap.h"
+#include "../../util/event.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/session.h"
@@ -67,7 +68,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 	struct evsel *evsel, *arm_spe_evsel = NULL;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = perf_event_paranoid_check(-1);
 	struct evsel *tracking_evsel;
 	int err;
 
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 1f2cf61..16d26ea 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 
 #include "../../util/cpumap.h"
+#include "../../util/event.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/session.h"
@@ -108,7 +109,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
 	struct evsel *evsel, *intel_bts_evsel = NULL;
 	const struct perf_cpu_map *cpus = evlist->core.cpus;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = perf_event_paranoid_check(-1);
 
 	btsr->evlist = evlist;
 	btsr->snapshot_mode = opts->auxtrace_snapshot_mode;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 44cfe72..746981c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -579,7 +579,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	bool have_timing_info, need_immediate = false;
 	struct evsel *evsel, *intel_pt_evsel = NULL;
 	const struct perf_cpu_map *cpus = evlist->core.cpus;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = perf_event_paranoid_check(-1);
 	u64 tsc_bit;
 	int err;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fa67635..7c704b8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -282,7 +282,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 static bool perf_event_can_profile_kernel(void)
 {
-	return geteuid() == 0 || perf_event_paranoid() == -1;
+	return perf_event_paranoid_check(-1);
 }
 
 struct evsel *perf_evsel__new_cycles(bool precise)
