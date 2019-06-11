Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF5C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174112184D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279887;
	bh=l+dV5M2g9671cnvuk4p+EPhow8WZzJRVbUMZkvEqIw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uLgd2PreFY/YXOvzRkncLg+YruUM/QaOP1Dag3OcP4KKap2CWT7QPt8jKAXDUcylp
	 g4FpByjlEg1uaI4GX8+OnW72A95VjZ63lIf+Xsn5zpHQRvLlS70BzuOKAomX3lhjuz
	 FfL4e5OleBB3IEGllePQDAtIRQd0FNfKMGcrWAqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407338AbfFKTEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407324AbfFKTEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6DE2184C;
        Tue, 11 Jun 2019 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279882;
        bh=l+dV5M2g9671cnvuk4p+EPhow8WZzJRVbUMZkvEqIw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNtydntTWiidBdKfp66XeWJDukMHyys3e5pytI13CWF8p3QRCNcvvhkTZBEb1xo1J
         WOmq4Xm6/WAfUBwIEwATLWoTvjEZ6kfrLY9BNwNpqE3SUfjKZxJ+s9OVg9EPChXLht
         0A5I99BEWHg3O+Z1rgZkPvxB4IV0jZ1MYlQf1J50=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 77/85] perf time-utils: Fix --time documentation
Date:   Tue, 11 Jun 2019 15:59:03 -0300
Message-Id: <20190611185911.11645-78-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.20.1

