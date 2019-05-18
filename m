Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B7EC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA3E21744
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NQcAcwK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfERJMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:12:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:12:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9CRrl1737494
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:12:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9CRrl1737494
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170748;
        bh=wc+WaeEON08mHk4bDnZUmH+3NtuR1PgfwrSN1ccGKrg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NQcAcwK/CqxQvUjw6SRhbHF9WXOfHl0VYSd/kMPWjCoF+8lbd8pm+cNQc0E6aqYOK
         G/FwNQVmRp/gPWAhPSAU8nVWuqQVFDRjtnlpHUY5qrSu/FbQk4pli+AMV8x1YEVC1w
         JGEYtt9p06MUwlJN+DRLQCRnuMPytgErZ9OYAdGprChIxzViQg8uJoNQk+NB43LFZ7
         IX3kPPm6RJzQVyzguNFdyk9SJd4r/binQW0Uf64pl2c59pPn0P6e/2lk3PXB/VLAuW
         WUYJEdqQNfmSiVPteRpRXiGuXCANytD7ZTlALkTXpESkPbu//XxwPmiNSBD6llBheI
         cfi8Eu8UPDFDg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9CQF31737491;
        Sat, 18 May 2019 02:12:26 -0700
Date:   Sat, 18 May 2019 02:12:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-96e75ef97d882655d3d2f14aec444d5544bd93ff@git.kernel.org>
Cc:     namhyung@kernel.org, akpm@linux-foundation.org,
        tstoyanov@vmware.com, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mingo@kernel.org
Reply-To: hpa@zytor.com, namhyung@kernel.org, akpm@linux-foundation.org,
          tstoyanov@vmware.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
          acme@redhat.com, rostedt@goodmis.org
In-Reply-To: <20190510200108.885426878@goodmis.org>
References: <20190510200108.885426878@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for get field value
 APIs
Git-Commit-ID: 96e75ef97d882655d3d2f14aec444d5544bd93ff
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

Commit-ID:  96e75ef97d882655d3d2f14aec444d5544bd93ff
Gitweb:     https://git.kernel.org/tip/96e75ef97d882655d3d2f14aec444d5544bd93ff
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:25 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for get field value APIs

Create man pages for libtraceevent APIs:

  tep_get_any_field_val(),
  tep_get_common_field_val(),
  tep_get_field_val(),
  tep_get_field_raw()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-19-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200108.885426878@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-field_get_val.txt  | 122 +++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt b/tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
new file mode 100644
index 000000000000..6324f0d48aeb
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
@@ -0,0 +1,122 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_get_any_field_val, tep_get_common_field_val, tep_get_field_val,
+tep_get_field_raw - Get value of a field.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+*#include <trace-seq.h>*
+
+int *tep_get_any_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
+int *tep_get_common_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
+int *tep_get_field_val*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, unsigned long long pass:[*]_val_, int _err_);
+void pass:[*]*tep_get_field_raw*(struct trace_seq pass:[*]_s_, struct tep_event pass:[*]_event_, const char pass:[*]_name_, struct tep_record pass:[*]_record_, int pass:[*]_len_, int _err_);
+--
+
+DESCRIPTION
+-----------
+These functions can be used to find a field and retrieve its value.
+
+The _tep_get_any_field_val()_ function searches in the _record_ for a field
+with _name_, part of the _event_. If the field is found, its value is stored in
+_val_. If there is an error and _err_ is not zero, then an error string is
+written into _s_.
+
+The _tep_get_common_field_val()_ function does the same as
+_tep_get_any_field_val()_, but searches only in the common fields. This works
+for any event as all events include the common fields.
+
+The _tep_get_field_val()_ function does the same as _tep_get_any_field_val()_,
+but searches only in the event specific fields.
+
+The _tep_get_field_raw()_ function searches in the _record_ for a field with
+_name_, part of the _event_. If the field is found, a pointer to where the field
+exists in the record's raw data is returned. The size of the data is stored in
+_len_. If there is an error and _err_ is not zero, then an error string is
+written into _s_.
+
+RETURN VALUE
+------------
+The _tep_get_any_field_val()_, _tep_get_common_field_val()_ and
+_tep_get_field_val()_ functions return 0 on success, or -1 in case of an error.
+
+The _tep_get_field_raw()_ function returns a pointer to field's raw data, and
+places the length of this data in _len_. In case of an error NULL is returned.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+#include <trace-seq.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+struct tep_event *event = tep_find_event_by_name(tep, "kvm", "kvm_exit");
+...
+void process_record(struct tep_record *record)
+{
+	int len;
+	char *comm;
+	struct tep_event_format *event;
+	unsigned long long val;
+
+	event = tep_find_event_by_record(pevent, record);
+	if (event != NULL) {
+		if (tep_get_common_field_val(NULL, event, "common_type",
+					     record, &val, 0) == 0) {
+			/* Got the value of common type field */
+		}
+		if (tep_get_field_val(NULL, event, "pid", record, &val, 0) == 0) {
+			/* Got the value of pid specific field */
+		}
+		comm = tep_get_field_raw(NULL, event, "comm", record, &len, 0);
+		if (comm != NULL) {
+			/* Got a pointer to the comm event specific field */
+		}
+	}
+}
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*trace-seq.h*
+	Header file to include in order to have access to trace sequences
+	related APIs. Trace sequences are used to allow a function to call
+	several other functions to create a string of data to use.
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
