Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1143621850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfB1HrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:47:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1HrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:47:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7lE4i2950226
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:47:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7lDNd2950222;
        Wed, 27 Feb 2019 23:47:13 -0800
Date:   Wed, 27 Feb 2019 23:47:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-deb83da16c1f3412fcb33c8944b3d854c4b265d6@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, peterz@infradead.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, namhyung@kernel.org, peterz@infradead.org,
          acme@redhat.com, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          jolsa@kernel.org
In-Reply-To: <20190220122800.864-6-jolsa@kernel.org>
References: <20190220122800.864-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cpumap: Increase debug level for
 cpu_map__snprint verbose output
Git-Commit-ID: deb83da16c1f3412fcb33c8944b3d854c4b265d6
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

Commit-ID:  deb83da16c1f3412fcb33c8944b3d854c4b265d6
Gitweb:     https://git.kernel.org/tip/deb83da16c1f3412fcb33c8944b3d854c4b265d6
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 20 Feb 2019 13:27:59 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 20 Feb 2019 17:08:39 -0300

perf cpumap: Increase debug level for cpu_map__snprint verbose output

So it does not screw up single -v verbose output.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 0bbc3feb0894..0b599229bc7e 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -681,7 +681,7 @@ size_t cpu_map__snprint(struct cpu_map *map, char *buf, size_t size)
 
 #undef COMMA
 
-	pr_debug("cpumask list: %s\n", buf);
+	pr_debug2("cpumask list: %s\n", buf);
 	return ret;
 }
 
