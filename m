Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A03C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A326721871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfDELqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:46:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDELqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:46:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BkI2f2737316
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:46:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BkILY2737313;
        Fri, 5 Apr 2019 04:46:18 -0700
Date:   Fri, 5 Apr 2019 04:46:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-2ce4639f6936261bf6e0bae5c21a0c09a8daeacc@git.kernel.org>
Cc:     tstoyanov@vmware.com, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        rostedt@goodmis.org, mingo@kernel.org, akpm@linux-foundation.org,
        namhyung@kernel.org
Reply-To: tstoyanov@vmware.com, hpa@zytor.com, tglx@linutronix.de,
          acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
          rostedt@goodmis.org, mingo@kernel.org, namhyung@kernel.org,
          akpm@linux-foundation.org
In-Reply-To: <20190401164343.817886725@goodmis.org>
References: <20190401164343.817886725@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Removed unneeded !! and
 return parenthesis
Git-Commit-ID: 2ce4639f6936261bf6e0bae5c21a0c09a8daeacc
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

Commit-ID:  2ce4639f6936261bf6e0bae5c21a0c09a8daeacc
Gitweb:     https://git.kernel.org/tip/2ce4639f6936261bf6e0bae5c21a0c09a8daeacc
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Mon, 1 Apr 2019 12:43:13 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:09 -0300

tools lib traceevent: Removed unneeded !! and return parenthesis

As return is not a function we do not need parenthesis around the return
value. Also, a function returning bool does not need to add !!.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164343.817886725@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 2ac8b44854ce..002b3f73862b 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -88,7 +88,7 @@ void tep_clear_flag(struct tep_handle *tep, enum tep_flag flag)
 bool tep_test_flag(struct tep_handle *tep, enum tep_flag flag)
 {
 	if (tep)
-		return (tep->flags & flag);
+		return tep->flags & flag;
 	return false;
 }
 
@@ -340,7 +340,7 @@ void tep_set_latency_format(struct tep_handle *pevent, int lat)
 bool tep_is_old_format(struct tep_handle *tep)
 {
 	if (tep)
-		return !!(tep->old_format);
+		return tep->old_format;
 	return false;
 }
 
