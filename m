Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F5AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7F72166E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SUt7ETwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfFQTsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:48:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48381 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFQTsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:48:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJluVs3569738
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:47:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJluVs3569738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800877;
        bh=WAOZ6C3+Y0pl/mblFujh+KHc8Z64A+MSAQN27r68xXY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SUt7ETwgMR5oYGpZjkZ4qSgXnpyFr8fmHZe7JgPjRUt5AwwqKgJ3lW1LBv8geEHBR
         l2klQt3ZSHBx4cg4J6mPccWmeb7uiglMJlyJtNA7xgfr08zXtVOHDc83xNtHxrMwj+
         UG71TnrUDmr9RPyF8HSzB2+sFT3ziCy/wVrO5OncdVydyREjkchkS5M5JAXmoSLZdC
         Kmu3VheOP/Q7rVoq5umkwK8U3SPe48DxjKeqFEBW81glalW6wvIWIytM6IMD8/prEy
         pmjO5rwahAYJICoVkHEzYdejG1yTGgSLan8yMQ8wRGhIUd6zh8W4E5aA1zcaPbUq+Z
         zx8HrhKaxT0bQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJlu413569735;
        Mon, 17 Jun 2019 12:47:56 -0700
Date:   Mon, 17 Jun 2019 12:47:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-0ccc69ba0af46e3371c8cefb506aaf9f0e4f554c@git.kernel.org>
Cc:     yao.jin@linux.intel.com, adrian.hunter@intel.com, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, jolsa@redhat.com
Reply-To: jolsa@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
          yao.jin@linux.intel.com, adrian.hunter@intel.com
In-Reply-To: <20190604130017.31207-16-adrian.hunter@intel.com>
References: <20190604130017.31207-16-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf time-utils: Fix --time documentation
Git-Commit-ID: 0ccc69ba0af46e3371c8cefb506aaf9f0e4f554c
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

Commit-ID:  0ccc69ba0af46e3371c8cefb506aaf9f0e4f554c
Gitweb:     https://git.kernel.org/tip/0ccc69ba0af46e3371c8cefb506aaf9f0e4f554c
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:13 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf time-utils: Fix --time documentation

Correct some punctuation and spelling and correct the format to show
that the time resolution is nanoseconds not microseconds.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt   | 6 +++---
 tools/perf/Documentation/perf-report.txt | 6 +++---
 tools/perf/Documentation/perf-script.txt | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index da7809b15cc9..5732f69580ab 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -142,9 +142,9 @@ OPTIONS
 	  perf diff --time 0%-10%,30%-40%
 
 	It also supports analyzing samples within a given time window
-	<start>,<stop>. Times have the format seconds.microseconds. If 'start'
-	is not given (i.e., time string is ',x.y') then analysis starts at
-	the beginning of the file. If stop time is not given (i.e, time
+	<start>,<stop>. Times have the format seconds.nanoseconds. If 'start'
+	is not given (i.e. time string is ',x.y') then analysis starts at
+	the beginning of the file. If stop time is not given (i.e. time
 	string is 'x.y,') then analysis goes to the end of the file. Time string is
 	'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
 	perf.data files.
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index f441baa794ce..3de029f6881d 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -412,12 +412,12 @@ OPTIONS
 
 --time::
 	Only analyze samples within given time window: <start>,<stop>. Times
-	have the format seconds.microseconds. If start is not given (i.e., time
+	have the format seconds.nanoseconds. If start is not given (i.e. time
 	string is ',x.y') then analysis starts at the beginning of the file. If
-	stop time is not given (i.e, time string is 'x.y,') then analysis goes
+	stop time is not given (i.e. time string is 'x.y,') then analysis goes
 	to end of file.
 
-	Also support time percent with multiple time range. Time string is
+	Also support time percent with multiple time ranges. Time string is
 	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
 
 	For example:
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index c59fd52e9e91..878349cce968 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -361,12 +361,12 @@ include::itrace.txt[]
 
 --time::
 	Only analyze samples within given time window: <start>,<stop>. Times
-	have the format seconds.microseconds. If start is not given (i.e., time
+	have the format seconds.nanoseconds. If start is not given (i.e. time
 	string is ',x.y') then analysis starts at the beginning of the file. If
-	stop time is not given (i.e, time string is 'x.y,') then analysis goes
+	stop time is not given (i.e. time string is 'x.y,') then analysis goes
 	to end of file.
 
-	Also support time percent with multipe time range. Time string is
+	Also support time percent with multiple time ranges. Time string is
 	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
 
 	For example:
