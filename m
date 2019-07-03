Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4450C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986AF218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BAyOt6f3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGCOEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:04:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52381 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:04:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E3Q4A3318776
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:03:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E3Q4A3318776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162607;
        bh=MpWYwBEhJGIvlPzXQhFpO1LkUrqZrPR1wGtqnYWJ1oc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BAyOt6f3Rtxlx4J9ctdBJB1/RCGGf7RFaZjAKQA/rVUrXQYnRwo/i8KrGRhDrgdpE
         WRIBPbGgR8n6p3EWqtgdYsqpbRc+tQoh4fVBU2NmcU3UI0u9kdsd+MECC++kq164AT
         MLCVr0Aw2LcgO0t70A0l3wCFuTkd0iI9TzFoIFX1Nc5ZZk1KuyVe04g/UUtX+GOWH7
         I1Jk38h2L2xydHufQndhXHDzvfMHMqWt3vwb6phy934kYBXMxREuMqrCTm0nrkVNJk
         sEAt93DvkgxVlsITEfG6PUxGTTwWiXJ64QdXFqJIAaMVIofRidVnTZ7KLPRf2ZBqmJ
         JPw1P08RlCCvg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E3PTN3318773;
        Wed, 3 Jul 2019 07:03:25 -0700
Date:   Wed, 3 Jul 2019 07:03:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kyle Meyer <tipbot@zytor.com>
Message-ID: <tip-9f94c7f947e919c343b30f080285af53d0fa9902@git.kernel.org>
Cc:     jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        namhyung@kernel.org, hpa@zytor.com, kyle.meyer@hpe.com
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
          namhyung@kernel.org, hpa@zytor.com, kyle.meyer@hpe.com
In-Reply-To: <20190620193630.154025-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
References: <20190620193630.154025-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Increase MAX_NR_CPUS and MAX_CACHES
Git-Commit-ID: 9f94c7f947e919c343b30f080285af53d0fa9902
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

Commit-ID:  9f94c7f947e919c343b30f080285af53d0fa9902
Gitweb:     https://git.kernel.org/tip/9f94c7f947e919c343b30f080285af53d0fa9902
Author:     Kyle Meyer <kyle.meyer@hpe.com>
AuthorDate: Thu, 20 Jun 2019 14:36:30 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf tools: Increase MAX_NR_CPUS and MAX_CACHES

Attempting to profile 1024 or more CPUs with perf causes two errors:

  perf record -a
  [ perf record: Woken up X times to write data ]
  way too many cpu caches..
  [ perf record: Captured and wrote X MB perf.data (X samples) ]

  perf report -C 1024
  Error: failed to set  cpu bitmap
  Requested CPU 1024 too large. Consider raising MAX_NR_CPUS

  Increasing MAX_NR_CPUS from 1024 to 2048 and redefining MAX_CACHES as
  MAX_NR_CPUS * 4 returns normal functionality to perf:

  perf record -a
  [ perf record: Woken up X times to write data ]
  [ perf record: Captured and wrote X MB perf.data (X samples) ]

  perf report -C 1024
  ...

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190620193630.154025-1-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.h        | 2 +-
 tools/perf/util/header.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 711e009381ec..74d0124d38f3 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -26,7 +26,7 @@ static inline unsigned long long rdclock(void)
 }
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS			1024
+#define MAX_NR_CPUS			2048
 #endif
 
 extern const char *input_name;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 06ddb6618ef3..abc9c2145efe 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1121,7 +1121,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES 2000
+#define MAX_CACHES (MAX_NR_CPUS * 4)
 
 static int write_cache(struct feat_fd *ff,
 		       struct perf_evlist *evlist __maybe_unused)
