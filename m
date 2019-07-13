Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB292C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6B32083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p2butWx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfGMLEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:04:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfGMLEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:04:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB3pjn3839117
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:03:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB3pjn3839117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015832;
        bh=l7YBeiil97fJnQYrMWgIoLrmOJa7C1+dhW8EvzR9Bbc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p2butWx9snMnubMkovim5lI8uMp89v8St+jXgQTYXAc5r5vW5kd74A/rOCE3cXbFz
         kVc3IxpBvINGx7T5xu+Irx2IRwc5PtRvpAokjmzNynX2kRctYA1uHLab9o2Rty3gIN
         9TJb44HKcNuxQF5s4CZE5dYY/B2evCrjPMsqQDlwH5ClQ6DSER8ZCeaJYV4DHxOpWc
         XzzDLF5/WYQVFh3RKpT3qjoAe1FEObDbttzhGSQCWZ5ZLIC+XS0vqc4aMV0bqdYLw6
         Aav93al17r+z6s6no8gZsMgfL4hDpYZloWOos9gvb2OG+Ir4U4zQmVW37K3Xf4Q5dR
         YyKVKXYoMlYDA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB3oBs3839114;
        Sat, 13 Jul 2019 04:03:50 -0700
Date:   Sat, 13 Jul 2019 04:03:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Luke Mujica <tipbot@zytor.com>
Message-ID: <tip-34c9af571e51466fbcc423fb955277c82f03ce92@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, lukemujica@google.com,
        eranian@google.com, mingo@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, peterz@infradead.org, irogers@google.com,
        jolsa@redhat.com, hpa@zytor.com
Reply-To: mingo@kernel.org, eranian@google.com, lukemujica@google.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, hpa@zytor.com,
          peterz@infradead.org, irogers@google.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          namhyung@kernel.org, tglx@linutronix.de
In-Reply-To: <20190703222509.109616-1-lukemujica@google.com>
References: <20190703222509.109616-1-lukemujica@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf parse-events: Remove unused variable 'i'
Git-Commit-ID: 34c9af571e51466fbcc423fb955277c82f03ce92
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

Commit-ID:  34c9af571e51466fbcc423fb955277c82f03ce92
Gitweb:     https://git.kernel.org/tip/34c9af571e51466fbcc423fb955277c82f03ce92
Author:     Luke Mujica <lukemujica@google.com>
AuthorDate: Wed, 3 Jul 2019 15:25:08 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:27 -0300

perf parse-events: Remove unused variable 'i'

Remove the 'int i' because it is declared but not used in parse-events.y
or in the generated parse-events.c.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190703222509.109616-1-lukemujica@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 6ad8d4914969..172dbb73941f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -626,7 +626,6 @@ PE_TERM
 PE_NAME array '=' PE_NAME
 {
 	struct parse_events_term *term;
-	int i;
 
 	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
 					$1, $4, &@1, &@4));
