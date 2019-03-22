Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E699BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0C4218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCVW1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:27:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVW1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:27:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMQh9I752807
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:26:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMQggG752804;
        Fri, 22 Mar 2019 15:26:42 -0700
Date:   Fri, 22 Mar 2019 15:26:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-9b40dff7ba3caaf0d1919f98e136fa3400bd34aa@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        acme@redhat.com, peterz@infradead.org, jolsa@kernel.org,
        namhyung@kernel.org, changbin.du@gmail.com,
        linux-kernel@vger.kernel.org, ast@kernel.org,
        milian.wolff@kdab.com, rostedt@goodmis.org, daniel@iogearbox.net
Reply-To: changbin.du@gmail.com, linux-kernel@vger.kernel.org,
          ast@kernel.org, milian.wolff@kdab.com, rostedt@goodmis.org,
          daniel@iogearbox.net, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, acme@redhat.com, peterz@infradead.org,
          jolsa@kernel.org, namhyung@kernel.org
In-Reply-To: <20190316080556.3075-5-changbin.du@gmail.com>
References: <20190316080556.3075-5-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf config: Fix an error in the config template
 documentation
Git-Commit-ID: 9b40dff7ba3caaf0d1919f98e136fa3400bd34aa
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

Commit-ID:  9b40dff7ba3caaf0d1919f98e136fa3400bd34aa
Gitweb:     https://git.kernel.org/tip/9b40dff7ba3caaf0d1919f98e136fa3400bd34aa
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:44 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:04 -0300

perf config: Fix an error in the config template documentation

The option 'sort-order' should be 'sort_order'.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 893c5c798be9 ("perf config: Show default report configuration in example and docs")
Link: http://lkml.kernel.org/r/20190316080556.3075-5-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 95054a8176a2..462b3cde0675 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -114,7 +114,7 @@ Given a $HOME/.perfconfig like this:
 
 	[report]
 		# Defaults
-		sort-order = comm,dso,symbol
+		sort_order = comm,dso,symbol
 		percent-limit = 0
 		queue-size = 0
 		children = true
