Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45169C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193DA208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WcuoKARW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfHOJ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:27:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60411 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfHOJ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:27:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9R2Yv2273680
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:27:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9R2Yv2273680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861224;
        bh=lnQ3H19HZ58giYLo0y18HHVblMeUSCSD7OYn+JDT4TQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=WcuoKARW50uEz7Xt2v8OwjK+/f9iJpwtJgP/T3YIO7PnoSYGWfDE7REIHxALdeU0G
         HvE2ms+06MFOiLs2jq/a6eotKQyA/6MYpVRVs2hRQEgZE91TeGx+ZjB6YefptXtrie
         yCh6DHyGUHSvEoMX07kDAt0SR4gb1HKj0QimoCT3ams2440B92vxarvDC0h6vbOHpm
         vryfvrSVxEAJ6N4Gi40bq+GtVGrW6Kd9HL+WQKj5AM0J44BDWpFetvhE/mDb5E2Ugx
         cRMyoEoKgVer/I+hMb1GdS2IjkO+f5f5R/nJUqCdwrF7wOADxe4Xuwz63n+dI4obRT
         hU4xN3m+8hr7g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9R1M82273659;
        Thu, 15 Aug 2019 02:27:01 -0700
Date:   Thu, 15 Aug 2019 02:27:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dcize2v6jjab7tds5ngz97dk@git.kernel.org>
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, mingo@kernel.org, ilubashe@akamai.com,
        mathieu.poirier@linaro.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        suzuki.poulose@arm.com, alexey.budankov@linux.intel.com,
        acme@redhat.com, hpa@zytor.com, jmorris@namei.org
Reply-To: namhyung@kernel.org, ilubashe@akamai.com,
          mathieu.poirier@linaro.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
          acme@redhat.com, suzuki.poulose@arm.com, hpa@zytor.com,
          jmorris@namei.org, jolsa@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add CAP_SYSLOG define for older systems
Git-Commit-ID: 083c1359b0e03867a8c7effd21d4c0be3639f336
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

Commit-ID:  083c1359b0e03867a8c7effd21d4c0be3639f336
Gitweb:     https://git.kernel.org/tip/083c1359b0e03867a8c7effd21d4c0be3639f336
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 13 Aug 2019 11:38:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf tools: Add CAP_SYSLOG define for older systems

Some of the systems I test don't have that define, provide it
conditionally since we'll use it in the kptr_restrict checks in the next
patch.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-dcize2v6jjab7tds5ngz97dk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
index 10af94e473da..051dc590ceee 100644
--- a/tools/perf/util/cap.h
+++ b/tools/perf/util/cap.h
@@ -24,4 +24,9 @@ static inline bool perf_cap__capable(int cap __maybe_unused)
 
 #endif /* HAVE_LIBCAP_SUPPORT */
 
+/* For older systems */
+#ifndef CAP_SYSLOG
+#define CAP_SYSLOG	34
+#endif
+
 #endif /* __PERF_CAP_H */
