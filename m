Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE6C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6F62253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="0sQD7mu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392171AbfGWVqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:46:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGWVqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:46:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLkKR4252895
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:46:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLkKR4252895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918381;
        bh=UmnHuoPKJn7bSe4IZn9yAqGHKg6XhymatM+sgbIfMW0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=0sQD7mu5SB+IuKHYsGCMjet30SPL9KcvtCQtxZgGQTtc2bj3GDDb3pOS+BvJWLtex
         /2qGehHzq8RiFz56YgL8ZHQ5PC1SOZkA7Nd0NEdN1h3VhW17PzL88Dn8MPrxTwKcW+
         ItK75WOVfRhnWZc7jodEJoYDKEPXIf6+oCYFX5ULhXHyew+XuZHrF32Ps7zQV8NsQl
         JyrMqhH4C2bl30AGnqnJG+fxTmdqSLUIcNnt/5itztxQI9cNR9md4dW4O1udGUeF8V
         DfswajapZf8zc7FYeSzC59XRcoHBJ64bU3fqunLrhHX/ck6U5XCgoWNqNoDrMHky5i
         mX254pjmhAiTw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLkKgu252892;
        Tue, 23 Jul 2019 14:46:20 -0700
Date:   Tue, 23 Jul 2019 14:46:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-5f8eec3225ff7b86763b060164e9ce47b1a71406@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        tglx@linutronix.de, jolsa@kernel.org, ak@linux.intel.com,
        hpa@zytor.com
Reply-To: acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          ak@linux.intel.com
In-Reply-To: <20190711181922.18765-1-andi@firstfloor.org>
References: <20190711181922.18765-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Fix --max-blocks man page
 description
Git-Commit-ID: 5f8eec3225ff7b86763b060164e9ce47b1a71406
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

Commit-ID:  5f8eec3225ff7b86763b060164e9ce47b1a71406
Gitweb:     https://git.kernel.org/tip/5f8eec3225ff7b86763b060164e9ce47b1a71406
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 11 Jul 2019 11:19:20 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 08:57:54 -0300

perf script: Fix --max-blocks man page description

The --max-blocks description was using the old name brstackasm.  Use
brstackinsn instead.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190711181922.18765-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index d4e2e18a5881..042b9e5dcc32 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -384,7 +384,7 @@ include::itrace.txt[]
 	perf script --time 0%-10%,30%-40%
 
 --max-blocks::
-	Set the maximum number of program blocks to print with brstackasm for
+	Set the maximum number of program blocks to print with brstackinsn for
 	each sample.
 
 --reltime::
