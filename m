Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D7DC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14EB2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FkZ/q322"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfERJJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:09:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:09:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I98kcP1736656
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:08:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I98kcP1736656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170527;
        bh=IsCkhLdqM10G7V4eii1jf53eX6/L+wH1G3egkijtrGU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FkZ/q322mZp7kTVDrrgHrBt8xMAKt4YVK2zhfltN7hsw4/bbs/irEK5ezeD+FgSzY
         nZlz4Lq9xI0LhDYAJOgo3OIUj3i22POn+r94sa5ZU5ZJ9EvsfOq2xjA+SM7vqij4in
         EaYUz+6b6/2lZ+XN1TxdWQBpc2qtO/85/1Ql7MXixJkOurZD+kqDI3bcSG7sSHzbWu
         sQLFA565PLt8rN0P69FnWDwahHGcFt1YDxN9FW5aPVZUtqmawZoi6AyTsk02tEt0V7
         2q52QQ0KV+3Hy6DichacnAZo9/WG4nE23gNsTjAodlbb57fJqRYewp3JWaCuEziYmi
         vqpozEcJxZlhw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I98kXQ1736653;
        Sat, 18 May 2019 02:08:46 -0700
Date:   Sat, 18 May 2019 02:08:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-c76c22421875bbcbadd3c9fd4033981677aacfb0@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, jolsa@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, akpm@linux-foundation.org,
        tstoyanov@vmware.com, namhyung@kernel.org, hpa@zytor.com
Reply-To: tstoyanov@vmware.com, hpa@zytor.com, namhyung@kernel.org,
          rostedt@goodmis.org, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
          jolsa@redhat.com, tglx@linutronix.de
In-Reply-To: <20190510200108.042164597@goodmis.org>
References: <20190510200108.042164597@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for
 tep_read_number()
Git-Commit-ID: c76c22421875bbcbadd3c9fd4033981677aacfb0
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

Commit-ID:  c76c22421875bbcbadd3c9fd4033981677aacfb0
Gitweb:     https://git.kernel.org/tip/c76c22421875bbcbadd3c9fd4033981677aacfb0
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:20 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man page for tep_read_number()

Create man page for tep_read_number() libtraceevent API.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-14-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200108.042164597@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 ...vent-cpus.txt => libtraceevent-endian_read.txt} | 29 +++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-cpus.txt b/tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
similarity index 54%
copy from tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
copy to tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
index 5ad70e43b752..e64851b6e189 100644
--- a/tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
+++ b/tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
@@ -3,8 +3,7 @@ libtraceevent(3)
 
 NAME
 ----
-tep_get_cpus, tep_set_cpus - Get / set the number of CPUs, which have a tracing
-buffer representing it. Note, the buffer may be empty.
+tep_read_number - Reads a number from raw data.
 
 SYNOPSIS
 --------
@@ -12,23 +11,20 @@ SYNOPSIS
 --
 *#include <event-parse.h>*
 
-int *tep_get_cpus*(struct tep_handle pass:[*]_tep_);
-void *tep_set_cpus*(struct tep_handle pass:[*]_tep_, int _cpus_);
+unsigned long long *tep_read_number*(struct tep_handle pass:[*]_tep_, const void pass:[*]_ptr_, int _size_);
 --
 
 DESCRIPTION
 -----------
-The _tep_get_cpus()_ function gets the number of CPUs, which have a tracing
-buffer representing it. The _tep_ argument is trace event parser context.
-
-The _tep_set_cpus()_ function sets the number of CPUs, which have a tracing
-buffer representing it. The _tep_ argument is trace event parser context.
-The _cpu_ argument is the number of CPUs with tracing data.
+The _tep_read_number()_ function reads an integer from raw data, taking into
+account the endianness of the raw data and the current host. The _tep_ argument
+is the trace event parser context. The _ptr_ is a pointer to the raw data, where
+the integer is, and the _size_ is the size of the integer.
 
 RETURN VALUE
 ------------
-The _tep_get_cpus()_ functions returns the number of CPUs, which have tracing
-data recorded.
+The _tep_read_number()_ function returns the integer in the byte order of
+the current host. In case of an error, 0 is returned.
 
 EXAMPLE
 -------
@@ -38,9 +34,14 @@ EXAMPLE
 ...
 struct tep_handle *tep = tep_alloc();
 ...
-	tep_set_cpus(tep, 5);
+void process_record(struct tep_record *record)
+{
+	int offset = 24;
+	int data = tep_read_number(tep, record->data + offset, 4);
+
+	/* Read the 4 bytes at the offset 24 of data as an integer */
+}
 ...
-	printf("We have tracing data for %d CPUs", tep_get_cpus(tep));
 --
 
 FILES
