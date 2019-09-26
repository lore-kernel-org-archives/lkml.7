Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D89C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76492222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458052;
	bh=YVwSMbvixZehl93S7rez5JiqUpuJ7cSubH6Qo7NWeNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TdkikO4K+ScBXUhJ/4xBebGgGSmkpjBzPOIM6FkyNWPwTmPDZsONXVf2s6VIT1mml
	 rlx01q6chR5WNAD0Mg0sG+LUx1f1ADmP4m5XqT3f7s65C+Y0XlFPQpXRYeZfdMXKtK
	 Jt6DnQGU5W0vxjmjbDzk1d1BxpgYkhX7fpcFg0ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfIZAeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388301AbfIZAeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:09 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A528222CD;
        Thu, 26 Sep 2019 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458048;
        bh=YVwSMbvixZehl93S7rez5JiqUpuJ7cSubH6Qo7NWeNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imyD+b6+uHtfnZaDrVf3Mk3MzJ6p2JQCUFHduxlIk5DNVLg9VNceFowWKZGdwbBx7
         KetNixk3gadvIPvQNNh/np0VM1WFON2g/hvFZ2Bm4E7TUrx/BCCedJ1W6lbxS0er1s
         Rj0XqvMxt8bkA/cAanQMKmhHOBETF/07NL8gtX3M=
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
Subject: [PATCH 18/66] perf tools: Rename perf_evlist__alloc_mmap() to evlist__alloc_mmap()
Date:   Wed, 25 Sep 2019 21:31:56 -0300
Message-Id: <20190926003244.13962-19-acme@kernel.org>
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

Rename perf_evlist__alloc_mmap() to evlist__alloc_mmap(), so we don't
have a name clash when we add perf_evlist__alloc_mmap() to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 888472c7bf9c..5bde2e5bf0e3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -693,8 +693,8 @@ void evlist__munmap(struct evlist *evlist)
 	zfree(&evlist->overwrite_mmap);
 }
 
-static struct mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
-						 bool overwrite)
+static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
+				       bool overwrite)
 {
 	int i;
 	struct mmap *map;
@@ -752,7 +752,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 			maps = evlist->overwrite_mmap;
 
 			if (!maps) {
-				maps = perf_evlist__alloc_mmap(evlist, true);
+				maps = evlist__alloc_mmap(evlist, true);
 				if (!maps)
 					return -1;
 				evlist->overwrite_mmap = maps;
@@ -1004,7 +1004,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 				  .comp_level = comp_level };
 
 	if (!evlist->mmap)
-		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
+		evlist->mmap = evlist__alloc_mmap(evlist, false);
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-- 
2.21.0

