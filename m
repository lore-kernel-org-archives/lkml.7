Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4722C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9807A216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KW3zzfXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbfG3STo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:19:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbfG3STj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:19:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIJQ2f3326935
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:19:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIJQ2f3326935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510767;
        bh=VPrKE2Yp6oop93/YFTtaKPWE1BHVl2rneqEANP5wpcQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KW3zzfXR2TplH843zz4BfK+T7tfwT1jMgxzt9Q6SAwDmktANPny5Hra9O1APQJuCL
         mA3VT+frMjUupCSX9LePlfU2dJKd3Bcw762oDikAonr1k6EU3u/wgNBNVNd2MUj6oL
         qQxQ/DkGLFdH40BIyUG1VFXzojf1Y68/ZH7ZY9GIHhcf5QV4aco4av8kDv4txfllhv
         /DZCBCU5vfgKr2aYFLjym6kdLgVdnErkA8ijgBEV+rxjlfIXEgqbAgPZfgxlGYsTRt
         HHygUU6qBx+lz9AQx+wh/LkaIk+LlfRYAs2RO1eHzidL2qYDzsmBB8F5Hq52CIMwKG
         QKPf9PS/J7weA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIJQFd3326932;
        Tue, 30 Jul 2019 11:19:26 -0700
Date:   Tue, 30 Jul 2019 11:19:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-24e376b24582648d363df4e0a6bcc2ffcecd211e@git.kernel.org>
Cc:     ak@linux.intel.com, jolsa@kernel.org, hpa@zytor.com,
        alexey.budankov@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
        namhyung@kernel.org, peterz@infradead.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, tglx@linutronix.de,
          namhyung@kernel.org, peterz@infradead.org, mpetlan@redhat.com,
          ak@linux.intel.com, hpa@zytor.com, jolsa@kernel.org
In-Reply-To: <20190721112506.12306-18-jolsa@kernel.org>
References: <20190721112506.12306-18-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Rename perf_evsel__apply_filter() to
 evsel__apply_filter()
Git-Commit-ID: 24e376b24582648d363df4e0a6bcc2ffcecd211e
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

Commit-ID:  24e376b24582648d363df4e0a6bcc2ffcecd211e
Gitweb:     https://git.kernel.org/tip/24e376b24582648d363df4e0a6bcc2ffcecd211e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evsel: Rename perf_evsel__apply_filter() to evsel__apply_filter()

Rename perf_evsel__apply_filter() to evsel__apply_filter(), so we don't
have a name clash when we add perf_evsel__apply_filter() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/evsel.c  | 2 +-
 tools/perf/util/evsel.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9461583c53d9..e71c3cc93924 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1158,7 +1158,7 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
 		 * filters only work for tracepoint event, which doesn't have cpu limit.
 		 * So evlist and evsel should always be same.
 		 */
-		err = perf_evsel__apply_filter(evsel, evsel->filter);
+		err = evsel__apply_filter(evsel, evsel->filter);
 		if (err) {
 			*err_evsel = evsel;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 855d286298eb..5aeb7260c8e1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1187,7 +1187,7 @@ static int perf_evsel__run_ioctl(struct evsel *evsel,
 	return 0;
 }
 
-int perf_evsel__apply_filter(struct evsel *evsel, const char *filter)
+int evsel__apply_filter(struct evsel *evsel, const char *filter)
 {
 	return perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c338ce14e8aa..35f7e7ff3c5e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -294,7 +294,7 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
-int perf_evsel__apply_filter(struct evsel *evsel, const char *filter);
+int evsel__apply_filter(struct evsel *evsel, const char *filter);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 
