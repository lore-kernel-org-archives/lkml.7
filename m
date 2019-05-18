Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C320BC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED4D20848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aA6BliyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfERJOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:14:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49917 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:14:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9DtUh1737686
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:13:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9DtUh1737686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170836;
        bh=NxjzSnZa4bcekzrTo/Som2q3f07EuHTDfpDqIp7qbE8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aA6BliyQ+FheuQAIcoZzkurDsJu5sxqLDk4e+ICODIfjLZYzLFmNxwfqQF1pFeF1g
         waEzkDSOKc7EWqyob1HbWuZ4PVzET9USXlsEA3z65kOVuB0s+KBvFupGNIyt4SpVtz
         /UnxZjRcLvg11u2eGzSNP3my8Q2pAsI3tewBe5AhE4UKBPtg1BTJMObJU/EjIIyAqn
         YiLNxPwe1qY7ERpF/SLbznXiCxwj+Iec+uNHkMe6OhN3197g5LBaZxsbtgpSgE/nM4
         pgIuiz+SngIoeeJ9pFdoiXmHRt+JLQuDSiY2tyeZd0vTKdleedbYXPrraqF7r5dxpz
         fL1sWqvfS/obw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9DsB01737682;
        Sat, 18 May 2019 02:13:54 -0700
Date:   Sat, 18 May 2019 02:13:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-95ec2822a976af27c9cb77cdc01c650a3640adfa@git.kernel.org>
Cc:     akpm@linux-foundation.org, acme@redhat.com, jolsa@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, tstoyanov@vmware.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
          tstoyanov@vmware.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, namhyung@kernel.org, akpm@linux-foundation.org,
          acme@redhat.com, jolsa@redhat.com
In-Reply-To: <20190510200109.219394901@goodmis.org>
References: <20190510200109.219394901@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for
 tep_read_number_field()
Git-Commit-ID: 95ec2822a976af27c9cb77cdc01c650a3640adfa
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

Commit-ID:  95ec2822a976af27c9cb77cdc01c650a3640adfa
Gitweb:     https://git.kernel.org/tip/95ec2822a976af27c9cb77cdc01c650a3640adfa
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:27 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man page for tep_read_number_field()

Create man page for libtraceevent API tep_read_number_field().

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-21-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200109.219394901@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 ...ndian_read.txt => libtraceevent-field_read.txt} | 27 ++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt b/tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
similarity index 54%
copy from tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
copy to tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
index e64851b6e189..64e9e25d3fd9 100644
--- a/tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
+++ b/tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
@@ -3,7 +3,7 @@ libtraceevent(3)
 
 NAME
 ----
-tep_read_number - Reads a number from raw data.
+tep_read_number_field - Reads a number from raw data.
 
 SYNOPSIS
 --------
@@ -11,20 +11,20 @@ SYNOPSIS
 --
 *#include <event-parse.h>*
 
-unsigned long long *tep_read_number*(struct tep_handle pass:[*]_tep_, const void pass:[*]_ptr_, int _size_);
+int *tep_read_number_field*(struct tep_format_field pass:[*]_field_, const void pass:[*]_data_, unsigned long long pass:[*]_value_);
 --
 
 DESCRIPTION
 -----------
-The _tep_read_number()_ function reads an integer from raw data, taking into
-account the endianness of the raw data and the current host. The _tep_ argument
-is the trace event parser context. The _ptr_ is a pointer to the raw data, where
-the integer is, and the _size_ is the size of the integer.
+The _tep_read_number_field()_ function reads the value of the _field_ from the
+raw _data_ and stores it in the _value_. The function sets the _value_ according
+to the endianness of the raw data and the current machine and stores it in
+_value_.
 
 RETURN VALUE
 ------------
-The _tep_read_number()_ function returns the integer in the byte order of
-the current host. In case of an error, 0 is returned.
+The _tep_read_number_field()_ function retunrs 0 in case of success, or -1 in
+case of an error.
 
 EXAMPLE
 -------
@@ -34,16 +34,19 @@ EXAMPLE
 ...
 struct tep_handle *tep = tep_alloc();
 ...
+struct tep_event *event = tep_find_event_by_name(tep, "timer", "hrtimer_start");
+...
 void process_record(struct tep_record *record)
 {
-	int offset = 24;
-	int data = tep_read_number(tep, record->data + offset, 4);
+	unsigned long long pid;
+	struct tep_format_field *field_pid = tep_find_common_field(event, "common_pid");
 
-	/* Read the 4 bytes at the offset 24 of data as an integer */
+	if (tep_read_number_field(field_pid, record->data, &pid) != 0) {
+		/* Failed to get "common_pid" value */
+	}
 }
 ...
 --
-
 FILES
 -----
 [verse]
