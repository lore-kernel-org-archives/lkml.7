Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A7EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED9E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LuL/0QFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfG3SXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:23:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54773 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfG3SXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:23:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UILhZA3327492
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:21:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UILhZA3327492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510904;
        bh=U8uyCmd1o6By2Be1KrOeHzQryH+WAM9OMNwTTIkdmd0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LuL/0QFAFy3nTloREenWwgO2hphK9BvmLCG5+F6fGWsZuU3Nb09aqmnFBqZvUqFPi
         Uo4ylaBVgCwlGKNhHyaFzAYy6mn90rkXE2Lg+SAzBr+IFTKKGg8qZJcZavaNoA81/+
         Vrys4MeEyTy7nhfMX2/zkiBc6FUOGBBgSOSz5OAfqwMcWMpOARv48KQc8bDfE7zmXT
         XDQrUq9vzcPcZ0cQ0TFjORvuaEB8K9JC2iBujNxl1ByrxfjScHDpDWcQAx9l1/eOMJ
         8Bfu6IGib4cmL2cI8iMVVQMFDNtMI4lCCe1aQN0a9kJtsbaQE0gRtK98Pii33EBeCt
         HE5UFtwgl521g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UILgCx3327489;
        Tue, 30 Jul 2019 11:21:42 -0700
Date:   Tue, 30 Jul 2019 11:21:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-750b4edeb0527414fb17b0ee2a76d2dbbd9a199d@git.kernel.org>
Cc:     namhyung@kernel.org, ak@linux.intel.com, acme@redhat.com,
        mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, mpetlan@redhat.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          alexey.budankov@linux.intel.com, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <20190721112506.12306-21-jolsa@kernel.org>
References: <20190721112506.12306-21-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evlist: Rename perf_evlist__close() to
 evlist__close()
Git-Commit-ID: 750b4edeb0527414fb17b0ee2a76d2dbbd9a199d
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

Commit-ID:  750b4edeb0527414fb17b0ee2a76d2dbbd9a199d
Gitweb:     https://git.kernel.org/tip/750b4edeb0527414fb17b0ee2a76d2dbbd9a199d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:07 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evlist: Rename perf_evlist__close() to evlist__close()

Rename perf_evlist__close() to evlist__close(), so we don't have a name
clash when we add perf_evlist__close() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c  | 2 +-
 tools/perf/builtin-stat.c | 4 ++--
 tools/perf/util/evlist.c  | 6 +++---
 tools/perf/util/evlist.h  | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 85604d117558..6a0573a9c16b 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1058,7 +1058,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 	if (perf_evlist__mmap(evlist, kvm->opts.mmap_pages) < 0) {
 		ui__error("Failed to mmap the events: %s\n",
 			  str_error_r(errno, sbuf, sizeof(sbuf)));
-		perf_evlist__close(evlist);
+		evlist__close(evlist);
 		goto out;
 	}
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d28d4d71d9b7..bdfe138f7aed 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -613,7 +613,7 @@ try_again:
 	 * later the evsel_list will be closed after.
 	 */
 	if (!STAT_RECORD)
-		perf_evlist__close(evsel_list);
+		evlist__close(evsel_list);
 
 	return WEXITSTATUS(status);
 }
@@ -2003,7 +2003,7 @@ int cmd_stat(int argc, const char **argv)
 			perf_session__write_header(perf_stat.session, evsel_list, fd, true);
 		}
 
-		perf_evlist__close(evsel_list);
+		evlist__close(evsel_list);
 		perf_session__delete(perf_stat.session);
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7d44e05dfaa4..67c288f467f6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -140,7 +140,7 @@ void evlist__delete(struct evlist *evlist)
 		return;
 
 	perf_evlist__munmap(evlist);
-	perf_evlist__close(evlist);
+	evlist__close(evlist);
 	cpu_map__put(evlist->cpus);
 	thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
@@ -1348,7 +1348,7 @@ void perf_evlist__set_selected(struct evlist *evlist,
 	evlist->selected = evsel;
 }
 
-void perf_evlist__close(struct evlist *evlist)
+void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -1412,7 +1412,7 @@ int evlist__open(struct evlist *evlist)
 
 	return 0;
 out_err:
-	perf_evlist__close(evlist);
+	evlist__close(evlist);
 	errno = -err;
 	return err;
 }
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f4b3152c879e..47e9d26b6774 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -147,7 +147,7 @@ void perf_evlist__toggle_bkw_mmap(struct evlist *evlist, enum bkw_mmap_state sta
 void perf_evlist__mmap_consume(struct evlist *evlist, int idx);
 
 int evlist__open(struct evlist *evlist);
-void perf_evlist__close(struct evlist *evlist);
+void evlist__close(struct evlist *evlist);
 
 struct callchain_param;
 
