Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B7AC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C756A2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Pac6CBcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfERJDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:03:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:03:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I92us91734138
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:02:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I92us91734138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170177;
        bh=FWw0Z5HkdGb0/VTIxJRXGzPhkZxj2EdLu1Zxo2MlFvE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Pac6CBcXSewlnWegh4I4i33H7sLNlaglxxHAeOMLX54e+01dm+gwp4Ki6t5/Wqo/k
         2MVgPaCEyNZMc5xBLsp4Z7mc9RJdS7ZXtIkIK+d7aPeuxe9gd89G2pNJJLHmICwLsw
         480QRJmaeW3lWQ6mkZTVqG9z72VnpVtzBj1IpTf8Zc+3ZZCrld89pDJ4CQfYU3mfmC
         zsGMhwQhsvRzr/eeC6nEXWKdPH+XP17BiXHHJ8QsSPOq3AW8tw1Hd+Q/qNzKzj8kM2
         Jg2GfpJ1Li9uKecdy3i3swAaTVWux/d4KKZDjKgRJA0Szs/ThXEta+raTkbhg0EnjK
         dp3CHQMcgc/fw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I92tv71734135;
        Sat, 18 May 2019 02:02:55 -0700
Date:   Sat, 18 May 2019 02:02:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-ba28fabe43c3a13bbc6e48f78fdf609dcc5e114b@git.kernel.org>
Cc:     namhyung@kernel.org, akpm@linux-foundation.org,
        rostedt@goodmis.org, hpa@zytor.com, tstoyanov@vmware.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: akpm@linux-foundation.org, namhyung@kernel.org,
          rostedt@goodmis.org, tstoyanov@vmware.com, hpa@zytor.com,
          acme@redhat.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190510200106.742948683@goodmis.org>
References: <20190510200106.742948683@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for get/set cpus
 APIs
Git-Commit-ID: ba28fabe43c3a13bbc6e48f78fdf609dcc5e114b
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

Commit-ID:  ba28fabe43c3a13bbc6e48f78fdf609dcc5e114b
Gitweb:     https://git.kernel.org/tip/ba28fabe43c3a13bbc6e48f78fdf609dcc5e114b
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:12 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

tools lib traceevent: Man page for get/set cpus APIs

Create man pages for libtraceevent APIs:

 tep_get_cpus(),
 tep_set_cpus()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-6-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200106.742948683@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 ...eevent-long_size.txt => libtraceevent-cpus.txt} | 27 +++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt b/tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
similarity index 52%
copy from tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
copy to tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
index 01d78ea2519a..5ad70e43b752 100644
--- a/tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
+++ b/tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
@@ -3,8 +3,8 @@ libtraceevent(3)
 
 NAME
 ----
-tep_get_long_size, tep_set_long_size - Get / set the size of a long integer on
-the machine, where the trace is generated, in bytes
+tep_get_cpus, tep_set_cpus - Get / set the number of CPUs, which have a tracing
+buffer representing it. Note, the buffer may be empty.
 
 SYNOPSIS
 --------
@@ -12,23 +12,23 @@ SYNOPSIS
 --
 *#include <event-parse.h>*
 
-int *tep_get_long_size*(strucqt tep_handle pass:[*]_tep_);
-void *tep_set_long_size*(struct tep_handle pass:[*]_tep_, int _long_size_);
+int *tep_get_cpus*(struct tep_handle pass:[*]_tep_);
+void *tep_set_cpus*(struct tep_handle pass:[*]_tep_, int _cpus_);
 --
 
 DESCRIPTION
 -----------
-The _tep_get_long_size()_ function returns the size of a long integer on the machine,
-where the trace is generated. The _tep_ argument is trace event parser context.
+The _tep_get_cpus()_ function gets the number of CPUs, which have a tracing
+buffer representing it. The _tep_ argument is trace event parser context.
 
-The _tep_set_long_size()_ function sets the size of a long integer on the machine,
-where the trace is generated. The _tep_ argument is trace event parser context.
-The _long_size_ is the size of a long integer, in bytes.
+The _tep_set_cpus()_ function sets the number of CPUs, which have a tracing
+buffer representing it. The _tep_ argument is trace event parser context.
+The _cpu_ argument is the number of CPUs with tracing data.
 
 RETURN VALUE
 ------------
-The _tep_get_long_size()_ function returns the size of a long integer on the machine,
-where the trace is generated, in bytes.
+The _tep_get_cpus()_ functions returns the number of CPUs, which have tracing
+data recorded.
 
 EXAMPLE
 -------
@@ -38,10 +38,9 @@ EXAMPLE
 ...
 struct tep_handle *tep = tep_alloc();
 ...
-tep_set_long_size(tep, 4);
-...
-int long_size = tep_get_long_size(tep);
+	tep_set_cpus(tep, 5);
 ...
+	printf("We have tracing data for %d CPUs", tep_get_cpus(tep));
 --
 
 FILES
