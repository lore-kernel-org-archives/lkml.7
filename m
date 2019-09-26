Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B422FC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA46217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458057;
	bh=zTaL7a9bXWeu2+RCtNVAb67Qi+vT+272qzUIr1EMtBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Muk+OLwvEiXkjnwug0HsOSmmmkenOkoruLv/ANWbInAFfm6k/mCBuS2arSoINVSrr
	 26V0WzMM8TZV0D0T9oCjOjFEEiLhN4526ESUqJUlsKiiN+n1XzkxWe5xZmVwbGKGIh
	 UoTrt1XUug+HlGXbvETzrDn1F1Ke+8vaj7FDYOlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbfIZAeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388395AbfIZAeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:12 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC9F21D7B;
        Thu, 26 Sep 2019 00:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458052;
        bh=zTaL7a9bXWeu2+RCtNVAb67Qi+vT+272qzUIr1EMtBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUZroaDdYOzvTggmze3JT+Gz3HvNVVrG217Q3hiOxfog3YU+b8rzxVnr5lfYz1ROm
         HH48i4MZ0+8dT9nr/SDng6flAcB/coTKNmJZBsIGvacwlKXG7yQ4nzkfScQaBMij2p
         nZQo46K/5JEpqX9Ec2nCane6ql6Mli2OV5sv2MNk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/66] perf tools: Rename perf_evlist__exit() to evlist__exit()
Date:   Wed, 25 Sep 2019 21:31:57 -0300
Message-Id: <20190926003244.13962-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evlist__exit() to evlist__exit(), so we don't have a name
clash when we add perf_evlist__exit() to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 4 ++--
 tools/perf/util/evlist.h | 2 +-
 tools/perf/util/python.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5bde2e5bf0e3..4c5b7040c02b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -137,7 +137,7 @@ static void perf_evlist__purge(struct evlist *evlist)
 	evlist->core.nr_entries = 0;
 }
 
-void perf_evlist__exit(struct evlist *evlist)
+void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
@@ -156,7 +156,7 @@ void evlist__delete(struct evlist *evlist)
 	evlist->core.cpus = NULL;
 	evlist->core.threads = NULL;
 	perf_evlist__purge(evlist);
-	perf_evlist__exit(evlist);
+	evlist__exit(evlist);
 	free(evlist);
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f07501602353..b33c5d67410a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -65,7 +65,7 @@ struct evlist *perf_evlist__new_default(void);
 struct evlist *perf_evlist__new_dummy(void);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads);
-void perf_evlist__exit(struct evlist *evlist);
+void evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
 void evlist__add(struct evlist *evlist, struct evsel *entry);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b102d174b868..60a6b6e8e176 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -884,7 +884,7 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 
 static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
 {
-	perf_evlist__exit(&pevlist->evlist);
+	evlist__exit(&pevlist->evlist);
 	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
 }
 
-- 
2.21.0

