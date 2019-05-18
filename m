Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9DCC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E08F2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="akt0+Izi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfERJF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:05:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:05:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I954sT1736164
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:05:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I954sT1736164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170305;
        bh=CY3rK7L4x/CTU+8V+8E4MmoZ9n7EyCt7utpwvWenc/s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=akt0+Izibvu9fja9hlROtoUF072Mh4Wb6J4JTl6718EHUu0jNykpjs+5u8h5A6Re2
         d6zHFmyLb2R9WQaqk7YAQJZSUzE5huAxOfjypglVL2vmKr3IhXLvu9LVqKCWtpUMGr
         V3oLkRIQ2hu3QhBCAo32YCg2CSVfC+Y/1ZVxiyM4KXSn28LNbt2j2kI/5Za29u2aEl
         PUPYGmQfIi9/1waJ2TuWI+PZKbQ0TfIssPDfcBgkwd1np3kRfOFdyXuiTt5cBBljnA
         YH8WbcvmTYJ9q+p/km3yL3h7DQPXoAm+m+wqeDxEn20i+XfpkQPuKf+stzlODU4eRX
         c0DDzsOSV9g9A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9537T1736159;
        Sat, 18 May 2019 02:05:03 -0700
Date:   Sat, 18 May 2019 02:05:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-71ee989f94cf06ce73ec5bd8a9f28cca5d167499@git.kernel.org>
Cc:     tstoyanov@vmware.com, mingo@kernel.org, namhyung@kernel.org,
        rostedt@goodmis.org, akpm@linux-foundation.org, hpa@zytor.com,
        acme@redhat.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, namhyung@kernel.org, akpm@linux-foundation.org,
          rostedt@goodmis.org, hpa@zytor.com, acme@redhat.com,
          tstoyanov@vmware.com, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, tglx@linutronix.de
In-Reply-To: <20190510200107.218173559@goodmis.org>
References: <20190510200107.218173559@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for page size APIs
Git-Commit-ID: 71ee989f94cf06ce73ec5bd8a9f28cca5d167499
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

Commit-ID:  71ee989f94cf06ce73ec5bd8a9f28cca5d167499
Gitweb:     https://git.kernel.org/tip/71ee989f94cf06ce73ec5bd8a9f28cca5d167499
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:15 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

tools lib traceevent: Man page for page size APIs

Create man pages for libtraceevent APIs:

  tep_get_page_size()
  tep_set_page_size()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-9-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200107.218173559@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 ...t-long_size.txt => libtraceevent-page_size.txt} | 34 ++++++++++++----------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt b/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
similarity index 50%
copy from tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
copy to tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
index 01d78ea2519a..452c0cfa1822 100644
--- a/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
+++ b/tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
@@ -3,8 +3,8 @@ libtraceevent(3)
 
 NAME
 ----
-tep_get_long_size, tep_set_long_size - Get / set the size of a long integer on
-the machine, where the trace is generated, in bytes
+tep_get_page_size, tep_set_page_size - Get / set the size of a memory page on
+the machine, where the trace is generated
 
 SYNOPSIS
 --------
@@ -12,36 +12,40 @@ SYNOPSIS
 --
 *#include <event-parse.h>*
 
-int *tep_get_long_size*(strucqt tep_handle pass:[*]_tep_);
-void *tep_set_long_size*(struct tep_handle pass:[*]_tep_, int _long_size_);
+int *tep_get_page_size*(struct tep_handle pass:[*]_tep_);
+void *tep_set_page_size*(struct tep_handle pass:[*]_tep_, int _page_size_);
 --
 
 DESCRIPTION
 -----------
-The _tep_get_long_size()_ function returns the size of a long integer on the machine,
-where the trace is generated. The _tep_ argument is trace event parser context.
+The _tep_get_page_size()_ function returns the size of a memory page on
+the machine, where the trace is generated. The _tep_ argument is trace
+event parser context.
 
-The _tep_set_long_size()_ function sets the size of a long integer on the machine,
-where the trace is generated. The _tep_ argument is trace event parser context.
-The _long_size_ is the size of a long integer, in bytes.
+The _tep_set_page_size()_ function stores in the _tep_ context the size of a
+memory page on the machine, where the trace is generated.
+The _tep_ argument is trace event parser context.
+The _page_size_ argument is the size of a memory page, in bytes.
 
 RETURN VALUE
 ------------
-The _tep_get_long_size()_ function returns the size of a long integer on the machine,
-where the trace is generated, in bytes.
+The _tep_get_page_size()_ function returns size of the memory page, in bytes.
 
 EXAMPLE
 -------
 [source,c]
 --
+#include <unistd.h>
 #include <event-parse.h>
 ...
 struct tep_handle *tep = tep_alloc();
 ...
-tep_set_long_size(tep, 4);
-...
-int long_size = tep_get_long_size(tep);
-...
+	int page_size = getpagesize();
+
+	tep_set_page_size(tep, page_size);
+
+	printf("The page size for this machine is %d\n", tep_get_page_size(tep));
+
 --
 
 FILES
