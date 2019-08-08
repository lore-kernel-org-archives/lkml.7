Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5666C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BC62173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LZ1gJNnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404749AbfHHUVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:21:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404629AbfHHUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:21:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KKs6T3321503
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:20:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KKs6T3321503
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295656;
        bh=jB9lJFazloCBsP9ogNel+3Ue7cq3GA01L+pcSkwUcfU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LZ1gJNnWXV2dFuNttDFxqtZEiXdxxufLD5kv0U39ucCLBOq9kinUpFHw1y9Ql12tm
         SfVavbfgHoKyg4stW6sOKt24GIxYHBmxNRJjV1FEHJ4AlhjH0VSzsCCiyymq2PD8sW
         z5rywwj/P/bKwHX4HhMFFqWqHO9JQHkO1VlP1NV4ncbQxAzKn8iB3HgKYa41QSoC2V
         XjMTFiEaaJ/lB4CkSpGGt3XNaufBnJzfWiHBhKbR5Iu4H6+iPirg1Dj5sjmquhNUuF
         k/v31FfjvBqMxCcNXcLOcBHd4d7Wbr7iGNcQGwILhgnop1BSaM8waPgbu8UHgFEkES
         xaqrqvq/OFt2A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KKsuh3321498;
        Thu, 8 Aug 2019 13:20:54 -0700
Date:   Thu, 8 Aug 2019 13:20:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ian Rogers <tipbot@zytor.com>
Message-ID: <tip-fa37bab6d7154658d8a35920513f9396587754cc@git.kernel.org>
Cc:     ak@linux.intel.com, irogers@google.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        jolsa@redhat.com, eranian@google.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: namhyung@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, eranian@google.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de, ak@linux.intel.com, irogers@google.com,
          mingo@kernel.org
In-Reply-To: <20190731225441.233800-1-irogers@google.com>
References: <20190731225441.233800-1-irogers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix include paths in ui directory
Git-Commit-ID: fa37bab6d7154658d8a35920513f9396587754cc
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

Commit-ID:  fa37bab6d7154658d8a35920513f9396587754cc
Gitweb:     https://git.kernel.org/tip/fa37bab6d7154658d8a35920513f9396587754cc
Author:     Ian Rogers <irogers@google.com>
AuthorDate: Wed, 31 Jul 2019 15:54:41 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:11 -0300

perf tools: Fix include paths in ui directory

These paths point to the wrong location but still work because they get
picked up by a -I flag that happens to direct to the correct file. Fix
paths to point to the correct location without -I flags.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190731225441.233800-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c      | 9 +++++----
 tools/perf/ui/tui/progress.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index f80c51d53565..d227d74b28f8 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../string2.h"
-#include "../config.h"
-#include "../../perf.h"
+#include "../util/util.h"
+#include "../util/string2.h"
+#include "../util/config.h"
+#include "../perf.h"
 #include "libslang.h"
 #include "ui.h"
 #include "util.h"
@@ -14,7 +15,7 @@
 #include "browser.h"
 #include "helpline.h"
 #include "keysyms.h"
-#include "../color.h"
+#include "../util/color.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index bc134b82829d..5a24dd3ce4db 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "../cache.h"
+#include "../../util/cache.h"
 #include "../progress.h"
 #include "../libslang.h"
 #include "../ui.h"
