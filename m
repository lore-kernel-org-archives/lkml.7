Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E7C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ABF20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kSNhY7wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfG3S0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:26:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3S0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:26:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIQOYb3329753
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:26:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIQOYb3329753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511185;
        bh=RB+cRx7RD+cVLZuKlwJg+785+/97N3SD77q3KdCtJsg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=kSNhY7waAR9nNjLkXDzthhvLJeDXqzS4ncja+HfEJMTylXH8yzpdvwM3FPWvqNht9
         EuE8HUUcjFQztRX0HemtikLP5/TQP7eb2vzjsMjJZsSUiqARNoyrKkvaBBPlxZnHKx
         +Zqhvcc9nAG6rMIs+AZjCXnq2VY/kNwXnrWjLZKSMPbCrbL7qXWvKviPPoiadO0UP1
         uu34M+R8fvFwo2lfOyMHFsqU/ZvOQWiH373C238XzyG7QX4hN6tBkv1OplA7+nyG+v
         +GpGKFjaQEzTREBydElyAnzYG/9nCFj62wumYW/prETJR+xTWtMzimqwY4TcROlhtB
         ++s8FZv96xi0A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIQNtP3329750;
        Tue, 30 Jul 2019 11:26:23 -0700
Date:   Tue, 30 Jul 2019 11:26:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5b7f445d684fc287a2101e29d42d1fee19ae14ff@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, mingo@kernel.org,
        alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
        ak@linux.intel.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          acme@redhat.com, tglx@linutronix.de,
          alexey.budankov@linux.intel.com, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
          peterz@infradead.org, hpa@zytor.com, jolsa@kernel.org,
          mingo@kernel.org
In-Reply-To: <20190721112506.12306-27-jolsa@kernel.org>
References: <20190721112506.12306-27-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf/core.h header
Git-Commit-ID: 5b7f445d684fc287a2101e29d42d1fee19ae14ff
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

Commit-ID:  5b7f445d684fc287a2101e29d42d1fee19ae14ff
Gitweb:     https://git.kernel.org/tip/5b7f445d684fc287a2101e29d42d1fee19ae14ff
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:13 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf/core.h header

Add perf/core.h header to be used in header files coming in the
following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/core.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
new file mode 100644
index 000000000000..e2e4b43c9131
--- /dev/null
+++ b/tools/perf/lib/include/perf/core.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CORE_H
+#define __LIBPERF_CORE_H
+
+#ifndef LIBPERF_API
+#define LIBPERF_API __attribute__((visibility("default")))
+#endif
+
+#endif /* __LIBPERF_CORE_H */
