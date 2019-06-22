Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81043C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5390F2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iHrjqMfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFVGqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:46:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49609 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:46:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6jo1X2008959
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:45:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6jo1X2008959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185951;
        bh=pdf0HpJGwLcYXrl9oX6DIO7Z9G77JkOBZOTDSGbTAzg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=iHrjqMfBkfpitHOx0B1JgMowU4qUChFDAS9miXGZr+C5SxlIKDsyeZKUGOln1PocD
         ULIUmDyBZMofkNbcE1peHOiNYOwBIe7uq2hiiAA/vMAM0oWVzLOp9bwjawAjtg1/DX
         wC2c8BHbW8VSousenMEVGUb3o4fAJ1eduffPlyo/urFnU5Zb1dGx36ZDEqRzEaDSJF
         6vpkxU2CmR+MwSLNSaPq51ZBv0aQB/7gVgA0LfcaBJzElmJEjtzimq1w+a6dq57Li3
         xaluRlbXdqvaBANQmThdvxTdLVtv5m6Fhx/tMbTMas5ehiXCMV/K9AjAG/owboGUZw
         9iKFliWLtIHtQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6jocE2008952;
        Fri, 21 Jun 2019 23:45:50 -0700
Date:   Fri, 21 Jun 2019 23:45:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3h6fa866w6ao0wsbyqz9nrm8@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, acme@redhat.com
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools build feature tests: Add missing SPDX headers
Git-Commit-ID: 5e2156d837e875c0277bbe9c5cd965ff56539e0b
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

Commit-ID:  5e2156d837e875c0277bbe9c5cd965ff56539e0b
Gitweb:     https://git.kernel.org/tip/5e2156d837e875c0277bbe9c5cd965ff56539e0b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 13 Jun 2019 18:25:04 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:19 -0300

tools build feature tests: Add missing SPDX headers

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3h6fa866w6ao0wsbyqz9nrm8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-fortify-source.c | 1 +
 tools/build/feature/test-hello.c          | 1 +
 tools/build/feature/test-setns.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/build/feature/test-fortify-source.c b/tools/build/feature/test-fortify-source.c
index c9f398d87868..c8a57194f9f2 100644
--- a/tools/build/feature/test-fortify-source.c
+++ b/tools/build/feature/test-fortify-source.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 
 int main(void)
diff --git a/tools/build/feature/test-hello.c b/tools/build/feature/test-hello.c
index c9f398d87868..c8a57194f9f2 100644
--- a/tools/build/feature/test-hello.c
+++ b/tools/build/feature/test-hello.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 
 int main(void)
diff --git a/tools/build/feature/test-setns.c b/tools/build/feature/test-setns.c
index 4a1581ae7a55..2757c201ed50 100644
--- a/tools/build/feature/test-setns.c
+++ b/tools/build/feature/test-setns.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 #include <sched.h>
 
