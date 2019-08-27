Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C05C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EE9217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfH0I0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42769 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbfH0I00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wnx-0007q0-8F; Tue, 27 Aug 2019 10:26:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A370B1C0DDE;
        Tue, 27 Aug 2019 10:26:16 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:16 -0000
From:   tip-bot2 for Souptick Joarder <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove duplicate headers
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1566663319-4283-1-git-send-email-jrdr.linux@gmail.com>
References: <1566663319-4283-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Message-ID: <156689437654.24508.3120746550321091583.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b4de344b25b9fbd4db7b84da43808a6b7daac887
Gitweb:        https://git.kernel.org/tip/b4de344b25b9fbd4db7b84da43808a6b7daac887
Author:        Souptick Joarder <jrdr.linux@gmail.com>
AuthorDate:    Sat, 24 Aug 2019 21:45:19 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:29 -03:00

perf tools: Remove duplicate headers

Removed headers which are included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1566663319-4283-1-git-send-email-jrdr.linux@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c                 | 1 -
 tools/perf/util/get_current_dir_name.c | 1 -
 tools/perf/util/stat-display.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 1d1b97a..74aafe0 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -9,7 +9,6 @@
 #include <unistd.h>
 #include <string.h>
 #include <asm/bug.h>
-#include <sys/types.h>
 #include <dirent.h>
 
 #include "data.h"
diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
index 01f32f2..b205d92 100644
--- a/tools/perf/util/get_current_dir_name.c
+++ b/tools/perf/util/get_current_dir_name.c
@@ -5,7 +5,6 @@
 #include "get_current_dir_name.h"
 #include <unistd.h>
 #include <stdlib.h>
-#include <stdlib.h>
 
 /* Android's 'bionic' library, for one, doesn't have this */
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 51d6781..1461dac 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -14,7 +14,6 @@
 #include "string2.h"
 #include <linux/ctype.h>
 #include "cgroup.h"
-#include <math.h>
 #include <api/fs/fs.h>
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
