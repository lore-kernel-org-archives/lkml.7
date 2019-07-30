Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A830AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8040B2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YDcUC9F5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbfG3SSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:18:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48531 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388117AbfG3SQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIGUwL3326166
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:16:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIGUwL3326166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510591;
        bh=v8Efk4gwISrpLfv/YaUK/3HiF/epzkl++w7peLRhhPE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YDcUC9F5dw6A4zpkbQ/En3WtKzWZwNrU2xZ5b4QyNj+1KkUaGYR251gXGAXOaIQ+d
         61CEV3ogV7N21t78AhNqwYD/Yz95aXrgSNAY57A6pHyYwtOOeVCAbtXFxkc3k5B5Kk
         AT6TlAJOFSP2L2hLD0L9GSXHRQB6NSfTpONK+fVIYPk7BLJX+wqsEZTaAZuRz+o4W7
         BjKcNiAO0d94rO1+9xSh5jqycjDIUH6+FgGPlnYmwlhQm0fX7z7jv8MZS2czyh2mG3
         DhuYMs/6939+PtVFqkREMpgjWTMk+HxNybAVv/49pFuFZmNyrem/Ww1h46d3VNR4EX
         tDJ7QV3V/JrmQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIGThX3326163;
        Tue, 30 Jul 2019 11:16:29 -0700
Date:   Tue, 30 Jul 2019 11:16:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1625102764a578b11fb407b8194cb0521129d919@git.kernel.org>
Cc:     mpetlan@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, ak@linux.intel.com, alexey.budankov@linux.intel.com,
        namhyung@kernel.org
Reply-To: acme@redhat.com, mpetlan@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
          jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, alexey.budankov@linux.intel.com
In-Reply-To: <20190721112506.12306-14-jolsa@kernel.org>
References: <20190721112506.12306-14-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evlist: Rename perf_evlist__remove() to
 evlist__remove()
Git-Commit-ID: 1625102764a578b11fb407b8194cb0521129d919
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

Commit-ID:  1625102764a578b11fb407b8194cb0521129d919
Gitweb:     https://git.kernel.org/tip/1625102764a578b11fb407b8194cb0521129d919
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:00 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evlist: Rename perf_evlist__remove() to evlist__remove()

Rename perf_evlist__remove() to evlist__remove(), so we don't have a
name clash when we add perf_evlist__remove() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 4 ++--
 tools/perf/util/evlist.c    | 2 +-
 tools/perf/util/evlist.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 917c8fb4baa5..4e56e399bbc8 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -622,7 +622,7 @@ static void strip_fini(struct perf_inject *inject)
 		if (evsel->handler == drop_sample &&
 		    ok_to_remove(evlist, evsel)) {
 			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
-			perf_evlist__remove(evlist, evsel);
+			evlist__remove(evlist, evsel);
 			evsel__delete(evsel);
 		}
 	}
@@ -724,7 +724,7 @@ static int __cmd_inject(struct perf_inject *inject)
 			if (evsel) {
 				pr_debug("Deleting %s\n",
 					 perf_evsel__name(evsel));
-				perf_evlist__remove(session->evlist, evsel);
+				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
 			if (inject->strip)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7741e12bdcb0..47516db62424 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -190,7 +190,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 	__perf_evlist__propagate_maps(evlist, entry);
 }
 
-void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel)
+void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
 	list_del_init(&evsel->node);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index d52b29a1d852..b3a44e2eed08 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -74,7 +74,7 @@ void perf_evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
 void evlist__add(struct evlist *evlist, struct evsel *entry);
-void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel);
+void evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
 int __perf_evlist__add_default(struct evlist *evlist, bool precise);
 
