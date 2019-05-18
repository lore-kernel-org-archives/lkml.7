Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE74C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7862087E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oeM7ymT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfERJSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:18:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERJSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:18:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9Ha401738228
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:17:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9Ha401738228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171057;
        bh=hZ9yrTrslIAmhf6KLA2J/SP5qx6zwfYnjXrV/z5HEjg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=oeM7ymT/0eh7kvaci1a+NUbK+OKpqEhVxTEBhF4eKyRk5eO+pPqwl6JX2XqxDGQZ4
         6A1bPREUFrb2K/Ih75VbU3PK831fVfqUBWYu+0d5EwMf8i+qa+R4a45pbXSzrK9+ic
         DcqFLzlo8Yn4cjbxNo0xaxJsfcByEGDVK0w3LZj2pcVc9BnLBfyhe4XZzz9+2BU6VL
         iJ/D6y2unbaH7fMNv9gWYK1UzK/y7SxT151jOK/jk4XROOcL9WEAVSfcFiKw3DWpXB
         LLdIV5Xylo246Yhv+UiDNV16LH1rqzyYA7cDS+uSCDEfVs/9QR08Chx5Cbczl3k2L0
         5z6cSVjQtk3MA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9HZOf1738225;
        Sat, 18 May 2019 02:17:35 -0700
Date:   Sat, 18 May 2019 02:17:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-0133fc6068fb51aa7ce8876e8fee465d92acfc14@git.kernel.org>
Cc:     mingo@kernel.org, akpm@linux-foundation.org, acme@redhat.com,
        namhyung@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        tstoyanov@vmware.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@redhat.com,
          tglx@linutronix.de, rostedt@goodmis.org, tstoyanov@vmware.com,
          acme@redhat.com, akpm@linux-foundation.org, mingo@kernel.org,
          hpa@zytor.com, namhyung@kernel.org
In-Reply-To: <20190510200110.284281830@goodmis.org>
References: <20190510200110.284281830@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for APIs used to
 extract common fields from a record
Git-Commit-ID: 0133fc6068fb51aa7ce8876e8fee465d92acfc14
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

Commit-ID:  0133fc6068fb51aa7ce8876e8fee465d92acfc14
Gitweb:     https://git.kernel.org/tip/0133fc6068fb51aa7ce8876e8fee465d92acfc14
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:32 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for APIs used to extract common fields from a record

Create man pages for libtraceevent APIs:

 tep_data_type(),
 tep_data_pid(),
 tep_data_preempt_count(),
 tep_data_flags()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-26-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200110.284281830@goodmis.org
[ Fixed missing T in description of NOSUPPORT flag ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-record_parse.txt   | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt b/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
new file mode 100644
index 000000000000..e9a69116c78b
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
@@ -0,0 +1,137 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_data_type, tep_data_pid,tep_data_preempt_count, tep_data_flags -
+Extract common fields from a record.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *trace_flag_type* {
+	_TRACE_FLAG_IRQS_OFF_,
+	_TRACE_FLAG_IRQS_NOSUPPORT_,
+	_TRACE_FLAG_NEED_RESCHED_,
+	_TRACE_FLAG_HARDIRQ_,
+	_TRACE_FLAG_SOFTIRQ_,
+};
+
+int *tep_data_type*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
+int *tep_data_pid*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
+int *tep_data_preempt_count*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
+int *tep_data_flags*(struct tep_handle pass:[*]_tep_, struct tep_record pass:[*]_rec_);
+--
+
+DESCRIPTION
+-----------
+This set of functions can be used to extract common fields from a record.
+
+The _tep_data_type()_ function gets the event id from the record _rec_.
+It reads the "common_type" field. The _tep_ argument is the trace event parser
+context.
+
+The _tep_data_pid()_ function gets the process id from the record _rec_.
+It reads the "common_pid" field. The _tep_ argument is the trace event parser
+context.
+
+The _tep_data_preempt_count()_ function gets the preemption count from the
+record _rec_. It reads the "common_preempt_count" field. The _tep_ argument is
+the trace event parser context.
+
+The _tep_data_flags()_ function gets the latency flags from the record _rec_.
+It reads the "common_flags" field. The _tep_ argument is the trace event parser
+context. Supported latency flags are:
+[verse]
+--
+	_TRACE_FLAG_IRQS_OFF_,		Interrupts are disabled.
+	_TRACE_FLAG_IRQS_NOSUPPORT_,	Reading IRQ flag is not supported by the architecture.
+	_TRACE_FLAG_NEED_RESCHED_,	Task needs rescheduling.
+	_TRACE_FLAG_HARDIRQ_,		Hard IRQ is running.
+	_TRACE_FLAG_SOFTIRQ_,		Soft IRQ is running.
+--
+
+RETURN VALUE
+------------
+The _tep_data_type()_ function returns an integer, representing the event id.
+
+The _tep_data_pid()_ function returns an integer, representing the process id
+
+The _tep_data_preempt_count()_ function returns an integer, representing the
+preemption count.
+
+The _tep_data_flags()_ function returns an integer, representing the latency
+flags. Look at the _trace_flag_type_ enum for supported flags.
+
+All these functions in case of an error return a negative integer.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+void process_record(struct tep_record *record)
+{
+	int data;
+
+	data = tep_data_type(tep, record);
+	if (data >= 0) {
+		/* Got the ID of the event */
+	}
+
+	data = tep_data_pid(tep, record);
+	if (data >= 0) {
+		/* Got the process ID */
+	}
+
+	data = tep_data_preempt_count(tep, record);
+	if (data >= 0) {
+		/* Got the preemption count */
+	}
+
+	data = tep_data_flags(tep, record);
+	if (data >= 0) {
+		/* Got the latency flags */
+	}
+}
+...
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*-ltraceevent*
+	Linker switch to add when building a program that uses the library.
+--
+
+SEE ALSO
+--------
+_libtraceevent(3)_, _trace-cmd(1)_
+
+AUTHOR
+------
+[verse]
+--
+*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
+*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
+--
+REPORTING BUGS
+--------------
+Report bugs to  <linux-trace-devel@vger.kernel.org>
+
+LICENSE
+-------
+libtraceevent is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
