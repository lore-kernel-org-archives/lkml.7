Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E89DC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043DD2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="brCvklvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfGMLEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:04:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37659 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGMLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:04:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB4YLT3840733
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:04:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB4YLT3840733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015874;
        bh=qOi0yLL3X026GEeOdyKLd/SL4k1A+LiWXBtVyvUhjhQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=brCvklvj3NVOirHmnZq00SGKvTece1uDC9edye+YMObOlLTUXpwHaXz6xTWk/SOoo
         bdq24yyZ+DRvz90IfjeHoAQN0/xFqhD402uy5IMhFZHDRai3TR9t2/W8dDOsV40QDp
         ng8w0ObSEO7D9sLvc0TP5L7AQf4wTLyawmefSpTMu4LmuhSjJmle5oXeIe1bQhZZFm
         m573wgBFsx3euwWD+CnhcasOnq05bgb/zUO4GSJAAkvIZFOCxR+wdb8ZDkS6GaHTsE
         9fRHP74PVyhXQCSxhSgiNxEGl07u+tDmjMOQZv4nOwz+Z6t5lY2wOIoZ0KUtpdwKS2
         fuMbSV6/IVQ4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB4XNj3840730;
        Sat, 13 Jul 2019 04:04:33 -0700
Date:   Sat, 13 Jul 2019 04:04:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Luke Mujica <tipbot@zytor.com>
Message-ID: <tip-72de3fd97f15d75657dd5389e26801cbf8af0f9a@git.kernel.org>
Cc:     mingo@kernel.org, lukemujica@google.com, namhyung@kernel.org,
        eranian@google.com, tglx@linutronix.de, irogers@google.com,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: acme@redhat.com, irogers@google.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
          mingo@kernel.org, lukemujica@google.com, tglx@linutronix.de
In-Reply-To: <20190703222509.109616-2-lukemujica@google.com>
References: <20190703222509.109616-2-lukemujica@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf parse-events: Remove unused variable: error
Git-Commit-ID: 72de3fd97f15d75657dd5389e26801cbf8af0f9a
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

Commit-ID:  72de3fd97f15d75657dd5389e26801cbf8af0f9a
Gitweb:     https://git.kernel.org/tip/72de3fd97f15d75657dd5389e26801cbf8af0f9a
Author:     Luke Mujica <lukemujica@google.com>
AuthorDate: Wed, 3 Jul 2019 15:25:09 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:27 -0300

perf parse-events: Remove unused variable: error

Remove the 'error' variable because it is declared but not used in
parse-events.y or in the generated parse-events.c.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190703222509.109616-2-lukemujica@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 172dbb73941f..f1c36ed1cf36 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -480,7 +480,6 @@ event_bpf_file:
 PE_BPF_OBJECT opt_event_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
 	struct list_head *list;
 
 	ALLOC_LIST(list);
