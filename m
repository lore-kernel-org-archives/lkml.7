Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A47C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFD8248C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfFDNCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbfFDNCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:15 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] perf time-utils: Fix --time documentation
Date:   Tue,  4 Jun 2019 16:00:13 +0300
Message-Id: <20190604130017.31207-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct some punctuation and spelling and correct the format to show that
the time resolution is nanoseconds not microseconds.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
-- 
2.17.1

